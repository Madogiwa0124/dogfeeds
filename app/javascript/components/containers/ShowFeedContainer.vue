<template>
  <div class="feed-show">
    <feed-infomation v-if="!!feed" :feed="feed" :entries="entries" />
    <page-loader :init-is-loading="isLoading" />
    <message v-if="notFound" title="NotFound" body="対象のフィードが見つかりませんでした🐾" level="warning" />
    <message v-if="hasError" title="Error" body="予期せぬエラーが発生しました🐕" level="danger" />
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import { Feed, Entry } from "@js/types/types.d.ts";
import FeedInfomation from "@js/components/feed/FeedInfomation.vue";
import PageLoader from "@js/components/common/PageLoader.vue";
import Message from "@js/components/common/Message.vue";
import { getFeed } from "@js/services/FeedService.ts";
import { getEntries } from "@js/services/EntryService.ts";

interface DataType {
  feed: Feed;
  entries: Entry[];
  isLoading: boolean;
  notFound: boolean;
  hasError: boolean;
}

const LOADING_SLEEP_MSEC = 200;

export default Vue.extend({
  name: "ShowFeedContainer",
  components: { FeedInfomation, PageLoader, Message },
  props: {
    feedId: {
      type: Number,
      required: true,
    },
  },
  data: function (): DataType {
    return {
      feed: null,
      entries: [],
      isLoading: true,
      notFound: false,
      hasError: false,
    };
  },
  created: async function (): Promise<void> {
    try {
      this.feed = await getFeed(this.feedId);
      this.entries = await getEntries("", { feedId: this.feedId });
      // 一瞬でloadingが消えるとチカチカするのでsleepを入れる
      await this.sleep(LOADING_SLEEP_MSEC);
    } catch (error) {
      if (error.response.status === 404) {
        this.notFound = true;
      } else {
        this.hasError = true;
      }
    }
    this.isLoading = false;
  },
  methods: {
    sleep: function (msec: number): Promise<void> {
      return new Promise((resolve) => setTimeout(resolve, msec));
    },
  },
});
</script>
<style lang="scss">
.feed-show {
  padding: 20px;
}
</style>
