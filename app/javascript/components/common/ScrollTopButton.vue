<template>
  <button class="scroll-top-button button is-rounded is-info" @click="scrollUp">
    <font-awesome-icon :icon="['fas', 'caret-up']" />
  </button>
</template>

<script lang="ts">
import Vue from "vue";
import VueCompositionApi, { defineComponent } from "@vue/composition-api";
Vue.use(VueCompositionApi);

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faCaretUp } from "@fortawesome/free-solid-svg-icons";
library.add(faCaretUp);

export default defineComponent({
  name: "ToTopButton",
  components: { FontAwesomeIcon },
  setup() {
    const scroll = (to: number) => window.scrollBy(0, to);
    const scrollUp = () => {
      const currentY = window.pageYOffset;
      if (currentY > 0) scroll(currentY * -1);
    };
    return { scrollUp };
  },
});
</script>

<style lang="scss" scoped>
.scroll-top-button {
  padding: 14px;
  outline: none;
}
</style>
