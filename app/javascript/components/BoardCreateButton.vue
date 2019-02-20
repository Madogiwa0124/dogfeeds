<template>
  <div>
    <button
      class="button is-primary is-fullwidth"
      @click="hundleOnClick()"
    >
      ボードを作る
    </button>
    <board-confirm-modal
      v-show="showModal"
      :feeds="feeds"
      @close="hundleOnClose()"
      @submit="hundleOnSubmit()"
    />
  </div>
</template>

<script>
import BoardConfirmModal from './BoardConfirmModal';
import axios from 'axios';
import { csrfToken } from 'rails-ujs';
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken();

export default {
  name: 'BoradCreateButton',
  components: { BoardConfirmModal },
  props: ['feeds'],
  data: function () {
    return {
      showModal: false
    };
  },
  methods: {
    hundleOnClick: function () {
      this.showModal = true;
    },
    hundleOnClose: function () {
      this.showModal = false;
    },
    hundleOnSubmit: function () {
      axios.post('/api/boards', {
        boards: { feed_ids: this.feeds.map(feed => feed.id) }
      });
      this.showModal = false;
    }
  }
};
</script>

<style>

</style>
