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
      <feed-collection-container v-if="selectedFeedTab" />
      <entry-collection-container v-if="selectedEntryTab" />
    </main>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import FeedCollectionContainer from "@js/components/containers/feed/FeedCollectionContainer.vue";
import EntryCollectionContainer from "@js/components/containers/feed/EntryCollectionContainer.vue";

enum Tabs {
  Feed = "feed",
  Entry = "entry",
}

interface DataType {
  selectedTab: Tabs;
}

export default Vue.extend({
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
.feed-index {
  padding: 20px;

  .tabs {
    margin-bottom: 0px;

    li.is-active a {
      border-bottom-color: hsl(171, 100%, 41%);
      color: hsl(171, 100%, 41%);
    }
  }
}
</style>
