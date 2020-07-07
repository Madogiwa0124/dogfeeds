export interface Feed {
  id: number;
  endpoint: string;
  last_published_at: Date;
  title: string;
  created_at: Date;
  updated_at: Date;
}

export interface Entry {
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

export interface FeedTag {
  feed_id: number;
  body: Text;
}

export interface FeedsResponse {
  feeds: Feed[];
  last_entries: Entry[];
  tags: FeedTag[];
}
export interface PostBoardResponse {
  id: number;
}
