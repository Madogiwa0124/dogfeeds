<template>
  <div class="feed-show">
    <feed-infomation v-if="!!feed" :feed="feed" :entries="entries" @tagClick="handleOnTagClick" />
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
import { getFeedEntries } from "@js/services/EntryService.ts";
import { sleep } from "@js/components/common/Sleep.ts";

interface DataType {
  feed: Feed | null;
  entries: Entry[];
  isLoading: boolean;
  notFound: boolean;
  hasError: boolean;
}

const LOADING_SLEEP_MSEC = 200;
const TAG_CLICK_REDIRECT_PATH = "/feeds";

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
      this.entries = await getFeedEntries("", { feedId: this.feedId });
      // 一瞬でloadingが消えるとチカチカするのでsleepを入れる
      await sleep(LOADING_SLEEP_MSEC);
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
    handleOnTagClick: function (body: string) {
      const query = `?query[keyword]=${body}`;
      window.location.href = `${TAG_CLICK_REDIRECT_PATH}/${query}`;
    },
  },
});
</script>
<style lang="scss">
.feed-show {
  padding: 20px;
}
</style>
