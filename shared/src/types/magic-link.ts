// Magic link authentication types

export interface MagicLink {
  id: string;
  email: string;
  token: string;
  expiresAt: Date;
  used: boolean;
}
