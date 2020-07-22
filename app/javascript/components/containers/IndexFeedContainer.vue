<template>
  <div id="feeds" class="feed-index columns">
    <main class="column">
      <h1 class="title">
        登録されているRSSフィード
      </h1>
      <div class="level-left column is-12">
        <search-form :init-keyword="keyword" @search="handleOnSearch" />
      </div>
      <feed-card-collection :init-feeds="feeds" :selectable="false" @clickTag="handleOnSearch" />
      <infinite-loading ref="InfiniteLoading" :distance="100" @infinite="infiniteHandler" />
    </main>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import FeedCardCollection from "@js/components/FeedCardCollection.vue";
import SearchForm from "@js/components/SearchForm.vue";
import InfiniteLoading from "vue-infinite-loading";
import { getFeeds } from "@js/services/FeedService";
import { Feed } from "@js/types/types.d.ts";

interface DataType {
  page: number;
  feeds: Feed[];
  isLoading: boolean;
  keyword: string;
}

export default Vue.extend({
  name: "IndexFeedContainer",
  components: { FeedCardCollection, SearchForm, InfiniteLoading },
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
      this.feeds.splice(0);
    },
    updateFeedList: function (feeds: Feed[]): void {
      this.feeds.push(...feeds);
    },
    infiniteHandler: async function ($state: any): Promise<void> {
      if (this.isLoading) return;

      this.isLoading = true;
      const feeds: Feed[] = await getFeeds(this.query, { page: this.page });
      if (feeds.length) {
        this.page += 1;
        this.updateFeedList(feeds);
        if ($state) $state.loaded();
      } else {
        $state.complete();
      }
      this.isLoading = false;
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
