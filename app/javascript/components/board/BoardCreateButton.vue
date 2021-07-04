<template>
  <div class="board-create-button">
    <button
      class="button is-conversion is-rounded is-fullwidth has-text-weight-bold"
      :disabled="!isActive"
      @click="handleOnClick()"
    >
      1つにまとめる
    </button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

interface DataType {
  showModal: boolean;
}

export default defineComponent({
  name: "BoradCreateButton",
  components: {},
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
  },
  emits: ["click"],
  methods: {
    handleOnClick: function (): void {
      this.$emit("click");
    },
  },
});
</script>

<style lang="scss"></style>
