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
        <a
          :href="lastEntry.link"
          target="_blank"
        >
          リンク先で読む
        </a>
        <p>
          <feed-tag
            v-for="tag in tags"
            :key="tag.id"
            :tag="tag"
          />
        </p>
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
import FeedTag from './FeedTag';

export default {
  name: 'FeedCard',
  components: { SelectFeed, FeedTag },
  filters: {
    fromNow: function (value) {
      return moment(value, 'YYYYMMDD h:mm:ss').fromNow();
    },
    eyeCatch: function (value) {
      if(!value) return '/noimage.png';
      return value;
    }
  },
  props: ['feed', 'lastEntry', 'tags'],
  methods: {
    feedPath: function () {
      return `/feeds/${this.feed.id}`;
    }
  }
};
</script>
<style lang="scss">
</style>
