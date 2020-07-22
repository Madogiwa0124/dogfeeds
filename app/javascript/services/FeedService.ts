import Client from "@js/services/Client.ts";
import { FeedsResponse, Feed, OriginFeed, OriginEntry, OriginFeedTag } from "@js/types/types.d.ts";

const FEEDS_API_ENDPOINT = "/api/feeds";

function _lastEntry(lastEntryes: OriginEntry[], feed: OriginFeed): OriginEntry {
  return lastEntryes.find((entry) => {
    return entry.feed_id === feed.id;
  });
}

function _feedTag(feedTags: OriginFeedTag[], feed: OriginFeed): OriginFeedTag[] {
  return feedTags.filter((feedTag) => {
    return feedTag.feed_id === feed.id;
  });
}

export async function getFeeds(query = "", params: object): Promise<Feed[]> {
  const response = await Client.get(FEEDS_API_ENDPOINT + query, { params: params });
  const feedResponse: FeedsResponse = response.data;
  const result: Feed[] = feedResponse.feeds.map((feed) => {
    /* eslint-disable @typescript-eslint/camelcase */
    const last_entry: OriginEntry = _lastEntry(feedResponse.last_entries, feed);
    const tags: OriginFeedTag[] = _feedTag(feedResponse.tags, feed);
    return { ...feed, last_entry, tags };
    /* eslint-enable @typescript-eslint/camelcase */
  });
  return result;
}
