/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images sync recursive ^\\.\\/.*$":
/*!*******************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images/ sync ^\.\/.*$ ***!
  \*******************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

var map = {
	"./decidim/decidim_dev_dummy.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images/decidim/decidim_dev_dummy.svg",
	"./decidim/gamification/badges/decidim_gamification_badges_test.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_test.svg"
};


function webpackContext(req) {
	var id = webpackContextResolve(req);
	return __webpack_require__(id);
}
function webpackContextResolve(req) {
	if(!__webpack_require__.o(map, req)) {
		var e = new Error("Cannot find module '" + req + "'");
		e.code = 'MODULE_NOT_FOUND';
		throw e;
	}
	return map[req];
}
webpackContext.keys = function webpackContextKeys() {
	return Object.keys(map);
};
webpackContext.resolve = webpackContextResolve;
module.exports = webpackContext;
webpackContext.id = "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images sync recursive ^\\.\\/.*$";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/icon.js":
/*!******************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/icon.js ***!
  \******************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ icon; }
/* harmony export */ });
var DEFAULT_ATTRIBUTES = {
  role: "img",
  "aria-hidden": "true"
};
/**
 * Generates a Decidim icon element and returns it as a string.
 * @param {String} iconKey - the key of the icon to be generated
 * @param {Object} attributes - extra attributes to define for the icon SVG
 * @param {int} wait - number of milliseconds to wait before executing the function.
 * @private
 * @returns {Void} - Returns nothing.
 */

function icon(iconKey) {
  var attributes = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
  var iconAttributes = $.extend(DEFAULT_ATTRIBUTES, attributes);
  var title = iconAttributes.title || iconAttributes.ariaLabel;
  Reflect.deleteProperty(iconAttributes, "title");
  var htmlAttributes = {
    "class": "icon icon--".concat(iconKey)
  };
  Object.keys(iconAttributes).forEach(function (key) {
    // Convert the key to dash-format.
    var newKey = key.replace(/([A-Z])/g, function (ucw) {
      return "-".concat(ucw[0].toLowerCase());
    });

    if (typeof htmlAttributes[key] === "undefined") {
      htmlAttributes[newKey] = iconAttributes[key];
    } else {
      htmlAttributes[newKey] = "".concat(htmlAttributes[newKey], " ").concat(iconAttributes[key]);
    }
  });
  var iconsPath = window.Decidim.config.get("icons_path");
  var elHtml = "<svg><use href=\"".concat(iconsPath, "#icon-").concat(iconKey, "\"></use></svg>");
  var $el = $(elHtml);

  if (title) {
    $el.prepend("<title>".concat(title, "</title>"));
  } else {
    // This keeps accessibility audit tools happy
    $el.prepend("<title>".concat(iconKey, "</title>")); // Force hidden if title is not defined

    htmlAttributes["aria-hidden"] = "true";
  }

  $el.attr(htmlAttributes);
  return $("<div />").append($el).html();
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/entrypoints/decidim_dev.js":
/*!************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/entrypoints/decidim_dev.js ***!
  \************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var entrypoints_decidim_dev_scss__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! entrypoints/decidim_dev.scss */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/entrypoints/decidim_dev.scss");
/* harmony import */ var src_decidim_dev_accessibility__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/dev/accessibility */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/src/decidim/dev/accessibility.js");
// Images
__webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images sync recursive ^\\.\\/.*$"); // CSS





/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/src/decidim/dev/accessibility.js":
/*!******************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/src/decidim/dev/accessibility.js ***!
  \******************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var axe_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! axe-core */ "./node_modules/axe-core/axe.js");
