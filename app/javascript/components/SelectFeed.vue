<template>
  <a @click="toggleSelectedFeed()">
    <span v-if="isSelected()">
      <i class="far fa-check-square" />
      Selected
    </span>
    <span v-else>
      <i class="far fa-square" />
      Select
    </span>
  </a>
</template>
<script>
import store from '../packs/store';

export default {
  name: 'SelectFeed',
  components: {},
  props: ['feed'],
  data: () => store.state,
  methods: {
    isSelected: function () {
      return !!this.findSelectedFeed(this.feed.id);
    },
    toggleSelectedFeed: function () {
      if(this.isSelected()) { return this.unselectedFeed(this.feed); }
      this.selectedFeeds.push(this.feed);
    },
    unselectedFeed: function () {
      this.selectedFeeds.splice(this.selectedFeeds.indexOf(this.feed), 1);
    },
    findSelectedFeed: function (id) {
      return this.selectedFeeds.find(function(feed) { return feed.id === id; });
    }
  }
};
</script>
<style lang="scss">

</style>
