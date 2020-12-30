<template>
  <div class="board-show">
    <message v-if="hasError" title="Error" body="予期せぬエラーが発生しました🐕" level="danger" />
    <message v-if="notFound" title="NotFound" body="対象のボードが見つかりませんでした🐾" level="warning" />

    <board-infomation v-if="!!board" :board="board" />
    <entry-card-collection :entries="entries" :clumn-size="3" />
    <page-loader :init-is-loading="isLoading" />
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import { Entry, Board } from "@js/types/types.ts";
import BoardInfomation from "@js/components/board/BoardInfomation.vue";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";
import PageLoader from "@js/components/common/PageLoader.vue";
import Message from "@js/components/common/Message.vue";
import { getBoard } from "@js/services/BoardService.ts";
import { getFeedEntries } from "@js/services/EntryService.ts";
import { sleep } from "@js/components/common/Sleep.ts";

interface DataType {
  board: Board | null;
  entries: Entry[];
  isLoading: boolean;
  notFound: boolean;
  hasError: boolean;
}

const LOADING_SLEEP_MSEC = 200;

export default Vue.extend({
  name: "ShowBoardContainer",
  components: { BoardInfomation, EntryCardCollection, PageLoader, Message },
  props: {
    boardId: {
      type: Number,
      required: true,
    },
  },
  data: function (): DataType {
    return {
      board: null,
      entries: [],
      isLoading: true,
      notFound: false,
      hasError: false,
    };
  },
  created: async function (): Promise<void> {
    try {
      this.board = await getBoard(this.boardId);
      this.entries = await getFeedEntries("", { feedId: this.board.feedIds });
      await sleep(LOADING_SLEEP_MSEC);
    } catch (error) {
      if (error.response.status === 404) {
        this.notFound = true;
      } else {
        this.hasError = true;
      }
    }
    this.isLoading = false;
  },
});
</script>
<style lang="scss">
.board-show {
  padding: 20px;
}
</style>
