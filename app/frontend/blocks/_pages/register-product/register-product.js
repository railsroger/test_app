import Vue from 'vue';
import VeeValidate from 'vee-validate';
import axios from 'axios';

import {fadeIn, fadeOut} from 'helpers/animations';

Vue.use(VeeValidate);

const element = document.querySelector('.register-product');

if (element) {
  new Vue({ // eslint-disable-line
    el: element,
    data() {
      return {
        fadeIn: fadeIn,
        fadeOut: fadeOut,

        formIsSuccess: false,

        requestBlocked: false
      };
    },

    computed: {},

    created() {},

    mounted() {},

    watch: {},

    methods: {
      validateBeforeSubmit(e) {
        this.$validator.validateAll().then(result => {
          if (result) {
            const payload = new FormData(e.target);
            this.requestBlocked = true;

            axios.post(e.target.target, payload).then(() => {
              this.formIsSuccess = true;
              this.requestBlocked = false;
            }).catch(() => {
              this.requestBlocked = false;
            });
          }
        });
      }
    }
  });
}
