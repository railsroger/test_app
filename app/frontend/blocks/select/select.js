import Choices from 'choices.js';

const selects = {
  elements: [],
  overlayElement: document.querySelector('.select__overlay'),
  _tl: new TimelineMax()
};

Array.prototype.slice.call(document.querySelectorAll('.select__input')).forEach(item => {
  selects.elements.push({
    element: item,
    isOpen: false
  });
});

selects.elements.forEach((item, index) => {
  const choices = new Choices(item.element, {  // eslint-disable-line
    searchEnabled: false,
    shouldSort: false
  });

  choices.passedElement.addEventListener('showDropdown', () => {
    selects.showDropdown(index);
  }, false);

  choices.passedElement.addEventListener('hideDropdown', () => {
    setTimeout(() => {
      selects.hideDropdown(index);
    }, 10);
  }, false);
});

selects.showDropdown = index => {
  const someIsOpen = selects.elements.some(item => item.isOpen);

  if (!someIsOpen) {
    selects.showOverlay();
  }

  selects.elements[index].isOpen = true;
};

selects.hideDropdown = index => {
  selects.elements[index].isOpen = false;

  const someIsOpen = selects.elements.some(item => item.isOpen);

  if (!someIsOpen) {
    selects.hideOverlay();
  }
};

selects.showOverlay = () => {
  selects._tl
    .clear()
    .set(selects.overlayElement, {opacity: 0, display: 'block', transition: 'none'})
    .to(selects.overlayElement, .3, {opacity: 1});
};

selects.hideOverlay = () => {
  selects._tl
    .clear()
    .set(selects.overlayElement, {opacity: 1, transition: 'none'})
    .to(selects.overlayElement, .3, {opacity: 0, display: 'none'});
};
