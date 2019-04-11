import Vue from 'vue';
import VeeValidate from 'vee-validate';
import axios from 'axios';

import tabsMixin from 'blocks/tabs/tabs';

import {fadeIn, fadeOut} from 'helpers/animations';

Vue.use(VeeValidate);

const element = document.querySelector('.contact');

if (element) {
  new Vue({ // eslint-disable-line
    el: element,
    data() {
      return {
        openCallBlockIndex: null,
        fadeIn: fadeIn,
        fadeOut: fadeOut,

        formIsSuccess: false,

        requestBlocked: false
      };
    },

    mixins: [tabsMixin],

    computed: {},

    created() {},

    mounted() {},

    watch: {},

    methods: {
      openCallWindow(index) {
        this.openCallBlockIndex = index;
      },

      closeCallWindow() {
        this.openCallBlockIndex = null;
      },

      validateBeforeSubmit(e) {
        if (!this.requestBlocked) {
          this.requestBlocked = true;

          this.$validator.validateAll().then(result => {
            if (result) {
              const payload = new FormData(e.target);
              this.formIsSuccess = true;

              axios.post(e.target.target, payload).then(() => {
                this.requestBlocked = false;
              }).catch(() => {
                this.requestBlocked = false;
              });
            } else {
              this.requestBlocked = false;
            }
          });
        }
      },

      hookWindowEnter(el, done) {
        const head = el.querySelector('.contact__window-head');
        const columns = el.querySelector('.contact__window-column-wrap');

        const tl = new TimelineLite({onComplete: done});

        tl.set(el, {opacity: 0})
          .set(head, {opacity: 0, y: -10})
          .set(columns, {opacity: 0})
          .to(el, .3, {opacity: 1, clearProps: 'opacity'})
          .to(head, .3, {opacity: 1, y: 0, clearProps: 'opacity, y'})
          .to(columns, .3, {opacity: 1, clearProps: 'opacity'}, '-=.3');
      },

      hookWindowLeave(el, done) {
        const tl = new TimelineLite({onComplete: done});

        tl.set(el, {opacity: 1})
          .to(el, .3, {opacity: 0, clearProps: 'opacity'});
      }
    }
  });
}
