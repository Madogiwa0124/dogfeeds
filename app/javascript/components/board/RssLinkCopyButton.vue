<template>
  <button class="rss-link-copy-button button is-conversion is-rounded" @click.stop="handleOnRssLinkCopyClick">
    このRSSフィードのURLをコピーする
    <font-awesome-icon icon="rss" />
  </button>
</template>

<script lang="ts">
import { defineComponent, PropType } from "vue";
import { Board } from "@js/types/types";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faRss } from "@fortawesome/free-solid-svg-icons";
import { trackEvent } from "@js/services/Gtag";
library.add(faRss);

export default defineComponent({
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
      trackEvent({
        action: "copy_board_rss_link",
        category: this.$options.name,
        label: this.board.title,
      });
      alert(`${this.rssUrl}をクリップボードにコピーしました！`);
    },
  },
});
</script>
<style lang="scss" scoped></style>
