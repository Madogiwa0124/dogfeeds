import { Feed } from "@js/types/types";
import { buildEntry } from "./Entry";
import { buildFeedTag } from "./FeedTag";

export const buildFeed = (id: number): Feed => {
  return {
    id: id,
    title: `feed title ${id}`,
    lastPublishedAt: new Date("2021-05-03T14:35:46+09:00"),
    endpoint: "https://example.com/rss",
    lastEntry: buildEntry(id),
    tags: [buildFeedTag(id), buildFeedTag(id)],
  };
};
