<template>
  <div class="entry-card card">
    <header class="card-header">
      <p class="card-header-title">
        {{ entry.title }}
      </p>
    </header>
    <div class="card-content">
      <div class="content">
        {{ entry.description }}
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">
        <span> <font-awesome-icon :icon="['far', 'clock']" />{{ entry.publishedAt | fromNow }} </span>
      </p>
      <p class="card-footer-item">
        <a :href="entry.link" target="_blank" rel="noopener">
          リンク先で読む
          <font-awesome-icon icon="external-link-alt" />
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
import { faClock } from "@fortawesome/free-regular-svg-icons";
library.add(faExternalLinkAlt, faClock);

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
