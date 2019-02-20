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
      // TODO: APIに投げてボードを作る。
      this.showModal = false;
    }
  }
};
</script>

<style>

</style>
