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
        <input
          v-model="title"
          type="text"
          class="input"
          placeholder="ボードのタイトル(任意)"
        >
      </div>
      <ul class="menu-list">
        <selected-feed
          v-for="feed in selectedFeeds"
          :key="feed.id"
          :feed="feed"
          @unselectedFeed="handleOnUnselectedFeed"
        />
      </ul>
      <board-create-button
        :is-active="selectedFeeds.length > 0"
        @click="handleOnClick"
      />
      <board-confirm-modal
        v-show="showModal"
        :feeds="selectedFeeds"
        :title="title"
        @close="handleOnClose"
        @submit="handleOnSubmit"
      />
    </div>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import store from "@js/packs/store";
import { Feed } from "@js/types/types.d.ts";
import SelectedFeed from "@js/components/SelectedFeed.vue";
import BoardCreateButton from "@js/components/BoardCreateButton.vue";
import BoardConfirmModal from "@js/components/BoardConfirmModal.vue";

interface DataType {
  title: string;
  showModal: boolean;
  selectedFeeds: Feed[];
}

export default Vue.extend({
  name: "BoadCreateForm",
  components: { SelectedFeed, BoardCreateButton, BoardConfirmModal },
  props: {},
  data: function (): DataType {
    return {
      title: "",
      showModal: false,
      selectedFeeds: store.state.selectedFeeds,
    };
  },
  methods: {
    handleOnUnselectedFeed: function (id) {
      const target = this.findSelectedFeed(id);
      this.selectedFeeds.splice(this.selectedFeeds.indexOf(target), 1);
    },
    findSelectedFeed: function (id) {
      return this.selectedFeeds.find(function(feed) { return feed.id === id; });
    },
    handleOnClick: function (): void {
      this.showModal = true;
    },
    handleOnClose: function (): void {
      this.showModal = false;
    },
    handleOnSubmit: function (): void {
      this.$emit("submitBoard", this.title, this.selectedFeeds);
    }
  }
});
</script>
<style lang="scss">

</style>
