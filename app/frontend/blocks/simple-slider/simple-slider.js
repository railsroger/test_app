import Swiper from 'swiper/dist/js/swiper';

document.addEventListener('DOMContentLoaded', () => {
  const element = document.querySelector('.simple-slider__container');

  const swiper = new Swiper(element, {  // eslint-disable-line
    slidesPerView: 1,
    navigation: {
      prevEl: '.simple-slider__navigation_left',
      nextEl: '.simple-slider__navigation_right'
    },
    pagination: {
      el: '.swiper-pagination',
      type: 'fraction'
    }
  });
});
