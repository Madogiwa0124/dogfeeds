<template>
  <div class="entries is-multiline columns">
    <div
      v-for="feed in feeds"
      :key="feed.id"
      class="column is-4"
    >
      <feed-card
        :feed="feed"
        :lastEntry="feedLastEntry(feed)"
        :tags="feedTags(feed)"
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
      default(): Feed[] { return []; },
      require: false
    },
    initLastEntries: {
      type: Array as PropType<Entry[]>,
      default(): Entry[] { return []; },
      require: false
    },
    initTags: {
      type: Array as PropType<FeedTag[]>,
      default(): FeedTag[] { return []; },
      require: false
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
    feedLastEntry: function(feed: Feed): Entry {
      return this.lastEntries.filter(entry => entry.feed_id === feed.id)[0];
    },
    feedTags: function(feed: Feed): FeedTag {
      return this.tags.filter(tag => tag.feed_id === feed.id);
    }
  }
});
</script>
<style lang="scss">
</style>
