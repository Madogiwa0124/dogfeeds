import { Board, PostBoardResponse } from "@js/types/types.d.ts";
import Client from "@js/services/Client.ts";
const BOARDS_API_ENDPOINT = "/api/boards";

export async function postBoard(params: object): Promise<PostBoardResponse> {
  const response = await Client.post(BOARDS_API_ENDPOINT, { boards: params });
  return response.data;
}

export async function getBoard(id: number): Promise<Board> {
  const response = await Client.get(`${BOARDS_API_ENDPOINT}/${id}`);
  return response.data;
}
