<template>
  <div class="search-form field is-grouped">
    <div class="control is-expanded">
      <input v-model="keyword" class="input" placeholder="タグ、タイトルで検索できます" @keydown.enter="search" />
    </div>
    <div class="control">
      <button class="button submit is-primary" @click="search">
        検索
      </button>
    </div>
  </div>
</template>
<script>
export default {
  name: "SearchForm",
  components: {},
  props: {
    initKeyword: {
      type: String,
      default: "",
    },
  },
  data: function () {
    return {
      keyword: this.initKeyword,
    };
  },
  watch: {
    initKeyword(newKeyword) {
      this.keyword = newKeyword;
    },
  },
  methods: {
    search: function () {
      this.$emit("search", this.keyword);
    },
  },
};
</script>
<style lang="scss"></style>
