import Client from "@js/services/Client.ts";
import { Tag } from "@js/types/types.d.ts";

const TAGS_API_ENDPOINT = "/api/tags";

export async function getTags(query = "", params: object): Promise<Tag[]> {
  const response = await Client.get(TAGS_API_ENDPOINT + query, { params: params });
  console.log(response.data);
  const tags: Tag[] = response.data;
  return tags;
}
