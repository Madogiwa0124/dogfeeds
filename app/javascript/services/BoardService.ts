import { PostBoardResponse } from "@js/types/types.d.ts";
import Client from "@js/services/Client.ts";
const BOARDS_API_ENDPOINT = "/api/boards";

export async function postBoard(params: object): Promise<PostBoardResponse> {
  const response = await Client.post(BOARDS_API_ENDPOINT, { boards: params });
  return response.data;
}
