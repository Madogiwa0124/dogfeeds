<template>
  <div class="column is-4">
    <div class="board-card card">
      <header class="card-header">
        <p class="card-header-title">
          <a :href="boardPath">{{ board.title }}</a>
        </p>
      </header>
      <div class="card-content">
        <div class="content">
          {{ board.description }}
        </div>
      </div>
      <footer class="card-footer">
        <p class="card-footer-item">
          {{ board.lastEntry.publishedAt | fromNow }}
        </p>
      </footer>
    </div>
  </div>
</template>
<script lang="ts">
import Vue, { PropType } from "vue";
import moment from "moment";
import { Board } from "@js/types/types.ts";

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
    boardPath: function (): string {
      return `/boards/${this.board.id}`;
    },
  },
});
</script>
<style lang="scss" scoped />
