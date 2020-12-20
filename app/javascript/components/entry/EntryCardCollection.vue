<template>
  <div class="entry-card-collection entries is-multiline columns">
    <div v-for="entry in entries" :key="entry.id" :class="`column is-${clumnSize}`">
      <entry-card :entry="entry" :descriptionLimit="descriptionLimit" :showFeedLink="showFeedLink" />
    </div>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import VueCompositionApi, { defineComponent } from "@vue/composition-api";
Vue.use(VueCompositionApi);

import EntryCard from "@js/components/entry/EntryCard.vue";
import { Entry } from "@js/types/types.d.ts";

type Props = {
  entries: Entry[];
  descriptionLimit: number | null;
  clumnSize: number;
  showFeedLink: boolean;
};

export default defineComponent({
  components: { EntryCard },
  props: {
    clumnSize: {
      type: Number,
      default: 12,
    },
    descriptionLimit: {
      type: Number,
      default: null,
    },
    showFeedLink: {
      type: Boolean,
      default: false,
    },
    entries: {
      type: Array,
      default: () => {
        return [];
      },
    },
  },
  // propsの型定義のためsetup引数に型を設定
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  setup(props: Props) {
    return {};
  },
});
</script>
<style lang="scss" scoped>
.entry-card-collection {
  .entry-card {
    margin: 15px 0px;
  }
}
</style>
