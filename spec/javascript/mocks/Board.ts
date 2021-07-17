import { Board } from "@js/types/types";
import { buildEntry } from "./Entry";

export const buildBoard = (id: number): Board => {
  return {
    id: id,
    title: `board title ${id}`,
    description: `board description ${id}`,
    feedIds: [id],
    lastEntry: buildEntry(1),
  };
};
