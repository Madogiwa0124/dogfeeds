<template>
  <div class="feed-card-collection entries is-multiline columns">
    <div v-for="feed in feeds" :key="feed.id" class="column is-4">
      <feed-card
        :feed="feed"
        :lastEntry="feedLastEntry(feed)"
        :tags="feedTags(feed)"
        :selectable="selectable"
        :selected="selected(feed)"
        @clickTag="handleOnClickTag"
        @selectedFeed="handleOnSelected"
        @unselectedFeed="handleOnUnselected"
      />
    </div>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import { Feed, Entry, FeedTag } from "@js/types/types.d.ts";
import FeedCard from "@js/components/FeedCard.vue";

interface DataType {
  feeds: Feed[];
  lastEntries: Entry[];
  tags: FeedTag[];
}

export default Vue.extend({
  name: "FeedCardCollection",
  components: { FeedCard },
  props: {
    initFeeds: {
      type: Array as PropType<Feed[]>,
      default(): Feed[] {
        return [];
      },
    },
    initLastEntries: {
      type: Array as PropType<Entry[]>,
      default(): Entry[] {
        return [];
      },
    },
    initTags: {
      type: Array as PropType<FeedTag[]>,
      default(): FeedTag[] {
        return [];
      },
    },
    selectedFeeds: {
      type: Array as PropType<Feed[]>,
      default(): Feed[] {
        return [];
      },
    },
    selectable: {
      type: Boolean,
      default: true,
    },
  },
  data(): DataType {
    return {
      feeds: this.initFeeds,
      lastEntries: this.initLastEntries,
      tags: this.initTags,
    };
  },
  methods: {
    feedLastEntry: function (feed: Feed): Entry {
      return this.lastEntries.filter((entry) => entry.feed_id === feed.id)[0];
    },
    feedTags: function (feed: Feed): FeedTag {
      return this.tags.filter((tag) => tag.feed_id === feed.id);
    },
    selected: function (feed: Feed): boolean {
      const exists = !!this.selectedFeeds.find(function (selectedFeed) {
        return selectedFeed.id === feed.id;
      });
      return exists;
    },
    handleOnClickTag: function (tagBody: string): void {
      this.$emit("clickTag", tagBody);
    },
    handleOnSelected: function (id: number) {
      this.$emit("selectedFeed", id);
    },
    handleOnUnselected: function (id: number) {
      this.$emit("unselectedFeed", id);
    },
  },
});
</script>
<style lang="scss"></style>
