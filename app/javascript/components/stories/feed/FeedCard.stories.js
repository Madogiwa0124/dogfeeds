import FeedCard from "@js/components/feed/FeedCard.vue";
import { buildFeed } from "@spec/mocks/Feed";

export default {
  title: "FeedCard",
  component: FeedCard,
};

const Template = (args) => ({
  components: { FeedCard },
  setup() {
    return { args };
  },
  // eslint-disable-next-line quotes
  template: '<feed-card  v-bind="args" />',
});

const feed = buildFeed(1);
feed.lastEntry.eyeCatchingImage = "";

export const Default = Template.bind({});
Default.args = {
  feed: feed,
};
