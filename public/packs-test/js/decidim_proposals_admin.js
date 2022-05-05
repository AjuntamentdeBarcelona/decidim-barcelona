/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/attach_input.js":
/*!************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/attach_input.js ***!
  \************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ attachGeocoding; }
/* harmony export */ });
/* harmony import */ var _coordinate_input__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./coordinate_input */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/coordinate_input.js");
/* eslint-disable require-jsdoc */

/**
 * You can use this method to "attach" front-end geocoding to any forms in the
 * front-end which have address fields with geocoding autocompletion
 * functionality already applied to them.
 *
 * To learn more about the front-end geocoding autocompletion, please refer to
 * the maps documentation at: /docs/customization/maps.md.
 *
 * When the geocoding autocompletion finishes, most of the times, its results
 * will also contain the geocoordinate information for the selected address.
 * This method allows you to pass these coordinates (latitude and longitude)
 * to the same front-end form where the geocoding autocompletion address field
 * is located at (which is the $input you pass to this method). The latitude
 * and longitude coordinates will be added or "attached" to the form once the
 * user selects one of the suggested addresses.
 *
 * Therefore, if there was the following geocoding autocompletion field at
 * your form:
 *   <input
 *     id="record_address"
 *     type="text"
 *     name="record[address]"
 *     data-decidim-geocoding="{&quot;url&quot;:&quot;https://photon.example.org/api/&quot;}"
 *   />
 *
 * You would then "attach" the geocoding result coordinates to the same form
 * where this input is at as follows:
 *   $(document).ready(function() {
 *     window.Decidim.attachGeocoding($("#record_address"));
 *   });
 *
 * Now, after the user selects one of the suggested geocoding autocompletion
 * addresses and the geocoding autocompletion API provides the coordinates in
 * the results, you would have the following fields automatically generated
 * to your form:
 *   <input id="record_address" type="text" name="record[address]" value="Selected address, 00210, City" ... />
 *   <input id="record_latitude" type="hidden" name="record[latitude]" value="1.123" />
 *   <input id="record_longitude" type="hidden" name="record[longitude]" value="2.234" />
 *
 * If you would not do the attachment, these hidden longitude and latitude
 * fields would not be generated and the geocoding would have to happen at the
 * server-side when the form is submitted. The problem with that approach
 * would be that the server-side address geocoding could potentially result in
 * different coordinates than what the user actually selected in the front-end
 * because the autocompletion API can return different coordinates than the
 * geocoding API. Another reason is to avoid unnecessary calls to the
 * geocoding API as the front-end geocoding suggestion already returned the
 * coordinate values we need.
 *
 * @param {jQuery} $input The input jQuery element for the geocoded address
 *   field.
 * @param {Object} options (optional) Extra options if you want to customize
 *   the latitude and longitude element IDs or names from the default.
 * @param {function} callback (optional) Callback to run when updating the coordinates values
 * @returns {void}
 */

