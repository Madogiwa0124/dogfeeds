<template>
  <nav class="navbar" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item" href="/">
        <img src="/favicon.ico" alt="favicon" height="28" width="28" />
        Dogfeeds
      </a>
      <span class="navbar-item tag-line">いろんなRSSをまとめて、1つのRSSに。</span>
      <a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false" data-target="header-navbar">
        <span aria-hidden="true" />
        <span aria-hidden="true" />
        <span aria-hidden="true" />
      </a>
    </div>
    <div id="header-navbar" class="navbar-menu">
      <div class="navbar-end">
        <div class="navbar-item">
          <a class="button is-primary is-rounded" href="/feeds/new">RSSフィードを登録する</a>
        </div>
        <div class="navbar-item">
          <a class="button is-info is-rounded" href="/feeds">RSSフィードを見る</a>
        </div>
        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link is-arrowless"> MENU &nbsp; <font-awesome-icon icon="bars" /></a>
          <div class="navbar-dropdown is-right">
            <a class="navbar-item" href="/boards">
              <font-awesome-icon icon="boxes" />&nbsp;みんながまとめたRSSフィードを見る
            </a>
            <hr class="navbar-divider" />
            <a class="navbar-item" href="/boards/new"> <font-awesome-icon icon="box" />&nbsp; RSSフィードをまとめる </a>
            <hr class="navbar-divider" />
            <a class="navbar-item" href="/mypage"> <font-awesome-icon icon="user" />&nbsp; マイページ </a>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>
<script>
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faUser, faBoxes, faBox, faRss, faBars } from "@fortawesome/free-solid-svg-icons";

library.add(faUser, faBoxes, faBox, faRss, faBars);

export default {
  name: "NavigationBar",
  components: {
    FontAwesomeIcon,
  },
  props: {},
  computed: {},
  mounted: function () {
    const navbarBurgers = Array.prototype.slice.call(document.querySelectorAll(".navbar-burger"), 0);
    if (navbarBurgers.length < 1) return;
    navbarBurgers.forEach((el) => {
      el.addEventListener("click", () => {
        const target = document.getElementById(el.dataset.target);
        el.classList.toggle("is-active");
        target.classList.toggle("is-active");
      });
    });
  },
};
</script>
<style lang="scss" scoped>
@import url("https://fonts.googleapis.com/css2?family=Ubuntu&display=swap");

.navbar-brand {
  font-family: "Ubuntu", sans-serif;
  font-size: 20px;

  a:hover {
    color: hsl(171, 100%, 41%);
  }

  .tag-line {
    color: #888888;
    font-size: 10px;
  }
}
</style>
