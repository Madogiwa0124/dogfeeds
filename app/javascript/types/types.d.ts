export interface OriginFeed {
  id: number;
  endpoint: string;
  last_published_at: Date;
  title: string;
  created_at: Date;
  updated_at: Date;
}

export interface Feed {
  id: number;
  endpoint: string;
  last_published_at: Date;
  title: string;
  created_at: Date;
  updated_at: Date;
  last_entry: OriginEntry;
  tags: OriginFeedTag[];
}

export interface OriginEntry {
  id: number;
  description: Text;
  eye_catching_image: string;
  link: string;
  published_at: Date;
  title: string;
  created_at: Date;
  updated_at: Date;
  feed_id: number;
}

export interface OriginFeedTag {
  feed_id: number;
  body: Text;
}

export interface FeedsResponse {
  feeds: OriginFeed[];
  last_entries: OriginEntry[];
  tags: OriginFeedTag[];
}
export interface PostBoardResponse {
  id: number;
}
