<template>
  <div :id="`feed-card-${feed.id}`" class="feed-card card" @click="redirectFeedPath">
    <header class="card-header">
      <p class="card-header-title">
        {{ feed.title | truncate(22) }}
      </p>
      <select-feed
        v-if="selectable"
        class="selected-feed"
        :selected="selected"
        @selected.stop="handleOnSelected"
        @unselected.stop="handleOnUnselected"
      />
    </header>
    <div class="card-content">
      <div class="card-image">
        <img :src="eyeCatch" :alt="feed.lastEntry.title" />
      </div>
      <div class="content">
        <div class="tag-area field is-grouped is-grouped-multiline">
          <span v-if="feed.tags.length < 1" class="tag is-light control has-text-weight-medium">untagged</span>
          <div v-for="(tag, index) in feed.tags" :key="index" class="control">
            <tag :body="tag.body" @click="handleOnTagClick" />
          </div>
        </div>
        <a class="has-text-info last-entry-title" @click.stop="openExternal">
          {{ feed.lastEntry.title | truncate(49) }}
          <font-awesome-icon :icon="['fas', 'external-link-alt']" />
        </a>
        <p class="last-updated-at has-text-right">
          Last updadated {{ feed.lastEntry.publishedAt | fromNow }}
          <font-awesome-icon :icon="['far', 'clock']" />
        </p>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import moment from "moment";
import SelectFeed from "@js/components/feed/SelectFeed.vue";
import Tag from "@js/components/Tag.vue";
import { Feed } from "@js/types/types.ts";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faClock } from "@fortawesome/free-regular-svg-icons";
import { faExternalLinkAlt } from "@fortawesome/free-solid-svg-icons";

library.add(faClock, faExternalLinkAlt);
const NO_IMAGE_PATH = "/noimage.png";

export default Vue.extend({
  name: "FeedCard",
  components: { SelectFeed, Tag, FontAwesomeIcon },
  filters: {
    fromNow: function (value: string): string {
      return moment(value, "YYYYMMDD h:mm:ss").fromNow();
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
    feedPath: function (): string {
      return `/feeds/${this.feed.id}`;
    },
  },
  methods: {
    redirectFeedPath: function (): void {
      if (this.openNewTab) {
        window.open(this.feedPath);
      } else {
        window.location.href = this.feedPath;
      }
    },
    openExternal: function (): void {
      window.open(this.feed.lastEntry.link);
    },
    handleOnTagClick: function (tagBody: string, event: Event): void {
      event.stopPropagation();
      this.$emit("clickTag", tagBody);
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
.feed-card:hover {
  cursor: pointer;
  box-shadow: inherit;
}

.feed-card {
  border-radius: 0px;

  .selected-feed {
    height: 100%;
    font-size: 20px;
    padding: 10px;
  }

  .card-header-title {
    padding: 10px;
    font-size: 14px;
  }

  .card-content {
    padding: 0px;

    .content {
      margin: 0px 10px 10px 10px;

      .last-entry-title {
        font-size: 14px;
      }
    }
  }

  .card-image {
    margin: 0px;

    img {
      height: 250px;
      width: 100%;
      object-fit: cover;
    }
  }

  .tag-area {
    .control {
      margin-top: 6px;
      margin-right: 6px;
      margin-bottom: 6px !important;
    }
  }
}
</style>
