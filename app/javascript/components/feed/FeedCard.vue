<template>
  <div :id="`feed-card-${feed.id}`" class="feed-card card">
    <a :href="feedPath" :target="feedLinkTarget" :rel="feedLinkRel">
      <header class="card-header">
        <p class="card-header-title">
          {{ feed.title | truncate(24) }}
        </p>
      </header>
      <div class="card-content">
        <div class="card-image">
          <img :src="eyeCatch" :alt="feed.lastEntry.title" height="220" width="350" />
        </div>
        <div class="content">
          <div class="tag-area field is-grouped is-grouped-multiline">
            <span v-if="feed.tags.length < 1" class="tag is-light control has-text-weight-medium">untagged</span>
            <div v-for="(tag, index) in feed.tags" :key="index" class="control">
              <tag :body="tag.body" @click="handleOnTagClick" />
            </div>
          </div>
          <object>
            <a
              class="has-text-info last-entry-title"
              :href="feed.lastEntry.link"
              target="_blank"
              rel="noopener"
              @click.stop
            >
              {{ feed.lastEntry.title | truncate(49) }}
              <font-awesome-icon :icon="['fas', 'external-link-alt']" />
            </a>
          </object>
          <p class="entry-info has-text-right">
            <span :title="lastPublishedAtText">Last updated {{ feed.lastEntry.publishedAt | fromNow }}</span>
            <font-awesome-icon :icon="['far', 'clock']" />
            <entry-clip class="clip" :entry-link="feed.lastEntry.link" @clip="handleOnClipEntry" />
          </p>
        </div>
      </div>
      <footer v-if="selectable" class="card-footer">
        <p class="card-footer-item">
          <select-feed
            class="selected-feed"
            :selected="selected"
            @selected.stop.prevent="handleOnSelected"
            @unselected.stop.prevent="handleOnUnselected"
          />
        </p>
      </footer>
    </a>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import moment from "moment";
import SelectFeed from "@js/components/feed/SelectFeed.vue";
import Tag from "@js/components/Tag.vue";
import EntryClip from "@js/components/entry/EntryClip.vue";
import { Feed } from "@js/types/types";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faClock } from "@fortawesome/free-regular-svg-icons";
import { faExternalLinkAlt } from "@fortawesome/free-solid-svg-icons";

library.add(faClock, faExternalLinkAlt);
const NO_IMAGE_PATH = "/noimage.png";

export default Vue.extend({
  name: "FeedCard",
  components: { SelectFeed, Tag, FontAwesomeIcon, EntryClip },
  filters: {
    fromNow: function (value: string): string {
      return moment(value).fromNow();
    },
    truncate: function (value: string, limit: number): string {
      if (value.length <= limit) return value;
      return `${value.trim().replace(/\s+/g, "").substring(0, limit)}…`;
    },
  },
  props: {
    feed: {
      type: Object as PropType<Feed>,
      required: true,
    },
    selectable: {
      type: Boolean,
      default: true,
    },
    selected: {
      type: Boolean,
      default: false,
    },
    openNewTab: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    eyeCatch: function (): string {
      if (!this.feed.lastEntry.eyeCatchingImage) return NO_IMAGE_PATH;
      return this.feed.lastEntry.eyeCatchingImage;
    },
    lastPublishedAtText: function (): string {
      return moment(this.feed.lastEntry.publishedAt).format("YYYY/MM/DD h:mm:ss");
    },
    feedPath: function (): string {
      return `/feeds/${this.feed.id}`;
    },
    feedLinkTarget: function (): "_self" | "_blank" {
      return this.openNewTab ? "_blank" : "_self";
    },
    feedLinkRel: function (): "noopener" | "" {
      return this.openNewTab ? "noopener" : "";
    },
  },
  methods: {
    handleOnTagClick: function (tagBody: string, event: Event): void {
      event.stopPropagation();
      event.preventDefault();
      this.$emit("clickTag", tagBody);
    },
    handleOnClipEntry: function (entryLink: string, cliped: boolean, event: Event): void {
      event.stopPropagation();
      event.preventDefault();
      this.$emit("clipEntry", entryLink, cliped);
    },
    handleOnSelected: function (): void {
      this.$emit("selectedFeed", this.feed.id);
    },
    handleOnUnselected: function (): void {
      this.$emit("unselectedFeed", this.feed.id);
    },
  },
});
</script>
<style lang="scss" scoped>
.feed-card {
  border-radius: 0px;

  .selected-feed {
    font-size: 14px;
    width: 70%;
  }

  .card-header-title {
    padding: 10px;
    font-size: 14px;
  }

  .card-content {
    padding: 0px;

    .content {
      margin: 0px 10px 10px 10px;
      line-height: 16px;

      .last-entry-title {
        font-size: 14px;
      }

      .entry-info {
        font-size: 12px;
        color: #999999;

        .clip {
          font-size: 20px;
        }
      }
    }
  }

  .card-image {
    margin: 0px 0px 5px 0px;
    line-height: 0px;

    img {
      min-height: 220px;
      height: 220px;
      width: 100%;
      object-fit: cover;
    }
  }

  .tag-area {
    .control {
      margin-top: 0px;
      margin-right: 5px;
      margin-bottom: 5px !important;
    }
  }

  .card-footer-item {
    padding: 10px;
  }
}

.feed-card:hover {
  cursor: pointer;
  box-shadow: inherit;
}
</style>
