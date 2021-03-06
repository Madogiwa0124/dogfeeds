import { mount } from "@vue/test-utils";
import Component from "@js/components/entry/EntryCard.vue";
import { buildEntry } from "@spec/mocks/Entry";
import { advanceTo } from "jest-date-mock";

describe("components/entry/EntryCard.vue", () => {
  it("snapshot", () => {
    const props = { entry: buildEntry(1) };
    advanceTo(new Date("2021-05-03T15:35:47+09:00"));
    const wrapper = mount(Component, { propsData: props });
    expect(wrapper.element).toMatchSnapshot();
  });
});
