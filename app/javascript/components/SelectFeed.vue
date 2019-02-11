<template>
<span>
  <a @click="addSelectedFeed()" v-if="!isSelected()">
    <i class="fas fa-plus-circle"></i>
    Select
  </a>
  <span v-else>
    <i class="fas fa-check-square"></i>
    Selected
  </span>
</span>
</template>
<script>
import store from '../store'

export default {
  name: 'SelectFeed',
  components: {},
  props: ['feed'],
  data: () => store.state,
  methods: {
    isSelected: function () {
      return !!this.findSelectedFeed(this.feed.id)
    },
    addSelectedFeed: function () {
      if(this.isSelected()) { return }
      this.selectedFeeds.push(this.feed)
    },
    findSelectedFeed: function (id) {
      return this.selectedFeeds.find(function(feed) { return feed.id === id })
    }
  }
}
</script>
<style lang="scss">

</style>
