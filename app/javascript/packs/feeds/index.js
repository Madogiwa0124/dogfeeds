import Vue from "vue/dist/vue.esm";
import SearchForm from "../../components/SearchForm";
import FeedCardCollection from "../../components/FeedCardCollection";

new Vue({
  el: "#feeds",
  components: { SearchForm, FeedCardCollection },
});
