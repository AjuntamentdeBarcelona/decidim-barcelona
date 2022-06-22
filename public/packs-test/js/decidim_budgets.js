/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/images sync recursive ^\\.\\/.*$":
/*!***********************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/images/ sync ^\.\/.*$ ***!
  \***********************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

var map = {
	"./decidim/budgets/decidim_budgets.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/images/decidim/budgets/decidim_budgets.svg"
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
webpackContext.id = "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/images sync recursive ^\\.\\/.*$";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/exit_handler.js":
/*!*************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/exit_handler.js ***!
  \*************************************************************************************************************************************************************/
/***/ (function() {

var currentAllocationZero = function currentAllocationZero() {
  var $budgetSummary = $(".budget-summary__progressbox");
  return parseInt($budgetSummary.attr("data-current-allocation"), 10) === 0;
};

var isSafeUrl = function isSafeUrl(exitUrl) {
  if (!exitUrl) {
    return false;
  }

  var safeUrls = [$(".budget-summary").attr("data-safe-url").split("?")[0], "".concat(location.pathname, "#"), "".concat(location.href, "#"), "#"];
  var safe = false;
  safeUrls.forEach(function (url) {
    if (exitUrl.startsWith(url)) {
      safe = true;
    }
  });
  return safe;
};

var allowExitFrom = function allowExitFrom($el) {
  if (currentAllocationZero()) {
    return true;
  } else if ($el.attr("target") === "_blank") {
    return true;
  } else if ($el.parents("#loginModal").length > 0) {
    return true;
  } else if ($el.parents("#authorizationModal").length > 0) {
    return true;
  } else if ($el.attr("id") === "exit-notification-link") {
    return true;
  } else if ($el.parents(".voting-wrapper").length > 0) {
    return true;
  } else if (isSafeUrl($el.attr("href"))) {
    return true;
  }

  return false;
}; // Don't show browser's default confirmation panel when visit current_path is called in tests.


var testReload = function testReload(initialLocation) {
  if (navigator && navigator.webdriver && initialLocation === location.href) {
    return true;
  }

  return false;
};

$(function () {
  var $exitNotification = $("#exit-notification");
  var $exitLink = $("#exit-notification-link");
  var defaultExitUrl = $exitLink.attr("href");
  var defaultExitLinkText = $exitLink.text();
  var exitLinkText = defaultExitLinkText;
  var initialLocation = location.href;

  if ($exitNotification.length < 1) {
    // Do not apply when not inside the voting pipeline
    return;
  }

  var openExitNotification = function openExitNotification(url) {
    var method = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : null;

    if (method && method !== "get") {
      $exitLink.attr("data-method", method);
    } else {
      $exitLink.removeAttr("data-method");
    }

    $exitLink.attr("href", url);
    $exitLink.html(exitLinkText);
    $exitNotification.foundation("open");
  }; // Handle "beforeunload"


  window.allowExit = false;
  $(document).on("click", "a", function (event) {
    exitLinkText = defaultExitLinkText;
    window.allowExit = false;
    var $link = $(event.currentTarget);

    if (allowExitFrom($link)) {
      window.allowExit = true;
    } else {
      event.preventDefault();
      openExitNotification($link.attr("href"), $link.data("method"));
    }
  }); // Custom handling for the header sign out so that it won't trigger the
  // logout form submit and so that it changes the exit link text. This does
  // not trigger the document link click listener because it has the
  // data-method attribute to trigger a form submit event.

  $(".header a.sign-out-link").on("click", function (event) {
    event.preventDefault();
    event.stopPropagation();
    var $link = $(event.currentTarget);
    exitLinkText = $link.text();
    openExitNotification($link.attr("href"), $link.data("method"));
  }); // Custom handling for the exit link which needs to change the exit link
  // text to the default text as this is not handled by the document click
  // listener.

  $("a[data-open='exit-notification']").on("click", function () {
    exitLinkText = defaultExitLinkText;
    openExitNotification(defaultExitUrl);
  }); // Allow all form submits on the page, including language change and sign
  // out form (when triggered by the exit link click).

  $(document).on("submit", "form", function () {
    window.allowExit = true;
  });
  window.addEventListener("beforeunload", function (event) {
    var allowExit = window.allowExit;
    window.allowExit = false;

    if (allowExit || testReload(initialLocation)) {
      return;
    }

    event.returnValue = true;
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/progressFixed.js":
/*!**************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/progressFixed.js ***!
  \**************************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var checkProgressPosition = function checkProgressPosition() {
    var progressFix = document.querySelector("[data-progressbox-fixed]"),
        progressRef = document.querySelector("[data-progress-reference]"),
        progressVisibleClass = "is-progressbox-visible";

    if (!progressRef) {
      return;
    }

    var progressPosition = progressRef.getBoundingClientRect().bottom;

    if (progressPosition > 0) {
      progressFix.classList.remove(progressVisibleClass);
    } else {
      progressFix.classList.add(progressVisibleClass);
    }
  };

  window.addEventListener("scroll", checkProgressPosition);
  window.DecidimBudgets = window.DecidimBudgets || {};
  window.DecidimBudgets.checkProgressPosition = checkProgressPosition;
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/projects.js":
/*!*********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/projects.js ***!
  \*********************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var $projects = $("#projects, #project");
  var $budgetSummaryTotal = $(".budget-summary__total");
  var $budgetExceedModal = $("#budget-excess");
  var $budgetSummary = $(".budget-summary__progressbox");
  var $voteButton = $(".budget-vote-button");
  var totalAllocation = parseInt($budgetSummaryTotal.attr("data-total-allocation"), 10);

  var cancelEvent = function cancelEvent(event) {
    $(event.currentTarget).removeClass("loading-spinner");
    event.stopPropagation();
    event.preventDefault();
  };

  $voteButton.on("click", "span", function () {
    $(".budget-list__action").click();
  });
  $projects.on("click", ".budget-list__action", function (event) {
    var currentAllocation = parseInt($budgetSummary.attr("data-current-allocation"), 10);
    var $currentTarget = $(event.currentTarget);
    var projectAllocation = parseInt($currentTarget.attr("data-allocation"), 10);

    if (!$currentTarget.attr("data-open")) {
      $currentTarget.addClass("loading-spinner");
    }

    if ($currentTarget.attr("disabled")) {
      cancelEvent(event);
    } else if ($currentTarget.attr("data-add") === "true" && currentAllocation + projectAllocation > totalAllocation) {
      $budgetExceedModal.foundation("toggle");
      cancelEvent(event);
    }
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/images/decidim/budgets/decidim_budgets.svg":
/*!********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/images/decidim/budgets/decidim_budgets.svg ***!
  \********************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_budgets-63f448a8ecee4f8376a0.svg";

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
/******/ 	/* webpack/runtime/publicPath */
/******/ 	!function() {
/******/ 		__webpack_require__.p = "/packs-test/";
/******/ 	}();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be in strict mode.
!function() {
"use strict";
/*!********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/entrypoints/decidim_budgets.js ***!
  \********************************************************************************************************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_budgets_projects__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/budgets/projects */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/projects.js");
/* harmony import */ var src_decidim_budgets_projects__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_budgets_projects__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_budgets_progressFixed__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/budgets/progressFixed */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/progressFixed.js");
/* harmony import */ var src_decidim_budgets_progressFixed__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(src_decidim_budgets_progressFixed__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var src_decidim_budgets_exit_handler__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/budgets/exit_handler */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/src/decidim/budgets/exit_handler.js");
/* harmony import */ var src_decidim_budgets_exit_handler__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(src_decidim_budgets_exit_handler__WEBPACK_IMPORTED_MODULE_2__);


 // Images

__webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-budgets/app/packs/images sync recursive ^\\.\\/.*$");
}();
/******/ })()
;
//# sourceMappingURL=decidim_budgets.js.map