/* harmony import */ var axe_core__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(axe_core__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_icon__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/icon */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/icon.js");



var positionIndicators = function positionIndicators() {
  $(".decidim-accessibility-indicator").each(function (_i, el) {
    var $indicator = $(el);
    var $target = $indicator.data("accessibility-target");
    var offset = $target.offset();
    $indicator.css({
      top: offset.top - 30,
      left: offset.left - 30
    });
  });
};

var moveScreenTo = function moveScreenTo($target) {
  // Scroll the view where the indicator is visible
  var targetTop = $target.offset().top;
  var screenHeight = $(window).height();
  var screenTop = $(window).scrollTop();
  var screenBottom = screenTop + screenHeight;

  if (targetTop < screenTop || targetTop > screenBottom) {
    $(window).scrollTop(targetTop - Math.round(screenHeight / 2));
  } // Scroll horizontally so that the element is visible (240 is the
  // accessibility sidebar width).


  var targetLeft = $target.offset().left;
  var screenWidth = $(window).width() - 240;
  var screenLeft = $(window).scrollLeft() + 240;
  var screenRight = screenLeft + screenWidth;

  if (targetLeft < screenLeft || targetLeft > screenRight) {
    $(window).scrollLeft(targetLeft - Math.round(screenWidth / 2));
  }
};

var htmlEncode = function htmlEncode(text) {
  return $("<div />").text(text).html();
};

$(function () {
  var $badge = $("\n    <div lang=\"en\" class=\"decidim-accessibility-badge\" tabindex=\"0\" aria-label=\"Toggle accessibility report\">\n      <div class=\"decidim-accessibility-title\">WAI WCAG</div>\n      <div class=\"decidim-accessibility-info\"></div>\n    </div>\n  ");
  var $report = $('<div lang="en" class="decidim-accessibility-report"></div>');
  var resizeTimeout = null;
  $(window).on("resize", function () {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(function () {
      positionIndicators();
    }, 500);
  });
  $badge.on("click", function () {
    $("body").toggleClass("decidim-accessibility-report-open");
    positionIndicators();
  });
  axe_core__WEBPACK_IMPORTED_MODULE_0___default().run().then(function (results) {
    $("body").prepend($report).prepend($badge);

    if (results.violations.length < 1) {
      $badge.addClass("decidim-accessibility-success");
      $(".decidim-accessibility-info", $badge).append((0,src_decidim_icon__WEBPACK_IMPORTED_MODULE_1__["default"])("check"));
      $report.append("\n        <div class=\"decidim-accessibility-report-item\">\n          <div class=\"decidim-accessibility-report-item-title\">\n            No accessibility violations found\n          </div>\n        </div>\n      ");
      return;
    }

    $badge.addClass("decidim-accessibility-violation");
    $(".decidim-accessibility-info", $badge).append((0,src_decidim_icon__WEBPACK_IMPORTED_MODULE_1__["default"])("warning")).append("\n      <span class=\"decidim-accessibility-info-amount\">\n        ".concat(results.violations.length, "\n      </span>\n    "));
    results.violations.forEach(function (violation) {
      var $item = $("\n        <div class=\"decidim-accessibility-report-item\" data-accessibility-violation-id=\"".concat(violation.id, "\">\n          <div class=\"decidim-accessibility-report-item-title\">\n            ").concat(violation.id, " - ").concat(htmlEncode(violation.help), "\n          </div>\n          <div class=\"decidim-accessibility-report-item-description\">\n            <div>Impact: ").concat(violation.impact, "</div>\n            <div>\n              ").concat(htmlEncode(violation.description), "\n            </div>\n            <div class=\"decidim-accessibility-report-item-nodes\">\n              Nodes:\n            </div>\n          </div>\n        </div>\n      "));
      var $violationNodes = $("<ul></ul>");
      $(".decidim-accessibility-report-item-nodes", $item).append($violationNodes);
      violation.nodes.forEach(function (node) {
        node.target.forEach(function (target) {
          // The selectors can have IDs starting with numbers which may not
          // be correctly indicated by axe. E.g. if the selector is `#123aa`,
          // axe might report it as `#\31 23aa`. It always adds `#\3` and a
          // space after the following number.
          var selector = target.replace(/#\\3([0-9]) /g, "#$1");
          var $target = $(selector);
          var $indicator = $("\n            <div class=\"decidim-accessibility-indicator\" aria-hidden=\"true\">".concat((0,src_decidim_icon__WEBPACK_IMPORTED_MODULE_1__["default"])("warning"), "</div>\n          "));
          $indicator.data("accessibility-target", $target);
          $target.data("accessibility-indicator", $indicator);
          $target.attr("data-accessibility-violation", true);
          $("body").append($indicator);
          var $link = $("<a href=\"#\">".concat(selector, "</a>"));
          $link.data("accessibility-target", $target);
          $violationNodes.append($("<li></li>").append($link));
          $indicator.on("click", function () {
            clearTimeout($item.data("blink-timeout"));
            clearTimeout($link.data("blink-timeout"));
            $item.addClass("decidim-accessibility-report-item-blink");
            $item.data("blink-timeout", setTimeout(function () {
              $item.removeClass("decidim-accessibility-report-item-blink");
            }, 1000));
            $link.addClass("decidim-accessibility-report-item-nodes-item-blink");
            $link.data("blink-timeout", setTimeout(function () {
              $link.removeClass("decidim-accessibility-report-item-nodes-item-blink");
            }, 1000));
          });
        });
      });
      $(".decidim-accessibility-report-item-nodes a", $item).on("click", function (ev) {
        ev.preventDefault();
        var $target = $(ev.target).data("accessibility-target");
        var $indicator = $target.data("accessibility-indicator");
        clearTimeout($indicator.data("blink-timeout"));
        moveScreenTo($target);
        setTimeout(function () {
          // From base color to blink color (1s)
          $indicator.addClass("decidim-accessibility-indicator-blink");
          $target.attr("data-accessibility-violation", "blink"); // From blink color to base color (1s)

          $indicator.data("blink-timeout", setTimeout(function () {
            $indicator.removeClass("decidim-accessibility-indicator-blink");
            $target.attr("data-accessibility-violation", true);
          }, 1000));
        }, 10);
      });
      $report.append($item);
    });
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/entrypoints/decidim_dev.scss":
/*!**************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/entrypoints/decidim_dev.scss ***!
  \**************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
// extracted by mini-css-extract-plugin


/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images/decidim/decidim_dev_dummy.svg":
/*!**********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images/decidim/decidim_dev_dummy.svg ***!
  \**********************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_dev_dummy-7c65732068c5ec7c313e.svg";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_test.svg":
/*!*********************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_test.svg ***!
  \*********************************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_gamification_badges_test-12369bee0baf637c42e9.svg";

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
/******/ 			id: moduleId,
/******/ 			loaded: false,
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
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
/******/ 	/* webpack/runtime/node module decorator */
/******/ 	!function() {
/******/ 		__webpack_require__.nmd = function(module) {
/******/ 			module.paths = [];
/******/ 			if (!module.children) module.children = [];
/******/ 			return module;
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/publicPath */
/******/ 	!function() {
/******/ 		__webpack_require__.p = "/packs-test/";
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
/******/ 			"decidim_dev": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["vendors-node_modules_axe-core_axe_js"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-dev/app/packs/entrypoints/decidim_dev.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_dev.js.map