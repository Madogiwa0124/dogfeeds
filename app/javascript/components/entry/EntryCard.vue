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
        <p class="entry-footer">
          <span :title="publishedAtText">{{ fromNow }} </span>
          <entry-clip class="clip" :entry-link="entry.link" :init-cliped="cliped" @clip="handleOnClipEntry" />
        </p>
      </div>
    </div>
    <footer class="card-footer">
      <p v-if="showFeedLink" class="card-footer-item">
        <a :href="feedPath" class="has-text-primary">
          RSSフィードを見る
          <font-awesome-icon :icon="['far', 'newspaper']" />
        </a>
      </p>
    </footer>
  </div>
</template>
<script lang="ts">
import { defineComponent, computed, SetupContext } from "vue";

import * as moment from "moment";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faExternalLinkAlt } from "@fortawesome/free-solid-svg-icons";
import { faClock, faNewspaper } from "@fortawesome/free-regular-svg-icons";
import { Entry } from "@js/types/types";
library.add(faExternalLinkAlt, faClock, faNewspaper);

import EntryClip from "@js/components/entry/EntryClip.vue";
import "@js/assets/noimage.png";

type Props = {
  entry: Entry;
  descriptionLimit: number | null;
  showFeedLink: boolean;
  cliped: boolean;
};

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
  emits: ["clipEntry"],
  setup(props, context: SetupContext) {
    const publishedAtText = computed(() => moment(props.entry.publishedAt).format("YYYY/MM/DD h:mm:ss"));
    const fromNow = computed(() => moment(props.entry.publishedAt).fromNow());
    const handleOnClipEntry = (entryLink: string, cliped: boolean, event: Event) => {
      context.emit("clipEntry", entryLink, cliped, event);
    };
    const limitedDescription = computed(() => {
      if (props.descriptionLimit === null) return props.entry.description;
      if (props.entry.description.length <= props.descriptionLimit) return props.entry.description;

      return `${props.entry.description.slice(0, props.descriptionLimit)}...`;
    });
    const eyeCatch = computed(() => {
      if (!props.entry.eyeCatchingImage) return require("@js/assets/noimage.png");
      return props.entry.eyeCatchingImage;
    });
    const feedPath = computed(() => {
      return `/feeds/${props.entry.feedId}`;
    });
    return {
      publishedAtText,
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
@import "@css/common.scss";

$entry-body-color: #888888;

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
      color: $entry-body-color;
      font-size: $font-size-xs;
      margin: 0px;
    }

    .entry-footer {
      text-align: right;
      font-size: $font-size-xs;
      color: $entry-body-color;

      .clip {
        font-size: $font-size-m;
      }
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

    color: $entry-body-color;
  }
}
</style>
