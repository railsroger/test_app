import {slideIn, slideOut} from 'helpers/animations';

const button = document.querySelector('.specs-list__button');
const moreBlock = document.querySelector('.specs-list__more');

if (button && moreBlock) {
  let isOpen = false;

  const onButtonClick = () => {
    if (isOpen) {
      slideOut(moreBlock);
      button.classList.remove('specs-list__button_opened');
    } else {
      slideIn(moreBlock);
      button.classList.add('specs-list__button_opened');
    }

    isOpen = !isOpen;
  };

  button.addEventListener('click', onButtonClick);
}
