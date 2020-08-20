<template>
  <div class="entry-card card">
    <header class="card-header">
      <p class="card-header-title">
        {{ entry.title }}
      </p>
    </header>
    <div class="card-content">
      <div class="content">
        {{ limitedDescription }}
        <a :href="entry.link" target="_blank" rel="noopener">
          リンク先で読む
          <font-awesome-icon icon="external-link-alt" />
        </a>
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">
        <span> <font-awesome-icon :icon="['far', 'clock']" />{{ entry.publishedAt | fromNow }} </span>
      </p>
      <p v-if="showFeedLink" class="card-footer-item">
        <a :href="feedPath">
          RSSフィードを見る
          <font-awesome-icon :icon="['far', 'newspaper']" />
        </a>
      </p>
    </footer>
  </div>
</template>
<script>
import moment from "moment/moment";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faExternalLinkAlt } from "@fortawesome/free-solid-svg-icons";
import { faClock, faNewspaper } from "@fortawesome/free-regular-svg-icons";
library.add(faExternalLinkAlt, faClock, faNewspaper);

export default {
  name: "EntryCard",
  components: { FontAwesomeIcon },
  filters: {
    fromNow: function (value) {
      return moment(value, "YYYYMMDD").fromNow();
    },
  },
  props: {
    entry: {
      type: Object,
      required: true,
    },
    descriptionLimit: {
      type: Number,
      default: null,
    },
    showFeedLink: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    limitedDescription: function () {
      const showFull = !this.descriptionLimit || this.entry.description <= this.descriptionLimit;
      if (showFull) return this.entry.description;
      return `${this.entry.description.slice(0, this.descriptionLimit)}...`;
    },
    feedPath: function () {
      return `/feeds/${this.entry.feedId}`;
    },
  },
};
</script>
<style lang="scss" scoped>
.entry-card {
  .card-content {
    word-wrap: break-word;
  }
}
</style>
