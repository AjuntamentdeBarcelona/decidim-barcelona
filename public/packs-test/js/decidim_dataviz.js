/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./decidim-dataviz/app/packs/src/decidim/dataviz/dataviz.js":
/*!******************************************************************!*\
  !*** ./decidim-dataviz/app/packs/src/decidim/dataviz/dataviz.js ***!
  \******************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_vendor_jquery_browser__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/vendor/jquery.browser */ "./decidim-dataviz/app/packs/src/vendor/jquery.browser.js");
/* harmony import */ var src_vendor_jquery_browser__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_vendor_jquery_browser__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_vendor_jquery_iframe_auto_height__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/vendor/jquery-iframe-auto-height */ "./decidim-dataviz/app/packs/src/vendor/jquery-iframe-auto-height.js");
/* harmony import */ var src_vendor_jquery_iframe_auto_height__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(src_vendor_jquery_iframe_auto_height__WEBPACK_IMPORTED_MODULE_1__);


$(function () {
  $("iframe.autoheight").iframeAutoHeight({
    heightOffset: 150
  });
});

/***/ }),

/***/ "./decidim-dataviz/app/packs/src/vendor/jquery-iframe-auto-height.js":
/*!***************************************************************************!*\
  !*** ./decidim-dataviz/app/packs/src/vendor/jquery-iframe-auto-height.js ***!
  \***************************************************************************/
/***/ (function(module, exports) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;function _typeof(obj) {
  "@babel/helpers - typeof";

  return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
    return typeof obj;
  } : function (obj) {
    return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
  }, _typeof(obj);
}
/*! jquery-iframe-auto-height - v2.0.0
 *  Release on: 2015-06-28
 *  Copyright (c) 2015 Jesse House
 *  Licensed The Unlicense */


(function (root, factory) {
  if (true) {
    // AMD. Register as an anonymous module unless amdModuleId is set
    !(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function () {
      return factory();
    }).apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__),
		__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
  } else {}
})(this, function () {
  (function ($) {
    $.fn.iframeAutoHeight = function (spec) {
      var undef;

      if ($.browser === undef) {
        var message = [];
        message.push("WARNING: you appear to be using a newer version of jquery which does not support the $.browser variable.");
        message.push("The jQuery iframe auto height plugin relies heavly on the $.browser features.");
        message.push("Install jquery-browser: https://raw.github.com/house9/jquery-iframe-auto-height/master/release/jquery.browser.js");
        alert(message.join("\n"));
        return $;
      } // set default option values


      var options = $.extend({
        heightOffset: 0,
        minHeight: 0,
        maxHeight: 0,
        callback: function callback() {},
        animate: false,
        debug: false,
        diagnostics: false,
        // used for development only
        resetToMinHeight: false,
        triggerFunctions: [],
        heightCalculationOverrides: []
      }, spec); // logging

      function debug(message) {
        if (options.debug && options.debug === true && window.console) {
          console.log(message);
        }
      } // not used by production code


      function showDiagnostics(iframe, calledFrom) {
        debug("Diagnostics from '" + calledFrom + "'");

        try {
          debug("  " + $(iframe, window.parent).contents().find('body')[0].scrollHeight + " for ...find('body')[0].scrollHeight");
          debug("  " + $(iframe.contentWindow.document).height() + " for ...contentWindow.document).height()");
          debug("  " + $(iframe.contentWindow.document.body).height() + " for ...contentWindow.document.body).height()");
        } catch (ex) {
          // ie fails when called during for each, ok later on
          // probably not an issue if called in a document ready block
          debug("  unable to check in this state");
        }

        debug("End diagnostics -> results vary by browser and when diagnostics are requested");
      } // show all option values


      debug(options); // ******************************************************
      // iterate over the matched elements passed to the plugin ; return will make it chainable

      return this.each(function () {
        // ******************************************************
        // http://api.jquery.com/jQuery.browser/
        var strategyKeys = ['webkit', 'mozilla', 'msie', 'opera', 'chrome'];
        var strategies = {};

        strategies['default'] = function (iframe, $iframeBody, options) {
          // NOTE: this is how the plugin determines the iframe height, override if you need custom
          return $iframeBody[0].scrollHeight + options.heightOffset;
        };

        jQuery.each(strategyKeys, function (index, value) {
          // use the default strategy for all browsers, can be overridden if desired
          strategies[value] = strategies['default'];
        }); // override strategies if registered in options

        jQuery.each(options.heightCalculationOverrides, function (index, value) {
          strategies[value.browser] = value.calculation;
        });

        function findStrategy(browser) {
          var strategy = null;
          jQuery.each(strategyKeys, function (index, value) {
            if (browser[value]) {
              strategy = strategies[value];
              return false;
            }
          });

          if (strategy === null) {
            strategy = strategies['default'];
          }

          return strategy;
        } // ******************************************************
        // for use by webkit only


        var loadCounter = 0;
        var iframeDoc = this.contentDocument || this.contentWindow.document; // resizeHeight

        function resizeHeight(iframe) {
          if (options.diagnostics) {
            showDiagnostics(iframe, "resizeHeight");
          } // set the iframe size to minHeight so it'll get smaller on resizes in FF and IE


          if (options.resetToMinHeight && options.resetToMinHeight === true) {
            iframe.style.height = options.minHeight + 'px';
          } // get the iframe body height and set inline style to that plus a little


          var $body = $(iframe, window.parent).contents().find('body');
          var strategy = findStrategy($.browser);
          var newHeight = strategy(iframe, $body, options, $.browser);
          debug(newHeight);

          if (newHeight < options.minHeight) {
            debug("new height is less than minHeight");
            newHeight = options.minHeight;
          }

          if (options.maxHeight > 0 && newHeight > options.maxHeight) {
            debug("new height is greater than maxHeight");
            newHeight = options.maxHeight;
          }

          newHeight += options.heightOffset;
          debug("New Height: " + newHeight);

          if (options.animate) {
            $(iframe).animate({
              height: newHeight + 'px'
            }, {
              duration: 500
            });
          } else {
            iframe.style.height = newHeight + 'px';
          }

          options.callback.apply($(iframe), [{
            newFrameHeight: newHeight
          }]);
        } // END resizeHeight
        // debug me


        debug(this);

        if (options.diagnostics) {
          showDiagnostics(this, "each iframe");
        } // if trigger functions are registered, invoke them


        if (options.triggerFunctions.length > 0) {
          debug(options.triggerFunctions.length + " trigger Functions");

          for (var i = 0; i < options.triggerFunctions.length; i++) {
            options.triggerFunctions[i](resizeHeight, this);
          }
        } // Check if browser is Webkit (Safari/Chrome) or Opera


        if ($.browser.webkit || $.browser.opera || $.browser.chrome) {
          debug("browser is webkit (Safari/Chrome) or opera"); // Start timer when loaded.

          $(this).load(function () {
            var delay = 0;
            var iframe = this;

            var delayedResize = function delayedResize() {
              resizeHeight(iframe);
            };

            if (loadCounter === 0) {
              // delay the first one
              delay = 500;
            } else {
              // Reset iframe height to 0 to force new frame size to fit window properly
              // this is only an issue when going from large to small iframe, not executed on page load
              iframe.style.height = options.minHeight + 'px';
            }

            debug("load delay: " + delay);
            setTimeout(delayedResize, delay);
            loadCounter++;
          }); // Safari and Opera need a kick-start.

          var source = $(this).attr('src');
          $(this).attr('src', '');
          $(this).attr('src', source);
        } else {
          // For other browsers.
          if (iframeDoc.readyState === 'complete') {
            resizeHeight(this);
          } else {
            $(this).load(function () {
              resizeHeight(this);
            });
          }
        } // if browser

      }); // $(this).each(function () {
    }; // $.fn.iframeAutoHeight = function (options) {

  })(jQuery); // (function ($) {

});

