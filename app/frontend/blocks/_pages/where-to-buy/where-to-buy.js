import L from 'leaflet';
import StickySidebar from 'vendor/sticky-sidebar';

import {fadeIn, fadeOut} from 'helpers/animations';
import {getIsMobile} from 'helpers/layoutHelper';

const mobileControls = Array.prototype.slice.call(document.querySelectorAll('.where-to-buy__mobile-control'));
const buyListElement = document.querySelector('.where-to-buy__list');

let savedIsMobile = getIsMobile();
let markersList = null;

const mapMarkers = [];

if (typeof markersListData !== 'undefined') { // eslint-disable-line
  markersList = markersListData; // eslint-disable-line
}

const mapElement = document.querySelector('.where-to-buy__map');
const mapElementWrapper = document.querySelector('.where-to-buy__map-wrapper');

const checkVisibleLayout = () => {
  if (getIsMobile()) {
    mobileControls.forEach(button => {
      button.classList.remove('active');
    });

    mobileControls[0].classList.add('active');

    mapMarkers.forEach(item => {
      item.setOpacity(0);
    });
  } else {
    fadeIn(buyListElement);
    mapMarkers.forEach(item => {
      item.setOpacity(1);
    });
  }
};

if (mapElement && markersList) {
  const map = L.map(mapElement, {
    zoomControl: false,
    minZoom: 4,
    maxZoom: 14
  });

  const bounds = markersList.map(item => item.coordinates);
  const leftPosition = document.querySelector('.where-to-buy__content').getBoundingClientRect().left + 220;

  const fitBounds = () => {
    map.fitBounds(bounds, {
      paddingTopLeft: getIsMobile()
        ? [40, 40]
        : [leftPosition, 200],
      paddingBottomRight: getIsMobile()
        ? [150, 40]
        : [150, 60]
    });
  };

  mobileControls.forEach(item => {
    item.addEventListener('click', () => {
      mobileControls.forEach(button => {
        button.classList.remove('active');
      });

      item.classList.add('active');

      switch (item.getAttribute('data-value')) {
        case 'buy':
          fadeIn(buyListElement);

          mapMarkers.forEach(marker => {
            marker.setOpacity(0);
          });

          break;

        case 'stores':
          fadeOut(buyListElement);
          fitBounds();

          mapMarkers.forEach(marker => {
            marker.setOpacity(1);
          });

          break;
      }
    });

    window.addEventListener('resize', () => {
      const isMobile = getIsMobile();

      if (savedIsMobile !== isMobile) {
        savedIsMobile = isMobile;

        checkVisibleLayout();
      }
    });
  });

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  const getIcon = markerData => L.divIcon({
    iconSize: [16, 16],
    className: 'where-to-buy__marker',
    html: `
        <div class="where-to-buy__marker-icon" style="background: ${markerData.color}"></div>
        <div class="where-to-buy__marker-title">${markerData.title}</div>
    `
  });

  markersList.forEach(item => {
    L.marker(item.coordinates, {
      icon: getIcon(item)
    }).addTo(map);
  });

  map.eachLayer(layer => {
    if (layer.options.icon) {
      mapMarkers.push(layer);
    }
  });

  fitBounds();
  checkVisibleLayout();

  const stickySidebar = new StickySidebar(mapElementWrapper); // eslint-disable-line
}
