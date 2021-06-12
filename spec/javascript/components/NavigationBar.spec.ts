import { mount } from "@vue/test-utils";
import Component from "@js/components/NavigationBar.vue";

describe("components/NavigationBar.vue", () => {
  it("snapshot", () => {
    const wrapper = mount(Component);
    expect(wrapper.element).toMatchSnapshot();
  });
});
