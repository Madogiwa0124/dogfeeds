<template>
  <aside class="menu column is-2">
    <p class="menu-label">
      Selected Feeds
    </p>
    <span v-if="selectedFeeds.length < 1">
      まとめたいRSSフィードを選択して、ボードを作ってみましょう！
    </span>
    <borad-create-form
      :feeds="selectedFeeds"
      @unselectedFeed="handleUnselectedFeed(id)"
    />
  </aside>
</template>
<script>
import store from '../packs/store';
import BoradCreateForm from './BoradCreateForm';

export default {
  name: 'SelectedFeedCollection',
  components: { BoradCreateForm },
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
