<template>
  <aside class="menu column is-2">
    <p class="menu-label">
      Selected Feeds
    </p>
    <span v-if="selectedFeeds.length < 1">Feedを選択して、ボードを作ってみましょう！</span>
    <ul class="menu-list">
      <li
        v-for="feed in selectedFeeds"
        :key="feed.id"
      >
        <i
          class="delete icon is-small"
          @click="deleteSelectedFeed(feed.id)"
        />
        {{ feed.title }}
      </li>
    </ul>
    <button class="button is-primary is-fullwidth">
      ボードを作る
    </button>
  </aside>
</template>
<script>
import store from '../store';

export default {
  name: 'Menu',
  components: {},
  data: () => store.state,
  methods: {
    deleteSelectedFeed: function (id) {
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
