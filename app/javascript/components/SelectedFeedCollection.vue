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
      @unselectedFeed="handleOnUnselectedFeed(id)"
    />
  </aside>
</template>
<script>
import store from '../packs/store';
import BoradCreateForm from './BoradCreateForm';

export default {
  name: 'SelectedFeedCollection',
  components: { BoradCreateForm },
  data: () => store.state,
  methods: {
    // TODO: 下記警告に対応するためにidを返すメソッドを定義しているが、詳細要調査
    // [Vue warn]: Property or method "id" is not defined on the instance but referenced during render
    id: function (id) {
      return id;
    },
    handleOnUnselectedFeed: function (id) {
      const target = this.findSelectedFeed(id);
      this.selectedFeeds.splice(this.selectedFeeds.indexOf(target), 1);
    },
    findSelectedFeed: function (id) {
      return this.selectedFeeds.find(function(feed) { return feed.id === id; });
    }
  }
};
</script>
<style lang="scss">

</style>
