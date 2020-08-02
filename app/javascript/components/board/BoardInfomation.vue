<template>
  <div class="board-information">
    <h1 class="title">{{ board.title }}</h1>
    <p class="description">
      {{ board.description }}
      <a :href="rssUrl" target="_blank" rel="noopener">
        Rssへのリンクはこちら
        <i class="fas fa-rss" />
      </a>
    </p>
    <entry-card-collection :entries="entries" />
  </div>
</template>

<script lang="ts">
import Vue, { PropType } from "vue";
import { Entry, Board } from "@js/types/types.d.ts";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";

export default Vue.extend({
  name: "FeedInfomation",
  components: { EntryCardCollection },
  props: {
    board: {
      type: Object as PropType<Board>,
      required: true,
    },
    entries: {
      type: Array as PropType<Entry[]>,
      default: [],
    },
  },
  computed: {
    rssUrl: function (): string {
      return `/boards/${this.board.id}.rss`;
    },
  },
});
</script>
<style lang="scss" scoped>
.board-information {
  .title {
    text-align: center;
  }

  .description {
    margin: 0px auto;
    padding: 10px;
    width: 90%;
    border-radius: 5px;
    background-color: #ffffff;
  }
}
</style>
