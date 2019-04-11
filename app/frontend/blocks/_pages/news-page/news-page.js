Array.prototype.slice.call(document.querySelectorAll('#news-page select')).forEach(item => {
  item.addEventListener('choice', e => {
    location.href = `${location.pathname}${e.detail.choice.value}`;
  });
});
