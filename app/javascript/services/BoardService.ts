import Client from "@js/services/Client.ts";
const BOARDS_API_ENDPOINT = "/api/boards";

export function postBoard(params: object): Promise<void> {
  return Client.post(BOARDS_API_ENDPOINT, { boards: params });
}