/***/ }),

/***/ "./decidim-dataviz/app/packs/src/vendor/jquery.browser.js":
/*!****************************************************************!*\
  !*** ./decidim-dataviz/app/packs/src/vendor/jquery.browser.js ***!
  \****************************************************************/
/***/ (function() {

(function (jQuery) {
  var matched,
      userAgent = navigator.userAgent || ""; // Use of jQuery.browser is frowned upon.
  // More details: http://api.jquery.com/jQuery.browser
  // jQuery.uaMatch maintained for back-compat

  jQuery.uaMatch = function (ua) {
    ua = ua.toLowerCase();
    var match = /(chrome)[ \/]([\w.]+)/.exec(ua) || /(webkit)[ \/]([\w.]+)/.exec(ua) || /(opera)(?:.*version)?[ \/]([\w.]+)/.exec(ua) || /(msie) ([\w.]+)/.exec(ua) || ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+))?/.exec(ua) || [];
    return {
      browser: match[1] || "",
      version: match[2] || "0"
    };
  };

  matched = jQuery.uaMatch(userAgent);
  jQuery.browser = {};

  if (matched.browser) {
    jQuery.browser[matched.browser] = true;
    jQuery.browser.version = matched.version;
  } // Deprecated, use jQuery.browser.webkit instead
  // Maintained for back-compat only


  if (jQuery.browser.webkit) {
    jQuery.browser.safari = true;
  }
})(jQuery);

/***/ }),

/***/ "./decidim-dataviz/app/packs/stylesheets/decidim/dataviz/dataviz.scss":
/*!****************************************************************************!*\
  !*** ./decidim-dataviz/app/packs/stylesheets/decidim/dataviz/dataviz.scss ***!
  \****************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
// extracted by mini-css-extract-plugin


/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/compat get default export */
/******/ 	!function() {
/******/ 		// getDefaultExport function for compatibility with non-harmony modules
/******/ 		__webpack_require__.n = function(module) {
/******/ 			var getter = module && module.__esModule ?
/******/ 				function() { return module['default']; } :
/******/ 				function() { return module; };
/******/ 			__webpack_require__.d(getter, { a: getter });
/******/ 			return getter;
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/define property getters */
/******/ 	!function() {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = function(exports, definition) {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	!function() {
/******/ 		__webpack_require__.o = function(obj, prop) { return Object.prototype.hasOwnProperty.call(obj, prop); }
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	!function() {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = function(exports) {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	}();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be in strict mode.
!function() {
"use strict";
/*!******************************************************************!*\
  !*** ./decidim-dataviz/app/packs/entrypoints/decidim_dataviz.js ***!
  \******************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_dataviz_dataviz_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/dataviz/dataviz.js */ "./decidim-dataviz/app/packs/src/decidim/dataviz/dataviz.js");
/* harmony import */ var stylesheets_decidim_dataviz_dataviz_scss__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! stylesheets/decidim/dataviz/dataviz.scss */ "./decidim-dataviz/app/packs/stylesheets/decidim/dataviz/dataviz.scss");
 // CSS for compiling


}();
/******/ })()
;
//# sourceMappingURL=decidim_dataviz.js.map