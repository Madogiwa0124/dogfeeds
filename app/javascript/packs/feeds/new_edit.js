import Vue from "vue";
import TagsInput from "@js/components/feed/TagsInput.vue";
import ToTopButton from "@js/components/common/ToTopButton.vue";

new Vue({
  el: "#feed-form",
  components: { TagsInput, ToTopButton },
});

import "@css/feed.scss";
