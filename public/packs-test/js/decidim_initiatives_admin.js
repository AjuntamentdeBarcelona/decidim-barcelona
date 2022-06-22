/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/admin/initiatives_types.js":
/*!********************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/admin/initiatives_types.js ***!
  \********************************************************************************************************************************************************************************/
/***/ (function() {

(function () {
  var $scope = $("#promoting-committee-details");
  var $promotingCommitteeCheckbox = $("#initiatives_type_promoting_committee_enabled", $scope);
  var $signatureType = $("#initiatives_type_signature_type");
  var $collectUserDataCheckbox = $("#initiatives_type_collect_user_extra_fields");

  var toggleVisibility = function toggleVisibility() {
    if ($promotingCommitteeCheckbox.is(":checked")) {
      $(".minimum-committee-members-details", $scope).show();
    } else {
      $(".minimum-committee-members-details", $scope).hide();
    }

    if ($signatureType.val() === "offline") {
      $("#initiatives_type_undo_online_signatures_enabled").parent().parent().hide();
    } else {
      $("#initiatives_type_undo_online_signatures_enabled").parent().parent().show();
    }

    if ($collectUserDataCheckbox.is(":checked")) {
      $("#initiatives_type-extra_fields_legal_information-tabs").parent().parent().show();
    } else {
      $("#initiatives_type-extra_fields_legal_information-tabs").parent().parent().hide();
    }
  };

  $($promotingCommitteeCheckbox).click(function () {
    return toggleVisibility();
  });
  $($signatureType).change(function () {
    return toggleVisibility();
  });
  $($collectUserDataCheckbox).click(function () {
    return toggleVisibility();
  });
  toggleVisibility();
})();

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/admin/invite_users.js":
/*!***************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/admin/invite_users.js ***!
  \***************************************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable no-empty */
$(function () {
  var inviteUsersButton = document.querySelector(".invite-users-link");

  if (inviteUsersButton !== null) {
    inviteUsersButton.addEventListener("click", function (event) {
      var link = document.querySelector("#committee_link"),
          range = document.createRange();
      event.preventDefault();
      range.selectNode(link);
      window.getSelection().addRange(range);

      try {
        document.execCommand("copy");
      } catch (err) {}

      window.getSelection().removeAllRanges();
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/scoped_type.js":
/*!********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/scoped_type.js ***!
  \********************************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable camelcase */
var controlSelector = function controlSelector(source, prefix, currentValueKey) {
  if (source.length) {
    var currentValue = source.data(currentValueKey),
        searchUrl = source.data("".concat(prefix, "-search-url")),
        targetElement = $("#".concat(source.data("".concat(prefix, "-selector"))));

    if (targetElement.length) {
      var refresh = function refresh() {
        $.ajax({
          url: searchUrl,
          cache: false,
          dataType: "html",
          data: {
            type_id: source.val(),
            selected: currentValue
          },
          success: function success(data) {
            targetElement.html(data);
          }
        });
      };

      source.change(refresh);
      refresh();
    }
  }
};

$(function () {
  var typeSelector = $("[data-scope-selector]");
  controlSelector(typeSelector, "scope", "scope-id");
  controlSelector(typeSelector, "signature-types", "signature-type");
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
/*!**********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/entrypoints/decidim_initiatives_admin.js ***!
  \**********************************************************************************************************************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_initiatives_admin_initiatives_types__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/initiatives/admin/initiatives_types */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/admin/initiatives_types.js");
/* harmony import */ var src_decidim_initiatives_admin_initiatives_types__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_initiatives_admin_initiatives_types__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_initiatives_admin_invite_users__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/initiatives/admin/invite_users */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/admin/invite_users.js");
/* harmony import */ var src_decidim_initiatives_admin_invite_users__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(src_decidim_initiatives_admin_invite_users__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var src_decidim_initiatives_scoped_type__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/initiatives/scoped_type */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-initiatives/app/packs/src/decidim/initiatives/scoped_type.js");
/* harmony import */ var src_decidim_initiatives_scoped_type__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(src_decidim_initiatives_scoped_type__WEBPACK_IMPORTED_MODULE_2__);



}();
/******/ })()
;
//# sourceMappingURL=decidim_initiatives_admin.js.map