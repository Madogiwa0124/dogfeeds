<template>
  <span class="tag is-success" @click="handleOnClick">
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
    handleOnClick: function (event) {
      this.$emit("click", this.body, event);
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
