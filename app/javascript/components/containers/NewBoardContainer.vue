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
        <div class="message-header">
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
      <div class="level-left column is-12">
        <search-form :init-keyword="keyword" @search="handleOnSearch" />
      </div>
      <feed-card-collection
        :init-feeds="feeds"
        :init-last-entries="lastEntries"
        :init-tags="tags"
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
import FeedCardCollection from "@js/components/FeedCardCollection.vue";
import BoardCreateForm from "@js/components/BoardCreateForm.vue";
import SearchForm from "@js/components/SearchForm.vue";
import InfiniteLoading from "vue-infinite-loading";
import { getFeeds } from "@js/services/FeedService";
import { postBoard } from "@js/services/BoardService";
import { Feed, Entry, FeedTag, FeedsResponse, PostBoardResponse } from "@js/types/types.d.ts";

interface DataType {
  page: number;
  feeds: Feed[];
  lastEntries: Entry[];
  tags: FeedTag[];
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
      lastEntries: [],
      tags: [],
      isLoading: false,
      selectedFeeds: [],
      keyword: this.searchWord,
    };
  },
  computed: {
    query: function () {
      if (!this.keyword) return "";
      return `?query[keyword]=${this.keyword}`;
    },
  },
  methods: {
    resetFeedList: function () {
      // NOTE: Vueに変更検知させるためにspliceしてる
      this.lastEntries.splice(0);
      this.tags.splice(0);
      this.feeds.splice(0);
    },
    updateFeedList: function (feeds: Feed[], lastEntries: Entry[], tags: FeedTag[]): void {
      this.feeds.push(...feeds);
      this.lastEntries.push(...lastEntries);
      this.tags.push(...tags);
    },
    infiniteHandler: async function ($state: any): Promise<void> {
      if (this.isLoading) return;

      this.isLoading = true;
      const data: FeedsResponse = await getFeeds(this.query, { page: this.page });
      if (data.feeds.length) {
        this.page += 1;
        this.updateFeedList(data.feeds, data.last_entries, data.tags);
        if ($state) $state.loaded();
      } else {
        $state.complete();
      }
      this.isLoading = false;
    },
    handleOnSubmitBoard: async function (title: string): Promise<void> {
      const res: PostBoardResponse = await postBoard({
        feed_ids: this.selectedFeeds.map((feed) => feed.id),
        title: title,
      });
      window.location.href = `/boards/${res.id}`;
    },
    handleOnSelectedFeed: function (id: number): void {
      const target: Feed = this.feeds.find((feed) => {
        return feed.id === id;
      });
      if (target) this.selectedFeeds.push(target);
    },
    handleOnUnselectedFeed: function (id: number): void {
      const target: Feed = this.selectedFeeds.find((feed) => {
        return feed.id === id;
      });
      this.selectedFeeds.splice(this.selectedFeeds.indexOf(target), 1);
    },
    handleOnSearch: async function (keyword: string) {
      this.keyword = keyword;
      this.resetFeedList();
      this.page = 1;
      this.$refs.InfiniteLoading.stateChanger.reset();
      this.infiniteHandler(this.$refs.InfiniteLoading.stateChanger);
    },
  },
});
</script>
<style lang="scss"></style>
