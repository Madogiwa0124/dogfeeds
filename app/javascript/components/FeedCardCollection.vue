<template>
  <div class="entries is-multiline columns">
    <page-loader :init_is_loading="isLoading" />
    <div
      v-for="feed in feeds"
      :key="feed.id"
      class="column is-4"
    >
      <feed-card
        :feed="feed"
        :lastEntry="feedLastEntry(feed)"
        :tags="feedTags(feed)"
      />
    </div>
    <infinite-loading @infinite="infiniteHandler" />
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import { Feed, Entry, FeedTag, FeedsResponse } from "@js/types/types.d.ts";
import FeedCard from "@js/components/FeedCard.vue";
import PageLoader from "@js/components/PageLoader.vue";
import InfiniteLoading from "vue-infinite-loading";
import DeviceChecker from "@js/common/DeviceChecker";
import { getFeeds } from "@js/services/FeedService";

interface DataType {
  page: number;
  feeds: Feed[];
  lastEntries: Entry[];
  tags: FeedTag[];
  isLoading: boolean;
}

export default Vue.extend({
  name: "FeedCardCollection",
  components: { FeedCard, PageLoader, InfiniteLoading },
  props: {
    initFeeds: {
      type: Array as PropType<Feed[]>,
      default(): Feed[] { return []; },
      require: false
    },
    initLastEntries: {
      type: Array as PropType<Entry[]>,
      default(): Entry[] { return []; },
      require: false
    },
    initTags: {
      type: Array as PropType<FeedTag[]>,
      default(): FeedTag[] { return []; },
      require: false
    },
  },
  data(): DataType {
    return {
      page: 1,
      feeds: this.initFeeds,
      lastEntries: this.initLastEntries,
      tags: this.initTags,
      isLoading: true
    };
  },
  created: async function() {
    const checker = new DeviceChecker(navigator.userAgent);
    // MEMO: 初回表示時にデータ取得するため実行
    if (!checker.isMobile()) await this.infiniteHandler();
    this.isLoading = false;
  },
  methods: {
    feedLastEntry: function(feed: Feed): Entry {
      return this.lastEntries.filter(entry => entry.feed_id === feed.id)[0];
    },
    feedTags: function(feed: Feed): FeedTag {
      return this.tags.filter(tag => tag.feed_id === feed.id);
    },
    updateFeedList: function(feeds: Feed[], lastEntries: Entry[], tags: FeedTag[]): void {
      this.feeds.push(...feeds);
      this.lastEntries.push(...lastEntries);
      this.tags.push(...tags);
    },
    infiniteHandler: async function ($state: any): Promise<void> {
      const data: FeedsResponse = await getFeeds(location.search, { page: this.page });
      if (data.feeds.length) {
        this.page += 1;
        this.updateFeedList(data.feeds, data.last_entries, data.tags);
        if ($state) { $state.loaded(); }
      } else {
        if ($state) { $state.complete(); }
      }
    }
  }
});
</script>
<style lang="scss">
</style>
