import { createApp } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import ShowMypageContainer from "@js/components/containers/ShowMypageContainer.vue";

const app = createApp(ShowMypageContainer);
app.component("FontAwesomeIcon", FontAwesomeIcon);
app.mount("#vue-root");
