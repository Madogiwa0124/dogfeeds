<template>
  <div class="feed-infomation">
    <h1 class="title">{{ feed.title }}</h1>
    <div class="center description">
      RSSフィードのURL:
      <a :href="feed.endpoint" target="_blank" rel="noopener">
        {{ feed.endpoint }}
        <font-awesome-icon icon="external-link-alt" />
      </a>
    </div>
    <div class="is-centered tags is-grouped">
      <div v-for="(tag, index) in feed.tags" :key="index" class="control">
        <tag :body="tag.body" @click="handleOnTagClick" />
      </div>
    </div>
    <entry-card-collection :entries="entries" :clumnSize="3" @clipEntry="handleOnClipEntry" />
  </div>
</template>
<script lang="ts">
import { defineComponent, PropType } from "vue";
import { Feed, Entry } from "@js/types/types";
import Tag from "@js/components/Tag.vue";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faExternalLinkAlt } from "@fortawesome/free-solid-svg-icons";
library.add(faExternalLinkAlt);

export default defineComponent({
  name: "FeedInfomation",
  components: { Tag, EntryCardCollection, FontAwesomeIcon },
  props: {
    feed: {
      type: Object as PropType<Feed>,
      required: true,
    },
    entries: {
      type: Array as PropType<Entry[]>,
      default: () => [],
    },
  },
  emits: ["tagClick", "clipEntry"],
  methods: {
    handleOnTagClick: function (body: string) {
      this.$emit("tagClick", body);
    },
    handleOnClipEntry: function (entryLink: string, cliped: boolean): void {
      this.$emit("clipEntry", entryLink, cliped);
    },
  },
});
</script>
<style lang="scss" scoped>
.feed-infomation {
  max-width: 90%;
  margin: 0px auto;

  .description {
    margin-bottom: 15px;
    padding: 10px;
    width: 100%;
    border-radius: 5px;
    background-color: #ffffff;
  }

  .title {
    text-align: center;
  }
}
</style>
