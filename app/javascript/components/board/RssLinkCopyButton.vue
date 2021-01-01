<template>
  <button class="rss-link-copy-button button is-conversion is-rounded" @click.stop="handleOnRssLinkCopyClick">
    このRSSフィードのURLをコピーする
    <font-awesome-icon icon="rss" />
  </button>
</template>

<script lang="ts">
import Vue, { PropType } from "vue";
import { Board } from "@js/types/types.ts";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faRss } from "@fortawesome/free-solid-svg-icons";
library.add(faRss);

export default Vue.extend({
  name: "FeedInfomation",
  components: { FontAwesomeIcon },
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
<style lang="scss" scoped></style>
