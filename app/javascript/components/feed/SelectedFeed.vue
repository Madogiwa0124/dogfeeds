<template>
  <li :key="feed.id" class="selected-feed">
    <i class="delete icon is-small" @click="unselectedFeed(feed.id)" />
    {{ truncatedFeedTitle }}
  </li>
</template>
<script>
import { defineComponent } from "vue";
import { truncate } from "@js/components/common/Truncate";

export default defineComponent({
  components: {},
  props: ["feed"],
  emits: ["unselectedFeed"],
  computed: {
    truncatedFeedTitle: function () {
      return truncate(this.feed.title, 12);
    },
  },
  methods: {
    unselectedFeed: function (id) {
      this.$emit("unselectedFeed", id);
    },
  },
});
</script>
<style lang="scss" scoped>
@import "@css/common.scss";

li.selected-feed {
  margin-bottom: 5px;
  font-size: $font-size-ms;
  border-radius: 5px;
  background-color: #ffffff;
  padding: 10px;

  .delete {
    background-color: $dengar-color;
  }
  .delete:hover {
    background-color: $dengar-hover-color;
  }
}
</style>
