import throttle from '../../helpers/throttle';

const parallaxItems = Array.prototype.slice.call(document.querySelectorAll('.page__cover-inner'));

const onWindowScroll = throttle(() => {
  const transformValue = (document.body.scrollTop || document.documentElement.scrollTop) / 2;

  parallaxItems.forEach(item => {
    item.style.transform = `translateY(${transformValue}px)`;
  });
}, 10);

window.addEventListener('scroll', onWindowScroll);
