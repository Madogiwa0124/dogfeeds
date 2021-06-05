<template>
  <div class="board-show">
    <message v-if="hasError" title="Error" body="予期せぬエラーが発生しました🐕" level="danger" />
    <message v-if="notFound" title="NotFound" body="対象のボードが見つかりませんでした🐾" level="warning" />

    <board-infomation v-if="!!board" :board="board" />
    <div class="tabs">
      <ul>
        <li class="entries" :class="{ 'is-active': selectedEntryTab }">
          <a @click="handleOnEntryTabClick"><span>配信中の記事</span></a>
        </li>
        <li class="feeds" :class="{ 'is-active': selectedFeedTab }">
          <a @click="handleOnFeedTabClick"><span>含まれているRSSフィード</span></a>
        </li>
      </ul>
    </div>
    <feed-card-collection
      v-if="selectedFeedTab"
      :init-feeds="feeds"
      :selectable="false"
      :clumn-size="3"
      @clipEntry="handleOnClipEntry"
    />
    <entry-card-collection v-if="selectedEntryTab" :entries="entries" :clumn-size="3" @clipEntry="handleOnClipEntry" />
    <div class="center">
      <to-top-button />
    </div>
    <page-loader :init-is-loading="isLoading" />
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import { Entry, Feed, Board } from "@js/types/types";
import BoardInfomation from "@js/components/board/BoardInfomation.vue";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";
import FeedCardCollection from "@js/components/feed/FeedCardCollection.vue";
import PageLoader from "@js/components/common/PageLoader.vue";
import Message from "@js/components/common/Message.vue";
import ToTopButton from "@js/components/common/ToTopButton.vue";
import { getBoard } from "@js/services/BoardService";
import { clipEntry, getFeedEntries } from "@js/services/EntryService";
import { sleep } from "@js/components/common/Sleep";
import { getFeeds } from "@js/services/FeedService";

interface DataType {
  board: Board | null;
  entries: Entry[];
  feeds: Feed[];
  selectedTab: Tabs;
  isLoading: boolean;
  notFound: boolean;
  hasError: boolean;
}

const LOADING_SLEEP_MSEC = 200;
enum Tabs {
  Feed = "feed",
  Entry = "entry",
}

export default Vue.extend({
  name: "ShowBoardContainer",
  components: { BoardInfomation, EntryCardCollection, FeedCardCollection, PageLoader, Message, ToTopButton },
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
      feeds: [],
      isLoading: true,
      notFound: false,
      hasError: false,
      selectedTab: Tabs.Entry,
    };
  },
  computed: {
    selectedFeedTab(): boolean {
      return this.selectedTab == Tabs.Feed;
    },
    selectedEntryTab(): boolean {
      return this.selectedTab == Tabs.Entry;
    },
  },
  created: async function (): Promise<void> {
    try {
      this.board = await getBoard(this.boardId);
      this.entries = await getFeedEntries("", { feedId: this.board.feedIds });
      this.feeds = await getFeeds("", { ids: this.board.feedIds });
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
  methods: {
    handleOnFeedTabClick() {
      this.selectedTab = Tabs.Feed;
    },
    handleOnEntryTabClick() {
      this.selectedTab = Tabs.Entry;
    },
    handleOnClipEntry: function (entryLink: string, clieped: boolean) {
      clipEntry(entryLink, clieped);
    },
  },
});
</script>
<style lang="scss">
.board-show {
  padding: 20px;

  .tabs {
    margin-bottom: 15px;

    li.is-active a {
      border-bottom-color: hsl(171, 100%, 41%);
      color: hsl(171, 100%, 41%);
    }
  }
}
</style>
