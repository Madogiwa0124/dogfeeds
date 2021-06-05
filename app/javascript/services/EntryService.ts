import Client from "@js/services/Client";
import { Entry } from "@js/types/types";
import { ENTRY_API_ENDPOINT, FEED_ENTRY_API_ENDPOINT } from "@js/services/Routes";

export async function getFeedEntries(query = "", params: object): Promise<Entry[]> {
  const response = await Client.get(FEED_ENTRY_API_ENDPOINT + query, { params: params });
  const entries: Entry[] = response.data;
  return entries;
}

export async function getEntries(query = "", params: object): Promise<Entry[]> {
  const response = await Client.get(ENTRY_API_ENDPOINT + query, { params: params });
  const entries: Entry[] = response.data;
  return entries;
}

const CLIP_STRAGE_KEY = "clipedEntriyIds";

export function getClipedEntryLinks(): Set<string> {
  const strage = window.localStorage;
  let strageValue = strage.getItem(CLIP_STRAGE_KEY);
  if (strageValue === null) strageValue = "[]";
  return new Set(JSON.parse(strageValue) as string[]);
}

export function clipEntry(link: string, cliped: boolean): void {
  const strage = window.localStorage;
  const clipedEntriyIds = getClipedEntryLinks();
  cliped ? clipedEntriyIds.add(link) : clipedEntriyIds.delete(link);
  strage.setItem(CLIP_STRAGE_KEY, JSON.stringify(Array.from(clipedEntriyIds)));
}
