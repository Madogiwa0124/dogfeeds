import { createApp } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import ShowFeedContainer from "@js/components/containers/ShowFeedContainer.vue";

const app = createApp(ShowFeedContainer);
app.component("FontAwesomeIcon", FontAwesomeIcon);
app.mount("#vue-root");
