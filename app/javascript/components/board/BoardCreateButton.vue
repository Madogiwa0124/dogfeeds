<template>
  <div class="board-create-button">
    <button class="button is-primary is-fullwidth has-text-weight-bold" :disabled="!isActive" @click="handleOnClick()">
      ボードを作る
    </button>
  </div>
</template>

<script lang="ts">
import Vue from "vue";

interface DataType {
  showModal: boolean;
}

export default Vue.extend({
  name: "BoradCreateButton",
  components: {},
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    handleOnClick: function (): void {
      this.$emit("click");
    },
  },
});
</script>

<style lang="scss"></style>
