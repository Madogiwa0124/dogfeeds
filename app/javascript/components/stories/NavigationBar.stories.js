import NavigationBar from "@js/components/NavigationBar.vue";

export default {
  title: "NavigationBar",
  component: NavigationBar,
};

export const Default = () => ({
  components: { NavigationBar },
  setup() {
    return {};
  },
  template: "<navigation-bar />",
});
