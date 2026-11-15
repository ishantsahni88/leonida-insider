import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: {
    default: 'Leonida Insider — GTA VI Intelligence & Player Resources',
    template: '%s | Leonida Insider',
  },
  description:
    'Leonida Insider is an independent GTA VI information and player resource platform. News, guides, mission tracking, caption studio, and launch countdown — one destination for GTA VI players.',
  keywords: ['GTA VI', 'Grand Theft Auto VI', 'GTA 6', 'gaming guides', 'mission tracker', 'caption studio', 'GTA VI news'],
  openGraph: {
    title: 'Leonida Insider — Your Ultimate Guide to Leonida',
    description: 'The latest GTA VI news, guides, discoveries, and tools. Everything you need to stay ahead.',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Leonida Insider — Your Ultimate Guide to Leonida',
    description: 'The latest GTA VI news, guides, discoveries, and tools.',
  },
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className="font-sans antialiased bg-[#0B0F1A] text-white min-h-screen">
        {children}
      </body>
    </html>
  )
}
