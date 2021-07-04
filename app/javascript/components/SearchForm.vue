<template>
  <div class="search-form">
    <div v-if="showTags.length > 0" class="tag-area has-background-white">
      <div class="field is-grouped is-grouped-multiline">
        <span class="tag is-light control has-text-weight-medium">Tags</span>
        <div v-for="(tag, index) in showTags" :key="index" class="control">
          <tag :body="tag.body" :count="tag.count" @click="tagSearch" />
        </div>
        <button
          v-if="allTags.length > initShowTagsLimit"
          class="button is-light is-link control more"
          @click.prevent="toggleShowAllTags"
        >
          <span v-if="showAllTags"> close <font-awesome-icon :icon="['fas', 'arrow-circle-up']" /> </span>
          <span v-else> more <font-awesome-icon :icon="['fas', 'arrow-circle-down']" /> </span>
        </button>
      </div>
    </div>
    <div class="field is-grouped">
      <div class="control is-expanded">
        <input
          v-model="keyword"
          class="input"
          placeholder="タグ、タイトルで検索できます"
          @keydown.enter="keywordSearch"
        />
      </div>
      <div class="control">
        <button class="button submit is-success" @click="keywordSearch">検索</button>
        <button class="button" @click="keywordReset">Reset</button>
      </div>
    </div>
  </div>
</template>
<script>
import { defineComponent } from "vue";
import Tag from "@js/components/Tag.vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faArrowCircleDown, faArrowCircleUp } from "@fortawesome/free-solid-svg-icons";

library.add(faArrowCircleDown, faArrowCircleUp);
export default defineComponent({
  name: "SearchForm",
  components: {
    Tag,
    FontAwesomeIcon,
  },
  props: {
    initKeyword: {
      type: String,
      default: "",
    },
    initTags: {
      type: Array,
      default: () => [],
    },
    initShowTagsLimit: {
      type: Number,
      default: 10,
    },
  },
  emits: ["search"],
  data: function () {
    return {
      keyword: this.initKeyword,
      allTags: this.initTags,
      showAllTags: false,
    };
  },
  computed: {
    omittedTags: function () {
      return this.allTags.slice(0, this.initShowTagsLimit);
    },
    showTags: function () {
      return this.showAllTags ? this.allTags : this.omittedTags;
    },
  },
  watch: {
    initKeyword(newKeyword) {
      this.keyword = newKeyword;
    },
    initTags(newTags) {
      this.allTags = newTags;
    },
  },
  methods: {
    toggleShowAllTags: function () {
      this.showAllTags = !this.showAllTags;
    },
    keywordSearch: function () {
      this.$emit("search", this.keyword);
    },
    tagSearch: function (tagBody) {
      this.keyword = tagBody;
      this.$emit("search", tagBody);
    },
    keywordReset: function () {
      this.keyword = "";
    },
  },
});
</script>
<style lang="scss" scoped>
@import "@css/common.scss";

.tag-area {
  margin-bottom: 10px;
  padding: 10px;
  border-radius: 4px;

  .more {
    font-size: $font-size-s;
    padding: 0px 9px;
    height: inherit;
  }
}
</style>
