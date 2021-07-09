<template>
  <div class="my-tag tags has-addons" @click="handleOnClick">
    <span class="tag is-success">{{ body }}</span>
    <span v-if="count" class="tag">{{ count }}</span>
  </div>
</template>
<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
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
  emits: ["click"],
  methods: {
    handleOnClick: function (event: Event) {
      this.$emit("click", this.body, event);
    },
  },
});
</script>
<style lang="scss" scoped>
.my-tag {
  cursor: pointer;
}
</style>
