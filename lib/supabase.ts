import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  // Fail gracefully in build environments where env vars may not be set yet
}

export const supabase = createClient(
  supabaseUrl ?? '',
  supabaseAnonKey ?? '',
)

export type Database = {
  public: {
    Tables: {
      users: {
        Row: {
          id: string
          email: string
          name: string | null
          role: string
          created_at: string
        }
        Insert: {
          id: string
          email: string
          name?: string | null
          role?: string
          created_at?: string
        }
        Update: {
          id?: string
          email?: string
          name?: string | null
          role?: string
          created_at?: string
        }
      }
      articles: {
        Row: {
          id: string
          title: string
          slug: string
          content: string
          excerpt: string | null
          category_id: string | null
          status: string
          author_id: string | null
          published_at: string | null
          updated_at: string
          seo_title: string | null
          seo_description: string | null
        }
      }
      categories: {
        Row: { id: string; name: string; slug: string; description: string | null }
      }
      news_sources: {
        Row: {
          id: string
          name: string
          url: string
          source_type: string
          category: string | null
          active: boolean
          last_checked_at: string | null
        }
      }
      discovered_news: {
        Row: {
          id: string
          source_id: string | null
          original_url: string
          title: string
          summary: string | null
          source_published_at: string | null
          verification_status: string
          duplicate_of: string | null
          created_at: string
        }
      }
      missions: {
        Row: { id: string; title: string; category: string | null; sequence: number; verified: boolean; created_at: string }
      }
      user_mission_progress: {
        Row: { id: string; user_id: string | null; mission_id: string; completed: boolean; completed_at: string | null }
      }
      caption_generations: {
        Row: { id: string; user_id: string | null; input_text: string; platform: string; generated_output: string; created_at: string }
      }
      subscribers: {
        Row: { id: string; email: string; first_name: string | null; consent_status: string; consent_timestamp: string | null; unsubscribe_timestamp: string | null }
      }
      affiliate_products: {
        Row: { id: string; product_name: string; category: string | null; product_url: string | null; affiliate_url: string | null; active: boolean }
      }
      affiliate_clicks: {
        Row: { id: string; product_id: string | null; user_id: string | null; clicked_at: string; source_page: string | null }
      }
      analytics_events: {
        Row: { id: string; event_name: string; user_id: string | null; metadata: string | null; created_at: string }
      }
    }
    Views: {}
    Functions: {}
    Enums: {}
    CompositeTypes: {}
  }
}