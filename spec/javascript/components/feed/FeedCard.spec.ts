import { mount } from "@vue/test-utils";
import Component from "@js/components/feed/FeedCard.vue";
import { buildFeed } from "@spec/mocks/Feed";
import { advanceTo } from "jest-date-mock";

describe("components/feed/FeedCard.vue", () => {
  it("snapshot", () => {
    const props = { feed: buildFeed(1) };
    advanceTo(new Date("2021-05-03T15:35:47+09:00"));
    const wrapper = mount(Component, { propsData: props });
    expect(wrapper.element).toMatchSnapshot();
  });
});
