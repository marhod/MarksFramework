// Search types

export interface SearchRequest {
  query: string;
  filters?: Record<string, any>;
  page?: number;
  pageSize?: number;
}

export interface SearchResult {
  id: string;
  title: string;
  excerpt: string;
  type: string;
  relevance: number;
}
