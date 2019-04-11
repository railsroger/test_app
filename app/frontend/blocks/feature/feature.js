import {detectMobile} from 'helpers/platformDetect';

const elements = Array.prototype.slice.call(document.querySelectorAll('.feature'));

elements.forEach(item => {
  const tl = new TimelineMax({
    onComplete: () => {}
  });

  const hoverElement = item.querySelector('.feature__hover');
  const title = item.querySelector('.feature__title-text');
  const overlay = item.querySelector('.feature__overlay');
  const hoverTitle = item.querySelector('.feature__hover-title-text');
  const hoverImage = item.querySelector('.feature__hover-image');

  item.addEventListener('mouseenter', e => {
    if (!detectMobile.isMobile) {
      const direction = e.target.offsetWidth / 2 > e.offsetX ? -1 : 1;

      tl.clear()
        .set(title, {y: '0%'})
        .set(hoverTitle, {y: '100%'})
        .set(hoverElement, {display: 'flex'})
        .set(hoverImage, {y: 20, opacity: 0})
        .set(overlay, {x: `${101 * direction}%`, display: 'block'})
        .to(overlay, .3, {x: '0%'}, '+=.2')
        .to(title, .3, {y: '-100%'}, '-=.3')
        .to(hoverTitle, .3, {y: '0%'}, '-=.2')
        .to(hoverImage, .4, {y: 0, opacity: 1}, '-=.2');
    }
  });

  item.addEventListener('mouseleave', e => {
    if (!detectMobile.isMobile) {
      const direction = e.target.offsetWidth / 2 > e.offsetX ? -1 : 1;

      tl.clear()
        .set(title, {y: '100%'})
        .to(hoverTitle, .3, {y: '-100%'})
        .to(title, .3, {y: '0%'}, '-=.1')
        .to(hoverImage, .4, {y: 20, opacity: 0}, '-=.4')
        .to(overlay, .3, {x: `${101 * direction}%`, clearProps: 'all'}, '-=.2');
    }
  });
});
