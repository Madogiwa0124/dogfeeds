<template>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        <a :href="feedPath()">{{ feed.title }}</a>
      </p>
    </header>
    <div class="card-content">
      <div class="card-image">
        <img :src="lastEntry.eye_catching_image | eyeCatch">
      </div>
      <div class="content">
        {{ lastEntry.title }}
        <a :href="lastEntry.link">リンク先で読む</a>
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">
        <i class="far fa-clock" />
        {{ lastEntry.published_at | fromNow }}
      </p>
      <p class="card-footer-item">
        <select-feed :feed="feed" />
      </p>
    </footer>
  </div>
</template>
<script>
import moment from 'moment/moment';
import SelectFeed from './SelectFeed';

export default {
  name: 'FeedCard',
  components: { SelectFeed },
  filters: {
    fromNow: function (value) {
      return moment(value, 'YYYYMMDD h:mm:ss').fromNow();
    },
    eyeCatch: function (value) {
      if(!value) return '/noimage.png';
      return value;
    }
  },
  props: ['feed', 'lastEntry'],
  methods: {
    feedPath: function () {
      return `/feeds/${this.feed.id}`;
    }
  }
};
</script>
<style lang="scss">
</style>
