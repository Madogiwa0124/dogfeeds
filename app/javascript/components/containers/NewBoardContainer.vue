<template>
  <div id="boards" class="boards-new columns">
    <aside class="menu column is-2">
      <board-create-form
        :selected-feeds="selectedFeeds"
        class="sticky-area"
        @submitBoard="handleOnSubmitBoard"
        @unselectedFeed="handleOnUnselectedFeed"
      />
      <board-confirm-modal
        v-show="showModal"
        title="これでRSSフィードをまとめますか？"
        @close="handleOnCloseModal"
        @submit="handleOnSubmitModal"
      >
        <div class="content">
          <p v-if="boardTitle.length > 0">タイトル「{{ boardTitle }}」</p>
          <ul>
            <li v-for="feed in selectedFeeds" :key="feed.id">
              {{ feed.title }}
            </li>
          </ul>
        </div>
      </board-confirm-modal>
    </aside>
    <main class="column">
      <service-infomation
        v-if="showServiceInfomation"
        class="service-infomation"
        @delete="handleOnServiceInfomationDelete"
      />
      <div class="level-left column is-12 search-form-area">
        <search-form :init-keyword="keyword" :init-tags="tags" @search="handleOnSearch" />
      </div>
      <feed-card-collection
        :init-feeds="feeds"
        :selected-feeds="selectedFeeds"
        :openNewTab="true"
        @selectedFeed="handleOnSelectedFeed"
        @unselectedFeed="handleOnUnselectedFeed"
        @clickTag="handleOnSearch"
        @clipEntry="handleOnClipEntry"
      />
      <infinite-loading ref="InfiniteLoading" :distance="100" @infinite="infiniteHandler" />
    </main>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import FeedCardCollection from "@js/components/feed/FeedCardCollection.vue";
import BoardCreateForm from "@js/components/board/BoardCreateForm.vue";
import ServiceInfomation from "@js/components/ServiceInfomation.vue";
import SearchForm from "@js/components/SearchForm.vue";
import InfiniteLoading, { StateChanger } from "vue-infinite-loading";
import BoardConfirmModal from "@js/components/common/ConfirmModal.vue";
import Rollbar from "@js/services/Rollbar";
import { getFeeds } from "@js/services/FeedService";
import { getTags } from "@js/services/TagService";
import { postBoard } from "@js/services/BoardService";
import { clipEntry } from "@js/services/EntryService";
import { Feed, PostBoardResponse, Tag } from "@js/types/types";

const SHOW_SERVICE_INFOMATION_STRAGE_KEY = "showServiceInfomation";

interface DataType {
  page: number;
  feeds: Feed[];
  tags: Tag[];
  isLoading: boolean;
  boardTitle: string;
  selectedFeeds: Feed[];
  keyword: string;
  showServiceInfomation: boolean;
  showModal: boolean;
}

export default Vue.extend({
  name: "NewBoardContainer",
  components: {
    ServiceInfomation,
    BoardCreateForm,
    FeedCardCollection,
    SearchForm,
    InfiniteLoading,
    BoardConfirmModal,
  },
  props: {
    searchWord: {
      type: String,
      default: "",
    },
  },
  data(): DataType {
    return {
      page: 1,
      feeds: [],
      tags: [],
      isLoading: false,
      boardTitle: "",
      selectedFeeds: [],
      keyword: this.searchWord,
      showServiceInfomation: true,
      showModal: false,
    };
  },
  computed: {
    query: function (): string {
      if (!this.keyword) return "";
      return `?query[keyword]=${this.keyword}`;
    },
    // NOTE: $refsを参照すると型情報が取得できないのでcomputedに切り出して型を判断できるようにした。
    // https://engineering.linecorp.com/ja/blog/vue-js-typescript-otoshidama
    infiniteLoading: function (): InfiniteLoading {
      return this.$refs.InfiniteLoading as InfiniteLoading;
    },
  },
  async mounted() {
    this.showServiceInfomation = this.initShowServiceInfomation();
    this.tags = await getTags("", {});
  },
  methods: {
    initShowServiceInfomation(): boolean {
      return localStorage.getItem(SHOW_SERVICE_INFOMATION_STRAGE_KEY) != "false";
    },
    resetFeedList: function (): void {
      // NOTE: Vueに変更検知させるためにspliceしてる
      this.feeds.splice(0);
    },
    updateFeedList: function (feeds: Feed[]): void {
      this.feeds.push(...feeds);
    },
    infiniteHandler: async function ($state: StateChanger): Promise<void> {
      if (this.isLoading) return;

      this.isLoading = true;
      try {
        const data: Feed[] = await getFeeds(this.query, { page: this.page });
        if (data.length) {
          this.page += 1;
          this.updateFeedList(data);
          if ($state) $state.loaded();
        } else {
          if ($state) $state.complete();
        }
      } catch {
        if ($state) $state.error();
      }
      this.isLoading = false;
    },
    handleOnSubmitBoard: function (title: string): void {
      this.boardTitle = title;
      this.showModal = true;
    },
    handleOnSubmitModal: async function (): Promise<void> {
      try {
        const res: PostBoardResponse = await postBoard({
          feed_ids: this.selectedFeeds.map((feed) => feed.id),
          title: this.boardTitle,
        });
        window.location.href = `/boards/${res.id}`;
      } catch (error) {
        // TODO: いい感じの汎用的なmodalを作る
        alert("予期せぬエラーが発生しました😢");
        Rollbar.error(error);
      }
    },
    handleOnCloseModal: function (): void {
      this.showModal = false;
    },
    findFeed(id: number): Feed | undefined {
      return this.feeds.find((feed) => {
        return feed.id === id;
      });
    },
    handleOnSelectedFeed: function (id: number): void {
      const target: Feed | undefined = this.findFeed(id);
      if (target) this.selectedFeeds.push(target);
    },
    handleOnUnselectedFeed: function (id: number): void {
      const target: Feed | undefined = this.findFeed(id);
      if (target) this.selectedFeeds.splice(this.selectedFeeds.indexOf(target), 1);
    },
    handleOnSearch: function (keyword: string): void {
      this.keyword = keyword;
      this.resetFeedList();
      this.page = 1;
      this.infiniteLoading.stateChanger.reset();
      this.infiniteHandler(this.infiniteLoading.stateChanger);
    },
    handleOnServiceInfomationDelete: function (): void {
      this.showServiceInfomation = false;
      localStorage.setItem(SHOW_SERVICE_INFOMATION_STRAGE_KEY, "false");
    },
    handleOnClipEntry: function (entryId: number, clieped: boolean) {
      clipEntry(entryId, clieped);
    },
  },
});
</script>
<style lang="scss" scoped>
.boards-new {
  padding: 20px;

  .service-infomation {
    margin-bottom: 0.75rem;
  }

  .sticky-area {
    position: sticky;
    top: 30px;
  }

  .search-form-area {
    padding: 0 0 0.75em 0;
  }
}
</style>
