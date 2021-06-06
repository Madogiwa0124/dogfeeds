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
@import "@css/common.scss";

.message {
  .message-body {
    .body {
      font-size: $font-size-m;
    }

    .top-link {
      font-size: $font-size-m;
    }
  }
}
</style>
