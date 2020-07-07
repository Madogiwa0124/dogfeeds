<template>
  <aside class="menu column is-2">
    <p class="menu-label">
      Selected Feeds
    </p>
    <span v-if="selectedFeeds.length < 1">
      まとめたいRSSフィードを選択して、ボード作ってみませんか？🐾
    </span>
    <borad-create-form
      :feeds="selectedFeeds"
      @unselectedFeed="handleOnUnselectedFeed"
      @submitBoard="handleOnSubmitBoard"
    />
  </aside>
</template>
<script>
import store from "@js/packs/store";
import BoradCreateForm from "@js/components/BoradCreateForm";

export default {
  name: "SelectedFeedCollection",
  components: { BoradCreateForm },
  data: () => store.state,
  methods: {
    handleOnUnselectedFeed: function (id) {
      const target = this.findSelectedFeed(id);
      this.selectedFeeds.splice(this.selectedFeeds.indexOf(target), 1);
    },
    findSelectedFeed: function (id) {
      return this.selectedFeeds.find(function(feed) { return feed.id === id; });
    },
    handleOnSubmitBoard: function(title) {
      this.$emit("submitBoard", title, this.selectedFeeds);
    }
  }
};
</script>
<style lang="scss">

</style>
