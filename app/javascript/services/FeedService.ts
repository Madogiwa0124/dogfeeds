import axios, { AxiosResponse } from "axios";
import { FeedsResponse } from "@js/types/types.d.ts";

const FEEDS_API_ENDPOINT = "/api/feeds";

export async function getFeeds(query: "", params: object): Promise<FeedsResponse> {
  const response: AxiosResponse = await axios.get(FEEDS_API_ENDPOINT + query, {params: params});
  return response.data;
}
