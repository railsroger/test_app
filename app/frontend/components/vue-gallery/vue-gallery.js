import {fadeIn, fadeOut} from 'helpers/animations';

import icon from 'components/icon/icon.vue';

export default {
  name: 'vue-gallery',

  components: {
    icon
  },

  data() {
    return {
      closed: true,
      currentImageIndex: 0,
      fadeIn: fadeIn,
      fadeOut: fadeOut,
      galleryIsEnter: false,
      images: [],
      loop: false,
      previousImageIndex: 0,
      slideDirection: 1,
      template: null,
      title: null,
      thumbsWrapper: null,
      uiTimeout: null,

      thumbnailsIsEnabled: false
    };
  },

  computed: {
    visibleUI() {
      return this.images.length > 1;
    },

    currentImage() {
      return this.images[this.currentImageIndex];
    }
  },

  watch: {
    currentImageIndex() {
      if (!this.closed && this.thumbsWrapper) {
        this.setThumbnailsScroll();
      }
    }
  },

  created() {
    window.addEventListener('keyup', e => {
      // esc key and 'q' for quit
      if (e.keyCode === 27 || e.keyCode === 81) {this.close();}
      // arrow right and 'l' key (vim-like binding)
      if (e.keyCode === 39 || e.keyCode === 76) {this.next();}
      // arrow left and 'h' key (vim-like binding)
      if (e.keyCode === 37 || e.keyCode === 72) {this.prev();}
    });

    window.addEventListener('scroll', () => {
      this.close();
    });
  },

  mounted: function () {},

  methods: {
    close() {
      this.images = [];
      this.currentImageIndex = 0;
      this.closed = true;
    },

    next() {
      this.slideDirection = 1;

      if (this.currentImageIndex + 1 < this.images.length) {
        this.currentImageIndex++;
      } else if (this.loop) {
        this.currentImageIndex = 0;
      }
    },

    prev() {
      this.slideDirection = -1;

      if (this.currentImageIndex > 0) {
        this.currentImageIndex--;
      } else if (this.loop) {
        this.currentImageIndex = this.images.length - 1;
      }
    },

    setThumbnailsScroll() {
      const wrapperWidth = this.thumbsWrapper.offsetWidth;
      const scrollWidth = this.thumbsWrapper.scrollWidth;

      if (scrollWidth > wrapperWidth) {
        const elementLeft = this.thumbnails[this.currentImageIndex].offsetLeft + this.thumbnails[this.currentImageIndex].offsetWidth / 2;
        let scrollLeft = 0;

        if (elementLeft > wrapperWidth / 2) {
          if (scrollWidth - elementLeft > wrapperWidth / 2) {
            scrollLeft = elementLeft - wrapperWidth / 2;
          } else {
            scrollLeft = scrollWidth - wrapperWidth;
          }
        }

        const tl = new TimelineLite();
        tl.to(this.thumbsWrapper, .3, {scrollTo: {x: scrollLeft}});
      }
    },

    onThumbnailClick(index) {
      this.slideDirection = this.currentImageIndex < index ? 1 : -1;
      this.currentImageIndex = index;
    },

    onBottomMouseEnter() {
      const bottomBar = this.$el.querySelector('.vue-gallery__bottom-bar');
      const left = this.$el.querySelector('.vue-gallery__nav_left');
      const right = this.$el.querySelector('.vue-gallery__nav_right');
      const imageWrapper = this.$el.querySelector('.vue-gallery__image-wrapper');

      const tl = new TimelineLite();

      tl.set(bottomBar, {y: '0%'})
        .set(imageWrapper, {y: '0%', opacity: 1})

        .to(left, .3, {x: 10, opacity: 0, transition: 'none', clearProps: 'transition'})
        .to(right, .3, {x: -10, opacity: 0, transition: 'none', clearProps: 'transition'}, '-=.3')
        .to(bottomBar, .4, {y: '-90%'}, '-=.3')
        .to(imageWrapper, .4, {y: '-50%', opacity: .4}, '-=.4');
    },

    onBottomMouseLeave() {
      const bottomBar = this.$el.querySelector('.vue-gallery__bottom-bar');
      const left = this.$el.querySelector('.vue-gallery__nav_left');
      const right = this.$el.querySelector('.vue-gallery__nav_right');
      const imageWrapper = this.$el.querySelector('.vue-gallery__image-wrapper');

      const tl = new TimelineLite();

      tl.set([left, right], {transition: 'none'})
        .to([left, right], .3, {x: 0, opacity: 1, clearProps: 'opacity, x, transition'})
        .to(bottomBar, .4, {y: '0%'}, '-=.3')
        .to(imageWrapper, .4, {y: '0%', opacity: 1, clearProps: 'opacity, y'}, '-=.4');
    },

    hookImageEnter(el, done) {
      const tl = new TimelineLite({onComplete: done});

      tl.set(el, {opacity: 0, x: `${this.slideDirection * 20}`})
        .to(el, .3, {opacity: 1, x: 0, clearProps: 'opacity, transform'});
    },

    hookImageLeave(el, done) {
      const tl = new TimelineLite({onComplete: done});

      tl.set(el, {opacity: 1, x: 0})
        .to(el, .3, {opacity: 0, x: `${this.slideDirection * -20}`});
    },

    hookEnter(el, done) {
      this.thumbsWrapper = el.querySelector('.vue-gallery__thumbnails');
      this.thumbnails = el.querySelectorAll('.vue-gallery__thumbnail');

      const bottomBar = el.querySelector('.vue-gallery__bottom-bar');
      const description = el.querySelector('.vue-gallery__description');
      const image = el.querySelector('.vue-gallery__image-wrapper');
      const left = el.querySelector('.vue-gallery__nav_left');
      const right = el.querySelector('.vue-gallery__nav_right');
      const thumbnails = el.querySelector('.vue-gallery__thumbnails');

      if (this.thumbnailsIsEnabled) {
        this.setThumbnailsScroll();
      }

      const tl = new TimelineLite({onComplete: done});

      tl.set(el, {opacity: 0});

      if (this.thumbnailsIsEnabled) {
        tl.set(bottomBar, {zIndex: 1})
          .set(thumbnails, {y: '0%'})
          .set(description, {opacity: 0});
      }

      tl.set(image, {y: 20, opacity: 0})
        .set(left, {opacity: 0, x: 10})
        .set(right, {opacity: 0, x: -10})
        .to(el, .3, {opacity: 1, clearProps: 'opacity'})
        .to(image, .6, {y: 0, opacity: 1, clearProps: 'y, opacity'})
        .to([left, right], .3, {x: 0, opacity: 1, clearProps: 'x, opacity'}, '-=.3');

      if (this.thumbnailsIsEnabled) {
        tl.to(thumbnails, .3, {y: '-10%', clearProps: 'y'}, '-=.3')
          .to(description, .6, {opacity: 1, clearProps: 'opacity'}, '-=.3')
          .set(bottomBar, {clearProps: 'z-index'});
      }
    },

    hookLeave(el, done) {
      const tl = new TimelineLite({onComplete: done});

      tl.set(el, {opacity: 1})
        .to(el, .3, {opacity: 0});
    }
  },

  beforeDestroy() {}
};
