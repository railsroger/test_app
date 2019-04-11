import queryString from 'query-string';

const searchLinks = Array.prototype.slice.call(document.querySelectorAll('.downloads__search-link'));
const searchElement = document.querySelector('#downloads-search');
const kindElement = document.querySelector('#downloads-kind');

if (kindElement && queryString.parse(location.search).kind) {
  kindElement.value = queryString.parse(location.search).kind;
}

searchLinks.forEach(link => {
  link.addEventListener('click', e => {
    e.preventDefault();

    const query = queryString.parse(link.getAttribute('href'));

    query.s = searchElement.getAttribute('value');

    location.href = `${location.pathname}?${queryString.stringify(query)}`;
  });
});
