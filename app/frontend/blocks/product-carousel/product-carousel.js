import Swiper from 'swiper/dist/js/swiper';

document.addEventListener('DOMContentLoaded', () => {
  const element = document.querySelector('.product-carousel__container');

  const swiper = new Swiper(element, {  // eslint-disable-line
    slidesPerView: 'auto',
    spaceBetween: 30,
    loop: false,
    mousewheel: true,
    scrollbar: {
      el: '.swiper-scrollbar'
    }
  });
});
