<template>
  <div class="board-card card" @click="redirectBoardPath">
    <header class="card-header">
      <p class="card-header-title">
        {{ board.title }}
      </p>
    </header>
    <div class="card-content">
      <div class="card-image">
        <img :src="eyeCatch" :alt="board.lastEntry.title" />
      </div>
      <div class="content">
        {{ board.description }}
      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item">last updated at {{ board.lastEntry.publishedAt | fromNow }}</p>
    </footer>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import moment from "moment";
import { Board } from "@js/types/types.ts";
const NO_IMAGE_PATH = "/noimage.png";

export default Vue.extend({
  name: "BoardCard",
  components: {},
  filters: {
    fromNow: function (value: string): string {
      return moment(value, "YYYYMMDD h:mm:ss").fromNow();
    },
  },
  props: {
    board: {
      type: Object as PropType<Board>,
      required: true,
    },
  },
  computed: {
    eyeCatch: function (): string {
      if (!this.board.lastEntry.eyeCatchingImage) return NO_IMAGE_PATH;
      return this.board.lastEntry.eyeCatchingImage;
    },
    boardPath: function (): string {
      return `/boards/${this.board.id}`;
    },
  },
  methods: {
    redirectBoardPath: function (): void {
      window.location.href = this.boardPath;
    },
  },
});
</script>
<style lang="scss" scoped>
.board-card:hover {
  cursor: pointer;
  box-shadow: inherit;
}

.board-card {
  .card-header-title {
    padding: 10px;
    font-size: 14px;
  }

  .card-content {
    padding: 0px;
    font-size: 14px;

    .content {
      margin: 0px 10px 10px 10px;
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
}
</style>
