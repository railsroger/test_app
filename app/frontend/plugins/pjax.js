/* eslint-disable */

/* !
 * pjax => pushState + ajax
 * Marten Schilstra <info@martndemus.nl>
 *
 * Based upon:
 * jquery.pjax by Chris Wanstrath
 * https://github.com/defunkt/jquery-pjax
 */

(function () {
  'use strict';

  const pjax = {};

  /*
   * Attaches a pjax handler on the specified anchortag(s)
   * An anchortag with an pjax handler will initialy prevent the default
   * action of the tag, instead it will fetch the specified url with an
   * ajax request and place the result into the specified container.
   *
   * If the browser does not support pushState, this function will not
   * attach any event listeners and thus anchortags will act like normal.
   *
   * The argument anchortag should be a single HTMLAnchorElement or an array
   * of HTMLAnchorElements.
   *
   * The options argument should be an object with some options to fine tune
   * the pjax handler. An example:
   *  {
   *    // The id of an HTMLElement where the fetched body should be placed into.
   *    // Required!
   *    container: document.getElementById('content'),
   *
   *    // Replacement url to get instead of the url from the href property
   *    // of the AnchorElement. Optional. You can also set the property
   *    // data-pjax of the AnchorElement with an url for the same effect.
   *    // The data-pjax property takes presedence over others.
   *    target: "/pjax/url.html",
   *
   *    // A function that will be called with the responseText of the ajax
   *    // as argument, called before the content is inserted into the dom.
   *    // Whatever the function returns is going to be used instead of the
   *    // responseText.
   *    preprocessor: myPreprocessFunction,
   *
   *    // Default true, set to false to not use pushState at all.
   *    changeState: true,
   *
   *    // Default "pushState", a string with the name of the history state
   *    // function to use. E.g. "replaceState" will use history.replaceState
   *    typeState: "pushState"
   *
   *    // Additional headers that you want to send along with the request
   *    // Being made by the pjax request
   *    headers: {
   *          headerOne: "abc123",
   *          headetTwo: "false"
   *    }
   *  }
   */
  pjax.set = function (anchorElement, options) {
    let i;

    // Both arguments are required so stop if one isn't supplied.
    if (!(anchorElement && options))
    {return false;}

    // Also stop if the browser has no support for pushState
    if (!pjax.support)
    {return false;}

    // Cast anchorElement to an array if it's not an nodeList or Array
    if (!anchorElement.length)
    {anchorElement = [anchorElement];}

    // Add the pjaxHandler to each of the supplied elements
    for (i = 0; i < anchorElement.length; i++) {
      anchorElement[i].addEventListener('click', function (e) {
        pjaxHandler.call(this, e, options);
      });
    }
  };

  /*
   * Loads the target url with an ajax request, the reponse will then first
   * be supplied to the preprocessor (if present) and then finally puts the
   * result from the preprocessor into the specified container.
   *
   * The options argument should be an object with some options to fine tune
   * the pjax request. See the pjax.set method comments for an example.
   * Note that target is now required!
   */
  pjax.get = function (options) {
    let xhr;

    // Call an external function to set the defaults for the options object
    options = setOptionDefaults(options);

    // If the required options aren't set, then stop / return failure
    if (!(options.container && options.target))
    {return false;}

    // Create the state object
    const state = {
      url: options.url,
      pjax: options.target,
      container: options.container
    };

    // Create the xhr
    xhr = XHR({
      url: options.target,
      header: options.headers
    },
      // Callback function on the xhr
    function (error, response) {
      if (error)
      {return false;}

      // feed the response throug the preprocessor if present.
      if (options.preprocessor)
      {response = options.preprocessor(response);}

      // Do the push/replaceState
      if (options.changeState === true) {
        history[options.typeState](state, '', state.url);
      }

      // Insert the response into the container
      document.getElementById(options.container).innerHTML = response;

      if (options.callback) {options.callback();}
    });

    // If the xhr is succesfully made, then return true
    if (xhr)
    {return true;}
  };

  /*
   * Handling the popstate, this the event that happens when the client
   * hits the back/forward button towards a page in the history that has been
   * added with the history api.
   */
  let initpop = false;
  window.onpopstate = function (event) {
    const state = event.state;

    if (state === null && initpop === false){
      initpop = true;
      return;
    }

    if (state && state.pjax) {
      pjax.get({
        url: state.url,
        container: state.container,
        target: state.pjax,
        changeState: false
      });
    }

    else
    {window.location = location.href;}
  };

  /*
   *  Checks if the browser supports pushState
   *  iife that sets this variable to true if the browser supports pushState
   *  otherwise it will be false.
   */
  pjax.support = (function (){
    return !!(window.history && history.pushState);
  }());

  /*
   *  Handles what happens when a client clicks on a pjax enabled link
   *  If it's unsuccesfull the default action should be done
   */
  var pjaxHandler = function (event, options) {
    // Ignore middle clicks and cmd/ctrl + clicks
    if (event.which > 1 || event.metaKey || event.ctrlKey)
    {return;}

    // Data-pjax attribute takes presedence over the target set in options
    // If it's not set, first check for a target in options, else set the
    // href url as target
    if (this.hasAttribute('data-pjax'))
    {options.target = this.getAttribute('data-pjax');}
    else if (!options.target)
    {options.target = this.href;}

    // Save the original url from the href
    options.url = this.href;

    // Try to do the pjax magic, if it is succesful, prevent default action.
    if (pjax.get(options)) {
      event.preventDefault();
      return false;
    }
  };

  /*
   *  Set the defaults for the options object of the pjax function
   */
  var setOptionDefaults = function (options) {
    options = options || {};

    // Set changeState default
    if (typeof (options.changeState) !== 'boolean')
    {options.changeState = true;}

    // Set typeState default
    if (!options.typeState)
    {options.typeState = 'pushState';}

    // Add the pjax header to the headers
    if (!options.headers)
    {options.headers = {'X-PJAX': 'true'};}
    else
    {options.headers['X-PJAX'] = 'true';}

    return options;
  };

  /*
   *  This function automates a few things around the XMLHttpRequest.
   *  It takes the following object as req(uest)
   *
   *  {
   *      method: 'GET',                          // Default = 'GET'
   *      url:  http://someurl.com/script         // Url to retrieve.
   *      async: true,                            // Default = true
   *      header: { "headername" : content }      // Object with name value pairs of headers
   *      data:  < some data >                    // Data to send with method = 'post'
   *  }
   *
   *  If a callback function is specified, it will execute that function when the full
   *  request result has been loaded. It will supply the arguments error and response
   *  to the callback.
   */
  var XHR = function (req, callback) {
    let xhr, name;

    // Set defaults
    if (!req.method) {
      req.method = 'GET';
    }

    if (req.async === undefined) {
      req.async = true;
    }

    // Create new XHR
    xhr = new XMLHttpRequest();

    // Open the request with given params
    xhr.open(req.method, req.url, req.async);

    // Set headers (if available)
    if (req.header) {
      for (name in req.header) {
        if (req.header.hasOwnProperty(name)) {
          xhr.setRequestHeader(name, req.header[name]);
        }
      }
    }

    // Fire callback when the request is complete
    if (callback) {
      xhr.addEventListener( 'readystatechange', function (e) {
        if (xhr.readyState === 4) {
          // When everything went fine
          if (xhr.status === 200) {
            callback(undefined, xhr.responseText);
          }
          // If it went bad!
          else {
            callback({
              status: xhr.status,
              statusText: xhr.statusText
            }, xhr.responseText);
          }
        }
      });
    }

    // Send request to server
    if (req.data && xhr.method === 'POST') {
      xhr.send(req.data);
    }
    else {
      xhr.send();
    }

    return xhr;
  };

  window.pjax = pjax;
}());
