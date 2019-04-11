import queryString from 'query-string';
import axios from 'axios';

const submitButton = document.querySelector('#catalog-result-button');
const query = queryString.parse(location.search);

Array.prototype.slice.call(document.querySelectorAll('#catalog-page select')).forEach(item => {
  item.addEventListener('choice', e => {
    const name = item.getAttribute('name');

    query[name] = e.detail.choice.value;
    query.count = 1;

    axios.get(`${location.pathname}?${queryString.stringify(query)}`)
      .then(response => {
        submitButton.value = response.data.count;
      });
  });
});
