import Vue from 'vue/dist/vue.esm';
import EntryCardCollection from '../../components/EntryCardCollection';
import FeedTag from '../../components/FeedTag';

new Vue({
  el: '#feeds-entries',
  components: { EntryCardCollection, FeedTag },
});
