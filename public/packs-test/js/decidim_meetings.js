/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images sync recursive ^\\.\\/.*$":
/*!************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images/ sync ^\.\/.*$ ***!
  \************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

var map = {
	"./decidim/gamification/badges/decidim_gamification_badges_attended_meetings.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_attended_meetings.svg",
	"./decidim/meetings/decidim_meetings.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images/decidim/meetings/decidim_meetings.svg"
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
webpackContext.id = "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images sync recursive ^\\.\\/.*$";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/field_dependent_inputs.component.js":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/field_dependent_inputs.component.js ***!
  \*****************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createFieldDependentInputs; }
/* harmony export */ });
function _classCallCheck(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

function _defineProperties(target, props) {
  for (var i = 0; i < props.length; i++) {
    var descriptor = props[i];
    descriptor.enumerable = descriptor.enumerable || false;
    descriptor.configurable = true;
    if ("value" in descriptor) descriptor.writable = true;
    Object.defineProperty(target, descriptor.key, descriptor);
  }
}

function _createClass(Constructor, protoProps, staticProps) {
  if (protoProps) _defineProperties(Constructor.prototype, protoProps);
  if (staticProps) _defineProperties(Constructor, staticProps);
  Object.defineProperty(Constructor, "prototype", {
    writable: false
  });
  return Constructor;
}
/* eslint-disable require-jsdoc */


var FieldDependentInputsComponent = /*#__PURE__*/function () {
  function FieldDependentInputsComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, FieldDependentInputsComponent);

    this.controllerField = options.controllerField;
    this.wrapperSelector = options.wrapperSelector;
    this.dependentFieldsSelector = options.dependentFieldsSelector;
    this.dependentInputSelector = options.dependentInputSelector;
    this.enablingCondition = options.enablingCondition;

    this._bindEvent();

    this._run();
  }

  _createClass(FieldDependentInputsComponent, [{
    key: "_run",
    value: function _run() {
      var $controllerField = this.controllerField;
      var $dependentFields = $controllerField.parents(this.wrapperSelector).find(this.dependentFieldsSelector);
      var $dependentInputs = $dependentFields.find(this.dependentInputSelector);

      if (this.enablingCondition($controllerField)) {
        $dependentInputs.prop("disabled", false);
        $dependentFields.show();
      } else {
        $dependentInputs.prop("disabled", true);
        $dependentFields.hide();
      }
    }
  }, {
    key: "_bindEvent",
    value: function _bindEvent() {
      var _this = this;

      this.controllerField.on("change", function () {
        _this._run();
      });
    }
  }]);

  return FieldDependentInputsComponent;
}();

function createFieldDependentInputs(options) {
  return new FieldDependentInputsComponent(options);
}

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

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/entrypoints/decidim_meetings.js":
/*!**********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/entrypoints/decidim_meetings.js ***!
  \**********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_meetings_meetings_form__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/meetings/meetings_form */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/meetings_form.js");
/* harmony import */ var src_decidim_meetings_meetings_polls__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/meetings/meetings_polls */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/meetings_polls.js");
/* harmony import */ var src_decidim_forms_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/forms/forms */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/forms.js");


 // Images

__webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images sync recursive ^\\.\\/.*$");

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/meetings_form.js":
/*!****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/meetings_form.js ***!
  \****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/geocoding/attach_input */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/attach_input.js");
/* harmony import */ var src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/admin/field_dependent_inputs.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/field_dependent_inputs.component.js");


