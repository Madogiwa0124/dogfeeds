<template>
  <span class="tag is-primary">
    {{ tag.body }}
  </span>
</template>
<script>
export default {
  name: 'FeedTag',
  props: ['tag'],
};
</script>
<style lang="scss">
</style>
