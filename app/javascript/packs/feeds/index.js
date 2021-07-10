import { createApp } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import IndexFeedContainer from "@js/components/containers/IndexFeedContainer.vue";

const app = createApp(IndexFeedContainer);
app.component("FontAwesomeIcon", FontAwesomeIcon);
app.mount("#vue-root");
