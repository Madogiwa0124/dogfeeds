<template>
  <div class="feed-infomation">
    <h1 class="title">{{ feed.title }}</h1>
    <div class="tags">
      <tag v-for="tag in feed.tags" :key="tag.id" :body="tag.body" @click="handleOnTagClick" />
    </div>
    <entry-card-collection :entries="entries" />
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import { Feed, Entry } from "@js/types/types.d.ts";
import Tag from "@js/components/Tag.vue";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";

export default Vue.extend({
  name: "FeedInfomation",
  components: { Tag, EntryCardCollection },
  props: {
    feed: {
      type: Object as PropType<Feed>,
      required: true,
    },
    entries: {
      type: Array as PropType<Entry[]>,
      default: [],
    },
  },
  methods: {
    handleOnTagClick: function (body: string) {
      this.$emit("tagClick", body);
    },
  },
});
</script>
<style lang="scss" scoped>
.feed-infomation {
  .title {
    text-align: center;
  }

  .entry-card-collection {
    max-width: 90%;
  }

  .tags {
    display: block;
    text-align: center;
  }
}
</style>
