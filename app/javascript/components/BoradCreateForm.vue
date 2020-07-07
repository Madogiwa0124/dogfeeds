<template>
  <div class="board-create-form">
    <div class="field">
      <div class="control">
        <input
          v-model="title"
          type="text"
          class="input"
          placeholder="ボードのタイトル(任意)"
        >
      </div>
    </div>
    <ul class="menu-list">
      <selected-feed
        v-for="feed in feeds"
        :key="feed.id"
        :feed="feed"
        @unselectedFeed="handleOnUnselectedFeed"
      />
    </ul>
    <board-create-button
      :is-active="feeds.length > 0"
      @click="handleOnClick"
    />
    <board-confirm-modal
      v-show="showModal"
      :feeds="feeds"
      :title="title"
      @close="handleOnClose"
      @submit="handleOnSubmit"
    />
  </div>
</template>
<script>
import SelectedFeed from "@js/components/SelectedFeed.vue";
import BoardCreateButton from "@js/components/BoardCreateButton.vue";
import BoardConfirmModal from "@js/components/BoardConfirmModal.vue";

export default {
  name: "BoadCreateForm",
  components: { SelectedFeed, BoardCreateButton, BoardConfirmModal },
  props: ["feeds"],
  data: function () {
    return {
      title: "",
      showModal: false
    };
  },
  methods: {
    handleOnClick: function () {
      console.log("fire");
      this.showModal = true;
    },
    handleOnClose: function () {
      this.showModal = false;
    },
    handleOnUnselectedFeed: function (id) {
      this.$emit("unselectedFeed", id);
    },
    handleOnSubmit: function () {
      this.$emit("submitBoard", this.title);
    }
  }
};
</script>
<style lang="scss">

</style>
