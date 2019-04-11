const elements = Array.prototype.slice.call(document.querySelectorAll('.input-textarea__input'));

const onKeyUp = e => {
  const element = e.target;
  const elementHeight = element.offsetHeight;
  const textLength = element.textLength;

  if (element.scrollHeight > elementHeight) {
    element.removeAttribute('style');
    element.style.height = `${element.scrollHeight + 10}px`;
  }

  this.scrollHeight = elementHeight;
  this.textLength = textLength;
};

elements.forEach(item => {
  item.addEventListener('keyup', onKeyUp);
});
