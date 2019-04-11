import {getCookie, setCookie} from 'helpers/cookies';
import {TimelineLite} from 'gsap';

const popup = document.querySelector('.cookies-popup');
const button = document.querySelector('.cookies-popup__button');

if (popup) {
  const open = () => {
    const tl = new TimelineLite();

    tl.set(popup, {y: '100%', display: 'block'})
      .to(popup, .3, {y: '0%', clearProps: 'y'});
  };

  const close = () => {
    const tl = new TimelineLite();

    tl.set(popup, {y: '0%'})
      .to(popup, .3, {y: '100%', clearProps: 'all'});
  };

  if (!getCookie('cookiesIsEnabled')) {
    setTimeout(() => {
      open();
    }, 5000);
  }

  button.addEventListener('click', () => {
    setCookie('cookiesIsEnabled', true, {expires: 3600 * 24 * 100, path: '/'});
    close();
  });
}
