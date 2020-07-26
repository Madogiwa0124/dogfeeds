<template>
  <div class="entries">
    <entry-card v-for="entry in entries" :key="entry.id" :entry="entry" />
  </div>
</template>
<script>
import EntryCard from "./EntryCard";

export default {
  name: "EntryCardCollection",
  components: { EntryCard },
  props: ["entries"],
};
</script>
<style lang="scss"></style>
