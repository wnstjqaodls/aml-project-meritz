interface AmountDisplayProps {
  amount: number | string | undefined | null
  currency?: string
  showCurrency?: boolean
}

export default function AmountDisplay({
  amount,
  currency = 'KRW',
  showCurrency = true,
}: AmountDisplayProps) {
  if (amount === null || amount === undefined || amount === '') {
    return <span>-</span>
  }

  const num = typeof amount === 'string' ? parseFloat(amount) : amount
  if (isNaN(num)) return <span>-</span>

  const formatted = new Intl.NumberFormat('ko-KR').format(num)

  const prefix = showCurrency
    ? currency === 'KRW'
      ? '₩'
      : currency + ' '
    : ''

  return (
    <span className="amount-display">
      {prefix}
      {formatted}
    </span>
  )
}
