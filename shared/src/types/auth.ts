// Authentication types

export type UserRole = 'Admin' | 'User' | 'CustomerViewer';

export interface User {
  id: string;
  email: string;
  name: string;
  role: UserRole;
}

export interface AuthToken {
  token: string;
  expiresAt: Date;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  user: User;
  token: string;
}