$(function () {
  // Adds the latitude/longitude inputs after the geocoding is done
  var $meetingAddress = $("#meeting_address");

  if ($meetingAddress.length > 0) {
    (0,src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_0__["default"])($meetingAddress);
  }

  var $form = $(".meetings_form");

  if ($form.length > 0) {
    var $meetingTypeOfMeeting = $form.find("#meeting_type_of_meeting");
    var $meetingOnlineFields = $form.find(".field[data-meeting-type='online']");
    var $meetingInPersonFields = $form.find(".field[data-meeting-type='in_person']");
    var $meetingOnlineAccessLevelFields = $form.find(".field[data-meeting-type='online-access-level']");

    var toggleDependsOnSelect = function toggleDependsOnSelect($target, $showDiv, type) {
      var value = $target.val();

      if (value === "hybrid") {
        $showDiv.show();
      } else {
        $showDiv.hide();

        if (value === type) {
          $showDiv.show();
        }
      }
    };

    $meetingTypeOfMeeting.on("change", function (ev) {
      var $target = $(ev.target);
      var embedTypeValue = $("#meeting_iframe_embed_type").val();
      toggleDependsOnSelect($target, $meetingOnlineFields, "online");
      toggleDependsOnSelect($target, $meetingInPersonFields, "in_person");

      if (embedTypeValue === "none") {
        $meetingOnlineAccessLevelFields.hide();
      } else {
        toggleDependsOnSelect($target, $meetingOnlineAccessLevelFields, "online");
      }
    });
    toggleDependsOnSelect($meetingTypeOfMeeting, $meetingOnlineFields, "online");
    toggleDependsOnSelect($meetingTypeOfMeeting, $meetingInPersonFields, "in_person");
    var $meetingRegistrationType = $form.find("#meeting_registration_type");
    var $meetingRegistrationTerms = $form.find("#meeting_registration_terms");
    var $meetingRegistrationUrl = $form.find("#meeting_registration_url");
    var $meetingAvailableSlots = $form.find("#meeting_available_slots");
    $meetingRegistrationType.on("change", function (ev) {
      var $target = $(ev.target);
      toggleDependsOnSelect($target, $meetingAvailableSlots, "on_this_platform");
      toggleDependsOnSelect($target, $meetingRegistrationTerms, "on_this_platform");
      toggleDependsOnSelect($target, $meetingRegistrationUrl, "on_different_platform");
    });
    toggleDependsOnSelect($meetingRegistrationType, $meetingAvailableSlots, "on_this_platform");
    toggleDependsOnSelect($meetingRegistrationType, $meetingRegistrationTerms, "on_this_platform");
    toggleDependsOnSelect($meetingRegistrationType, $meetingRegistrationUrl, "on_different_platform");
    (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_1__["default"])({
      controllerField: $("#meeting_iframe_embed_type"),
      wrapperSelector: ".iframe-fields",
      dependentFieldsSelector: ".iframe-fields--access-level",
      dependentInputSelector: "input",
      enablingCondition: function enablingCondition($field) {
        return $field.val() !== "none";
      }
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/meetings_polls.js":
/*!*****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/meetings_polls.js ***!
  \*****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_meetings_poll_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/meetings/poll.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/poll.component.js");

var OPEN_CLASS = "is-open";
$(function () {
  // Mount polls component for users
  var $container = $("[data-decidim-meetings-poll]");
  var $counter = $("#visible-questions-count");

  if ($container.length) {
    var poll = new src_decidim_meetings_poll_component__WEBPACK_IMPORTED_MODULE_0__["default"]($container, $container.data("decidim-meetings-poll"), $counter);
    $(".meeting-polls__action-list").on("click", function (event) {
      event.preventDefault();

      if (poll.isMounted()) {
        $(event.target).removeClass(OPEN_CLASS);
        $container.removeClass(OPEN_CLASS);
        poll.unmountComponent();
      } else {
        $(event.target).addClass(OPEN_CLASS);
        $container.addClass(OPEN_CLASS);
        poll.mountComponent();
      }
    });
  } // Mount polls component for admins


  var $adminContainer = $("[data-decidim-admin-meetings-poll]");

  if ($adminContainer.length) {
    var adminPoll = new src_decidim_meetings_poll_component__WEBPACK_IMPORTED_MODULE_0__["default"]($adminContainer, $adminContainer.data("decidim-admin-meetings-poll"));
    $(".meeting-polls__action-administrate").on("click", function (event) {
      event.preventDefault();

      if (adminPoll.isMounted()) {
        $(event.target).removeClass(OPEN_CLASS);
        $adminContainer.removeClass(OPEN_CLASS);
        adminPoll.unmountComponent();
      } else {
        $(event.target).addClass(OPEN_CLASS);
        $adminContainer.addClass(OPEN_CLASS);
        adminPoll.mountComponent();
      }
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/poll.component.js":
/*!*****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/poll.component.js ***!
  \*****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ PollComponent; }
/* harmony export */ });
function _classCallCheck(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

function _defineProperties(target, props) {
  for (var i = 0; i < props.length; i++) {
    var descriptor = props[i];
    descriptor.enumerable = descriptor.enumerable || false;
    descriptor.configurable = true;
    if ("value" in descriptor) descriptor.writable = true;
    Object.defineProperty(target, descriptor.key, descriptor);
  }
}

function _createClass(Constructor, protoProps, staticProps) {
  if (protoProps) _defineProperties(Constructor.prototype, protoProps);
  if (staticProps) _defineProperties(Constructor, staticProps);
  Object.defineProperty(Constructor, "prototype", {
    writable: false
  });
  return Constructor;
}
/* eslint id-length: ["error", { "exceptions": ["$"] }] */

/**
 * A plain Javascript component that handles questions from polls in meetings:
 *   - fetches them via Ajax
 *   - enables a polling to automatically update them
 *
 * @class
 * @augments Component
 */
// This is necessary for testing purposes


var $ = window.$; // Default question states

var OPEN = "open";
var CLOSED = "closed";

var PollComponent = /*#__PURE__*/function () {
  function PollComponent($element, config) {
    var $counter = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : null;

    _classCallCheck(this, PollComponent);

    this.$element = $element;
    this.$counter = $counter;
    this.questionsUrl = config.questionsUrl;
    this.pollingInterval = config.pollingInterval || 5000;
    this.mounted = false;
    this.questions = {};
  }
  /**
   * Returns if the component is mounted or not
   * @public
   * @returns {Void} - Returns nothing
   */


  _createClass(PollComponent, [{
    key: "isMounted",
    value: function isMounted() {
      return this.mounted;
    }
    /**
     * Handles the logic for mounting the component
     * @public
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "mountComponent",
    value: function mountComponent() {
      if (this.$element.length > 0 && !this.mounted) {
        this.mounted = true;

        this._fetchQuestions();
      }
    }
  }, {
    key: "unmountComponent",
    value: function unmountComponent() {
      if (this.mounted) {
        this.mounted = false;

        this._stopPolling();

        this.$element.html("");
      }
    }
    /**
     * Performs the ajax call that updates the list of questions
     * Before, stores the current questions states to apply them after the ajax call has
     * been completed
     * @private
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "_fetchQuestions",
    value: function _fetchQuestions() {
      var _this = this; // Store current questions state (open / closed) before overwritting them with the Ajax call
      // response.


      this._storeQuestionState(this.$element);

      $.ajax({
        url: this.questionsUrl,
        method: "GET",
        contentType: "application/javascript"
      }).done(function () {
        _this._updateCounter();

        _this._setQuestionsState(_this.$element);

        _this._pollQuestions();
      });
    }
    /**
     * Iterates over all existing questions and stores the state in an internal attribute.
     * @private
     * @param {jQuery} $parent - The HTML content for the questionnaire.
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "_storeQuestionState",
    value: function _storeQuestionState($parent) {
      var _this2 = this;

      $("[data-question]", $parent).each(function (_i, el) {
        var $el = $(el);
        var questionId = $el.data("question");

        if ($el[0].open === true) {
          _this2.questions[questionId] = OPEN;
        } else {
          _this2.questions[questionId] = CLOSED;
        }
      });
    }
    /**
     * Initializes the states of all the questions.
     * @private
     * @param {jQuery} $parent - The HTML container for the questionnaire.
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "_setQuestionsState",
    value: function _setQuestionsState($parent) {
      var _this3 = this;

      $("[data-question]", $parent).each(function (_i, el) {
        _this3._setQuestionState($(el));
      });
    }
    /**
     * Initializes the state of a single question with two types of modifications:
     *   - sets the is-new class if the question is new (doesn't exist in the internal list)
     *   - sets the state to open if it was open in the internal list
     * @private
     * @param {jQuery} $el - The HTML container for the questionnaire.
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "_setQuestionState",
    value: function _setQuestionState($el) {
      var questionId = $el.data("question"); // Current question state

      var state = this.questions[questionId]; // New questions have a special class

      if (!state) {
        $el.addClass("is-new");
      } else if (state === OPEN) {
        $el.prop(OPEN, true);
      }
    }
    /**
     * Sets a timeout to poll new questions.
     * @private
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "_pollQuestions",
    value: function _pollQuestions() {
      var _this4 = this;

      this._stopPolling();

      this.pollTimeout = setTimeout(function () {
        _this4._fetchQuestions();
      }, this.pollingInterval);
    }
    /**
     * Stops polling for new questions.
     * @private
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "_stopPolling",
    value: function _stopPolling() {
      if (this.pollTimeout) {
        clearTimeout(this.pollTimeout);
      }
    }
    /**
     * Updates the counter with the number of questions returned in the Ajax call
     * @private
     * @returns {Void} - Returns nothing
     */

  }, {
    key: "_updateCounter",
    value: function _updateCounter() {
      if (this.$counter) {
        var questionsCount = this.$element.find("details").length;
        this.$counter.html("(".concat(questionsCount, ")"));
      }
    }
  }]);

  return PollComponent;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_attended_meetings.svg":
/*!***************************************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images/decidim/gamification/badges/decidim_gamification_badges_attended_meetings.svg ***!
  \***************************************************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_gamification_badges_attended_meetings-0a385f1bbe5a6e378d14.svg";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images/decidim/meetings/decidim_meetings.svg":
/*!***********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/images/decidim/meetings/decidim_meetings.svg ***!
  \***********************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_meetings-f1cb40f132fbc2fa9a00.svg";

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
/******/ 	/* webpack/runtime/jsonp chunk loading */
/******/ 	!function() {
/******/ 		// no baseURI
/******/ 		
/******/ 		// object to store loaded and loading chunks
/******/ 		// undefined = chunk not loaded, null = chunk preloaded/prefetched
/******/ 		// [resolve, reject, Promise] = chunk loading, 0 = chunk loaded
/******/ 		var installedChunks = {
/******/ 			"decidim_meetings": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-forms_app-eb61c3"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/entrypoints/decidim_meetings.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_meetings.js.map