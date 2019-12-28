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
    <borad-create-button
      :feeds="feeds"
      :title="title"
    />
  </div>
</template>
<script>
import SelectedFeed from "./SelectedFeed";
import BoradCreateButton from "./BoardCreateButton";

export default {
  name: "SelectedFeedCollection",
  components: { SelectedFeed, BoradCreateButton },
  props: ["feeds"],
  data: function () {
    return {
      title: ""
    };
  },
  methods: {
    handleOnUnselectedFeed: function (id) {
      this.$emit("unselectedFeed", id);
    }
  }
};
</script>
<style lang="scss">

</style>
