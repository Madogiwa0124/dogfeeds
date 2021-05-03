import { FeedTag } from "@js/types/types";

export const buildFeedTag = (id: number, feedId: number = id): FeedTag => {
  return {
    id: id,
    body: `feed tag body ${id}`,
    feedId: feedId,
  };
};
