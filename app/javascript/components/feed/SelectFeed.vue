<template>
  <a class="select-feed is-conversion-color" @click="toggleSelected">
    <span v-if="selected">
      <font-awesome-icon :icon="['far', 'check-square']" />
    </span>
    <span v-else>
      <font-awesome-icon :icon="['far', 'square']" />
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
    toggleSelected: function (event) {
      this.$emit(this.selected ? "unselected" : "selected", event);
    },
  },
};
</script>
<style lang="scss" scoped>
@import "../../stylesheets/common.scss";

.select-feed:hover {
  color: darken($conversion-color, 10%);
}
</style>
