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
<script>
import FeedCard from './FeedCard';
import PageLoader from './PageLoader';
import InfiniteLoading from 'vue-infinite-loading';
import axios from 'axios';

const feedsApi = '/api/feeds';

export default {
  name: 'FeedCardCollection',
  components: { FeedCard, PageLoader, InfiniteLoading },
  props: ['init_feeds', 'init_last_entries', 'init_tags'],
  data: function () {
    return {
      page: 1,
      feeds: [],
      last_entries: [],
      tags: [],
      isLoading: true
    };
  },
  mounted: function () {
    // MEMO: 初回表示時にデータ取得するため実行
    this.infiniteHandler();
    this.$nextTick(function () {
      this.isLoading = false;
    });
  },
  methods: {
    feedLastEntry: function(feed) {
      return this.last_entries.filter(entry => entry.feed_id === feed.id)[0];
    },
    feedTags: function(feed) {
      return this.tags.filter(tag => tag.feed_id === feed.id);
    },
    infiniteHandler($state) {
      axios.get(feedsApi + location.search, {
        params: { page: this.page },
      }).then(({ data }) => {
        if (data.feeds.length) {
          this.page += 1;
          this.feeds.push(...data.feeds);
          this.last_entries.push(...data.last_entries);
          this.tags.push(...data.tags);
          if($state) { $state.loaded(); }
        } else {
          $state.complete();
        }
      });
    },
  }
};
</script>
<style lang="scss">
</style>
