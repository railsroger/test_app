import Swiper from 'swiper/dist/js/swiper';

document.addEventListener('DOMContentLoaded', () => {
  const element = document.querySelector('.main-slider__container');

  const swiper = new Swiper(element, {  // eslint-disable-line
    autoplay: {
      delay: 6000
    },
    loop: true,
    slidesPerView: 1
  });

  const leftNavElements = Array.prototype.slice.call(document.querySelectorAll('.main-slider__nav_side_left'));
  const rightNavElements = Array.prototype.slice.call(document.querySelectorAll('.main-slider__nav_side_right'));

  leftNavElements.forEach(item => {
    item.addEventListener('click', () => {
      swiper.slidePrev();
    });
  });

  rightNavElements.forEach(item => {
    item.addEventListener('click', () => {
      swiper.slideNext();
    });
  });

  document.querySelectorAll('video').forEach(item => {
    item.muted = true;
  });
});
