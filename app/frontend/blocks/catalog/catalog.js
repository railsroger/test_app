import StickySidebar from 'vendor/sticky-sidebar';
import queryString from 'query-string';

const searchLinks = Array.prototype.slice.call(document.querySelectorAll('.catalog__search-link'));
const searchElement = document.querySelector('#catalog-search');
const kindElement = document.querySelector('#catalog-category-id');

if (kindElement) {
  kindElement.value = queryString.parse(location.search).category_id;
}

searchLinks.forEach(link => {
  link.addEventListener('click', e => {
    e.preventDefault();

    const query = queryString.parse(link.getAttribute('href'));

    query.s = searchElement.getAttribute('value');

    location.href = `${location.pathname}?${queryString.stringify(query)}`;
  });
});

document.addEventListener('DOMContentLoaded', () => {
  const sidebar = document.querySelector('.catalog__filter');

  if (sidebar) {
    const stickySidebar = new StickySidebar('.catalog__filter'); // eslint-disable-line
  }
});
