import smoothscroll from 'smoothscroll-polyfill';

const scrollElement = document.querySelector('body');

smoothscroll.polyfill();

Array.prototype.slice.call(document.querySelectorAll('a')).forEach(linkElement => {
  const href = linkElement.attributes.href
    ? linkElement.attributes.href.value
    : null;

  if (href && href[0] === '#' && href.length > 1) {
    const element = document.querySelector(href);

    if (element) {
      linkElement.addEventListener('click', e => {
        e.preventDefault();

        const offsetElement = document.querySelector(linkElement.getAttribute('data-offset-selector'));
        const offsetTop = element.getBoundingClientRect().top - scrollElement.getBoundingClientRect().top;

        let scrollOffset = 0;

        if (offsetElement) {
          scrollOffset = offsetElement.offsetHeight - 1;
        }

        window.scroll({
          top: offsetTop - scrollOffset,
          left: 0,
          behavior: 'smooth'
        });
      });
    }
  }
});
