<template>
  <div class="field is-grouped">
    <div class="control is-expanded">
      <input
        v-model="keyword"
        class="input"
        placeholder="タグ、タイトルで検索できます"
        @keydown.enter="Search()"
      >
    </div>
    <div class="control">
      <button
        class="button is-primary"
        @click="Search()"
      >
        検索
      </button>
    </div>
  </div>
</template>
<script>
export default {
  name: 'SearchForm',
  components: {},
  props: ['init_keyword'],
  data: function() {
    return {
      keyword: this.init_keyword,
    };
  },
  computed: {
    query: function () {
      return `?query[keyword]=${this.keyword}`;
    }
  },
  methods: {
    Search: function() {
      // TODO: 検索処理は非同期でやってEntoryCardCollectionのfeedsを更新するようにしたい。。。
      window.location.href = location.pathname + this.query;
    }
  }
};
</script>
<style lang="scss">
</style>
