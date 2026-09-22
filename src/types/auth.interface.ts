export interface LoginInput {
  readonly email: string
  readonly password: string
}

export interface AuthenticatedSuperadmin {
  readonly id: number
  readonly name: string
  readonly email: string
}

export interface LoginResult {
  readonly token: string
  readonly user: AuthenticatedSuperadmin
}
