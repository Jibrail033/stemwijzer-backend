export interface PartyMatch {
  readonly partyId: number
  readonly partyName: string
  readonly matchPercentage: number | null
  readonly matchedAnswers: number
  readonly comparedAnswers: number
  readonly missingAnswers: number
}

export interface MatchingResult {
  readonly totalAnswers: number
  readonly matches: PartyMatch[]
}
