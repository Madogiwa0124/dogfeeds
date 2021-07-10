<template>
  <div class="pageloader" :class="{ 'is-active': isLoading }">
    <span class="title">Loading</span>
  </div>
</template>
<script>
import { defineComponent } from "vue";

export default defineComponent({
  name: "PageLoader",
  components: {},
  props: ["initIsLoading"],
  data: function () {
    return {
      isLoading: this.initIsLoading,
    };
  },
  watch: {
    initIsLoading: function () {
      this.isLoading = this.initIsLoading;
    },
  },
  methods: {},
});
</script>
<style lang="scss"></style>
