import { createApp } from "vue";
import TagsInputContainer from "@js/components/containers/feed/TagsInputContainer.vue";
import ToTopButton from "@js/components/common/ToTopButton.vue";

// NOTE: Componentを登録する形だとレンダリングがされず真っ白な画面になってしまうため、
// RootComponentとなるようにmount先を調整
createApp(TagsInputContainer).mount("#vue-form-tags");
createApp(ToTopButton).mount("#vue-form-footer");

import "@css/feed.scss";
