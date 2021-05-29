import { mount } from "@vue/test-utils";
import Component from "@js/components/feed/TagsInput.vue";
import { buildTag } from "@spec/mocks/Tags";

describe("components/feed/FeedCard.vue", () => {
  describe("初期表示", () => {
    it("snapshot", () => {
      const props = { recommendedTags: [buildTag("tag1"), buildTag("tags2")] };
      const wrapper = mount(Component, { propsData: props });
      expect(wrapper.element).toMatchSnapshot();
    });

    describe("recommendedTagsが空の場合", () => {
      it("snapshot", () => {
        const props = { recommendedTags: [] };
        const wrapper = mount(Component, { propsData: props });
        expect(wrapper.element).toMatchSnapshot();
      });
    });
  });
});
