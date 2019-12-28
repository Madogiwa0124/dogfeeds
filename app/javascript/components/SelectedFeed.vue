<template>
  <li :key="feed.id">
    <i
      class="delete icon is-small"
      @click="unselectedFeed(feed.id)"
    />
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
    }
  }
};
</script>
<style lang="scss">

</style>
