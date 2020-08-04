<template>
  <a class="select-feed" @click="toggleSelected">
    <span v-if="selected">
      <font-awesome-icon :icon="['far', 'check-square']" />
      Selected
    </span>
    <span v-else>
      <font-awesome-icon :icon="['far', 'square']" />
      Select
    </span>
  </a>
</template>
<script>
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faCheckSquare, faSquare } from "@fortawesome/free-regular-svg-icons";

library.add(faCheckSquare, faSquare);

export default {
  name: "SelectFeed",
  components: { FontAwesomeIcon },
  props: {
    selected: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    toggleSelected: function () {
      this.$emit(this.selected ? "unselected" : "selected");
    },
  },
};
</script>
<style lang="scss"></style>
