import { Tag } from "@js/types/types";

export const buildTag = (body: string, count = 1): Tag => {
  return {
    body: body,
    count: count,
  };
};
