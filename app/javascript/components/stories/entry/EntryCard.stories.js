import EntryCard from "@js/components/entry/EntryCard.vue";
import { buildEntry } from "@spec/mocks/Entry";

export default {
  title: "EntryCard",
  component: EntryCard,
};

const Template = (args) => ({
  components: { EntryCard },
  setup() {
    return { args };
  },
  // eslint-disable-next-line quotes
  template: '<entry-card  v-bind="args" />',
});

const entry = buildEntry(1);
entry.eyeCatchingImage = "";

export const Default = Template.bind({});
Default.args = {
  entry: entry,
};
