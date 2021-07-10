<template>
  <div class="speech-bubble">
    <div class="balloon1">{{ body }}</div>
  </div>
</template>
<script>
export default {
  name: "SpeechBubble",
  components: {},
  props: {
    body: {
      type: String,
      required: true,
    },
  },
  methods: {},
};
</script>
<style lang="scss" scoped>
@import "@css/common.scss";

.speech-bubble {
  .balloon1 {
    position: relative;
    display: inline-block;
    margin: 0 0 1.5em 0;
    padding: 7px 10px;
    width: 100%;
    font-size: $font-size-ms;
    background: #ffffff;
    border-radius: 10px;
  }

  .balloon1:before {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -15px;
    border: 15px solid transparent;
    border-top: 15px solid #ffffff;
  }

  .balloon1 p {
    margin: 0;
    padding: 0;
  }
}
</style>
