import queryString from 'query-string';

let params = queryString.parse(location.search);

if (params.back && history) {
  params.back = undefined; // eslint-disable-line
  params = queryString.stringify(params);
  params = params
    ? `?${params}`
    : '';

  history.pushState(null, null, `${location.origin}${location.pathname}${params}`);
}
