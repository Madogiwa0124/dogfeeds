import { mount } from "@vue/test-utils";
import Component from "@js/components/containers/ShowMypageContainer.vue";
import { getEntries, getClipedEntryLinks } from "@js/services/EntryService";

jest.mock("@js/services/EntryService");

describe("components/containers/ShowMypageContainer.vue", () => {
  it("snapshot", () => {
    (getClipedEntryLinks as jest.Mock).mockReturnValue(new Set([]));
    (getEntries as jest.Mock).mockReturnValue(Promise.resolve([]));
    const wrapper = mount(Component);
    expect(wrapper.element).toMatchSnapshot();
  });
});
