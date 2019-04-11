import {slideIn, slideOut} from 'helpers/animations';

const collapseElements = Array.prototype.slice.call(document.querySelectorAll('.collapse-list__item'));
const activeClassName = 'collapse-list__item_opened';

collapseElements.forEach(collapseElement => {
  const button = collapseElement.querySelector('.collapse-list__head');
  const targetBodyElement = collapseElement.querySelector('.collapse-list__body');

  button.addEventListener('click', () => {
    if (collapseElement.classList.contains(activeClassName)) {
      collapseElement.classList.remove(activeClassName);
      slideOut(targetBodyElement);
    } else {
      slideIn(targetBodyElement);
      collapseElement.classList.add(activeClassName);
    }
  });
});
