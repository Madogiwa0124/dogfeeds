import Client from "@js/services/Client.ts";
import { Entry } from "@js/types/types.d.ts";

const ENTRY_API_ENDPOINT = "/api/entries";

export async function getEntries(query = "", params: object): Promise<Entry[]> {
  const response = await Client.get(ENTRY_API_ENDPOINT + query, { params: params });
  const entries: Entry[] = response.data;
  return entries;
}