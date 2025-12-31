// Page/Content types

export type PageType = 'Markdown' | 'SOP' | 'Runbook' | 'Checklist';

export interface Page {
  id: string;
  title: string;
  content: string;
  type: PageType;
  tags: string[];
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
}

export interface PageVersion {
  id: string;
  pageId: string;
  content: string;
  version: number;
  createdAt: Date;
  createdBy: string;
}
