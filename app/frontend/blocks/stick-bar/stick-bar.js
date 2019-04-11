import StickySidebar from 'vendor/sticky-sidebar';

import throttle from '../../helpers/throttle';

document.addEventListener('DOMContentLoaded', () => {
  const sidebar = document.querySelector('.stick-bar');
  const sidebarInner = document.querySelector('.stick-bar__inner');

  if (sidebar) {
    const setSidebarHeight = () => {
      sidebar.style.minHeight = `${sidebarInner.offsetHeight}px`;
    };

    const onWindowResize = throttle(() => {
      setSidebarHeight();
    }, 300);

    setSidebarHeight();

    const stickySidebar = new StickySidebar('.stick-bar'); // eslint-disable-line

    window.addEventListener('resize', onWindowResize);

    window.addEventListener('load', () => {
      stickySidebar.updateSticky();
    });
  }
});
