function isMobile() {
  return window.matchMedia('only screen and (max-width: 46.9em)').matches;
}

module.exports = {
  isMobile: isMobile(),
  getIsMobile: isMobile
};
