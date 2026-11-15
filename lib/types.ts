export interface Bill {
  id: string
  bill_id: string
  student_name: string
  bill_type: string
  amount: number
  amount_paid: number
  school?: string | null
  description: string
  country: string
  currency: string
  status: string
  created_at: string
  evidence_url?: string | null
  owner_phone?: string | null
  owner_email?: string | null
  is_test: boolean
  payer_name?: string | null
  payer_phone?: string | null
  payer_email?: string | null
  last_payment_amount?: number | null
  last_payment_at?: string | null
}
