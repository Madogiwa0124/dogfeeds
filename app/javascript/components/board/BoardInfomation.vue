<template>
  <div class="board-information">
    <h1 class="title">{{ board.title }}</h1>
    <div class="btn-area center">
      <rss-link-copy-button :board="board" />
    </div>
    <p class="description">
      {{ board.description }}
    </p>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from "vue";
import { Board } from "@js/types/types";
import RssLinkCopyButton from "@js/components/board/RssLinkCopyButton.vue";

export default defineComponent({
  name: "FeedInfomation",
  components: { RssLinkCopyButton },
  props: {
    board: {
      type: Object as PropType<Board>,
      required: true,
    },
  },
  computed: {
    rssUrl: function (): string {
      return `${location.protocol}${location.host}/boards/${this.board.id}.rss`;
    },
  },
  methods: {
    handleOnRssLinkCopyClick: async function () {
      await navigator.clipboard.writeText(this.rssUrl);
      alert(`${this.rssUrl}をクリップボードにコピーしました！`);
    },
  },
});
</script>
<style lang="scss" scoped>
.board-information {
  .title {
    text-align: center;
    margin-bottom: 15px;
  }

  .btn-area {
    margin-bottom: 15px;

    button {
      max-width: 100%;
    }
  }

  .description {
    margin-bottom: 15px;
    padding: 10px;
    width: 100%;
    border-radius: 5px;
    background-color: #ffffff;
  }
}
</style>
