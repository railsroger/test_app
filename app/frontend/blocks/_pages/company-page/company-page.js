import Vue from 'vue';
import WheelIndicator from 'wheel-indicator';

import {fadeIn, fadeOut} from 'helpers/animations';
import {isMobile} from 'helpers/layoutHelper';

import {header} from 'blocks/header/header';

const element = document.querySelector('#company-page');

if (element && !isMobile) {
  new Vue({ // eslint-disable-line
    el: element,
    data() {
      return {
        anchors: (() => {
          const anchors = Array.prototype.slice.call(document.querySelectorAll('.company-page__screen')).map(item => {
            return item.getAttribute('id');
          });
          return anchors;
        })(),
        fadeIn: fadeIn,
        fadeOut: fadeOut,
        activeSectionId: null,
        scrollScores: 0,
        scrollMaxScore: 2,
        scrollInterval: null,
        scrollTop: 0,
        scrollElement: document.querySelector('html'),
        footerElement: document.querySelector('footer'),
        indicator: new WheelIndicator(),
        isTop: null,
        isBottom: null
      };
    },

    computed: {
      scrollIndicatorStyles() {
        if (this.lastSectionNow && this.scrollScores > 0 || this.firstSectionNow && this.scrollScores < 0) {
          return {};
        }

        return {
          transform: `translateX(${100 / this.scrollMaxScore * Math.abs(this.scrollScores)}%)`
        };
      },

      menuIsVisible() {
        return this.scrollTop < window.innerHeight / 3 * 2;
      },

      firstSectionNow() {
        let id = this.anchors.indexOf(this.activeSectionId);
        id = id === -1 ? 1 : id;

        return id === 0;
      },

      lastSectionNow() {
        let id = this.anchors.indexOf(this.activeSectionId);
        id = id === -1 ? 1 : id;

        return id === this.anchors.length - 1;
      }
    },

    created() {
      this.setActiveSection();

      window.onhashchange = () => {
        this.setActiveSection();
      };
    },

    mounted() {
      this.checkScrollPosition();

      this.setFooterVisibility();

      this.indicator.setOptions(this.getWheelOptions());

      window.addEventListener('scroll', () => {
        this.checkScrollPosition();
      });
    },

    watch: {
      activeSectionId() {
        this.scrollDownScores = 0;

        setTimeout(() => {
          this.checkScrollPosition();
        }, 1000);
      },

      scrollScores() {
        if (Math.abs(this.scrollScores) > 0) {
          if (this.scrollInterval === null) {
            this.scrollInterval = setInterval(() => {
              this.scrollScores = 0;
            }, 1500);
          }
        } else {
          clearInterval(this.scrollInterval);
          this.scrollInterval = null;
        }

        if (this.scrollScores > this.scrollMaxScore) {
          this.scrollScores = 0;
          this.setNextSection();
        } else if (this.scrollScores < this.scrollMaxScore * -1) {
          this.scrollScores = 0;
          this.setNextSection(-1);
        }
      }
    },

    methods: {
      checkScrollPosition() {
        this.scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
        this.isTop = this.scrollTop === 0;
        this.isBottom = this.scrollTop >= this.scrollElement.scrollHeight - this.scrollElement.offsetHeight;
      },

      setActiveSectionId(id) {
        this.activeSectionId = id;
        location.hash = id;
      },

      getWheelOptions(preventMouse = false) {
        return {
          callback: e => {
            if (e.direction !== 'up') {
              if (this.isBottom) {
                this.scrollScores++;
              }
            }

            if (e.direction !== 'down') {
              if (this.isTop) {
                this.scrollScores--;
              }
            }
          },
          preventMouse: preventMouse
        };
      },

      setActiveSection() {
        const hash = location.hash.slice(1);
        this.activeSectionId = this.anchors.indexOf(hash) === -1
          ? this.anchors[0]
          : hash;
      },

      setFooterVisibility() {
        if (this.lastSectionNow) {
          this.footerElement.style.display = '';
        } else {
          this.footerElement.style.display = 'none';
        }
      },

      setNextSection(step = 1) {
        let id = this.anchors.indexOf(this.activeSectionId);
        id = id === -1 ? 1 : id + step;

        if (id < this.anchors.length && id >= 0) {
          location.hash = this.anchors[id];
          this.activeSectionId = this.anchors[id];
        }
      },

      hookEnter(el, done) {
        setTimeout(() => {
          this.scrollElement.scrollTop = 0;
        }, 300);

        const tl = new TimelineLite({
          onComplete: () => {
            header.overlapDetect.update();
            this.setFooterVisibility();
            done();
          }
        });

        tl.set(el, {display: 'none'})
          .set(el, {opacity: 0, transition: 'none', clearProps: 'display'}, '+=.3')
          .to(el, .3, {opacity: 1, clearProps: 'opacity, transition'});
      },

      hookLeave(el, done) {
        fadeOut(el, done);
      }
    }
  });
}
