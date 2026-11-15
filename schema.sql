-- Leonida Insider Database Schema
-- Run this against your Supabase PostgreSQL database
-- Execute via: supabase db push or in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table (extends Supabase auth)
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  name TEXT,
  role TEXT DEFAULT 'user' CHECK (role IN ('user', 'admin', 'editor')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Categories for articles/guides
CREATE TABLE IF NOT EXISTS categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Articles (guides, news, help centre)
CREATE TABLE IF NOT EXISTS articles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  content TEXT NOT NULL,
  excerpt TEXT,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived', 'scheduled')),
  author_id UUID REFERENCES users(id) ON DELETE SET NULL,
  published_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  seo_title TEXT,
  seo_description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_articles_status ON articles(status);
CREATE INDEX IF NOT EXISTS idx_articles_category ON articles(category_id);
CREATE INDEX IF NOT EXISTS idx_articles_published ON articles(published_at DESC);
CREATE INDEX IF NOT EXISTS idx_articles_slug ON articles(slug);
CREATE INDEX IF NOT EXISTS idx_articles_author ON articles(author_id);

-- News sources for monitoring
CREATE TABLE IF NOT EXISTS news_sources (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  source_type TEXT NOT NULL CHECK (source_type IN ('rss', 'api', 'web', 'social')),
  category TEXT,
  active BOOLEAN DEFAULT true,
  last_checked_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_news_sources_active ON news_sources(active);

-- Discovered news items (before editorial review)
CREATE TABLE IF NOT EXISTS discovered_news (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  source_id UUID REFERENCES news_sources(id) ON DELETE SET NULL,
  original_url TEXT NOT NULL,
  title TEXT NOT NULL,
  summary TEXT,
  source_published_at TIMESTAMPTZ,
  verification_status TEXT DEFAULT 'pending' CHECK (verification_status IN ('pending', 'verified', 'rejected', 'duplicate')),
  duplicate_of UUID REFERENCES discovered_news(id) ON DELETE SET NULL,
  ai_draft TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_discovered_news_status ON discovered_news(verification_status);
CREATE INDEX IF NOT EXISTS idx_discovered_news_source ON discovered_news(source_id);
CREATE INDEX IF NOT EXISTS idx_discovered_news_date ON discovered_news(source_published_at DESC);

-- Article sources (linking articles to discovered news)
CREATE TABLE IF NOT EXISTS article_sources (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  article_id UUID REFERENCES articles(id) ON DELETE CASCADE,
  discovered_news_id UUID REFERENCES discovered_news(id) ON DELETE CASCADE,
  source_url TEXT NOT NULL,
  source_title TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_article_sources_article ON article_sources(article_id);
CREATE INDEX IF NOT EXISTS idx_article_sources_discovered ON article_sources(discovered_news_id);

-- Missions for Mission Tracker
CREATE TABLE IF NOT EXISTS missions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  category TEXT CHECK (category IN ('main_story', 'side_missions', 'activities', 'collectibles', 'challenges', 'achievements')),
  sequence INTEGER NOT NULL,
  verified BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_missions_category ON missions(category);
CREATE INDEX IF NOT EXISTS idx_missions_sequence ON missions(sequence);

-- User mission progress
CREATE TABLE IF NOT EXISTS user_mission_progress (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  mission_id UUID REFERENCES missions(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMPTZ,
  UNIQUE (user_id, mission_id)
);

CREATE INDEX IF NOT EXISTS idx_user_mission_progress_user ON user_mission_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_mission_progress_mission ON user_mission_progress(mission_id);

-- Caption generations
CREATE TABLE IF NOT EXISTS caption_generations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  input_text TEXT NOT NULL,
  platform TEXT NOT NULL,
  generated_output JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_caption_generations_user ON caption_generations(user_id);

-- Email subscribers
CREATE TABLE IF NOT EXISTS subscribers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email TEXT NOT NULL UNIQUE,
  first_name TEXT,
  consent_status TEXT DEFAULT 'pending' CHECK (consent_status IN ('pending', 'confirmed', 'unsubscribed')),
  consent_timestamp TIMESTAMPTZ,
  unsubscribe_timestamp TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_subscribers_email ON subscribers(email);
CREATE INDEX IF NOT EXISTS idx_subscribers_status ON subscribers(consent_status);

-- Affiliate products
CREATE TABLE IF NOT EXISTS affiliate_products (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_name TEXT NOT NULL,
  category TEXT NOT NULL,
  product_url TEXT,
  affiliate_url TEXT NOT NULL,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_affiliate_products_category ON affiliate_products(category);
CREATE INDEX IF NOT EXISTS idx_affiliate_products_active ON affiliate_products(active);

-- Affiliate clicks tracking
CREATE TABLE IF NOT EXISTS affiliate_clicks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_id UUID REFERENCES affiliate_products(id) ON DELETE SET NULL,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  clicked_at TIMESTAMPTZ DEFAULT NOW(),
  source_page TEXT
);

CREATE INDEX IF NOT EXISTS idx_affiliate_clicks_product ON affiliate_clicks(product_id);
CREATE INDEX IF NOT EXISTS idx_affiliate_clicks_user ON affiliate_clicks(user_id);
CREATE INDEX IF NOT EXISTS idx_affiliate_clicks_date ON affiliate_clicks(clicked_at DESC);

-- Analytics events
CREATE TABLE IF NOT EXISTS analytics_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  event_name TEXT NOT NULL,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_analytics_events_name ON analytics_events(event_name);
CREATE INDEX IF NOT EXISTS idx_analytics_events_user ON analytics_events(user_id);
CREATE INDEX IF NOT EXISTS idx_analytics_events_date ON analytics_events(created_at DESC);

-- Row Level Security Policies
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE news_sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE discovered_news ENABLE ROW LEVEL SECURITY;
ALTER TABLE article_sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE missions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_mission_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE caption_generations ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscribers ENABLE ROW LEVEL SECURITY;
ALTER TABLE affiliate_products ENABLE ROW LEVEL SECURITY;
ALTER TABLE affiliate_clicks ENABLE ROW LEVEL SECURITY;
ALTER TABLE analytics_events ENABLE ROW LEVEL SECURITY;

-- Users: users can read their own data, admins can read all
CREATE POLICY "Users can view own profile" ON users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Admins can view all users" ON users FOR SELECT USING (
  EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
);

-- Articles: public can read published, authors/editors can read own drafts, admins all
CREATE POLICY "Published articles are public" ON articles FOR SELECT USING (status = 'published');
CREATE POLICY "Authors can view own articles" ON articles FOR SELECT USING (author_id = auth.uid());
CREATE POLICY "Admins/Editors can view all articles" ON articles FOR SELECT USING (
  EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role IN ('admin', 'editor'))
);

-- Categories: public read
CREATE POLICY "Categories are public" ON categories FOR SELECT USING (true);

-- Missions: public read
CREATE POLICY "Missions are public" ON missions FOR SELECT USING (true);

-- User mission progress: users can manage own progress
CREATE POLICY "Users can view own progress" ON user_mission_progress FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Users can insert own progress" ON user_mission_progress FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Users can update own progress" ON user_mission_progress FOR UPDATE USING (user_id = auth.uid());

-- Caption generations: users can manage own
CREATE POLICY "Users can view own generations" ON caption_generations FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Users can insert own generations" ON caption_generations FOR INSERT WITH CHECK (user_id = auth.uid());

-- Subscribers: admin only
CREATE POLICY "Admins can manage subscribers" ON subscribers FOR ALL USING (
  EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
);

-- Affiliate products: public read active
CREATE POLICY "Active affiliate products are public" ON affiliate_products FOR SELECT USING (active = true);
CREATE POLICY "Admins can manage affiliate products" ON affiliate_products FOR ALL USING (
  EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
);

-- Affiliate clicks: admin only
CREATE POLICY "Admins can view affiliate clicks" ON affiliate_clicks FOR SELECT USING (
  EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
);

-- Analytics events: admin only
CREATE POLICY "Admins can view analytics" ON analytics_events FOR SELECT USING (
  EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
);

-- Seed categories
INSERT INTO categories (name, slug, description) VALUES
  ('Beginner Guides', 'beginner-guides', 'Getting started with GTA VI'),
  ('Characters', 'characters', 'Protagonists, NPCs, and character guides'),
  ('Missions', 'missions', 'Mission walkthroughs and strategies'),
  ('Vehicles', 'vehicles', 'Cars, bikes, boats, aircraft and more'),
  ('Weapons', 'weapons', 'Weapon stats, locations, and loadouts'),
  ('Map & Locations', 'map-locations', 'Leonida map, landmarks, and points of interest'),
  ('Gameplay', 'gameplay', 'Gameplay mechanics, systems, and features'),
  ('Tips & Tricks', 'tips-tricks', 'Pro tips, secrets, and hidden mechanics'),
  ('Technical Guides', 'technical-guides', 'Settings, performance, and troubleshooting'),
  ('FAQ', 'faq', 'Frequently asked questions')
ON CONFLICT (name) DO NOTHING;