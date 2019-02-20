<template>
  <div class="modal is-active">
    <div class="modal-background" />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          ボードを作る
        </p>
        <button
          class="delete"
          aria-label="close"
          @click="close()"
        />
      </header>
      <section class="modal-card-body">
        <p class="has-text-weight-semibold">
          下記のフィードをまとめますね！
        </p>
        <ul>
          <li
            v-for="feed in feeds"
            :key="feed.id"
          >
            {{ feed.title }}
          </li>
        </ul>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button is-success is-fullwidth"
          @click="submit()"
        >
          OK!!
        </button>
      </footer>
    </div>
  </div>
</template>
<script>
export default {
  name: 'ConfirmModal',
  components: {},
  props: ['feeds'],
  methods: {
    close: function () {
      this.$emit('close');
    },
    submit: function () {
      this.$emit('submit');
    }
  }
};
</script>
<style>
</style>
