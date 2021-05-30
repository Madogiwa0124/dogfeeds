import Client from "@js/services/Client";
import { Feed } from "@js/types/types";
import { FEEDS_API_ENDPOINT } from "@js/services/Routes";

export async function getFeeds(query = "", params: object): Promise<Feed[]> {
  const response = await Client.get(FEEDS_API_ENDPOINT + query, { params: params });
  const feeds: Feed[] = response.data;
  return feeds;
}

export async function getFeed(id: number): Promise<Feed> {
  const response = await Client.get(`${FEEDS_API_ENDPOINT}/${id}`);
  const feed: Feed = response.data;
  return feed;
}
