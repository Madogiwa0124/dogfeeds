<template>
  <span class="tag is-primary" @click="handleOnClick">
    {{ tag.body }}
  </span>
</template>
<script>
export default {
  name: "Tag",
  props: {
    tag: {
      type: Object,
      required: true,
    },
  },
  methods: {
    handleOnClick: function () {
      this.$emit("click", this.tag.body);
    },
  },
};
</script>
<style lang="scss"></style>
