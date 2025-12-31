// AI related types

export interface AIRequest {
  prompt: string;
  context?: string;
}

export interface AIResponse {
  result: string;
  confidence?: number;
}
