<template>
  <span class="entry-clip" :title="props.title" :class="{ cliped: state.cliped }" @click="clip">
    <slot />
    <font-awesome-icon icon="paperclip" />
  </span>
</template>
<script lang="ts">
import Vue from "vue";
import VueCompositionApi, { defineComponent, SetupContext, reactive } from "@vue/composition-api";
Vue.use(VueCompositionApi);

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faPaperclip } from "@fortawesome/free-solid-svg-icons";
library.add(faPaperclip);

type Props = {
  initCliped: boolean;
  entryLink: string;
  title: string;
};

export default defineComponent({
  components: { FontAwesomeIcon },
  props: {
    initCliped: {
      default: false,
      type: Boolean,
    },
    entryLink: {
      required: true,
      type: String,
    },
    title: {
      default: "Clipして後で読む",
      type: String,
    },
  },
  emits: ["clip"],
  setup(props: Props, context: SetupContext) {
    const state = reactive<{ cliped: boolean }>({ cliped: props.initCliped });
    const clip = (event: Event) => {
      state.cliped = !state.cliped;
      context.emit("clip", props.entryLink, state.cliped, event);
    };
    return { clip, state, props };
  },
});
</script>
<style lang="scss" scoped>
.entry-clip {
  cursor: pointer;
  &.cliped {
    color: hsl(48, 100%, 67%);
  }
}
</style>
