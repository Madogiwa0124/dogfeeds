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
  props: ['init_feeds', 'init_last_entries'],
  data: function () {
    return {
      page: 1,
      feeds: [],
      last_entries: [],
      isLoading: true
    };
  },
  mounted: function () {
    this.$nextTick(function () {
      this.isLoading = false;
    });
  },
  methods: {
    feedLastEntry: function(feed) {
      return this.last_entries.filter(entry => entry.feed_id === feed.id)[0];
    },
    infiniteHandler($state) {
      axios.get(feedsApi, {
        params: { page: this.page },
      }).then(({ data }) => {
        if (data.feeds.length) {
          this.page += 1;
          this.feeds.push(...data.feeds);
          this.last_entries.push(...data.last_entries);
          $state.loaded();
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
