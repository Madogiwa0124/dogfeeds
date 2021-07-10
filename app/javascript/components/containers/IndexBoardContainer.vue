<template>
  <div class="board-index">
    <div class="is-multiline columns">
      <div v-for="board in boards" :key="board.id" class="column is-4">
        <board-card :board="board" :feeds="boradFeeds(board)" />
      </div>
    </div>
    <page-loader :init-is-loading="isLoading" />
    <message v-if="hasError" title="Error" body="予期せぬエラーが発生しました🐕" level="danger" />
    <message
      v-if="!isLoading && !hasError && boards.length === 0"
      title="Warning"
      body="登録されているボードがありません🐾"
      level="warning"
    />
  </div>
</template>
<script lang="ts">
import { defineComponent } from "vue";
import BoardCard from "@js/components/board/BoardCard.vue";
import PageLoader from "@js/components/common/PageLoader.vue";
import Message from "@js/components/common/Message.vue";
import { getBoards } from "@js/services/BoardService";
import { Board, Feed } from "@js/types/types";
import { sleep } from "@js/components/common/Sleep";
import { getFeeds } from "@js/services/FeedService";

interface DataType {
  boards: Board[];
  feeds: Feed[];
  isLoading: boolean;
  hasError: boolean;
}

const LOADING_SLEEP_MSEC = 200;

export default defineComponent({
  name: "IndexBoardContainer",
  components: { BoardCard, PageLoader, Message },
  data(): DataType {
    return {
      boards: [],
      feeds: [],
      isLoading: true,
      hasError: false,
    };
  },
  created: async function () {
    try {
      this.boards = await getBoards("", {});
      this.feeds = await getFeeds("", { ids: this.boards.flatMap((board) => board.feedIds) });
      await sleep(LOADING_SLEEP_MSEC);
    } catch {
      this.hasError = true;
    } finally {
      this.isLoading = false;
    }
  },
  methods: {
    boradFeeds: function (board: Board): Feed[] {
      return this.feeds.filter((feed) => board.feedIds.includes(feed.id));
    },
  },
});
</script>
<style lang="scss" scoped>
.board-index {
  padding: 20px;
}
</style>
