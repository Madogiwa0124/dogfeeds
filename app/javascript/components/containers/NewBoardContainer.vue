<template>
  <div id="boards" class="boards-new columns">
    <aside class="menu column is-2">
      <board-create-form
        :selected-feeds="selectedFeeds"
        @submitBoard="handleOnSubmitBoard"
        @unselectedFeed="handleOnUnselectedFeed"
      />
    </aside>
    <main class="column">
      <article class="message">
        <div class="message-header has-background-info">
          <p>Dogfeedsとは？</p>
        </div>
        <div class="message-body">
          <strong>
            RSSフィードをまとめたRssフィードを作ることができます。 作り方は簡単なので、ぜひ作ってみてください🐶
          </strong>
          <br />
          1. フィードを選択する<br />
          2. まとめたフィード(ボード)に名前をつける<br />
          3. ボードを作って、共有するなり、Slackチャンネルに追加するなりする！<br />
        </div>
      </article>
      <div class="level-left column is-12 search-form-area">
        <search-form :init-keyword="keyword" @search="handleOnSearch" />
      </div>
      <feed-card-collection
        :init-feeds="feeds"
        :selected-feeds="selectedFeeds"
        @selectedFeed="handleOnSelectedFeed"
        @unselectedFeed="handleOnUnselectedFeed"
        @clickTag="handleOnSearch"
      />
      <infinite-loading ref="InfiniteLoading" :distance="100" @infinite="infiniteHandler" />
    </main>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import FeedCardCollection from "@js/components/feed/FeedCardCollection.vue";
import BoardCreateForm from "@js/components/board/BoardCreateForm.vue";
import SearchForm from "@js/components/SearchForm.vue";
import InfiniteLoading, { StateChanger } from "vue-infinite-loading";
import { getFeeds } from "@js/services/FeedService";
import { postBoard } from "@js/services/BoardService";
import { Feed, PostBoardResponse } from "@js/types/types.d.ts";

interface DataType {
  page: number;
  feeds: Feed[];
  isLoading: boolean;
  selectedFeeds: Feed[];
  keyword: string;
}

export default Vue.extend({
  name: "NewBoardContainer",
  components: { BoardCreateForm, FeedCardCollection, SearchForm, InfiniteLoading },
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
      isLoading: false,
      selectedFeeds: [],
      keyword: this.searchWord,
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
  methods: {
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
    handleOnSubmitBoard: async function (title: string): Promise<void> {
      try {
        const res: PostBoardResponse = await postBoard({
          feed_ids: this.selectedFeeds.map((feed) => feed.id),
          title: title,
        });
        window.location.href = `/boards/${res.id}`;
      } catch {
        // TODO: いい感じの汎用的なmodalを作る
        alert("予期せぬエラーが発生しました😢");
      }
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
    handleOnSearch: async function (keyword: string): Promise<void> {
      this.keyword = keyword;
      this.resetFeedList();
      this.page = 1;
      this.infiniteLoading.stateChanger.reset();
      this.infiniteHandler(this.infiniteLoading.stateChanger);
    },
  },
});
</script>
<style lang="scss" scoped>
.boards-new {
  padding: 20px;

  .message {
    margin-bottom: 0em;

    .message-header {
      background-color: #999999;
    }
    .message-body {
      color: #000000;
      background-color: #ffffff;
    }
  }

  .search-form-area {
    padding: 0.75em 0 0.75em 0;
  }
}
</style>
