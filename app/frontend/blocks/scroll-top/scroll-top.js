import throttle from '../../helpers/throttle';

const button = document.querySelector('.scroll-top');
let buttonIsShow = false;

const showButton = () => {
  const tl = new TimelineLite({
    onComplete: () => {
      buttonIsShow = true;
    }
  });

  tl.set(button, {display: 'block', opacity: 0, transition: 'none'})
    .to(button, .3, {opacity: 1, clearProps: 'opacity, transition'});
};

const hideButton = () => {
  const tl = new TimelineLite({
    onComplete: () => {
      buttonIsShow = false;
    }
  });

  tl.set(button, {opacity: 1, transition: 'none'})
    .to(button, .3, {opacity: 0, clearProps: 'opacity, transition, display'});
};

const checkScrollPosition = () => {
  const scrollTop = document.body.scrollTop || document.documentElement.scrollTop;

  if (scrollTop > window.innerHeight) {
    if (!buttonIsShow) {
      showButton();
    }
  } else if (buttonIsShow) {
    hideButton();
  }
};

button.addEventListener('click', () => {
  window.scroll({
    top: 0,
    left: 0,
    behavior: 'smooth'
  });
});

const onWindowScroll = throttle(() => {
  checkScrollPosition();
}, 500);

// checkScrollPosition();
window.addEventListener('scroll', onWindowScroll);
