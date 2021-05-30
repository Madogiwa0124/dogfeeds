<template>
  <article :class="`message is-${level}`">
    <div class="message-header">
      <p>{{ title }}</p>
    </div>
    <div class="message-body">
      <p class="body">{{ body }}</p>
    </div>
  </article>
</template>
<script>
export default {
  name: "Message",
  components: {},
  props: {
    title: {
      type: String,
      required: true,
    },
    body: {
      type: String,
      required: true,
    },
    level: {
      type: String,
      required: true,
    },
  },
  methods: {},
};
</script>
<style lang="scss" scoped>
.message {
  text-align: center;

  .message-body {
    .body {
      font-size: 1.5em;
      margin-bottom: 1em;
    }

    .top-link {
      font-size: 1.2em;
    }
  }
}
</style>
