<template>
  <div class="board-create-button">
    <button
      class="button is-primary is-fullwidth"
      :disabled="!isActive()"
      @click="hundleOnClick()"
    >
      ボードを作る
    </button>
    <board-confirm-modal
      v-show="showModal"
      :feeds="feeds"
      :title="title"
      @close="hundleOnClose()"
      @submit="hundleOnSubmit()"
    />
  </div>
</template>

<script>
import BoardConfirmModal from "@js/components/BoardConfirmModal.vue";
import { postBoard } from "@js/services/BoardService.ts";

export default {
  name: "BoradCreateButton",
  components: { BoardConfirmModal },
  props: ["feeds", "title"],
  data: function () {
    return {
      showModal: false
    };
  },
  methods: {
    isActive: function () {
      return this.feeds.length > 0;
    },
    hundleOnClick: function () {
      this.showModal = true;
    },
    hundleOnClose: function () {
      this.showModal = false;
    },
    hundleOnSubmit: async function () {
      try {
        const res = await postBoard({ feed_ids: this.feeds.map(feed => feed.id), title: this.title });
        window.location.href = `/boards/${res.data.id}`;
      } finally {
        this.showModal = false;
      }
    }
  }
};
</script>

<style lang="scss">
</style>
