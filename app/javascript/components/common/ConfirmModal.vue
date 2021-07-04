<template>
  <div class="confirm-modal modal is-active">
    <div class="modal-background" />
    <div class="modal-card">
      <section class="modal-card-body">
        <p class="modal-card-title is-size-6 center has-text-weight-semibold">
          {{ title }}
        </p>
        <slot />
        <div class="btn-area has-text-centered">
          <button class="button is-rounded" @click="close">{{ cancelTitle }}</button>
          <button class="button submit is-rounded is-conversion" @click="submit">{{ submitTitle }}</button>
        </div>
      </section>
    </div>
  </div>
</template>
<script>
import { defineComponent } from "vue";

export default defineComponent({
  name: "ConfirmModal",
  components: {},
  props: {
    title: {
      type: String,
      required: true,
    },
    submitTitle: {
      type: String,
      default: "OK",
    },
    cancelTitle: {
      type: String,
      default: "キャンセル",
    },
  },
  emits: ["close", "submit"],
  methods: {
    close: function () {
      this.$emit("close");
    },
    submit: function () {
      this.$emit("submit");
    },
  },
});
</script>
<style lang="scss" scoped>
.confirm-modal {
  .modal-card-head {
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;
  }
  .btn-area {
    button {
      margin: 0px 20px;
      min-width: 120px;
    }
  }
}
</style>
