import Swiper from 'swiper/dist/js/swiper';

document.addEventListener('DOMContentLoaded', () => {
  const sliderElement = document.querySelector('.reviews-slider__container');

  const swiper = new Swiper(sliderElement, {  // eslint-disable-line
    slidesPerView: 1,
    centeredSlides: true,
    speed: 500,
    loop: true,
    navigation: {
      prevEl: '.reviews-slider__navigation_left',
      nextEl: '.reviews-slider__navigation_right'
    },
    pagination: {
      el: '.swiper-pagination'
    }
  });
});
