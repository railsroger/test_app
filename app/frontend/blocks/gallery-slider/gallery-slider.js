import Swiper from 'swiper/dist/js/swiper';

document.addEventListener('DOMContentLoaded', () => {
  const element = document.querySelector('.gallery-slider');
  const sliderElement = document.querySelector('.gallery-slider__container');

  const swiper = new Swiper(sliderElement, {  // eslint-disable-line
    slidesPerView: 3,
    centeredSlides: true,
    speed: 500,
    loop: false,
    navigation: {
      prevEl: '.gallery-slider__navigation_left',
      nextEl: '.gallery-slider__navigation_right'
    },
    breakpoints: {
      750: {
        slidesPerView: 1
      }
    },
    on: {
      init: () => {
        element.classList.remove('gallery-slider_hidden');
      }
    }
  });
});
