<template>
  <button class="to-top-button button is-rounded is-outlined is-info" @click="handleOnClick">TOPに戻る</button>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
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
