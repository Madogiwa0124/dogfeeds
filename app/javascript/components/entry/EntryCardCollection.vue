<template>
  <div class="entry-card-collection entries is-multiline columns">
    <div v-for="entry in entries" :key="entry.id" :class="`column is-${clumnSize}`">
      <entry-card :entry="entry" :descriptionLimit="descriptionLimit" :showFeedLink="showFeedLink" />
    </div>
  </div>
</template>
<script>
import EntryCard from "@js/components/entry/EntryCard";

export default {
  name: "EntryCardCollection",
  components: { EntryCard },
  props: {
    clumnSize: {
      type: Number,
      default: 12,
    },
    descriptionLimit: {
      type: Number,
      default: null,
    },
    showFeedLink: {
      type: Boolean,
      default: false,
    },
    entries: {
      type: Array,
      default: () => {
        return [];
      },
    },
  },
};
</script>
<style lang="scss" scoped>
.entry-card-collection {
  margin: 0px auto;

  .entry-card {
    margin: 15px;
  }
}
</style>
