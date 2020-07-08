<template>
  <span class="tag is-primary" @click="SearchByTag()">
    {{ tag.body }}
  </span>
</template>
<script>
export default {
  name: "FeedTag",
  props: ["tag"],
  computed: {
    query: function () {
      return `?query[keyword]=${this.tag.body}`;
    },
  },
  methods: {
    SearchByTag: function () {
      window.location.href = `/${this.query}`;
    },
  },
};
</script>
<style lang="scss"></style>