function attachGeocoding($input, options, callback) {
  var attachOptions = $.extend({}, options);
  var inputIdParts = $input.attr("id").split("_");
  inputIdParts.pop();
  var idPrefix = "".concat(inputIdParts.join("_"));
  var latitudeName = "latitude";
  var longitudeName = "longitude";

  if ($input.length > 0) {
    latitudeName = (0,_coordinate_input__WEBPACK_IMPORTED_MODULE_0__["default"])("latitude", $input, attachOptions);
    longitudeName = (0,_coordinate_input__WEBPACK_IMPORTED_MODULE_0__["default"])("longitude", $input, attachOptions);
  }

  var config = $.extend({
    latitudeId: "".concat(idPrefix, "_latitude"),
    longitudeId: "".concat(idPrefix, "_longitude"),
    latitudeName: latitudeName,
    longitudeName: longitudeName
  }, options);
  var geocoded = false;

  var createCoordinateFields = function createCoordinateFields() {
    var $latitude = $("#".concat(config.latitudeId));

    if ($latitude.length < 1) {
      $latitude = $("<input type=\"hidden\" name=\"".concat(config.latitudeName, "\" id=\"").concat(config.latitudeId, "\" />"));
      $input.after($latitude);
    }

    var $longitude = $("#".concat(config.longitudeId));

    if ($longitude.length < 1) {
      $longitude = $("<input type=\"hidden\" name=\"".concat(config.longitudeName, "\" id=\"").concat(config.longitudeId, "\" />"));
      $input.after($longitude);
    }
  };

  var clearCoordinateFields = function clearCoordinateFields() {
    if (geocoded) {
      return;
    }

    $("#".concat(config.latitudeId)).val("").removeAttr("value");
    $("#".concat(config.longitudeId)).val("").removeAttr("value");
  };

  var setCoordinates = function setCoordinates(coordinates) {
    createCoordinateFields();
    $("#".concat(config.latitudeId)).val(coordinates[0]).attr("value", coordinates[0]);
    $("#".concat(config.longitudeId)).val(coordinates[1]).attr("value", coordinates[1]);
  }; // When the user changes the value of the coordinate field without selecting
  // any of the geocoding autocomplete results, clear the current latitude and
  // longitude values to let the backend do the geocoding. Once a geocoding
  // autocomplete value has been selected, assume the user just wants to
  // refine the address formatting without changing the location point value.
  // If they want, they can still modify the point in the next step of the
  // proposal creation/editing.


  $input.on("change.decidim", function () {
    clearCoordinateFields();
  }); // When we receive the geocoding event on the field, update the coordinate
  // values.

  $input.on("geocoder-suggest-coordinates.decidim", function (_ev, coordinates) {
    setCoordinates(coordinates);
    geocoded = true;
    callback(coordinates);
  }); // Set the initial values if the field defines the coordinates

  var coordinates = "".concat($input.data("coordinates")).split(",").map(parseFloat);

  if (Array.isArray(coordinates) && coordinates.length === 2) {
    setCoordinates(coordinates);
  }
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/coordinate_input.js":
/*!****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/coordinate_input.js ***!
  \****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ getCoordinateInputName; }
/* harmony export */ });
/**
 * Get coordinate input name from a given $input
 * @param {string} coordinate - Allows to find 'latitude' or 'longitude' field.
 * @param {jQuery} $input - Address input field
 * @param {Object} options (optional) - Extra options
 * @returns {string} - Returns input name
 */
function getCoordinateInputName(coordinate, $input, options) {
  var key = "".concat(coordinate, "Name");

  if (options[key]) {
    return options[key];
  }

  var inputName = $input.attr("name");
  var subNameMatch = /\[[^\]]+\]$/;

  if (inputName.match(subNameMatch)) {
    return inputName.replace(subNameMatch, "[".concat(coordinate, "]"));
  }

  return coordinate;
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals.js":
/*!********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals.js ***!
  \********************************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable no-invalid-this */

/* eslint no-unused-vars: 0 */

