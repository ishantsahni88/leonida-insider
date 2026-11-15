import type { Metadata } from 'next'
import Link from 'next/link'
import { ArrowRight, Gamepad2, Newspaper, Search, Captions, Rocket, Shield, Users, MapPin } from 'lucide-react'

export const metadata: Metadata = {
  title: 'Leonida Insider',
  description:
    'The latest GTA VI news, guides, discoveries, and tools. Everything you need to stay ahead.',
}

const MODULES = [
  {
    slug: '/guides',
    icon: Search,
    name: 'GTA VI Help Centre',
    tagline: 'Searchable knowledge base of verified GTA VI guides, FAQs, and player resources.',
    priority: 'P0',
  },
  {
    slug: '/missions',
    icon: Gamepad2,
    name: 'Mission Tracker',
    tagline: 'Track your GTA VI completion progress with an interactive checklist.',
    priority: 'P0',
  },
  {
    slug: '/captions',
    icon: Captions,
    name: 'Caption Studio',
    tagline: 'Generate viral gaming captions, hooks, and social content from your clips.',
    priority: 'P1',
  },
  {
    slug: '/news',
    icon: Newspaper,
    name: 'AI Newsroom',
    tagline: 'AI-assisted editorial workflow turning verified sources into original news.',
    priority: 'P0/P1',
  },
  {
    slug: '/countdown',
    icon: Rocket,
    name: 'Launch Countdown',
    tagline: 'Countdown to GTA VI launch with email subscriber acquisition.',
    priority: 'P0',
  },
]

export default function HomePage() {
  return (
    <main className="min-h-screen bg-[#0B0F1A] text-white">
      {/* Header */}
      <header className="sticky top-0 z-20 bg-[#0B0F1A]/90 backdrop-blur border-b border-white/10">
        <div className="max-w-6xl mx-auto px-4 py-3 flex justify-between items-center gap-4 flex-wrap">
          <Link href="/" className="flex items-center gap-2">
            <div className="w-9 h-9 bg-[#39FF14] rounded-lg flex items-center justify-center">
              <Gamepad2 className="w-5 h-5 text-black" />
            </div>
            <div>
              <h1 className="text-lg font-black tracking-tight">Leonida Insider</h1>
              <p className="text-[10px] text-slate-400">Your Ultimate Guide to Leonida</p>
            </div>
          </Link>
          <nav className="flex gap-2 items-center text-xs flex-wrap">
            <Link href="/" className="px-3 py-2 rounded-full bg-[#39FF14] text-black font-bold">Home</Link>
            <Link href="/guides" className="px-3 py-2 rounded-full bg-white/10 hover:bg-white/20 transition">Guides</Link>
            <Link href="/missions" className="px-3 py-2 rounded-full bg-white/10 hover:bg-white/20 transition">Missions</Link>
            <Link href="/captions" className="px-3 py-2 rounded-full bg-white/10 hover:bg-white/20 transition">Captions</Link>
            <Link href="/news" className="px-3 py-2 rounded-full bg-white/10 hover:bg-white/20 transition">News</Link>
            <Link href="/countdown" className="px-3 py-2 rounded-full bg-white/10 hover:bg-white/20 transition">Countdown</Link>
          </nav>
        </div>
      </header>

      {/* Hero */}
      <section className="relative overflow-hidden border-b border-white/10">
        <div className="absolute inset-0 bg-gradient-to-b from-[#39FF14]/10 via-transparent to-transparent" />
        <div className="max-w-6xl mx-auto px-4 py-16 md:py-24 relative">
          <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-[#39FF14]/10 border border-[#39FF14]/30 text-[#39FF14] text-xs font-bold mb-6">
            <Newspaper className="w-3.5 h-3.5" /> AI-Powered GTA VI Intelligence
          </div>
          <h2 className="text-4xl md:text-6xl font-black tracking-tight leading-tight max-w-4xl">
            YOUR ULTIMATE GUIDE TO <span className="text-[#39FF14]">LEONIDA</span>
          </h2>
          <p className="mt-6 text-lg text-slate-300 max-w-2xl">
            The latest GTA VI news, guides, discoveries, and tools. Everything you need to stay ahead of
            the Leonida sun.
          </p>
          <div className="mt-8 flex gap-3 flex-wrap">
            <Link
              href="/guides"
              className="px-6 py-3 bg-[#39FF14] text-black rounded-full font-bold flex items-center gap-2"
            >
              Explore Latest News <ArrowRight className="w-4 h-4" />
            </Link>
            <Link
              href="/missions"
              className="px-6 py-3 bg-white/10 rounded-full font-bold flex items-center gap-2 hover:bg-white/20 transition"
            >
              Start Mission Tracker
            </Link>
          </div>
        </div>
      </section>

      {/* Modules */}
      <section className="max-w-6xl mx-auto px-4 py-16">
        <h3 className="text-2xl font-black mb-8">THE FIVE PRODUCTS</h3>
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
          {MODULES.map((m) => (
            <Link
              key={m.slug}
              href={m.slug}
              className="bg-[#111827] border border-white/10 rounded-2xl p-6 hover:border-[#39FF14]/50 transition group"
            >
              <div className="w-11 h-11 bg-white/5 rounded-xl flex items-center justify-center mb-4 group-hover:bg-[#39FF14]/10 transition">
                <m.icon className="w-6 h-6 text-[#39FF14]" />
              </div>
              <div className="flex items-center justify-between mb-2">
                <h4 className="font-bold text-lg">{m.name}</h4>
                <span className="text-[10px] font-bold text-[#39FF14] bg-[#39FF14]/10 px-2 py-1 rounded-full">{m.priority}</span>
              </div>
              <p className="text-sm text-slate-400">{m.tagline}</p>
            </Link>
          ))}
        </div>
      </section>

      {/* Trust bar */}
      <section className="border-t border-white/10 py-12">
        <div className="max-w-6xl mx-auto px-4 grid md:grid-cols-3 gap-6 text-center">
          <div>
            <Shield className="w-6 h-6 text-[#39FF14] mx-auto mb-2" />
            <p className="font-bold text-sm">Independently verified</p>
            <p className="text-xs text-slate-400 mt-1">Sources cross-checked before publication</p>
          </div>
          <div>
            <Users className="w-6 h-6 text-[#39FF14] mx-auto mb-2" />
            <p className="font-bold text-sm">Community powered</p>
            <p className="text-xs text-slate-400 mt-1">Player reports & community discoveries</p>
          </div>
          <div>
            <MapPin className="w-6 h-6 text-[#39FF14] mx-auto mb-2" />
            <p className="font-bold text-sm">Fan resource</p>
            <p className="text-xs text-slate-400 mt-1">Independent of Rockstar affiliation</p>
          </div>
        </div>
      </section>
    </main>
  )
}
