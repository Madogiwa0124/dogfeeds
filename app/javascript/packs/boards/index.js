import { createApp } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import IndexBoardContainer from "@js/components/containers/IndexBoardContainer.vue";

const app = createApp(IndexBoardContainer);
app.component("FontAwesomeIcon", FontAwesomeIcon);
app.mount("#vue-root");
