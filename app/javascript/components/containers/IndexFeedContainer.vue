<template>
  <div id="feeds" class="feed-index columns">
    <main class="column">
      <div class="tabs">
        <ul>
          <li class="feeds" :class="{ 'is-active': selectedFeedTab }">
            <a @click="handleOnFeedTabClick"><span>RSSフィード</span></a>
          </li>
          <li class="entries" :class="{ 'is-active': selectedEntryTab }">
            <a @click="handleOnEntryTabClick"><span>記事</span></a>
          </li>
        </ul>
      </div>
      <feed-collection-container v-if="selectedFeedTab" :search-word="initSearchWord" />
      <entry-collection-container v-if="selectedEntryTab" />
    </main>
  </div>
</template>
<script lang="ts">
import { defineComponent } from "vue";
import FeedCollectionContainer from "@js/components/containers/feed/FeedCollectionContainer.vue";
import EntryCollectionContainer from "@js/components/containers/feed/EntryCollectionContainer.vue";
import { parse } from "querystring";

enum Tabs {
  Feed = "feed",
  Entry = "entry",
}

interface DataType {
  selectedTab: Tabs;
}

export default defineComponent({
  name: "IndexFeedContainer",
  components: { FeedCollectionContainer, EntryCollectionContainer },
  props: {
    searchWord: {
      type: String,
      default: "",
    },
  },
  data(): DataType {
    return {
      selectedTab: Tabs.Feed,
    };
  },
  computed: {
    selectedFeedTab(): boolean {
      return this.selectedTab == Tabs.Feed;
    },
    selectedEntryTab(): boolean {
      return this.selectedTab == Tabs.Entry;
    },
    initSearchWord(): string | string[] {
      const searchKeywordQuery = "?query[keyword]";
      return parse(decodeURI(window.location.search))[searchKeywordQuery];
    },
  },
  methods: {
    handleOnFeedTabClick() {
      this.selectedTab = Tabs.Feed;
    },
    handleOnEntryTabClick() {
      this.selectedTab = Tabs.Entry;
    },
  },
});
</script>
<style lang="scss" scoped>
@import "@css/common.scss";

.feed-index {
  padding: 20px;

  .tabs {
    margin-bottom: 10px;

    li.is-active a {
      border-bottom-color: $primary-color;
      color: $primary-color;
    }
  }
}
</style>
