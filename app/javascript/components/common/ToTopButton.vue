<template>
  <div class="board-create-button">
    <button class="button is-rounded is-outlined is-info" @click="handleOnClick()">TOPに戻る</button>
  </div>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "ToTopButton",
  components: {},
  methods: {
    handleOnClick: function (): void {
      location.href = "/";
    },
  },
});
</script>

<style lang="scss"></style>
