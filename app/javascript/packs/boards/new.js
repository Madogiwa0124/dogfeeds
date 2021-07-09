import { createApp } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import NewBoardContainer from "@js/components/containers/NewBoardContainer.vue";

const app = createApp(NewBoardContainer);
app.component("FontAwesomeIcon", FontAwesomeIcon);
app.mount("#vue-root");
