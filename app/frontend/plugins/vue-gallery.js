import Vue from 'vue';

import VueGallery from 'components/vue-gallery/vue-gallery.vue';

const element = document.createElement('div');
element.setAttribute('id', 'vue-gallery');
document.querySelector('body').appendChild(element);

const vm = new Vue(
  Vue.util.extend({}, VueGallery)
).$mount('#vue-gallery');

const galleryElements = Array.prototype.slice.call(document.querySelectorAll('[data-gallery]'));

galleryElements.forEach(el => {
  el.addEventListener('click', () => {
    const images = [
      ...document.querySelectorAll(
        `[data-gallery="${el.getAttribute('data-gallery')}"]`
      )
    ];

    if (images.length !== 0) {
      Vue.set(vm, 'images', images.map(e => {
        return {
          src: e.dataset.src || e.src,
          alt: e.alt || '',
          description: e.dataset.description,
          uiColor: e.dataset.uiColor
        };
      }));

      const template = el.dataset.template;

      if (template) {
        Vue.set(vm, 'template', el.dataset.template);
      }

      Vue.set(vm, 'currentImageIndex', images.indexOf(el));
    }
    Vue.set(vm, 'closed', false);
  });
});
