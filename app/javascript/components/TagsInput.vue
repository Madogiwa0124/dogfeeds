<template>
  <div class="tags-input">
    <label class="label">タグ</label>
    <input
      v-for="(tag, index) in tags"
      :key="index"
      type="hidden"
      name="feed[tags][]"
      :value="tag.name"
    >
    <div class="tag-list">
      <span
        v-for="(tag, index) in tags"
        :key="index"
        class="tag is-primary"
      >
        {{ tag.name }}
        <span
          class="delete is-small"
          @click="deleteTag(index)"
        />
      </span>
    </div>
    <input
      v-model="tagName"
      class="tag-input-area input is-small"
      @keydown.enter="buildTag"
    >
    <p class="help">
      Rssフィードのタグを入力してください。(任意)
    </p>
  </div>
</template>
<script>
export default {
  name: 'TagsInput',
  components: {},
  props: ['init_tags'],
  data: function() {
    return {
      tagName: '',
      tags: this.init_tags ? this.init_tags : []
    };
  },
  methods: {
    buildTag: function(event) {
      event.preventDefault();
      this.tags.push({name: this.tagName});
      this.tagName = '';
    },
    deleteTag: function(index) {
      this.tags.splice(index,1);
    }
  }
};
</script>
<style lang="scss">
</style>
