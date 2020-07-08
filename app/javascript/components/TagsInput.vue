<template>
  <div class="tags-input">
    <label class="label">タグ</label>
    <input v-for="(tag, index) in tags" :key="index" type="hidden" name="feed[tags][]" :value="tag.body" />
    <div class="tag-list">
      <span v-for="(tag, index) in tags" :key="index" class="tag is-primary">
        {{ tag.body }}
        <span class="delete is-small" @click="deleteTag(index)" />
      </span>
    </div>
    <input v-model="tagBody" class="tag-input-area input is-small" @keydown.enter="buildTag" />
    <p class="help">
      Rssフィードのタグを入力してください。(任意)
    </p>
  </div>
</template>
<script>
export default {
  name: "TagsInput",
  components: {},
  props: ["init_tags"],
  data: function () {
    return {
      tagBody: "",
      tags: this.init_tags ? this.init_tags : [],
    };
  },
  methods: {
    buildTag: function (event) {
      event.preventDefault();
      if (this.tagBody.length <= 0) return;
      this.tags.push({ body: this.tagBody });
      this.tagBody = "";
    },
    deleteTag: function (index) {
      this.tags.splice(index, 1);
    },
  },
};
</script>
<style lang="scss"></style>
