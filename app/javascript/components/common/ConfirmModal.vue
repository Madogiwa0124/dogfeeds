<template>
  <div class="confirm-modal modal is-active">
    <div class="modal-background" />
    <div class="modal-card">
      <header :class="`modal-card-head has-background-${level}`">
        <p class="modal-card-title has-text-white">
          {{ title }}
        </p>
        <button class="delete" aria-label="close" @click="close()" />
      </header>
      <section class="modal-card-body">
        <slot />
      </section>
      <footer class="modal-card-foot">
        <button :class="`button submit is-${level} is-fullwidth`" @click="submit()">
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
  props: {
    title: {
      type: String,
      required: true,
    },
    level: {
      type: String,
      default: "primary",
    },
  },
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
