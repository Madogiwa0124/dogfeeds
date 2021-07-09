<template>
  <div class="tags-input-container">
    <tags-input :recommended-tags="state.tags" />
  </div>
</template>
<script lang="ts">
import { defineComponent, reactive } from "vue";
import TagsInput from "@js/components/feed/TagsInput.vue";
import { Tag } from "@js/types/types";
import { getTags } from "@js/services/TagService";
const TAGS_LIMIT = 8;

export default defineComponent({
  name: "TagsInputContainer",
  components: { TagsInput },

  setup() {
    const state = reactive<{ tags: Tag[] }>({ tags: [] });
    (async () => (state.tags = await getTags("", { limit: TAGS_LIMIT })))();
    return { state };
  },
});
</script>
<style lang="scss" scoped></style>
