<template>
  <div class="show-mypage-container">
    <header class="profile">
      <p class="avatar"><font-awesome-icon icon="user" /></p>
      <p class="nickname has-text-weight-bold">MY PAGE</p>
    </header>
    <main>
      <div class="tabs is-fullwidth">
        <ul>
          <li class="is-active">
            <a>CLIP <font-awesome-icon icon="paperclip" /></a>
          </li>
        </ul>
      </div>
      <div class="content">
        <entry-card-collection
          :entries="state.clipedEntries"
          :clumnSize="3"
          :descriptionLimit="100"
          :showFeedLink="true"
          :cliped="true"
          @clipEntry="handleOnClipEntry"
        />
      </div>
    </main>
  </div>
</template>
<script lang="ts">
import Vue from "vue";
import VueCompositionApi, { defineComponent, onMounted, reactive } from "@vue/composition-api";
Vue.use(VueCompositionApi);

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faPaperclip, faUser } from "@fortawesome/free-solid-svg-icons";
library.add(faPaperclip, faUser);

import { Entry } from "@js/types/types";
import { clipEntry, getClipedEntryIds, getEntries } from "@js/services/EntryService";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";

export default defineComponent({
  name: "ShowMypageContainer",
  components: { FontAwesomeIcon, EntryCardCollection },
  props: {},
  setup() {
    const state = reactive<{ clipedEntries: Entry[] }>({ clipedEntries: [] });
    onMounted(async () => {
      const clipedEntryIds = Array.from(getClipedEntryIds());
      if (clipedEntryIds.length < 1) return;
      state.clipedEntries = await getEntries("", { ids: clipedEntryIds, pager: false });
    });
    const handleOnClipEntry = (entryId: number, clieped: boolean) => {
      clipEntry(entryId, clieped);
    };
    return { state, handleOnClipEntry };
  },
});
</script>
<style lang="scss" scoped>
.show-mypage-container {
  .profile {
    text-align: center;

    .avatar {
      font-size: 50px;
    }
  }
  main {
    margin: 0 auto;
    padding: 10px;
    width: 90%;
  }
}
</style>
