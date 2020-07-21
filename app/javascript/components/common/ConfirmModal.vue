<template>
  <div class="board-confirm-modal modal is-active">
    <div class="modal-background" />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          {{ title }}
        </p>
        <button class="delete" aria-label="close" @click="close()" />
      </header>
      <section class="modal-card-body">
        <slot />
      </section>
      <footer class="modal-card-foot">
        <button class="button submit is-success is-fullwidth" @click="submit()">
          Submit
        </button>
      </footer>
    </div>
  </div>
</template>
<script>
export default {
  name: "ConfirmModal",
  components: {},
  props: ["title"],
  methods: {
    close: function () {
      this.$emit("close");
    },
    submit: function () {
      this.$emit("submit");
    },
  },
};
</script>
<style lang="scss"></style>
