<template>
  <div class="board-index">
    <div class="is-multiline columns">
      <board-card v-for="board in boards" :key="board.id" :board="board" />
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
import Vue from "vue";
import BoardCard from "@js/components/board/BoardCard.vue";
import PageLoader from "@js/components/common/PageLoader.vue";
import Message from "@js/components/common/Message.vue";
import { getBoards } from "@js/services/BoardService";
import { Board } from "@js/types/types";
import { sleep } from "@js/components/common/Sleep.ts";

interface DataType {
  boards: Board[];
  isLoading: boolean;
  hasError: boolean;
}

const LOADING_SLEEP_MSEC = 200;

export default Vue.extend({
  name: "IndexBoardContainer",
  components: { BoardCard, PageLoader, Message },
  data(): DataType {
    return {
      boards: [],
      isLoading: true,
      hasError: false,
    };
  },
  created: async function () {
    try {
      this.boards = await getBoards("", {});
      await sleep(LOADING_SLEEP_MSEC);
    } catch {
      this.hasError = true;
    } finally {
      this.isLoading = false;
    }
  },
});
</script>
<style lang="scss" scoped>
.board-index {
  padding: 20px;
}
</style>
