<template>
  <div :id="`feed-card-${feed.id}`" class="feed-card card">
    <header class="card-header">
      <p class="card-header-title">
        <a :href="feedPath">{{ feed.title }}</a>
      </p>
    </header>
    <div class="card-content">
      <div class="card-image">
        <img :src="eyeCatch" :alt="feed.lastEntry.title" />
      </div>
      <div class="content">
        {{ feed.lastEntry.title }}
        <a :href="feed.lastEntry.link" target="_blank" rel="noopener">
          リンク先で読む
        </a>
        <p>
          <tag v-for="tag in feed.tags" :key="tag.id" :body="tag.body" @click="handleOnTagClick" />
        </p>
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">
        <font-awesome-icon :icon="['far', 'clock']" />
        {{ feed.lastEntry.publishedAt | fromNow }}
      </p>
      <p v-if="selectable" class="card-footer-item">
        <select-feed :selected="selected" @selected="handleOnSelected" @unselected="handleOnUnselected" />
      </p>
    </footer>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import moment from "moment";
import SelectFeed from "@js/components/feed/SelectFeed.vue";
import Tag from "@js/components/Tag.vue";
import { Feed } from "@js/types/types.d.ts";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faClock } from "@fortawesome/free-regular-svg-icons";

library.add(faClock);
const NO_IMAGE_PATH = "/noimage.png";

export default Vue.extend({
  name: "FeedCard",
  components: { SelectFeed, Tag, FontAwesomeIcon },
  filters: {
    fromNow: function (value: string): string {
      return moment(value, "YYYYMMDD h:mm:ss").fromNow();
    },
  },
  props: {
    feed: {
      type: Object as PropType<Feed>,
      required: true,
    },
    selectable: {
      type: Boolean,
      default: true,
    },
    selected: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    eyeCatch: function (): string {
      if (!this.feed.lastEntry.eyeCatchingImage) return NO_IMAGE_PATH;
      return this.feed.lastEntry.eyeCatchingImage;
    },
    feedPath: function (): string {
      return `/feeds/${this.feed.id}`;
    },
  },
  methods: {
    handleOnTagClick: function (tagBody: string): void {
      this.$emit("clickTag", tagBody);
    },
    handleOnSelected: function (): void {
      this.$emit("selectedFeed", this.feed.id);
    },
    handleOnUnselected: function (): void {
      this.$emit("unselectedFeed", this.feed.id);
    },
  },
});
</script>
<style lang="scss" scoped>
.feed-card {
  .card-image {
    img {
      height: 320px;
      width: 320px;
      object-fit: cover;
    }
  }
}
</style>
