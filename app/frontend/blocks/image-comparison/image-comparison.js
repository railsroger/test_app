import {isMobile} from 'helpers/layoutHelper';

const selectors = Array.prototype.slice.call(document.querySelectorAll('.image-comparison'));

function wrap(top, element, bottom){
  const modified = top + element.outerHTML + bottom;
  element.outerHTML = modified;
}

function initComparisons() {
  const img = document.querySelector('.image-comparison__overlay');

  let slider;
  let clicked = 0;
  let w;

  /* get the width of the img element*/
  w = img.offsetWidth;
  /* set the width of the img element to 50%:*/
  img.style.width = (w / 2) + 'px';
  /* create slider:*/
  slider = document.createElement('div');
  slider.setAttribute('class', 'image-comparison__slider');
  /* insert slider*/
  img.parentElement.insertBefore(slider, img);
  /* position the slider in the middle:*/
  slider.style.left = (w / 2) - (slider.offsetWidth / 2) + 'px';

  function slideFinish() {
    /* the slider is no longer clicked:*/
    clicked = 0;
  }

  function getCursorPos(e) {
    let a;
    let x = 0;
    e = e || window.event;
    /* get the x positions of the image:*/
    a = img.getBoundingClientRect();
    /* calculate the cursor's x coordinate, relative to the image:*/
    x = e.pageX - a.left;
    /* consider any page scrolling:*/
    x -= window.pageXOffset;
    return x;
  }

  function slide(x) {
    /* resize the image:*/
    img.style.width = x + 'px';
    /* position the slider:*/
    slider.style.left = img.offsetWidth - (slider.offsetWidth / 2) + 'px';
  }

  function slideMove(e) {
    let pos;
    /* if the slider is no longer clicked, exit this function:*/
    if (clicked === 0) {
      return false;
    }
    /* get the cursor's x position:*/
    pos = getCursorPos(e);
    /* prevent the slider from being positioned outside the image:*/
    if (pos < 0) {pos = 0;}
    if (pos > w) {pos = w;}
    /* execute a function that will resize the overlay image according to the cursor:*/
    slide(pos);
  }

  function slideReady(e) {
    /* prevent any other actions that may occur when moving over the image:*/
    e.preventDefault();
    /* the slider is now clicked and ready to move:*/
    clicked = 1;
    /* execute a function when the slider is moved:*/
    window.addEventListener('mousemove', slideMove);
    window.addEventListener('touchmove', slideMove);
  }

  slider.addEventListener('mousedown', slideReady);
  window.addEventListener('mouseup', slideFinish);
  slider.addEventListener('touchstart', slideReady);
  window.addEventListener('touchstop', slideFinish);
}

if (selectors) {
  selectors.forEach(item => {
    let images = Array.prototype.slice.call(item.querySelectorAll('img'));

    if (images.length === 2) {
      images.forEach((image, index) => {
        image.classList.add('image-comparison__image');

        if (index === 0) {
          wrap('<div class="image-comparison__image-wrapper image-comparison__overlay">', image, '</div>');
        } else {
          wrap('<div class="image-comparison__image-wrapper">', image, '</div>');
        }
      });

      images = Array.prototype.slice.call(item.querySelectorAll('img'));

      function setImageSizes() { // eslint-disable-line
        images.forEach(image => {
          image.style.width = isMobile
            ? `${window.innerWidth * 1.5}px`
            : `${window.innerWidth}px`;
        });
      }

      function onWindowresize() { // eslint-disable-line
        setImageSizes();
      }

      window.addEventListener('resize', onWindowresize);

      const leftLabel = document.createElement('div');
      leftLabel.classList.add('image-comparison__label');
      leftLabel.classList.add('image-comparison__label_left');
      leftLabel.innerHTML = images[0].getAttribute('data-label') || 'Before';
      item.appendChild(leftLabel);

      const rightLabel = document.createElement('div');
      rightLabel.classList.add('image-comparison__label');
      rightLabel.classList.add('image-comparison__label_right');
      rightLabel.innerHTML = images[1].getAttribute('data-label') || 'After';
      item.appendChild(rightLabel);

      setImageSizes();
      initComparisons();
    }
  });
}
