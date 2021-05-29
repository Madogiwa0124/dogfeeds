<template>
  <div class="tags-input">
    <label class="label">タグ</label>
    <div v-if="props.recommendedTags.length > 0" class="recommended-tag-list">
      <span class="tag is-light control has-text-weight-medium">人気のタグ</span>
      <span
        v-for="(tag, index) in props.recommendedTags"
        :key="index"
        class="tag clickable is-success"
        @click="buildTag(tag.body)"
      >
        {{ tag.body }}
      </span>
    </div>
    <input v-for="(tag, index) in state.tags" :key="index" type="hidden" name="feed[tags][]" :value="tag.body" />
    <div class="tag-list">
      <span v-for="(tag, index) in state.tags" :key="index" class="tag is-success">
        {{ tag.body }}
        <span class="delete is-small" @click="deleteTag(index)" />
      </span>
    </div>
    <input
      v-model="state.tagBody"
      class="tag-input-area input is-small"
      @keydown.enter.prevent="buildTag(state.tagBody)"
      @blur.prevent="buildTag(state.tagBody)"
    />
    <p class="help">RSSフィードのタグを入力してください。(任意)</p>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import VueCompositionApi, { defineComponent, reactive } from "@vue/composition-api";
import { Tag } from "@js/types/types";
Vue.use(VueCompositionApi);

type Props = {
  recommendedTags: Tag[];
};

export default defineComponent({
  name: "TagsInput",
  components: {},
  props: {
    recommendedTags: {
      type: Array,
      default: () => [],
    },
  },
  setup(props: Props) {
    const state = reactive<{ tagBody: string; tags: Tag[] }>({
      tagBody: "",
      tags: [],
    });
    const buildTag = (body: string) => {
      if (body.length <= 0) return;
      state.tags.push({ body: body.trim(), count: 0 });
      state.tagBody = "";
    };
    const deleteTag = (index: number) => state.tags.splice(index, 1);
    return { state, props, buildTag, deleteTag };
  },
});
</script>
<style lang="scss" scoped>
.tags-input {
  .tag {
    margin-right: 3px;
  }

  .tag-list {
    display: inline;
  }

  .recommended-tag-list {
    margin-bottom: 5px;
    padding: 5px;

    .clickable {
      cursor: pointer;
    }
  }

  .input {
    width: initial;
  }
}
</style>
