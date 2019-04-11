import {getScrollBarWidth} from '../../helpers/scrollBarHelper';
import {isMobile} from '../../helpers/layoutHelper';

import {header} from '../header/header';
import {topMenu} from '../top-menu/top-menu';

const buttonCrossClass = 'button-cross_state_cross';

const rootElement = document.querySelector('body');
const modalElement = document.querySelector('.main-menu__modal');

const modalContentsElement = document.querySelector('.main-menu__modal-inner_contents');
const searchInputElement = document.querySelector('.main-menu__search-input');
const submenu = document.querySelector('.main-menu__submenu');
const menu = document.querySelector('.main-menu__menu');

const modalSearchElement = document.querySelector('.main-menu__modal-inner_search');
const searchElements = Array.prototype.slice.call(document.querySelectorAll('.main-menu__search-menu-item'));
const searchWrapperElement = document.querySelector('.main-menu__search-wrapper');
const searchFormElement = document.querySelector('.main-menu__search-form');
const searchFormSubmit = document.querySelector('.main-menu__search-submit');

const mainMenu = {
  element: document.querySelector('.main-menu__modal'),
  searchButtonElement: document.querySelector('.main-menu__button-search'),
  buttonElement: document.querySelector('.main-menu__button'),
  isOpen: false,
  openWindowName: null,
  isAnimated: false
};

mainMenu.buttonElement.addEventListener('click', () => {
  if (mainMenu.isOpen) {
    mainMenu.close();
  } else {
    mainMenu.open('content');
  }
});

mainMenu.searchButtonElement.addEventListener('click', () => {
  if (mainMenu.isOpen) {
    if (mainMenu.openWindowName === 'contents') {
      mainMenu._hideContents();
      mainMenu._showSearch(300);
    }
  } else {
    mainMenu.open('search');
  }
});

mainMenu.open = windowName => {
  topMenu.closeAll();

  if (!mainMenu.isOpen && !mainMenu.isAnimated) {
    const scrollBarWidth = getScrollBarWidth();

    mainMenu.buttonElement.classList.add(buttonCrossClass);

    rootElement.style.overflow = 'hidden';
    rootElement.style.position = 'fixed';
    rootElement.style.paddingRight = `${scrollBarWidth}px`;
    modalElement.style.paddingRight = `${scrollBarWidth}px`;
    header.element.style.right = `${scrollBarWidth}px`;

    header.setUiWhite();
    header.overlapDetect.pause();

    mainMenu.isAnimated = true;

    switch (windowName) {
      case 'content':
        mainMenu._showContents();
        break;

      case 'search':
        mainMenu._showSearch();
        break;
    }

    const tl = new TimelineMax({
      onComplete: () => {
        mainMenu.isOpen = true;
      }
    });
    tl.set(mainMenu.element, {opacity: 0, display: 'block'})
      .set(menu, {y: -40, opacity: 0})
      .to(mainMenu.element, .3, {opacity: 1, clearProps: 'opacity'});
  }
};

mainMenu._showContents = (delay = 0) => {
  mainMenu.openWindowName = 'contents';

  const tl = new TimelineMax({
    onComplete: () => {
      mainMenu.isAnimated = false;
    }
  });
  tl.set(submenu, {y: -20, opacity: 0})
    .set(menu, {y: -20, opacity: 0})
    .set(modalContentsElement, {display: 'block'})
    .to(submenu, .3, {y: 0, opacity: 1, clearProps: 'y, opacity'}, `+=${delay / 1000}`)
    .to(menu, .3, {y: 0, opacity: 1, clearProps: 'y, opacity'}, '-=.1');

};

mainMenu._hideContents = () => {
  const tl = new TimelineMax({
    onComplete: () => {
      mainMenu.isAnimated = false;
    }
  });
  tl.set(submenu, {y: 0, opacity: 1})
    .set(menu, {y: 0, opacity: 1})
    .to(submenu, .3, {y: -20, opacity: 0})
    .to(menu, .3, {y: -20, opacity: 0}, '-=.3')
    .set(modalContentsElement, {clearProps: 'display'})
    .set([submenu], {clearProps: 'y, opacity'})
    .set([menu], {clearProps: 'y, opacity'});
};

mainMenu._showSearch = (delay = 0) => {
  mainMenu.openWindowName = 'search';

  const tl = new TimelineMax({
    onComplete: () => {
      mainMenu.isAnimated = false;
      searchInputElement.focus();
    }
  });

  setTimeout(() => {
    tl.set(searchFormElement, {x: '100%'})
      .set(searchFormSubmit, {opacity: 0})
      .set(searchElements, {y: 20, opacity: 0})
      .set(modalSearchElement, {display: 'block'})
      .set(header.submenuElement, {opacity: 1});

    if (!isMobile) {
      tl.set(mainMenu.searchButtonElement, {
        right: 'auto',
        left: `${mainMenu.searchButtonElement.getBoundingClientRect().left}px`
      });
    }

    tl.to(header.submenuElement, .3, {opacity: 0}, `+=${delay / 1000}`);

    if (!isMobile) {
      tl.to(mainMenu.searchButtonElement, .3, {
        left: `${searchWrapperElement.getBoundingClientRect().left}px`
      });
    }

    tl.to(searchFormElement, .3, {x: '0%', clearProps: 'x'}, '-=.3')
      .to(searchFormSubmit, .3, {opacity: 1, clearProps: 'opacity'})
      .set(header.submenuElement, {display: 'none'});

    searchElements.forEach(menuItem => {
      tl.to(menuItem, .3, {y: 0, opacity: 1, clearProps: 'y, opacity'}, '-=.1');
    });
  }, 0);
};

mainMenu._hideSearch = () => {
  const tl = new TimelineMax({
    onComplete: () => {
      mainMenu.isAnimated = false;
    }
  });

  tl.set([searchElements, searchFormElement], {y: 0, opacity: 1});

  if (!isMobile) {
    tl.set(mainMenu.searchButtonElement, {y: 0, opacity: 1});
  }

  tl.set(header.submenuElement, {clearProps: 'display'})
    .to(header.submenuElement, .3, {opacity: 1, clearProps: 'all'})
    .to([searchElements, searchFormElement], .3, {y: -20, opacity: 0}, '-=.3');

  if (!isMobile) {
    tl.to(mainMenu.searchButtonElement, .3, {y: -20, opacity: 0, clearProps: 'y, left, right'}, '-=.3')
      .to(mainMenu.searchButtonElement, .3, {opacity: 1, clearProps: 'all'});
  }

  tl.set([searchElements, searchFormElement], {clearProps: 'y, opacity'})
    .set(modalSearchElement, {clearProps: 'display'});
};

mainMenu.close = () => {
  if (mainMenu.isOpen && !mainMenu.isAnimated) {
    mainMenu.buttonElement.classList.remove(buttonCrossClass);

    mainMenu.isAnimated = false;

    switch (mainMenu.openWindowName) {
      case 'contents':
        mainMenu._hideContents();
        break;

      case 'search':
        mainMenu._hideSearch();
        break;
    }

    const tl = new TimelineMax({
      onComplete: () => {
        mainMenu.isOpen = false;

        header.overlapDetect.update();
        header.overlapDetect.play();

        rootElement.style.overflow = '';
        rootElement.style.position = '';
        rootElement.style.paddingRight = '';
        modalElement.style.paddingRight = '';
        header.element.style.right = '';
      }
    });
    tl.set(mainMenu.element, {opacity: 1})
      .to(mainMenu.element, .3, {opacity: 0, display: 'none', clearProps: 'opacity'});
  }
};

export {mainMenu};
