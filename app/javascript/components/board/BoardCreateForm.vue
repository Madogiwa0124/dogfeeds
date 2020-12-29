<template>
  <div class="board-create-form">
    <div class="field">
      <div v-if="selectedFeeds.length < 1" class="has-text-centered has-text-justified">
        <speech-bubble body="まとめたいRSSフィードを選択してください 🐶" />
      </div>
      <div v-else>
        <speech-bubble body="以下のRSSフィードを選択中です 🐾" />
      </div>
      <ul class="menu-list">
        <selected-feed
          v-for="feed in selectedFeeds"
          :key="feed.id"
          :feed="feed"
          @unselectedFeed="handleOnUnselectedFeed"
        />
      </ul>
      <label v-if="selectedFeeds.length > 0" class="menu-label has-text-dark">タイトル(任意)</label>
      <div v-if="selectedFeeds.length > 0" class="control board-title">
        <input v-model="title" type="text" class="input board-title" placeholder="例)IT関連RSSまとめ etc." />
      </div>
      <board-create-button :is-active="selectedFeeds.length > 0" @click="handleOnSubmit" />
    </div>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import { Feed } from "@js/types/types.ts";
import SelectedFeed from "@js/components/feed/SelectedFeed.vue";
import BoardCreateButton from "@js/components/board/BoardCreateButton.vue";
import SpeechBubble from "@js/components/common/SpeechBubble.vue";

interface DataType {
  title: string;
}

export default Vue.extend({
  name: "BoardCreateForm",
  components: { SelectedFeed, BoardCreateButton, SpeechBubble },
  props: {
    selectedFeeds: {
      type: Array as PropType<Feed[]>,
      default: function () {
        return [];
      },
    },
  },
  data: function (): DataType {
    return {
      title: "",
    };
  },
  methods: {
    handleOnUnselectedFeed: function (id: number): void {
      this.$emit("unselectedFeed", id);
    },
    handleOnSubmit: function (): void {
      // NOTE: なぜかProperty 'XXX' does not exist on typeが発生するのでthisの型を無視する
      this.$emit("submitBoard", (this as any).title);
    },
  },
});
</script>
<style lang="scss" scoped>
.board-create-form {
  .field {
    div.board-title.control {
      margin-bottom: 5px;
    }
  }
}
</style>
