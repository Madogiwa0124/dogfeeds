<template>
  <div class="entry-card card">
    <header class="card-header">
      <p class="card-header-title">
        {{ entry.title }}
      </p>
    </header>
    <div class="card-content">
      <div class="content">
        {{ limitedDescription }}
        <a :href="entry.link" target="_blank" rel="noopener">
          リンク先で読む
          <font-awesome-icon icon="external-link-alt" />
        </a>
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">
        <span> <font-awesome-icon :icon="['far', 'clock']" />{{ fromNow }} </span>
      </p>
      <p v-if="showFeedLink" class="card-footer-item">
        <a :href="feedPath">
          RSSフィードを見る
          <font-awesome-icon :icon="['far', 'newspaper']" />
        </a>
      </p>
    </footer>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import VueCompositionApi, { defineComponent, computed } from "@vue/composition-api";
Vue.use(VueCompositionApi);

import moment from "moment/moment";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faExternalLinkAlt } from "@fortawesome/free-solid-svg-icons";
import { faClock, faNewspaper } from "@fortawesome/free-regular-svg-icons";
import { Entry } from "@js/types/types.d.ts";
library.add(faExternalLinkAlt, faClock, faNewspaper);

type Props = {
  entry: Entry;
  descriptionLimit: number | null;
  showFeedLink: boolean;
};

export default defineComponent({
  components: { FontAwesomeIcon },
  props: {
    entry: {
      type: Object,
      required: true,
    },
    descriptionLimit: {
      type: Number,
      default: null,
    },
    showFeedLink: {
      type: Boolean,
      default: false,
    },
  },
  setup(props: Props) {
    const fromNow = computed(() => {
      return moment(props.entry.publishedAt, "YYYYMMDD h:mm:ss").fromNow();
    });
    const limitedDescription = computed(() => {
      if (props.descriptionLimit === null) return props.entry.description;
      if (props.entry.description.length <= props.descriptionLimit) return props.entry.description;

      return `${props.entry.description.slice(0, props.descriptionLimit)}...`;
    });
    const feedPath = computed(() => {
      return `/feeds/${props.entry.feedId}`;
    });
    return {
      fromNow,
      limitedDescription,
      feedPath,
    };
  },
});
</script>
<style lang="scss" scoped>
.entry-card {
  .card-content {
    word-wrap: break-word;
  }
}
</style>
