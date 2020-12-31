<template>
  <div class="board-card card" @click="redirectBoardPath">
    <header class="card-header">
      <p class="card-header-title">
        {{ board.title }}
      </p>
    </header>
    <div class="card-content">
      <div class="card-image">
        <img v-for="(eyeCatch, index) in eyeCatches" :key="index" :src="eyeCatch" />
      </div>
      <div class="content">
        {{ board.description }}
        <p class="last-updated-at has-text-right">Last updated at {{ board.lastEntry.publishedAt | fromNow }}</p>
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">
        <rss-link-copy-button :board="board" />
      </p>
    </footer>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import moment from "moment";
import { Board, Feed } from "@js/types/types.ts";
import RssLinkCopyButton from "@js/components/board/RssLinkCopyButton.vue";
const NO_IMAGE_PATH = "/noimage.png";
const IMAGES_LIMIT = 6;
export default Vue.extend({
  name: "BoardCard",
  components: { RssLinkCopyButton },
  filters: {
    fromNow: function (value: string): string {
      return moment(value, "YYYYMMDD h:mm:ss").fromNow();
    },
  },
  props: {
    board: {
      type: Object as PropType<Board>,
      required: true,
    },
    feeds: {
      type: Array as PropType<Feed[]>,
      required: true,
    },
  },
  computed: {
    eyeCatches: function (): string[] {
      const result = this.feeds.map((feed) => {
        if (!feed.lastEntry.eyeCatchingImage) return NO_IMAGE_PATH;
        return feed.lastEntry.eyeCatchingImage;
      });
      return result.slice(0, IMAGES_LIMIT);
    },
    boardPath: function (): string {
      return `/boards/${this.board.id}`;
    },
  },
  methods: {
    redirectBoardPath: function (): void {
      window.location.href = this.boardPath;
    },
  },
});
</script>
<style lang="scss" scoped>
.board-card:hover {
  cursor: pointer;
  box-shadow: inherit;
}

.board-card {
  .card-header-title {
    padding: 10px;
    font-size: 14px;
  }

  .card-content {
    padding: 0px;
    font-size: 14px;

    .content {
      margin: 0px 10px 10px 10px;
    }
  }
  .card-image {
    margin: 0px;
    height: 200px;
    max-height: 200px;
    line-height: 0px;
    background-color: #eeeeee;

    img {
      width: 33%;
      height: 100px;
      object-fit: cover;
    }
  }
}
</style>
