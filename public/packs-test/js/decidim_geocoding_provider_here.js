/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/entrypoints/decidim_geocoding_provider_here.js":
/*!*********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/entrypoints/decidim_geocoding_provider_here.js ***!
  \*********************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_geocoding_provider_here__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/geocoding/provider/here */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/provider/here.js");


/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding.js":
/*!***********************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding.js ***!
  \***********************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_vendor_tribute__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/vendor/tribute */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/tribute.js");
/* harmony import */ var src_decidim_vendor_tribute__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_vendor_tribute__WEBPACK_IMPORTED_MODULE_0__);

$(function () {
  $("[data-decidim-geocoding]").each(function (_i, el) {
    var $input = $(el);
    var $fieldContainer = $input.parent();
    $fieldContainer.addClass("has-tribute");
    var tribute = new (src_decidim_vendor_tribute__WEBPACK_IMPORTED_MODULE_0___default())({
      autocompleteMode: true,
      // autocompleteSeparator: / \+ /, // See below, requires Tribute update
      allowSpaces: true,
      positionMenu: false,
      replaceTextSuffix: "",
      menuContainer: $fieldContainer.get(0),
      noMatchTemplate: null,
      values: function values(text, cb) {
        $input.trigger("geocoder-suggest.decidim", [text, cb]);
      }
    }); // Port https://github.com/zurb/tribute/pull/406
    // This changes the autocomplete separator from space to " + " so that
    // we can do searches such as "streetname 4" including a space. Otherwise
    // this would do two separate searches for "streetname" and "4".

    tribute.range.getLastWordInText = function (text) {
      var _final = text.replace(/\u00A0/g, " ");

      var wordsArray = _final.split(/ \+ /);

      var worldsCount = wordsArray.length - 1;
      return wordsArray[worldsCount].trim();
    };

    tribute.attach($input.get(0));
    $input.on("tribute-replaced", function (ev) {
      var selectedItem = ev.detail.item.original;
      $input.trigger("geocoder-suggest-select.decidim", [selectedItem]); // Not all geocoding autocomplete APIs include the coordinates in the
      // suggestions response. Therefore, some APIs may require additional
      // query for the coordinates, which should trigger this event for the
      // input element.

      if (selectedItem.coordinates) {
        $input.trigger("geocoder-suggest-coordinates.decidim", [selectedItem.coordinates]);
      }
    });
    $input.data("geocoder-tribute", tribute);
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/format_address.js":
/*!**************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/format_address.js ***!
  \**************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ formatAddress; }
/* harmony export */ });
/* eslint-disable require-jsdoc */
// If you want to customize the geocoder address format which is displayed
// when showing the geocoding results list, add this configuration code to
// your geocoder at config/initializers/decidim.rb:
// config.maps = {
//   # ... other configs ...
//   autocomplete: {
//     address_format: [%w(street houseNumber), "city", "country"]
//   }
// }
//
// For the available address keys, refer to the provider's own documentation.
var compact = function compact(items) {
  return items.filter(function (part) {
    return part !== null && typeof part !== "undefined" && "".concat(part).trim().length > 0;
  });
};

function formatAddress(object, keys) {
  var separator = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : ", ";
  var parts = keys.map(function (key) {
    if (Array.isArray(key)) {
      return formatAddress(object, key, " ");
    }

    return object[key] || object[key.toLowerCase()];
  });
  return compact(parts).join(separator).trim();
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/provider/here.js":
/*!*************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/provider/here.js ***!
  \*************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_geocoding__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/geocoding */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding.js");
/* harmony import */ var src_decidim_geocoding_format_address__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/geocoding/format_address */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/format_address.js");


/**
 * For the available address format keys, refer to:
 * https://developer.here.com/documentation/geocoder-autocomplete/dev_guide/topics/resource-type-response-suggest.html
 */

$(function () {
  var generateAddressLabel = src_decidim_geocoding_format_address__WEBPACK_IMPORTED_MODULE_1__["default"];
  $("[data-decidim-geocoding]").each(function (_i, el) {
    var $input = $(el);
    var config = $input.data("decidim-geocoding");
    var queryMinLength = config.queryMinLength || 2;
    var addressFormat = config.addressFormat || [["street", "houseNumber"], "district", "city", "county", "state", "country"];
    var language = $("html").attr("lang");
    var currentSuggestionQuery = null;

    if (!config.apiKey || config.apiKey.length < 1) {
      return;
    }

    $input.on("geocoder-suggest.decidim", function (_ev, query, callback) {
      clearTimeout(currentSuggestionQuery); // Do not trigger API calls on short queries

      if ("".concat(query).trim().length < queryMinLength) {
        return;
      }

      currentSuggestionQuery = setTimeout(function () {
        $.ajax({
          method: "GET",
          url: "https://autocomplete.geocoder.ls.hereapi.com/6.2/suggest.json",
          data: {
            apiKey: config.apiKey,
            query: query,
            language: language
          },
          dataType: "json"
        }).done(function (resp) {
          if (resp.suggestions) {
            return callback(resp.suggestions.map(function (item) {
              var label = generateAddressLabel(item.address, addressFormat);
              return {
                key: label,
                value: label,
                locationId: item.locationId
              };
            }));
          }

          return null;
        });
      }, 200);
    });
    $input.on("geocoder-suggest-select.decidim", function (_ev, selectedItem) {
      $.ajax({
        method: "GET",
        url: "https://geocoder.ls.hereapi.com/6.2/geocode.json",
        data: {
          apiKey: config.apiKey,
          gen: 9,
          jsonattributes: 1,
          locationid: selectedItem.locationId
        },
        dataType: "json"
      }).done(function (resp) {
        if (!resp.response || !Array.isArray(resp.response.view) || resp.response.view.length < 1) {
          return;
        }

        var view = resp.response.view[0];

        if (!Array.isArray(view.result) || view.result.length < 1) {
          return;
        }

        var result = view.result[0];
        var coordinates = [result.location.displayPosition.latitude, result.location.displayPosition.longitude];
        $input.trigger("geocoder-suggest-coordinates.decidim", [coordinates]);
      });
    });
  });
});

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
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = __webpack_modules__;
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/chunk loaded */
/******/ 	!function() {
/******/ 		var deferred = [];
/******/ 		__webpack_require__.O = function(result, chunkIds, fn, priority) {
/******/ 			if(chunkIds) {
/******/ 				priority = priority || 0;
/******/ 				for(var i = deferred.length; i > 0 && deferred[i - 1][2] > priority; i--) deferred[i] = deferred[i - 1];
/******/ 				deferred[i] = [chunkIds, fn, priority];
/******/ 				return;
/******/ 			}
/******/ 			var notFulfilled = Infinity;
/******/ 			for (var i = 0; i < deferred.length; i++) {
/******/ 				var chunkIds = deferred[i][0];
/******/ 				var fn = deferred[i][1];
/******/ 				var priority = deferred[i][2];
/******/ 				var fulfilled = true;
/******/ 				for (var j = 0; j < chunkIds.length; j++) {
/******/ 					if ((priority & 1 === 0 || notFulfilled >= priority) && Object.keys(__webpack_require__.O).every(function(key) { return __webpack_require__.O[key](chunkIds[j]); })) {
/******/ 						chunkIds.splice(j--, 1);
/******/ 					} else {
/******/ 						fulfilled = false;
/******/ 						if(priority < notFulfilled) notFulfilled = priority;
/******/ 					}
/******/ 				}
/******/ 				if(fulfilled) {
/******/ 					deferred.splice(i--, 1)
/******/ 					var r = fn();
/******/ 					if (r !== undefined) result = r;
/******/ 				}
/******/ 			}
/******/ 			return result;
/******/ 		};
/******/ 	}();
/******/ 	
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
/******/ 	/* webpack/runtime/jsonp chunk loading */
/******/ 	!function() {
/******/ 		// no baseURI
/******/ 		
/******/ 		// object to store loaded and loading chunks
/******/ 		// undefined = chunk not loaded, null = chunk preloaded/prefetched
/******/ 		// [resolve, reject, Promise] = chunk loading, 0 = chunk loaded
/******/ 		var installedChunks = {
/******/ 			"decidim_geocoding_provider_here": 0
/******/ 		};
/******/ 		
/******/ 		// no chunk on demand loading
/******/ 		
/******/ 		// no prefetching
/******/ 		
/******/ 		// no preloaded
/******/ 		
/******/ 		// no HMR
/******/ 		
/******/ 		// no HMR manifest
/******/ 		
/******/ 		__webpack_require__.O.j = function(chunkId) { return installedChunks[chunkId] === 0; };
/******/ 		
/******/ 		// install a JSONP callback for chunk loading
/******/ 		var webpackJsonpCallback = function(parentChunkLoadingFunction, data) {
/******/ 			var chunkIds = data[0];
/******/ 			var moreModules = data[1];
/******/ 			var runtime = data[2];
/******/ 			// add "moreModules" to the modules object,
/******/ 			// then flag all "chunkIds" as loaded and fire callback
/******/ 			var moduleId, chunkId, i = 0;
/******/ 			if(chunkIds.some(function(id) { return installedChunks[id] !== 0; })) {
/******/ 				for(moduleId in moreModules) {
/******/ 					if(__webpack_require__.o(moreModules, moduleId)) {
/******/ 						__webpack_require__.m[moduleId] = moreModules[moduleId];
/******/ 					}
/******/ 				}
/******/ 				if(runtime) var result = runtime(__webpack_require__);
/******/ 			}
/******/ 			if(parentChunkLoadingFunction) parentChunkLoadingFunction(data);
/******/ 			for(;i < chunkIds.length; i++) {
/******/ 				chunkId = chunkIds[i];
/******/ 				if(__webpack_require__.o(installedChunks, chunkId) && installedChunks[chunkId]) {
/******/ 					installedChunks[chunkId][0]();
/******/ 				}
/******/ 				installedChunks[chunkId] = 0;
/******/ 			}
/******/ 			return __webpack_require__.O(result);
/******/ 		}
/******/ 		
/******/ 		var chunkLoadingGlobal = self["webpackChunkapp"] = self["webpackChunkapp"] || [];
/******/ 		chunkLoadingGlobal.forEach(webpackJsonpCallback.bind(null, 0));
/******/ 		chunkLoadingGlobal.push = webpackJsonpCallback.bind(null, chunkLoadingGlobal.push.bind(chunkLoadingGlobal));
/******/ 	}();
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module depends on other loaded chunks and execution need to be delayed
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-core_app_-35a28b"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/entrypoints/decidim_geocoding_provider_here.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_geocoding_provider_here.js.map