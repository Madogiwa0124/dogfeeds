<template>
  <span class="tag is-primary" @click="handleOnClick">
    {{ body }}
  </span>
</template>
<script>
export default {
  name: "Tag",
  props: {
    body: {
      type: String,
      required: true,
    },
  },
  methods: {
    handleOnClick: function () {
      this.$emit("click", this.body);
    },
  },
};
</script>
<style lang="scss" scoped>
.tag {
  margin-right: 3px;
  cursor: pointer;
}
</style>
