import Vue from "vue/dist/vue.esm";
import FeedCardCollection from "../../components/FeedCardCollection";
import SelectedFeedCollection from "../../components/SelectedFeedCollection";
import SearchForm from "../../components/SearchForm";
import fontawesome from "@fortawesome/fontawesome";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { fab } from "@fortawesome/free-brands-svg-icons";
import { far } from "@fortawesome/free-regular-svg-icons";
fontawesome.library.add(fas, fab, far);

new Vue({
  el: "#boards",
  components: {
    FeedCardCollection,
    SelectedFeedCollection,
    SearchForm
  },
});
