<template>
  <li :key="feed.id" class="selected-feed">
    <i class="delete icon is-small" @click="unselectedFeed(feed.id)" />
    {{ feed.title | truncate(12) }}
  </li>
</template>
<script>
export default {
  components: {},
  filters: {
    truncate: function (value, limit) {
      if (value.length <= limit) return value;
      return `${value.trim().replace(/\s+/g, "").substring(0, limit)}…`;
    },
  },
  props: ["feed"],
  methods: {
    unselectedFeed: function (id) {
      this.$emit("unselectedFeed", id);
    },
  },
};
</script>
<style lang="scss" scoped>
li.selected-feed {
  margin-bottom: 5px;
  font-size: 14px;
  border-radius: 5px;
  background-color: #ffffff;
  padding: 10px;

  .delete {
    background-color: hsl(348, 100%, 61%);
  }
  .delete:hover {
    background-color: hsl(348, 60%, 44%);
  }
}
</style>
