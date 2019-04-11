import Vue from 'vue';
import VeeValidate from 'vee-validate';

import tabsMixin from 'blocks/tabs/tabs';

import {fadeIn, fadeOut} from 'helpers/animations';

Vue.use(VeeValidate);

const element = document.querySelector('.support');

if (element) {
  new Vue({ // eslint-disable-line
    el: element,
    data() {
      return {
        fadeIn: fadeIn,
        fadeOut: fadeOut,
        categoryValue: 'tv'
      };
    },

    mixins: [tabsMixin],

    computed: {},

    created() {},

    mounted() {
      this.categoryValue = this.$el.querySelector('.support__buttons').getAttribute('data-value')
        || this.$el.querySelectorAll('.support__button-input')[0].value;
    },

    watch: {},

    methods: {
      onSelectChange(e) {
        window.location.href = `${window.location.origin}/support/${e.target.value}#categories`;
      }
    }
  });
}
