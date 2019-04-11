import Vue from 'vue';

import tabsMixin from 'blocks/tabs/tabs';

const element = document.querySelector('.search-page');

if (element) {
  new Vue({ // eslint-disable-line
    el: element,
    data() {
      return {};
    },

    mixins: [tabsMixin]
  });
}
