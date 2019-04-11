import {topMenu} from '../top-menu/top-menu';
import {mainMenu} from '../main-menu/main-menu';

import OverlapDetect from '../../helpers/overlapDetect';

const headerElement = document.querySelector('.header');

const header = {
  element: headerElement,
  submenuElement: document.querySelector('.header__menu-wrapper'),
  setUiWhite: () => {
    headerElement.classList.remove('header_ui_black');
    headerElement.classList.add('header_ui_white');
  },
  setUiDark: () => {
    headerElement.classList.remove('header_ui_white');
    headerElement.classList.add('header_ui_black');
  }
};

header.overlapDetect = new OverlapDetect({
  target: headerElement,
  wrapper: window,
  selectors: [
    '[data-ui-white]'
  ],
  onEnter: () => {
    header.setUiWhite();
  },
  onLeave: () => {
    if (!mainMenu.isOpen) {
      header.setUiDark();
    }
  }
});

document.addEventListener('DOMContentLoaded', () => {
  header.overlapDetect.run();

  const headerMenuItems = Array.prototype.slice.call(document.querySelectorAll('[data-header-menu-item]'));

  headerMenuItems.forEach(item => {
    const id = item.getAttribute('data-header-menu-item');

    item.addEventListener('mouseenter', () => {
      if (!mainMenu.isOpen) {
        topMenu.open(id);
      }
    });
  });
});

export {header};
