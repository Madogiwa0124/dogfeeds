<template>
  <div class="feed-collection-container">
    <div class="level-left column is-12 search-form-area">
      <search-form :init-keyword="keyword" :init-tags="tags" @search="handleOnSearch" />
    </div>
    <feed-card-collection
      :init-feeds="feeds"
      :selectable="false"
      :clumn-size="3"
      @clickTag="handleOnSearch"
      @clipEntry="handleOnClipEntry"
    />
    <infinite-loading ref="InfiniteLoading" :distance="100" @infinite="infiniteHandler" />
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import FeedCardCollection from "@js/components/feed/FeedCardCollection.vue";
import SearchForm from "@js/components/SearchForm.vue";
import InfiniteLoading, { StateChanger } from "vue-infinite-loading";
import { getFeeds } from "@js/services/FeedService";
import { Feed, Tag } from "@js/types/types";
import { getTags } from "@js/services/TagService";
import { clipEntry } from "@js/services/EntryService";

interface DataType {
  page: number;
  feeds: Feed[];
  isLoading: boolean;
  keyword: string;
  tags: Tag[];
}

export default Vue.extend({
  name: "FeedCollectionContainer",
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
      tags: [],
      isLoading: false,
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
  mounted: async function () {
    this.tags = await getTags("", {});
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
    handleOnSearch: function (keyword: string): void {
      this.keyword = keyword;
      this.resetFeedList();
      this.page = 1;
      this.infiniteLoading.stateChanger.reset();
      this.infiniteHandler(this.infiniteLoading.stateChanger);
    },
    handleOnClipEntry: function (entryLink: string, clieped: boolean) {
      clipEntry(entryLink, clieped);
    },
  },
});
</script>
<style lang="scss" scoped>
.feed-collection-container {
  .search-form-area {
    padding-left: 0px;
    padding-right: 0px;
  }
}
</style>
