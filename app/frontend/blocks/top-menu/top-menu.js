import {header} from '../header/header';

const topMenu = {
  parentElement: document.querySelector('.top-menu'),
  elements: Array.prototype.slice.call(document.querySelectorAll('.top-menu__menu')),
  timeOut: null,
  menuHeight: 'auto',
  items: []
};

topMenu.elements.forEach(topMenuItem => {
  topMenuItem.style.display = 'none';
  const id = topMenuItem.getAttribute('data-top-menu');

  topMenu.items.push({
    element: topMenuItem,
    isOpen: false,
    id: id,
    _tl: new TimelineMax()
  });
});

topMenu.closeAll = () => {
  topMenu.items.forEach(item => {
    if (item.isOpen) {
      topMenu.close(item.id);
    }
  });

  header.overlapDetect.update();
  header.overlapDetect.play();
};

topMenu._getMenuById = id => {
  return topMenu.items.find(item => {
    return item.id === id;
  });
};

topMenu.close = id => {
  const menu = topMenu._getMenuById(id);
  const el = menu.element;
  const cardsColumn = el.querySelectorAll('.top-menu__cards-column');
  const menuColumn = el.querySelector('.top-menu__info-column');

  menu.isOpen = false;

  let overlayAnimationIsActive = true;

  if (topMenu.items.some(item => item.isOpen)) {
    overlayAnimationIsActive = false;
  }

  menu._tl.clear();

  if (overlayAnimationIsActive) {
    menu._tl
      .set(topMenu.parentElement, {opacity: 1});
  } else {
    if (el.offsetHeight > 0) {
      topMenu.menuHeight = `${el.offsetHeight}px`;
    }

    menu._tl
      .set(topMenu.parentElement, {height: topMenu.menuHeight})
      .set(el, {position: 'absolute'});
  }

  menu._tl
    .set(cardsColumn, {opacity: 1, y: 0})
    .set(menuColumn, {opacity: 1, y: 0})
    .to(cardsColumn, .3, {opacity: 0, y: -20})
    .to(menuColumn, .3, {opacity: 0, y: 20}, '-=.3');

  if (overlayAnimationIsActive) {
    menu._tl
      .to(topMenu.parentElement, .3, {opacity: 0, display: 'none', clearProps: 'all'});
  }

  menu._tl
    .set(el, {clearProps: 'all'})
    .set(cardsColumn, {clearProps: 'all'})
    .set(menuColumn, {clearProps: 'all'});
};

topMenu.open = id => {
  if (topMenu.items.some(item => item.isOpen)) {
    clearTimeout(topMenu.timeOut);

    topMenu.timeOut = setTimeout(() => {
      topMenu._open(id);
    }, 200);
  } else {
    topMenu._open(id);
  }
};

topMenu._open = id => {
  const menu = topMenu._getMenuById(id);

  if (!menu.isOpen) {
    menu.isOpen = true;

    let delay = 0;
    let overlayAnimationIsActive = true;

    if (topMenu.items.some(item => {
      return item.isOpen && item.id !== id;
    })) {
      delay = 300;
      overlayAnimationIsActive = false;

      topMenu.items.forEach(item => {
        if (item.id !== id && item.isOpen) {
          topMenu.close(item.id);
        }
      });
    }

    const el = menu.element;
    const cardsColumn = el.querySelectorAll('.top-menu__cards-column');
    const menuColumn = el.querySelector('.top-menu__info-column');

    header.setUiWhite();
    header.overlapDetect.pause();

    menu._tl
      .clear()
      .set(el, {display: 'block', clearProps: 'position'}, `+=${delay / 1000}`);

    if (overlayAnimationIsActive) {
      menu._tl
        .set(topMenu.parentElement, {opacity: 0, y: '-100%', display: 'block'}, `-=${delay / 1000}`);
    } else {
      menu._tl
        .set(topMenu.parentElement, {clearProps: 'height'});
    }

    menu._tl
      .set(menuColumn, {opacity: 0, y: -20})
      .set(cardsColumn, {opacity: 0, y: 20});

    if (overlayAnimationIsActive) {
      menu._tl
        .to(topMenu.parentElement, .3, {opacity: 1, y: '0%', clearProps: 'opacity, y'});
    }

    menu._tl
      .to(menuColumn, .3, {opacity: 1, y: 0, clearProps: 'all'})
      .to(cardsColumn, .3, {opacity: 1, y: 0, clearProps: 'all'}, '-=.2');
  }
};

document.addEventListener('DOMContentLoaded', () => {
  header.element.addEventListener('mouseleave', () => {
    topMenu.closeAll();
  });
});

export {topMenu};
