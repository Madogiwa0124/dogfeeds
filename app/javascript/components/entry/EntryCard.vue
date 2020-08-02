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
        <span> <i class="far fa-clock" />{{ entry.publishedAt | fromNow }} </span>
      </p>
      <p class="card-footer-item">
        <a :href="entry.link" target="_blank"> <i class="fas fa-external-link-alt" />リンク先で読む </a>
      </p>
    </footer>
  </div>
</template>
<script>
import moment from "moment/moment";

export default {
  name: "EntryCard",
  components: {},
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
