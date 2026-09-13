export interface CreatePartyInput {
  readonly name: string
  readonly description: string | null
  readonly imageUrl: string | null
  readonly isActive: boolean
}

export interface Party extends CreatePartyInput {
  readonly id: number
  readonly createdAt: string
  readonly updatedAt: string
}

export interface UpdatePartyInput {
  readonly name?: string
  readonly description?: string | null
  readonly imageUrl?: string | null
  readonly isActive?: boolean
}
