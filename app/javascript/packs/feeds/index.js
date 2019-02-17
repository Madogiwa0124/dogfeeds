import Vue from 'vue/dist/vue.esm';
import FeedCardCollection from '../../components/FeedCardCollection';
import SelectedFeedCollection from '../../components/SelectedFeedCollection';

new Vue({
  el: '#feeds',
  components: { FeedCardCollection, SelectedFeedCollection },
});
