<template>
  <article class="service-infomation message">
    <div class="message-header has-background-info">
      <p>Dogfeedsとは？</p>
      <button class="delete" aria-label="delete" @click="handleOnDelete" />
    </div>
    <div class="message-body">
      <strong>
        RSSフィードをまとめたRssフィードを作ることができます。 作り方は簡単なので、ぜひ作ってみてください🐶
      </strong>
      <br />
      1. フィードを選択する<br />
      2. まとめたフィード(ボード)に名前をつける<br />
      3. ボードを作って、共有するなり、Slackチャンネルに追加するなりする！<br />
    </div>
  </article>
</template>
<script lang="ts">
import Vue from "vue";
export default Vue.extend({
  name: "SetviceInfomation",
  methods: {
    handleOnDelete: function () {
      this.$emit("delete");
    },
  },
});
</script>
<style lang="scss" scoped>
.message {
  margin-bottom: 0em;

  .delete {
    &:hover {
      background-color: hsl(348, 100%, 61%);
    }
  }

  .message-body {
    color: #000000;
    background-color: #ffffff;
  }
}
</style>
