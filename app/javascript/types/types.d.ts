export interface Feed {
  id: number;
  endpoint: string;
  lastPublishedAt: Date;
  title: string;
  lastEntry: Entry;
  tags: FeedTag[];
}

export interface Entry {
  id: number;
  description: string;
  eyeCatchingImage: string;
  link: string;
  publishedAt: Date;
  title: string;
  feedId: number;
}

export interface FeedTag {
  id: number;
  body: string;
  feedId: number;
}

export interface Board {
  id: number;
  title: string;
  description: string;
  feedIds: number[];
  lastEntry: Entry;
}

export interface PostBoardResponse {
  id: number;
}
