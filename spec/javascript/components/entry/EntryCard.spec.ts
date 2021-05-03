import { mount } from "@vue/test-utils";
import Component from "@js/components/entry/EntryCard.vue";
import { buildEntry } from "@spec/mocks/Entry";

describe("components/entry/EntryCard.vue", () => {
  it("snapshot", () => {
    const props = { entry: buildEntry(1) };
    const wrapper = mount(Component, { propsData: props });
    expect(wrapper.element).toMatchSnapshot();
  });
});
