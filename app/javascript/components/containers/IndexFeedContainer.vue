<template>
  <div
    id="feeds"
    class="feed-index columns"
  >
    <main class="column">
      <h1 class="title">
        登録されているRSSフィード
      </h1>
      <div class="level-left column is-12">
        <search-form :init_keyword="searchWord" />
      </div>
      <feed-card-collection
        :init-feeds="feeds"
        :init-last-entries="lastEntries"
        :init-tags="tags"
      />
      <infinite-loading
        :distance="100"
        @infinite="infiniteHandler"
      />
    </main>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import FeedCardCollection from "@js/components/FeedCardCollection.vue";
import SearchForm from "@js/components/SearchForm.vue";
import InfiniteLoading from "vue-infinite-loading";
import { getFeeds } from "@js/services/FeedService";
import { Feed, Entry, FeedTag, FeedsResponse } from "@js/types/types.d.ts";

interface DataType {
  page: number;
  feeds: Feed[];
  lastEntries: Entry[];
  tags: FeedTag[];
  isLoading: boolean;
}

export default Vue.extend({
  name: "IndexFeedContainer",
  components: { FeedCardCollection, SearchForm, InfiniteLoading },
  props: {
    searchWord: {
      type: String,
      default: "",
    }
  },
  data(): DataType {
    return {
      page: 1,
      feeds: [],
      lastEntries: [],
      tags: [],
      isLoading: false,
    };
  },
  methods: {
    updateFeedList: function(feeds: Feed[], lastEntries: Entry[], tags: FeedTag[]): void {
      this.feeds.push(...feeds);
      this.lastEntries.push(...lastEntries);
      this.tags.push(...tags);
    },
    infiniteHandler: async function ($state: any): Promise<void> {
      if(this.isLoading) return;

      this.isLoading = true;
      const data: FeedsResponse = await getFeeds(location.search, { page: this.page });
      if (data.feeds.length) {
        this.page += 1;
        this.updateFeedList(data.feeds, data.last_entries, data.tags);
        if ($state) { $state.loaded(); }
      } else {
        $state.complete();
      }
      this.isLoading = false;
    }
  }
});
</script>
<style lang="scss">
</style>
