import Vue from "vue/dist/vue.esm";
import NewBoardContainer from "@js/components/containers/NewBoardContainer.vue";
import fontawesome from "@fortawesome/fontawesome";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { fab } from "@fortawesome/free-brands-svg-icons";
import { far } from "@fortawesome/free-regular-svg-icons";
fontawesome.library.add(fas, fab, far);

new Vue({
  el: "#vue-root",
  components: { NewBoardContainer },
});
