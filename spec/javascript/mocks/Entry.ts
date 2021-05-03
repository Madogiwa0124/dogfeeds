import { Entry } from "@js/types/types";

export const buildEntry = (id: number, feedId: number = id): Entry => {
  return {
    id: id,
    title: `entry title ${id}`,
    description: `entry discription ${id}`,
    link: "https://example.com",
    eyeCatchingImage: "https://example/com/sample.png",
    publishedAt: new Date("2021-05-03T14:35:46+09:00"),
    feedId: feedId,
  };
};
