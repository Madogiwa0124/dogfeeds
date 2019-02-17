<template>
  <span>
    <a
      v-if="!isSelected()"
      @click="addSelectedFeed()"
    >
      <i class="fas fa-plus-circle" />
      Select
    </a>
    <span v-else>
      <i class="fas fa-check-square" />
      Selected
    </span>
  </span>
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
    addSelectedFeed: function () {
      if(this.isSelected()) { return; }
      this.selectedFeeds.push(this.feed);
    },
    findSelectedFeed: function (id) {
      return this.selectedFeeds.find(function(feed) { return feed.id === id; });
    }
  }
};
</script>
<style lang="scss">

</style>
