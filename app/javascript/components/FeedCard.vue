<template>
<div class="card">
  <header class="card-header">
    <p class="card-header-title">
      <a :href="feedPath()">{{feed.title}}</a>
    </p>
  </header>
  <div class="card-content">
    <div class="card-image">
      <img :src="lastEntry.eye_catching_image | eyeCatch">
    </div>
    <div class="content">
      {{lastEntry.title}}
      <a :href="lastEntry.link">リンク先で読む</a>
    </div>
  </div>
  <footer class="card-footer">
    <p class="card-footer-item">
      <i class="far fa-clock"></i>
      {{lastEntry.published_at | fromNow}}
    </p>
    <p class="card-footer-item">
      <a><i class="fas fa-plus-circle"></i> Fllow</a>
    </p>
  </footer>
</div>
</template>
<script>
import moment from 'moment/moment'

export default {
  name: 'FeedCard',
  components: {},
  props: ['feed', 'lastEntry'],
  filters: {
    fromNow: function (value) {
      return moment(value, 'YYYYMMDD h:mm:ss').fromNow()
    },
    eyeCatch: function (value) {
      if(!value) return '/noimage.png'
      return value
    }
  },
  methods: {
    feedPath: function () {
      return `/feeds/${this.feed.id}`
    }
  }
}
</script>
<style lang="scss">
</style>
