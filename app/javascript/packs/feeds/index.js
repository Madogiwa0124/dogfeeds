import Vue from 'vue/dist/vue.esm';
import FeedCardCollection from '../../components/FeedCardCollection';
import SelectedFeeds from '../../components/SelectedFeeds';

new Vue({
  el: '#feeds',
  components: { FeedCardCollection, SelectedFeeds },
});