/* eslint id-length: ["error", { "exceptions": ["e"] }] */
$(function () {
  var selectedProposalsCount = function selectedProposalsCount() {
    return $(".table-list .js-check-all-proposal:checked").length;
  };

  var selectedProposalsNotPublishedAnswerCount = function selectedProposalsNotPublishedAnswerCount() {
    return $(".table-list [data-published-state=false] .js-check-all-proposal:checked").length;
  };

  var selectedProposalsCountUpdate = function selectedProposalsCountUpdate() {
    var selectedProposals = selectedProposalsCount();
    var selectedProposalsNotPublishedAnswer = selectedProposalsNotPublishedAnswerCount();

    if (selectedProposals === 0) {
      $("#js-selected-proposals-count").text("");
    } else {
      $("#js-selected-proposals-count").text(selectedProposals);
    }

    if (selectedProposals >= 2) {
      $('button[data-action="merge-proposals"]').parent().show();
    } else {
      $('button[data-action="merge-proposals"]').parent().hide();
    }

    if (selectedProposalsNotPublishedAnswer > 0) {
      $('button[data-action="publish-answers"]').parent().show();
      $("#js-form-publish-answers-number").text(selectedProposalsNotPublishedAnswer);
    } else {
      $('button[data-action="publish-answers"]').parent().hide();
    }
  };

  var showBulkActionsButton = function showBulkActionsButton() {
    if (selectedProposalsCount() > 0) {
      $("#js-bulk-actions-button").removeClass("hide");
    }
  };

  var hideBulkActionsButton = function hideBulkActionsButton() {
    var force = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : false;

    if (selectedProposalsCount() === 0 || force === true) {
      $("#js-bulk-actions-button").addClass("hide");
      $("#js-bulk-actions-dropdown").removeClass("is-open");
    }
  };

  var showOtherActionsButtons = function showOtherActionsButtons() {
    $("#js-other-actions-wrapper").removeClass("hide");
  };

  var hideOtherActionsButtons = function hideOtherActionsButtons() {
    $("#js-other-actions-wrapper").addClass("hide");
  };

  var hideBulkActionForms = function hideBulkActionForms() {
    $(".js-bulk-action-form").addClass("hide");
  }; // Expose functions to make them avaialble in .js.erb templates


  window.selectedProposalsCount = selectedProposalsCount;
  window.selectedProposalsNotPublishedAnswerCount = selectedProposalsNotPublishedAnswerCount;
  window.selectedProposalsCountUpdate = selectedProposalsCountUpdate;
  window.showBulkActionsButton = showBulkActionsButton;
  window.hideBulkActionsButton = hideBulkActionsButton;
  window.showOtherActionsButtons = showOtherActionsButtons;
  window.hideOtherActionsButtons = hideOtherActionsButtons;
  window.hideBulkActionForms = hideBulkActionForms;

  if ($(".js-bulk-action-form").length) {
    hideBulkActionForms();
    $("#js-bulk-actions-button").addClass("hide");
    $("#js-bulk-actions-dropdown ul li button").click(function (e) {
      e.preventDefault();
      var action = $(e.target).data("action");

      if (action) {
        $("#js-form-".concat(action)).submit(function () {
          $(".layout-content > .callout-wrapper").html("");
        });
        $("#js-".concat(action, "-actions")).removeClass("hide");
        hideBulkActionsButton(true);
        hideOtherActionsButtons();
      }
    }); // select all checkboxes

    $(".js-check-all").change(function () {
      $(".js-check-all-proposal").prop("checked", $(this).prop("checked"));

      if ($(this).prop("checked")) {
        $(".js-check-all-proposal").closest("tr").addClass("selected");
        showBulkActionsButton();
      } else {
        $(".js-check-all-proposal").closest("tr").removeClass("selected");
        hideBulkActionsButton();
      }

      selectedProposalsCountUpdate();
    }); // proposal checkbox change

    $(".table-list").on("change", ".js-check-all-proposal", function (e) {
      var proposalId = $(this).val();
      var checked = $(this).prop("checked"); // uncheck "select all", if one of the listed checkbox item is unchecked

      if ($(this).prop("checked") === false) {
        $(".js-check-all").prop("checked", false);
      } // check "select all" if all checkbox proposals are checked


      if ($(".js-check-all-proposal:checked").length === $(".js-check-all-proposal").length) {
        $(".js-check-all").prop("checked", true);
        showBulkActionsButton();
      }

      if ($(this).prop("checked")) {
        showBulkActionsButton();
        $(this).closest("tr").addClass("selected");
      } else {
        hideBulkActionsButton();
        $(this).closest("tr").removeClass("selected");
      }

      if ($(".js-check-all-proposal:checked").length === 0) {
        hideBulkActionsButton();
      }

      $(".js-bulk-action-form").find(".js-proposal-id-".concat(proposalId)).prop("checked", checked);
      selectedProposalsCountUpdate();
    });
    $(".js-cancel-bulk-action").on("click", function (e) {
      hideBulkActionForms();
      showBulkActionsButton();
      showOtherActionsButtons();
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals_form.js":
/*!*************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals_form.js ***!
  \*************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/geocoding/attach_input */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/attach_input.js");

$(function () {
  var $form = $(".proposal_form_admin");

  if ($form.length > 0) {
    var $proposalCreatedInMeeting = $form.find("#proposal_created_in_meeting");
    var $proposalMeeting = $form.find("#proposal_meeting");

    var toggleDisabledHiddenFields = function toggleDisabledHiddenFields() {
      var enabledMeeting = $proposalCreatedInMeeting.prop("checked");
      $proposalMeeting.find("select").attr("disabled", "disabled");
      $proposalMeeting.hide();

      if (enabledMeeting) {
        $proposalMeeting.find("select").attr("disabled", !enabledMeeting);
        $proposalMeeting.show();
      }
    };

    $proposalCreatedInMeeting.on("change", toggleDisabledHiddenFields);
    toggleDisabledHiddenFields();
    var $proposalAddress = $form.find("#proposal_address");

    if ($proposalAddress.length !== 0) {
      (0,src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_0__["default"])($proposalAddress);
    }
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals_picker.js":
/*!***************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals_picker.js ***!
  \***************************************************************************************************************************************************************************/
/***/ (function() {

function _typeof(obj) {
  "@babel/helpers - typeof";

  return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
    return typeof obj;
  } : function (obj) {
    return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
  }, _typeof(obj);
}

$(function () {
  var $content = $(".picker-content"),
      pickerMore = $content.data("picker-more"),
      pickerPath = $content.data("picker-path"),
      toggleNoProposals = function toggleNoProposals() {
    var showNoProposals = $("#proposals_list li:visible").length === 0;
    $("#no_proposals").toggle(showNoProposals);
  };

  var jqxhr = null;
  var filterBuffer = "";
  toggleNoProposals();
  $(".data_picker-modal-content").on("change keyup", "#proposals_filter", function (event) {
    var filter = event.target.value.toLowerCase();

    if (pickerMore) {
      if (filter.length < 3) {
        return;
      }

      if (filter === filterBuffer) {
        return;
      }

      if (jqxhr !== null) {
        jqxhr.abort();
      }

      $content.html("<div class='loading-spinner'></div>");
      jqxhr = $.get("".concat(pickerPath, "?q=").concat(filter), function (data) {
        filterBuffer = filter;
        $content.html(data);
        jqxhr = null;
        toggleNoProposals();

        if (_typeof(window.theDataPicker) === "object" && window.theDataPicker.current !== null) {
          window.theDataPicker._handleCheckboxes($content);

          window.theDataPicker._handleLinks($content);
        }
      });
    } else {
      $("#proposals_list li").each(function (index, li) {
        $(li).toggle(li.textContent.toLowerCase().indexOf(filter) > -1);
      });
      toggleNoProposals();
    }
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
/*!******************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/entrypoints/decidim_proposals_admin.js ***!
  \******************************************************************************************************************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_proposals_admin_proposals__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/proposals/admin/proposals */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals.js");
/* harmony import */ var src_decidim_proposals_admin_proposals__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_proposals_admin_proposals__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_proposals_admin_proposals_form__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/proposals/admin/proposals_form */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals_form.js");
/* harmony import */ var src_decidim_proposals_admin_proposals_picker__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/proposals/admin/proposals_picker */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/admin/proposals_picker.js");
/* harmony import */ var src_decidim_proposals_admin_proposals_picker__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(src_decidim_proposals_admin_proposals_picker__WEBPACK_IMPORTED_MODULE_2__);



}();
/******/ })()
;
//# sourceMappingURL=decidim_proposals_admin.js.map