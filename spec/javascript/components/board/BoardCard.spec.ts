import { mount } from "@vue/test-utils";
import Component from "@js/components/board/BoardCard.vue";
import { buildBoard } from "@spec/mocks/Board";
import { advanceTo } from "jest-date-mock";
import { buildFeed } from "@spec/mocks/Feed";

describe("components/board/BoardCard.vue", () => {
  it("snapshot", () => {
    const props = { board: buildBoard(1), feeds: [buildFeed(1)] };
    advanceTo(new Date("2021-05-03T15:35:47+09:00"));
    const wrapper = mount(Component, { propsData: props });
    expect(wrapper.element).toMatchSnapshot();
  });
});
