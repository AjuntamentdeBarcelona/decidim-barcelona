/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents sync recursive ^\\.\\/.*$":
/*!****************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents/ sync ^\.\/.*$ ***!
  \****************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

var map = {
	"./decidim/proposals/participatory_texts/participatory_text.md": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents/decidim/proposals/participatory_texts/participatory_text.md",
	"./decidim/proposals/participatory_texts/participatory_text.odt": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents/decidim/proposals/participatory_texts/participatory_text.odt"
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
webpackContext.id = "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents sync recursive ^\\.\\/.*$";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images sync recursive ^\\.\\/.*$":
/*!*************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/ sync ^\.\/.*$ ***!
  \*************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

var map = {
	"./decidim/gamification/badges/decidim_gamification_badges_accepted_proposals.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_accepted_proposals.svg",
	"./decidim/gamification/badges/decidim_gamification_badges_proposal_votes.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_proposal_votes.svg",
	"./decidim/gamification/badges/decidim_gamification_badges_proposals.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_proposals.svg",
	"./decidim/proposals/decidim_proposals.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/proposals/decidim_proposals.svg"
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
webpackContext.id = "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images sync recursive ^\\.\\/.*$";

/***/ }),

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

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/add_proposal.js":
/*!*****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/add_proposal.js ***!
  \*****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/geocoding/attach_input */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/attach_input.js");
/* harmony import */ var src_decidim_geocoding_coordinate_input__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/geocoding/coordinate_input */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/coordinate_input.js");


$(function () {
  var $checkbox = $("input:checkbox[name$='[has_address]']");
  var $addressInput = $("#address_input");
  var $addressInputField = $("input", $addressInput);
  var $map = $("#address_map");
  var latFieldName = "latitude";
  var longFieldName = "longitude";

  if ($addressInputField.length > 0) {
    latFieldName = (0,src_decidim_geocoding_coordinate_input__WEBPACK_IMPORTED_MODULE_1__["default"])("latitude", $addressInputField, {});
    longFieldName = (0,src_decidim_geocoding_coordinate_input__WEBPACK_IMPORTED_MODULE_1__["default"])("longitude", $addressInputField, {});
  }

  $map.hide();

  if ($checkbox.length > 0) {
    var toggleInput = function toggleInput() {
      if ($checkbox[0].checked) {
        $addressInput.show();
        $addressInputField.prop("disabled", false);
      } else {
        $addressInput.hide();
        $addressInputField.prop("disabled", true);
      }
    };

    toggleInput();
    $checkbox.on("change", toggleInput);
  }

  if ($addressInput.length > 0) {
    if ($checkbox[0].checked) {
      $map.show();
    }

    var ctrl = $("[data-decidim-map]").data("map-controller");
    ctrl.setEventHandler("coordinates", function (ev) {
      $("input[name='".concat(latFieldName, "']")).val(ev.lat);
      $("input[name='".concat(longFieldName, "']")).val(ev.lng);
    });
    (0,src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_0__["default"])($addressInputField, null, function (coordinates) {
      $map.show(); // Remove previous marker when user updates address in address field

      ctrl.removeMarker();
      ctrl.addMarker({
        latitude: coordinates[0],
        longitude: coordinates[1],
        address: $addressInput.val()
      });
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/utils.js":
/*!**********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/utils.js ***!
  \**********************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable no-invalid-this */
$(function () {
  $("#vote_button").mouseover(function () {
    $(this).text($(this).data("replace"));
  });
  $("#vote_button").mouseout(function () {
    $(this).text($(this).data("original"));
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents/decidim/proposals/participatory_texts/participatory_text.md":
/*!*************************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents/decidim/proposals/participatory_texts/participatory_text.md ***!
  \*************************************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/documents/0e67170e72070b470a07.md";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents/decidim/proposals/participatory_texts/participatory_text.odt":
/*!**************************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents/decidim/proposals/participatory_texts/participatory_text.odt ***!
  \**************************************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/documents/057f608bdff3d77526ff.odt";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_accepted_proposals.svg":
/*!*****************************************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_accepted_proposals.svg ***!
  \*****************************************************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_gamification_badges_accepted_proposals-907eee548361dfee6abe.svg";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_proposal_votes.svg":
/*!*************************************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_proposal_votes.svg ***!
  \*************************************************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_gamification_badges_proposal_votes-13426dd64ea84f600a64.svg";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_proposals.svg":
/*!********************************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_proposals.svg ***!
  \********************************************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_gamification_badges_proposals-92b1e6ff9b790aad8550.svg";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/proposals/decidim_proposals.svg":
/*!**************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images/decidim/proposals/decidim_proposals.svg ***!
  \**************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_proposals-15e5583a7f2834cd644e.svg";

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
/*!************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/entrypoints/decidim_proposals.js ***!
  \************************************************************************************************************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_proposals_utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/proposals/utils */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/utils.js");
/* harmony import */ var src_decidim_proposals_utils__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_proposals_utils__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_proposals_add_proposal__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/proposals/add_proposal */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/src/decidim/proposals/add_proposal.js");

 // Images

__webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/images sync recursive ^\\.\\/.*$"); // Documents


__webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-proposals/app/packs/documents sync recursive ^\\.\\/.*$");
}();
/******/ })()
;
//# sourceMappingURL=decidim_proposals.js.map