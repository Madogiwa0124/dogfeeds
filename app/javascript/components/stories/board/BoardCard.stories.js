import BoardCard from "@js/components/board/BoardCard.vue";
import { buildBoard } from "@spec/mocks/Board";
import { buildFeed } from "@spec/mocks/Feed";

export default {
  title: "BoardCard",
  component: BoardCard,
};

const Template = (args) => ({
  components: { BoardCard },
  setup() {
    return { args };
  },
  // eslint-disable-next-line quotes
  template: '<board-card  v-bind="args" />',
});

const board = buildBoard(1);
const feeds = [buildFeed(1)];
feeds[0].lastEntry.eyeCatchingImage = "";

export const Default = Template.bind({});
Default.args = {
  board: board,
  feeds: feeds,
};
