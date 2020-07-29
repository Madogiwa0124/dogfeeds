<template>
  <div class="entry-card-collection entries">
    <entry-card v-for="entry in entries" :key="entry.id" :entry="entry" />
  </div>
</template>
<script>
import EntryCard from "@js/components/entry/EntryCard";

export default {
  name: "EntryCardCollection",
  components: { EntryCard },
  props: {
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
