<template>
  <div class="my-tag has-addons" @click="handleOnClick">
    <span class="tag is-success">{{ body }}</span>
    <span v-if="count" class="tag">{{ count }}</span>
  </div>
</template>
<script>
export default {
  name: "Tag",
  props: {
    body: {
      type: String,
      required: true,
    },
    count: {
      type: Number,
      default: null,
    },
  },
  methods: {
    handleOnClick: function (event) {
      this.$emit("click", this.body, event);
    },
  },
};
</script>
<style lang="scss" scoped>
.my-tag {
  cursor: pointer;
}
</style>
