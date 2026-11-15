# Leonida Insider — Project Context

## Project Overview
Leonida Insider is an AI-powered GTA VI gaming intelligence & player resource platform.

## Tech Stack
- Next.js 14 (App Router) + TypeScript
- Tailwind CSS + shadcn/ui + Radix UI
- Supabase PostgreSQL (RLS enabled)
- Claude API (Anthropic)
- Resend (email)
- Vercel (hosting)

## Commands
```bash
npm run dev          # Start dev server on :3000
npm run build        # Production build
npm run start        # Start production server
npm run lint         # ESLint
npm run format       # Prettier
```

## Environment
Copy `.env.example` to `.env.local` and fill in:
- `NEXT_PUBLIC_SUPABASE_URL` / `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `ANTHROPIC_API_KEY`
- `RESEND_API_KEY`
- `RESEND_FROM_EMAIL`

## Architecture

### Directory Structure
```
app/                # Next.js App Router (routes, API routes, layout)
components/         # React components (ui/, layout/, modules/)
lib/                # Supabase, types, AI, auth, utils
ai/                 # Claude prompt templates
public/             # Static assets
docs/              # Documentation & ADRs
```

### Key Conventions
- App Router only — no Pages Router
- Use `@/` path alias for imports
- Server components by default; client components only when needed
- Tailwind classes; shadcn/ui primitives where appropriate
- Dark gaming theme: background `#0B0F1A`, accent `#39FF14` (neon green), gold `#F59E0B`
- All DB access through Supabase client with RLS enforced

### Data Model
See `schema.sql` for the authoritative database schema.

### Key Decisions
- Mission Tracker supports guest (localStorage) + authenticated (Supabase) progress
- Newsroom requires human editorial approval before publishing
- Caption Studio uses Claude API server-side only (API key never exposed)
- AI claims must be flagged as speculation/rumour; never presented as fact

## Build Phases
1. **Foundation** (current): App setup, database, auth, homepage
2. **MVP Features**: All five products
3. **Quality & SEO**: Performance, a11y, optimization
4. **Production**: Deployment, monitoring, scaling

## Current Status
- **Phase**: 1 — Project Foundation (in progress)

## TODO
- [ ] Initialize Next.js + TypeScript + Tailwind + shadcn/ui
- [ ] Connect Supabase
- [ ] Apply database schema
- [ ] Implement authentication & admin roles
- [ ] Build shared navigation & homepage
- [ ] Configure environment variables
- [ ] Verify application runs locally
- [ ] Create GitHub repository

## References
- PRD: `docs/PRD-GTA6.md`
- Architecture decisions: `docs/ADRs/`
- Database schema: `schema.sql`
- API routes: `app/api/`
- AI prompts: `ai/`
