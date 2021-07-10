import { createApp } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import ShowBoardContainer from "@js/components/containers/ShowBoardContainer.vue";

const app = createApp(ShowBoardContainer);
app.component("FontAwesomeIcon", FontAwesomeIcon);
app.mount("#vue-root");
