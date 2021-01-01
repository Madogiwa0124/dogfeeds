<template>
  <div class="entry-collection-container">
    <entry-card-collection :entries="entries" :clumnSize="3" :descriptionLimit="100" :showFeedLink="true" />
    <infinite-loading ref="InfiniteLoading" :distance="100" @infinite="infiniteHandler" />
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";
import InfiniteLoading, { StateChanger } from "vue-infinite-loading";
import { getEntries } from "@js/services/EntryService.ts";
import { Entry } from "@js/types/types.ts";

interface DataType {
  page: number;
  entries: Entry[];
  isLoading: boolean;
}

export default Vue.extend({
  name: "EntryCollectionContainer",
  components: { EntryCardCollection, InfiniteLoading },
  props: {},
  data(): DataType {
    return {
      page: 1,
      entries: [],
      isLoading: false,
    };
  },
  computed: {
    // NOTE: $refsを参照すると型情報が取得できないのでcomputedに切り出して型を判断できるようにした。
    // https://engineering.linecorp.com/ja/blog/vue-js-typescript-otoshidama
    infiniteLoading: function (): InfiniteLoading {
      return this.$refs.InfiniteLoading as InfiniteLoading;
    },
  },
  methods: {
    resetEntryList: function (): void {
      // NOTE: Vueに変更検知させるためにspliceしてる
      this.entries.splice(0);
    },
    updateEntryList: function (entries: Entry[]): void {
      this.entries.push(...entries);
    },
    infiniteHandler: async function ($state: StateChanger): Promise<void> {
      if (this.isLoading) return;

      this.isLoading = true;
      try {
        const data: Entry[] = await getEntries("", { page: this.page });
        if (data.length) {
          this.page += 1;
          this.updateEntryList(data);
          if ($state) $state.loaded();
        } else {
          if ($state) $state.complete();
        }
      } catch {
        if ($state) $state.error();
      }
      this.isLoading = false;
    },
    handleOnSearch: function (): void {
      this.resetEntryList();
      this.page = 1;
      this.infiniteLoading.stateChanger.reset();
      this.infiniteHandler(this.infiniteLoading.stateChanger);
    },
  },
});
</script>
<style lang="scss" scoped></style>
