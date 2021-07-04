<template>
  <div class="entry-card-collection entries is-multiline columns">
    <div v-for="entry in props.entries" :key="entry.id" :class="`column is-${clumnSize}`">
      <entry-card
        :entry="entry"
        :descriptionLimit="descriptionLimit"
        :showFeedLink="showFeedLink"
        :cliped="cliped"
        @clipEntry="handleOnClipEntry"
      />
    </div>
  </div>
</template>
<script lang="ts">
import { defineComponent, SetupContext } from "vue";

import EntryCard from "@js/components/entry/EntryCard.vue";
import { Entry } from "@js/types/types";

type Props = {
  entries: Entry[];
  cliped: boolean;
  descriptionLimit: number | null;
  clumnSize: number;
  showFeedLink: boolean;
};

export default defineComponent({
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
    cliped: {
      type: Boolean,
      default: false,
    },
    entries: {
      type: Array,
      default: () => [],
    },
  },
  emits: ["clipEntry"],
  setup(props, context: SetupContext) {
    const handleOnClipEntry = (entryLink: string, cliped: boolean): void => {
      context.emit("clipEntry", entryLink, cliped);
    };
    return {
      props,
      handleOnClipEntry,
    };
  },
});
</script>
<style lang="scss" scoped>
.entry-card-collection {
  .entry-card {
    margin: 15px 0px;
  }
}
</style>
