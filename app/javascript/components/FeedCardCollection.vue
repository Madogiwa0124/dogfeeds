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
import axios, { AxiosResponse } from "axios";
import DeviceChecker from "@js/common/DeviceChecker";

const feedsApi = "/api/feeds";

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
  mounted: function() {
    const checker = new DeviceChecker(navigator.userAgent);
    // MEMO: 初回表示時にデータ取得するため実行
    if (!checker.isMobile()) {
      this.infiniteHandler();
    }
    this.$nextTick(function() {
      this.isLoading = false;
    });
  },
  methods: {
    feedLastEntry: function(feed: Feed): Entry {
      return this.lastEntries.filter(entry => entry.feed_id === feed.id)[0];
    },
    feedTags: function(feed: Feed): FeedTag {
      return this.tags.filter(tag => tag.feed_id === feed.id);
    },
    updateFeedList: function(data: FeedsResponse): void {
      this.page += 1;
      this.feeds.push(...data.feeds);
      this.lastEntries.push(...data.last_entries);
      this.tags.push(...data.tags);
    },
    getFeeds: async function (params: object): Promise<AxiosResponse> {
      return await axios.get(feedsApi + location.search, {params: params});
    },
    infiniteHandler: async function ($state: any): Promise<void> {
      const response: AxiosResponse = await this.getFeeds({ page: this.page });
      const data: FeedsResponse = response.data;
      if (data.feeds.length) {
        this.updateFeedList(data);
        if ($state) { $state.loaded(); }
      } else {
        $state.complete();
      }
    }
  }
});
</script>
<style lang="scss">
</style>
