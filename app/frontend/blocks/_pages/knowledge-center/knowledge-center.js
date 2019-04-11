Array.prototype.slice.call(document.querySelectorAll('#knowledge-center select')).forEach(item => {
  item.addEventListener('choice', e => {
    location.href = `${location.pathname}${e.detail.choice.value}`;
  });
});
