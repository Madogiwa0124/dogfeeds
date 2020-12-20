<template>
  <div class="feed-card-collection is-multiline columns">
    <div v-for="feed in feeds" :key="feed.id" :class="`column is-${clumnSize}`">
      <feed-card
        :feed="feed"
        :selectable="selectable"
        :selected="selected(feed)"
        :openNewTab="openNewTab"
        @clickTag="handleOnClickTag"
        @selectedFeed="handleOnSelected"
        @unselectedFeed="handleOnUnselected"
      />
    </div>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import { Feed } from "@js/types/types.d.ts";
import FeedCard from "@js/components/feed/FeedCard.vue";

interface DataType {
  feeds: Feed[];
}

export default Vue.extend({
  name: "FeedCardCollection",
  components: { FeedCard },
  props: {
    clumnSize: {
      type: Number,
      default: 4,
    },
    initFeeds: {
      type: Array as PropType<Feed[]>,
      default(): Feed[] {
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
    openNewTab: {
      type: Boolean,
      default: false,
    },
  },
  data(): DataType {
    return {
      feeds: this.initFeeds,
    };
  },
  methods: {
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
