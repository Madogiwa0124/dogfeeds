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
          v-if="state.clipedEntries.length > 0"
          :entries="state.clipedEntries"
          :clumnSize="3"
          :descriptionLimit="100"
          :showFeedLink="true"
          :cliped="true"
          @clipEntry="handleOnClipEntry"
        />
        <message
          v-else
          level="link"
          title="CLIPされた記事がありません"
          body="📎をクリックして記事をCLIPするとこちらに表示されます。"
        />
      </div>
    </main>
    <div class="center">
      <to-top-button />
    </div>
  </div>
</template>
<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faPaperclip, faUser } from "@fortawesome/free-solid-svg-icons";
library.add(faPaperclip, faUser);

import { Entry } from "@js/types/types";
import { clipEntry, getClipedEntryLinks, getEntries } from "@js/services/EntryService";
import EntryCardCollection from "@js/components/entry/EntryCardCollection.vue";
import Message from "@js/components/common/Message.vue";
import ToTopButton from "@js/components/common/ToTopButton.vue";

export default defineComponent({
  name: "ShowMypageContainer",
  components: { FontAwesomeIcon, EntryCardCollection, Message, ToTopButton },
  props: {},
  setup() {
    const state = reactive<{ clipedEntries: Entry[] }>({ clipedEntries: [] });
    onMounted(async () => {
      const clipedEntryLinks = Array.from(getClipedEntryLinks());
      if (clipedEntryLinks.length < 1) return;
      state.clipedEntries = await getEntries("", { links: clipedEntryLinks, pager: false });
    });
    const handleOnClipEntry = (entryLink: string, clieped: boolean) => {
      clipEntry(entryLink, clieped);
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
