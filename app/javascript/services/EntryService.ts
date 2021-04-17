import Client from "@js/services/Client";
import { Entry } from "@js/types/types";

const FEED_ENTRY_API_ENDPOINT = "/api/feed_entries";
const ENTRY_API_ENDPOINT = "/api/entries";
const CLIP_STRAGE_KEY = "clipedEntriyIds";

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

export function getClipedEntryIds(): Set<number> {
  const strage = window.localStorage;
  let strageValue = strage.getItem(CLIP_STRAGE_KEY);
  if (strageValue === null) strageValue = "[]";
  return new Set(JSON.parse(strageValue) as number[]);
}

export function clipEntry(entryId: number, cliped: boolean): void {
  const strage = window.localStorage;
  const clipedEntriyIds = getClipedEntryIds();
  cliped ? clipedEntriyIds.add(entryId) : clipedEntriyIds.delete(entryId);
  strage.setItem(CLIP_STRAGE_KEY, JSON.stringify(Array.from(clipedEntriyIds)));
}
