# Leonida Insider — GTA VI Intelligence Platform

Leonida Insider is an independent GTA VI information and player resource platform combining five integrated products:

## Products

- **GTA VI Help Centre** — Searchable knowledge base of verified guides, tutorials, and player resources
- **Interactive Mission Tracker** — Track GTA VI completion progress with an interactive checklist
- **AI Clip Caption Studio** — Generate viral gaming captions, hooks, and social content from gameplay clips
- **AI-Powered Newsroom** — AI-assisted editorial workflow turning verified sources into original news
- **Launch Countdown** — Central landing page for email subscriber acquisition

## Architecture

Leonida Insider uses:
- **Frontend**: Next.js 14 (App Router) + TypeScript
- **Styling**: Tailwind CSS + shadcn/ui components
- **Backend**: Next.js server-side functions
- **Database**: Supabase PostgreSQL with Row Level Security
- **AI**: Claude API for caption generation and news analysis
- **Email**: Resend for campaigns
- **Analytics**: Google Analytics 4
- **Hosting**: Vercel

## Quick Start

### Prerequisites

- Node.js 18+
- Supabase account (PostgreSQL)
- Anthropic API key (for AI features)

### Development

```bash
# Install dependencies
npm install

# Set environment variables
cp .env.example .env.local
# Edit .env.local with your Supabase, Anthropic, and Resend credentials

# Run the development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the app.

### Build

```bash
npm run build
```

### Production

```bash
npm start
```

### Database

Apply the schema with:

```bash
supabase db push
```

This will run `schema.sql` against your Supabase PostgreSQL database.

### Deployment

Deploy to Vercel with:

```bash
npm install -g vercel
vercel --prod
```

## Contribution

Based on the massive PRD "GTA VI Information Management" designed for AI-assisted development.

## Architecture Decision Records

See `docs/ADRs/` for architectural decisions and rationale.

## Development Workflow

Use Claude Code with the following phases:

1. **Foundation** (5 days): App setup, database, authentication
2. **MVP Features** (10 days): All five products functional
3. **Quality & SEO** (5 days): Performance, accessibility, optimization
4. **Production** (5 days): Deployment, monitoring, scaling

## File Structure

```
src/
├── app/                    # Next.js App Router
│   ├── page.tsx           # Homepage
│   ├── not-found.tsx       # 404 page
│   └── layout.tsx         # Root layout
├── components/             # React components
│   ├── ui/                # shadcn/ui components
│   ├── layout/           # Navigation
│   ├── modules/           # Product components
│   └── ui/               # Atomic UI
├── lib/                    # Application logic
│   ├── supabase.ts        # Supabase client
│   ├── types.ts           # TypeScript types
│   ├── auth/             # Authentication
│   ├── ai/               # Claude API integration
│   └── utils.ts           # Helper functions
└── ai/                    # Claude prompt templates
    ├── caption-studio.md
    ├── newsroom.md
    └── prompts.md
```

## AI Prompt Libraries

- **Caption Studio**: System prompts for generating viral gaming captions
- **Newsroom**: Content extraction, verification, and editorial workflows
- **Help Centre**: Article generation with GTA VI fact-checking

## Monitoring & Analytics

- User tracking for all features
- Error monitoring with Vercel Analytics
- Conversion tracking for email signups and affiliate links
- Performance monitoring (Core Web Vitals)

## Security

- Row Level Security (RLS) policies on all database tables
- Server-side API routes for sensitive operations
- Email verification for campaigns
- Input validation and sanitization
- Rate limiting on AI generation endpoints

## SEO & Content Strategy

- Each article has SEO fields: title, description, canonical URL
- Open Graph metadata for social sharing
- Structured data for rich search results
- XML sitemap generation
- Internal linking strategy for organic traffic

## Email Campaign Strategy

The platform serves multiple email campaigns:

### Pre-Launch
- GTA VI news updates
- Helpful player guides
- Mission tracker tips

### Launch
- Launch day information
- Beginner guides
- Resource announcements

### Post-Launch
- New guides
- Progress sharing
- Community highlights

All campaigns respect unsubscribe requirements and include clear sender identification.

## Contact

For questions, suggestions, or collaboration opportunities:
- GitHub Issues
- Documentation in `docs/`
- Architecture decisions in `docs/ADRs/`

Leonida Insider aims to become the centralized destination for GTA VI players, helping thousands discover useful information and stay engaged with the Leonida ecosystem.