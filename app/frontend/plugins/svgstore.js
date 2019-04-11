const __svg__ = {path: '../assets/icons/*.svg', name: '[hash].logos.svg'}; // eslint-disable-line
require('webpack-svgstore-plugin/src/helpers/svgxhr')(__svg__);
