<template>
  <div class="board-create-form">
    <p class="menu-label">
      Selected Feeds
    </p>
    <span v-if="selectedFeeds.length < 1">
      まとめたいRSSフィードを選択して、ボード作ってみませんか？🐾
    </span>
    <div class="field">
      <div class="control">
        <input v-model="title" type="text" class="input" placeholder="ボードのタイトル(任意)" />
      </div>
      <ul class="menu-list">
        <selected-feed
          v-for="feed in selectedFeeds"
          :key="feed.id"
          :feed="feed"
          @unselectedFeed="handleOnUnselectedFeed"
        />
      </ul>
      <board-create-button :is-active="selectedFeeds.length > 0" @click="handleOnClick" />
      <board-confirm-modal
        v-show="showModal"
        title="このRSSフィードをまとめる！"
        @close="handleOnClose"
        @submit="handleOnSubmit"
      >
        <p v-if="title.length > 0" class="has-text-weight-semibold">タイトル「{{ title }}」</p>
        <div class="content">
          <ul>
            <li v-for="feed in selectedFeeds" :key="feed.id">
              {{ feed.title }}
            </li>
          </ul>
        </div>
      </board-confirm-modal>
    </div>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import { Feed } from "@js/types/types.d.ts";
import SelectedFeed from "@js/components/SelectedFeed.vue";
import BoardCreateButton from "@js/components/BoardCreateButton.vue";
import BoardConfirmModal from "@js/components/common/ConfirmModal.vue";

interface DataType {
  title: string;
  showModal: boolean;
}

export default Vue.extend({
  name: "BoardCreateForm",
  components: { SelectedFeed, BoardCreateButton, BoardConfirmModal },
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
      showModal: false,
    };
  },
  methods: {
    handleOnUnselectedFeed: function (id: number): void {
      this.$emit("unselectedFeed", id);
    },
    handleOnClick: function (): void {
      // NOTE: なぜかProperty 'XXX' does not exist on typeが発生するのでthisの型を無視する
      (this as any).showModal = true;
    },
    handleOnClose: function (): void {
      // NOTE: なぜかProperty 'XXX' does not exist on typeが発生するのでthisの型を無視する
      (this as any).showModal = false;
    },
    handleOnSubmit: function (): void {
      // NOTE: なぜかProperty 'XXX' does not exist on typeが発生するのでthisの型を無視する
      this.$emit("submitBoard", (this as any).title);
    },
  },
});
</script>
<style lang="scss"></style>
