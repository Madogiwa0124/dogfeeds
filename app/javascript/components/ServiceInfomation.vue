<template>
  <article class="service-infomation message">
    <div class="message-header has-background-info">
      <p>Dogfeedsとは、いろんなRSSをまとめて、1つのRSSにすることが出来るサービスです🐶</p>
      <button class="delete" aria-label="delete" @click="handleOnDelete" />
    </div>
    <div class="message-body">
      <strong>使い方</strong>
      <br />
      1. このページでRSSフィードを<strong>「選択します ✅」</strong><br />
      2. 選択が終わったら<strong>「1つにまとめる」</strong>をクリックして、まとめたRSSを作ります 🐾<br />
      3. 作成後の遷移先で<strong>「Rssへのリンクはこちら」</strong>からまとめたRSSのURLを取得出来ます ✨<br />
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
