<template>
  <li :key="feed.id" class="selected-feed">
    <i class="delete icon is-small" @click="unselectedFeed(feed.id)" />
    {{ feed.title }}
  </li>
</template>
<script>
export default {
  components: {},
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

  .delete {
    &:hover {
      background-color: hsl(348, 100%, 61%);
    }
  }
}
</style>
