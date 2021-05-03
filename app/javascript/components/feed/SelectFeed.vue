<template>
  <button
    class="select-feed button is-conversion is-rounded is-outline"
    :class="{ selected: selected }"
    @click="toggleSelected"
  >
    <span v-if="selected">
      <font-awesome-icon :icon="['far', 'check-square']" />
      RSSフィードの選択解除
    </span>
    <span v-else>
      <font-awesome-icon :icon="['far', 'square']" />
      RSSフィードを選択する
    </span>
  </button>
</template>
<script lang="ts">
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faCheckSquare, faSquare } from "@fortawesome/free-regular-svg-icons";

library.add(faCheckSquare, faSquare);

import Vue from "vue";
export default Vue.extend({
  name: "SelectFeed",
  components: { FontAwesomeIcon },
  props: {
    selected: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    toggleSelected: function (event: Event) {
      this.$emit(this.selected ? "unselected" : "selected", event);
    },
  },
});
</script>
<style lang="scss" scoped></style>
