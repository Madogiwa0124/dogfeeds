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
  </div>
</template>
<script>
import FeedCard from './FeedCard';
import PageLoader from './PageLoader';
import axios from 'axios';

const INTERVAL_TIME = 600000;

export default {
  name: 'FeedCardCollection',
  components: { FeedCard, PageLoader },
  props: ['init_feeds', 'init_last_entries'],
  data: function () {
    return {
      feeds: this.init_feeds,
      last_entries: this.init_last_entries,
      intervalId: 0,
      isLoading: true
    };
  },
  mounted: function () {
    this.intervalId = setInterval(this.getFeeds, INTERVAL_TIME);
    this.$nextTick(function () {
      this.isLoading = false;
    });
  },
  beforeDestroy: function () {
    clearInterval(this.intervalId);
  },
  methods: {
    feedLastEntry: function(feed) {
      return this.last_entries.filter(entry => entry.feed_id === feed.id)[0];
    },
    getFeeds: function() {
      axios.get('/api/feeds').then((res) => {
        this.feeds = res.data.feeds;
        this.last_entries = res.data.last_entries;
      });
    }
  }
};
</script>
<style lang="scss">
</style>
