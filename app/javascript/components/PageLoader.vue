<template>
  <div
    class="pageloader"
    :class="{ 'is-active': isLoading }"
  >
    <span class="title">Loading</span>
  </div>
</template>
<script>
export default {
  name: "PageLoader",
  components: { },
  props: ["init_is_loading"],
  data: function() {
    return {
      isLoading: this.init_is_loading
    };
  },
  watch: {
    init_is_loading: function() {
      this.isLoading = this.init_is_loading;
    }
  },
  methods: {}
};
</script>
<style lang="scss">
</style>
