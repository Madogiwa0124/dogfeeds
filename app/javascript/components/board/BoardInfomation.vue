<template>
  <div class="board-information">
    <h1 class="title">{{ board.title }}</h1>
    <div class="btn-area center">
      <button class="button is-conversion is-rounded" @click="handleOnRssLinkClick">
        まとめたRSSフィードのURLをコピーする
        <font-awesome-icon icon="rss" />
      </button>
    </div>
    <p class="description">
      {{ board.description }}
    </p>
  </div>
</template>

<script lang="ts">
import Vue, { PropType } from "vue";
import { Board } from "@js/types/types.ts";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faRss } from "@fortawesome/free-solid-svg-icons";
library.add(faRss);

export default Vue.extend({
  name: "FeedInfomation",
  components: { FontAwesomeIcon },
  props: {
    board: {
      type: Object as PropType<Board>,
      required: true,
    },
  },
  computed: {
    rssUrl: function (): string {
      return `${location.protocol}${location.host}/boards/${this.board.id}.rss`;
    },
  },
  methods: {
    handleOnRssLinkClick: async function () {
      await navigator.clipboard.writeText(this.rssUrl);
      alert(`${this.rssUrl}をクリップボードにコピーしました！`);
    },
  },
});
</script>
<style lang="scss" scoped>
.board-information {
  .title {
    text-align: center;
    margin-bottom: 10px;
  }

  .btn-area {
    margin-bottom: 10px;

    button {
      max-width: 100%;
    }
  }

  .description {
    margin: 0px auto;
    padding: 10px;
    width: 100%;
    border-radius: 5px;
    background-color: #ffffff;
  }
}
</style>
