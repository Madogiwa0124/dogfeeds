<template>
  <div class="entry-card card">
    <div class="card-content">
      <div class="card-image">
        <img :src="eyeCatch" :alt="props.entry.title" />
      </div>
      <div class="content">
        <a
          class="has-text-info entry-title has-text-weight-semibold"
          :href="props.entry.link"
          target="_blank"
          rel="noopener"
        >
          {{ props.entry.title }}
          <font-awesome-icon icon="external-link-alt" />
        </a>
        <p class="entry-description">
          {{ limitedDescription }}
        </p>
      </div>
    </div>
    <footer class="card-footer">
      <p v-if="showFeedLink" class="card-footer-item">
        <a :href="feedPath" class="has-text-primary">
          RSSフィード
          <font-awesome-icon :icon="['far', 'newspaper']" />
        </a>
      </p>
      <p class="card-footer-item">
        <entry-clip class="clip" :entryId="entry.id" :init-cliped="cliped" @clip="handleOnClipEntry"> CLIP </entry-clip>
      </p>
    </footer>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import VueCompositionApi, { defineComponent, computed, SetupContext } from "@vue/composition-api";
Vue.use(VueCompositionApi);

import moment from "moment/moment";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faExternalLinkAlt } from "@fortawesome/free-solid-svg-icons";
import { faClock, faNewspaper } from "@fortawesome/free-regular-svg-icons";
import { Entry } from "@js/types/types";
library.add(faExternalLinkAlt, faClock, faNewspaper);

import EntryClip from "@js/components/entry/EntryClip.vue";

type Props = {
  entry: Entry;
  descriptionLimit: number | null;
  showFeedLink: boolean;
  cliped: boolean;
};

const NO_IMAGE_PATH = "/noimage.png";

export default defineComponent({
  components: { FontAwesomeIcon, EntryClip },
  props: {
    entry: {
      type: Object,
      required: true,
    },
    cliped: {
      type: Boolean,
      default: false,
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
  setup(props: Props, context: SetupContext) {
    const fromNow = computed(() => {
      return moment(props.entry.publishedAt, "YYYYMMDD h:mm:ss").fromNow();
    });
    const handleOnClipEntry = (entryId: number, cliped: boolean, event: Event) => {
      context.emit("clipEntry", entryId, cliped, event);
    };
    const limitedDescription = computed(() => {
      if (props.descriptionLimit === null) return props.entry.description;
      if (props.entry.description.length <= props.descriptionLimit) return props.entry.description;

      return `${props.entry.description.slice(0, props.descriptionLimit)}...`;
    });
    const eyeCatch = computed(() => {
      if (!props.entry.eyeCatchingImage) return NO_IMAGE_PATH;
      return props.entry.eyeCatchingImage;
    });
    const feedPath = computed(() => {
      return `/feeds/${props.entry.feedId}`;
    });
    return {
      fromNow,
      limitedDescription,
      feedPath,
      eyeCatch,
      handleOnClipEntry,
      props,
    };
  },
});
</script>
<style lang="scss" scoped>
.entry-card {
  box-shadow: inherit;
  margin-top: 0px !important;

  .card-content {
    word-wrap: break-word;
    padding: 0px;

    .entry-title {
      margin: 0px;
    }

    .entry-description {
      color: #888888;
      font-size: 10px;
    }

    .content {
      margin: 0px 10px 10px 10px;
    }

    .card-image {
      img {
        height: 200px;
        width: 100%;
        object-fit: cover;
      }
    }
  }

  .card-footer {
    p:not(:last-child) {
      margin-bottom: 0px;
    }

    color: #888888;
  }
}
</style>
