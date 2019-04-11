export default class Overlap {
  constructor(data) {
    this.target = data.target;
    this.selectors = data.selectors || '';
    this.wrapper = data.wrapper || window;
    this.onEnter = data.onEnter || null;
    this.onLeave = data.onLeave || null;
    this.locked = false;

    this.setElements = () => {
      this.elements = [];
      this.selectors.forEach(selector => {
        if (selector.length) {
          const arr = Array.prototype.slice.call(document.querySelectorAll(selector));
          this.elements = this.elements.concat(arr);
        }
      });
    };

    this.setElements();
    this.setTargetStatus = () => {
      this.targetSize = this.target.getBoundingClientRect();

      this.targetIsActive = this.elements.some(element => {
        return (this.targetSize.top + this.targetSize.height / 2 > element.getBoundingClientRect().top) &&
          (this.targetSize.bottom - this.targetSize.height / 2 < element.getBoundingClientRect().bottom) &&
          (this.targetSize.left + this.targetSize.width / 2 > element.getBoundingClientRect().left) &&
          (this.targetSize.right - this.targetSize.height / 2 < element.getBoundingClientRect().right);
      });

      if (this.targetIsActive) {
        this.onEnter();
      } else {
        this.onLeave();
      }
    };

    let scrollTimeout;

    this.onScrollEvent = () => {
      if (!this.locked) {
        clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(() => {
          this.setTargetStatus();
        }, 200);
      }
    };

    return this;
  }

  destroy() {
    this.wrapper.removeEventListener('scroll', this.onScrollEvent);
  }

  run() {
    this.update();
    this.wrapper.addEventListener('scroll', this.onScrollEvent);
  }

  play() {
    this.locked = false;
  }

  pause() {
    this.locked = true;
  }

  update() {
    this.setElements();
    this.setTargetStatus();
  }
}
