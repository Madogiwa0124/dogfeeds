<template>
<div class="entries columns is-multiline">
  <div class="column is-4" v-for="feed in feeds" :key="feed.id">
    <feed-card
      :feed="feed"
      :lastEntry= "feedLastEntry(feed)">
    </feed-card>
  </div>
</div>
</template>
<script>
import FeedCard from './FeedCard'

export default {
  name: 'FeedCardCollection',
  components: { FeedCard },
  props: ['feeds', 'last_entries'],
  methods: {
    feedLastEntry: function(feed) {
      return this.last_entries.filter(entry => entry.feed_id === feed.id)[0]
    }
  }
}
</script>
<style lang="scss">
</style>
