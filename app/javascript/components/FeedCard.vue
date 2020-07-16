<template>
  <div class="card">
    <header class="card-header">
      <p class="card-header-title">
        <a :href="feedPath">{{ feed.title }}</a>
      </p>
    </header>
    <div class="card-content">
      <div class="card-image">
        <img :src="eyeCatch" />
      </div>
      <div class="content">
        {{ lastEntry.title }}
        <a :href="lastEntry.link" target="_blank">
          リンク先で読む
        </a>
        <p>
          <tag v-for="tag in tags" :key="tag.id" :tag="tag" @click="handleOnTagClick" />
        </p>
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">
        <i class="far fa-clock" />
        {{ lastEntry.published_at | fromNow }}
      </p>
      <p v-if="selectable" class="card-footer-item">
        <select-feed :feed="feed" />
      </p>
    </footer>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import moment from "moment";
import SelectFeed from "@js/components/SelectFeed.vue";
import Tag from "@js/components/Tag.vue";
import { Feed, Entry, FeedTag } from "@js/types/types.d.ts";

export default Vue.extend({
  name: "FeedCard",
  components: { SelectFeed, Tag },
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
    lastEntry: {
      type: Object as PropType<Entry>,
      required: true,
    },
    tags: {
      type: Array as PropType<FeedTag[]>,
      default(): FeedTag[] {
        return [];
      },
    },
    selectable: {
      type: Boolean,
      default: true,
    },
  },
  computed: {
    eyeCatch: function () {
      if (!this.lastEntry.eye_catching_image) return "/noimage.png";
      return this.lastEntry.eye_catching_image;
    },
    feedPath: function () {
      return `/feeds/${this.feed.id}`;
    },
  },
  methods: {
    handleOnTagClick: function (tagBody) {
      this.$emit("clickTag", tagBody);
    },
  },
});
</script>
<style lang="scss"></style>
