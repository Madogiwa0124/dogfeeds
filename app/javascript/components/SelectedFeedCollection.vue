<template>
  <aside class="menu column is-2">
    <p class="menu-label">
      Selected Feeds
    </p>
    <span v-if="selectedFeeds.length < 1">
      まとめたいRSSフィードを選択して、ボードを作ってみましょう！
    </span>
    <ul class="menu-list">
      <selected-feed
        v-for="feed in selectedFeeds"
        :key="feed.id"
        :feed="feed"
        @unselectedFeed="handleOnUnselectedFeed"
      />
    </ul>
    <borad-create-button :feeds="selectedFeeds" />
  </aside>
</template>
<script>
import store from '../packs/store';
import SelectedFeed from './SelectedFeed';
import BoradCreateButton from './BoardCreateButton';

export default {
  name: 'SelectedFeedCollection',
  components: { SelectedFeed, BoradCreateButton },
  data: () => store.state,
  methods: {
    handleOnUnselectedFeed: function (id) {
      const target = this.findSelectedFeed(id);
      this.selectedFeeds.splice(this.selectedFeeds.indexOf(target), 1);
    },
    findSelectedFeed: function (id) {
      return this.selectedFeeds.find(function(feed) { return feed.id === id; });
    }
  }
};
</script>
<style lang="scss">

</style>
