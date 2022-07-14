/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

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

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/entrypoints/decidim_meetings_admin.js":
/*!****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/entrypoints/decidim_meetings_admin.js ***!
  \****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_meetings_admin_agendas__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/meetings/admin/agendas */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/agendas.js");
/* harmony import */ var src_decidim_meetings_admin_destroy_meeting_alert__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/meetings/admin/destroy_meeting_alert */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/destroy_meeting_alert.js");
/* harmony import */ var src_decidim_meetings_admin_destroy_meeting_alert__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(src_decidim_meetings_admin_destroy_meeting_alert__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var src_decidim_meetings_admin_meetings_form__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/meetings/admin/meetings_form */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/meetings_form.js");
/* harmony import */ var src_decidim_meetings_admin_registrations_form__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/meetings/admin/registrations_form */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/registrations_form.js");
/* harmony import */ var src_decidim_meetings_admin_registrations_form__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(src_decidim_meetings_admin_registrations_form__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var src_decidim_meetings_admin_registrations_invite_form__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! src/decidim/meetings/admin/registrations_invite_form */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/registrations_invite_form.js");






/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/agendas.js":
/*!****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/agendas.js ***!
  \****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/admin/auto_buttons_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_buttons_by_position.component.js");
/* harmony import */ var src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/admin/auto_label_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_label_by_position.component.js");
/* harmony import */ var src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/admin/sort_list.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/sort_list.component.js");
/* harmony import */ var src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/admin/dynamic_fields.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/dynamic_fields.component.js");
/* harmony import */ var src_decidim_editor__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! src/decidim/editor */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor.js");





var wrapperSelector = ".meeting-agenda-items";
var fieldSelector = ".meeting-agenda-item";
var childsWrapperSelector = ".meeting-agenda-item-childs";
var childFieldSelector = ".meeting-agenda-item-child";
var autoLabelByPosition = new src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_1__["default"]({
  listSelector: ".meeting-agenda-item:not(.hidden)",
  labelSelector: ".card-title span:first",
  onPositionComputed: function onPositionComputed(el, idx) {
    $(el).find("input[name$=\\[position\\]]").val(idx);
  }
});
var autoButtonsByPosition = new src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_0__["default"]({
  listSelector: ".meeting-agenda-item:not(.hidden)",
  hideOnFirstSelector: ".move-up-agenda-item",
  hideOnLastSelector: ".move-down-agenda-item"
});

var createSortableList = function createSortableList() {
  (0,src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_2__["default"])(".meeting-agenda-items-list:not(.published)", {
    handle: ".agenda-item-divider",
    placeholder: '<div style="border-style: dashed; border-color: #000"></div>',
    forcePlaceholderSize: true,
    onSortUpdate: function onSortUpdate() {
      autoLabelByPosition.run();
    }
  });
};

var createSortableListChild = function createSortableListChild() {
  (0,src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_2__["default"])(".meeting-agenda-item-childs-list:not(.published)", {
    handle: ".agenda-item-child-divider",
    placeholder: '<div style="border-style: dashed; border-color: #000"></div>',
    forcePlaceholderSize: true,
    onSortUpdate: function onSortUpdate() {
      autoLabelByPosition.run();
    }
  });
};

var autoLabelByPositionChild = new src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_1__["default"]({
  listSelector: ".meeting-agenda-item-child:not(.hidden)",
  labelSelector: ".card-title span:first",
  onPositionComputed: function onPositionComputed(el, idx) {
    $(el).find("input[name$=\\[position\\]]").val(idx);
  }
});
var autoButtonsByPositionChild = new src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_0__["default"]({
  listSelector: ".meeting-agenda-item-child:not(.hidden)",
  hideOnFirstSelector: ".move-up-agenda-item-child",
  hideOnLastSelector: ".move-down-agenda-item-child"
});

var createDynamicFieldsForAgendaItemChilds = function createDynamicFieldsForAgendaItemChilds(fieldId) {
  return (0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_3__["default"])({
    placeholderId: "meeting-agenda-item-child-id",
    wrapperSelector: "#".concat(fieldId, " ").concat(childsWrapperSelector),
    containerSelector: ".meeting-agenda-item-childs-list",
    fieldSelector: childFieldSelector,
    addFieldButtonSelector: ".add-agenda-item-child",
    removeFieldButtonSelector: ".remove-agenda-item-child",
    moveUpFieldButtonSelector: ".move-up-agenda-item-child",
    moveDownFieldButtonSelector: ".move-down-agenda-item-child",
    onAddField: function onAddField($field) {
      createSortableListChild();
      $field.find(".editor-container").each(function (idx, el) {
        (0,src_decidim_editor__WEBPACK_IMPORTED_MODULE_4__["default"])(el);
      });
      autoLabelByPositionChild.run();
      autoButtonsByPositionChild.run();
    },
    onRemoveField: function onRemoveField() {
      autoLabelByPositionChild.run();
      autoButtonsByPositionChild.run();
    },
    onMoveUpField: function onMoveUpField() {
      autoLabelByPositionChild.run();
      autoButtonsByPositionChild.run();
    },
    onMoveDownField: function onMoveDownField() {
      autoLabelByPositionChild.run();
      autoButtonsByPositionChild.run();
    }
  });
};

var dynamicFieldsForAgendaItemChilds = {};

var setupInitialAgendaItemChildAttributes = function setupInitialAgendaItemChildAttributes($target) {
  var fieldId = $target.attr("id");
  dynamicFieldsForAgendaItemChilds[fieldId] = createDynamicFieldsForAgendaItemChilds(fieldId);
};

var hideDeletedAgendaItem = function hideDeletedAgendaItem($target) {
  var inputDeleted = $target.find("input[name$=\\[deleted\\]]").val();

  if (inputDeleted === "true") {
    $target.addClass("hidden");
    $target.hide();
  }
};

(0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_3__["default"])({
  placeholderId: "meeting-agenda-item-id",
  wrapperSelector: wrapperSelector,
  containerSelector: ".meeting-agenda-items-list",
  fieldSelector: fieldSelector,
  addFieldButtonSelector: ".add-agenda-item",
  removeFieldButtonSelector: ".remove-agenda-item",
  moveUpFieldButtonSelector: ".move-up-agenda-item",
  moveDownFieldButtonSelector: ".move-down-agenda-item",
  onAddField: function onAddField($field) {
    // createDynamicFieldsForAgendaItemChilds($field);
    setupInitialAgendaItemChildAttributes($field);
    createSortableList();
    $field.find(".editor-container").each(function (idx, el) {
      (0,src_decidim_editor__WEBPACK_IMPORTED_MODULE_4__["default"])(el);
    });
    autoLabelByPosition.run();
    autoButtonsByPosition.run();
  },
  onRemoveField: function onRemoveField() {
    autoLabelByPosition.run();
    autoButtonsByPosition.run();
  },
  onMoveUpField: function onMoveUpField() {
    autoLabelByPosition.run();
    autoButtonsByPosition.run();
  },
  onMoveDownField: function onMoveDownField() {
    autoLabelByPosition.run();
    autoButtonsByPosition.run();
  }
});
createSortableList();
$(fieldSelector).each(function (idx, el) {
  var $target = $(el);
  hideDeletedAgendaItem($target);
  setupInitialAgendaItemChildAttributes($target);
});
autoLabelByPosition.run();
autoButtonsByPosition.run();
autoLabelByPositionChild.run();
autoButtonsByPositionChild.run();

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/destroy_meeting_alert.js":
/*!******************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/destroy_meeting_alert.js ***!
  \******************************************************************************************************************************************************************************/
/***/ (function() {

var removeNewlineAdjacentSpaces = function removeNewlineAdjacentSpaces(text) {
  return text.replace(/\n\s/g, "\n");
};

$(function () {
  var $confirmButton = $(".destroy-meeting-alert");

  if ($confirmButton.length > 0) {
    $confirmButton.on("click", function () {
      var alertText = "".concat($confirmButton.data("invalid-destroy-message"), " \n\n");
      alertText += removeNewlineAdjacentSpaces($confirmButton.data("proposal-titles"));
      alert(alertText); // eslint-disable-line no-alert
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/meetings_form.js":
/*!**********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/meetings_form.js ***!
  \**********************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/admin/auto_buttons_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_buttons_by_position.component.js");
/* harmony import */ var src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/admin/auto_label_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_label_by_position.component.js");
/* harmony import */ var src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/admin/sort_list.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/sort_list.component.js");
/* harmony import */ var src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/admin/dynamic_fields.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/dynamic_fields.component.js");
/* harmony import */ var src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! src/decidim/admin/field_dependent_inputs.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/field_dependent_inputs.component.js");
/* harmony import */ var src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! src/decidim/geocoding/attach_input */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/geocoding/attach_input.js");






$(function () {
  var wrapperSelector = ".meeting-services";
  var fieldSelector = ".meeting-service";
  var autoLabelByPosition = new src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_1__["default"]({
    listSelector: ".meeting-service:not(.hidden)",
    labelSelector: ".card-title span:first",
    onPositionComputed: function onPositionComputed(el, idx) {
      $(el).find("input[name$=\\[position\\]]").val(idx);
    }
  });
  var autoButtonsByPosition = new src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_0__["default"]({
    listSelector: ".meeting-service:not(.hidden)",
    hideOnFirstSelector: ".move-up-service",
    hideOnLastSelector: ".move-down-service"
  });

  var createSortableList = function createSortableList() {
    (0,src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_2__["default"])(".meeting-services-list:not(.published)", {
      handle: ".service-divider",
      placeholder: '<div style="border-style: dashed; border-color: #000"></div>',
      forcePlaceholderSize: true,
      onSortUpdate: function onSortUpdate() {
        autoLabelByPosition.run();
      }
    });
  };

  var hideDeletedService = function hideDeletedService($target) {
    var inputDeleted = $target.find("input[name$=\\[deleted\\]]").val();

    if (inputDeleted === "true") {
      $target.addClass("hidden");
      $target.hide();
    }
  };

  (0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_3__["default"])({
    placeholderId: "meeting-service-id",
    wrapperSelector: wrapperSelector,
    containerSelector: ".meeting-services-list",
    fieldSelector: fieldSelector,
    addFieldButtonSelector: ".add-service",
    removeFieldButtonSelector: ".remove-service",
    moveUpFieldButtonSelector: ".move-up-service",
    moveDownFieldButtonSelector: ".move-down-service",
    onAddField: function onAddField() {
      createSortableList();
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onRemoveField: function onRemoveField() {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onMoveUpField: function onMoveUpField() {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onMoveDownField: function onMoveDownField() {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    }
  });
  createSortableList();
  $(fieldSelector).each(function (idx, el) {
    var $target = $(el);
    hideDeletedService($target);
  });
  autoLabelByPosition.run();
  autoButtonsByPosition.run();
  var $form = $(".edit_meeting, .new_meeting, .copy_meetings");

  if ($form.length > 0) {
    var $privateMeeting = $form.find("#private_meeting");
    var $transparent = $form.find("#transparent");

    var toggleDisabledHiddenFields = function toggleDisabledHiddenFields() {
      var enabledPrivateSpace = $privateMeeting.find("input[type='checkbox']").prop("checked");
      $transparent.find("input[type='checkbox']").attr("disabled", "disabled");

      if (enabledPrivateSpace) {
        $transparent.find("input[type='checkbox']").attr("disabled", !enabledPrivateSpace);
      }
    };

    $privateMeeting.on("change", toggleDisabledHiddenFields);
    toggleDisabledHiddenFields();
    (0,src_decidim_geocoding_attach_input__WEBPACK_IMPORTED_MODULE_5__["default"])($form.find("#meeting_address"));
    var $meetingRegistrationType = $form.find("#meeting_registration_type");
    var $meetingRegistrationTerms = $form.find("#meeting_registration_terms");
    var $meetingRegistrationUrl = $form.find("#meeting_registration_url");
    var $meetingAvailableSlots = $form.find("#meeting_available_slots");

    var toggleDependsOnSelect = function toggleDependsOnSelect($target, $showDiv, type) {
      var value = $target.val();
      $showDiv.toggle(value === type);
    };

    $meetingRegistrationType.on("change", function (ev) {
      var $target = $(ev.target);
      toggleDependsOnSelect($target, $meetingAvailableSlots, "on_this_platform");
      toggleDependsOnSelect($target, $meetingRegistrationTerms, "on_this_platform");
      toggleDependsOnSelect($target, $meetingRegistrationUrl, "on_different_platform");
    });
    $meetingRegistrationType.trigger("change");
    var $meetingTypeOfMeeting = $form.find("#meeting_type_of_meeting");
    var $meetingOnlineFields = $form.find(".field[data-meeting-type='online']");
    var $meetingInPersonFields = $form.find(".field[data-meeting-type='in_person']");
    var $meetingOnlineAccessLevelFields = $form.find(".field[data-meeting-type='online-access-level']");
    var $meetingIframeEmbedType = $form.find("#meeting_iframe_embed_type");

    var toggleTypeDependsOnSelect = function toggleTypeDependsOnSelect($target, $showDiv, type) {
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
      var embedTypeValue = $("#meeting_iframe_embed_type select").val();
      toggleTypeDependsOnSelect($target, $meetingOnlineFields, "online");
      toggleTypeDependsOnSelect($target, $meetingInPersonFields, "in_person");

      if (embedTypeValue === "none") {
        $meetingOnlineAccessLevelFields.hide();
      } else {
        toggleTypeDependsOnSelect($target, $meetingOnlineAccessLevelFields, "online");
      }
    });
    toggleTypeDependsOnSelect($meetingTypeOfMeeting, $meetingOnlineFields, "online");
    toggleTypeDependsOnSelect($meetingTypeOfMeeting, $meetingInPersonFields, "in_person");
    (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_4__["default"])({
      controllerField: $meetingIframeEmbedType,
      wrapperSelector: ".iframe-fields",
      dependentFieldsSelector: ".iframe-fields--access-level",
      dependentInputSelector: "input",
      enablingCondition: function enablingCondition($field) {
        return $field.find("select").val() !== "none";
      }
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/registrations_form.js":
/*!***************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/registrations_form.js ***!
  \***************************************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var $form = $(".edit_meeting_registrations");

  if ($form.length > 0) {
    var $registrationsEnabled = $form.find("#meeting_registrations_enabled");
    var $availableSlots = $form.find("#meeting_available_slots");
    var $reservedSlots = $form.find("#meeting_reserved_slots");

    var toggleDisabledFields = function toggleDisabledFields() {
      var enabled = $registrationsEnabled.prop("checked");
      $availableSlots.attr("disabled", !enabled);
      $reservedSlots.attr("disabled", !enabled);
      $form.find(".editor-container").each(function (idx, node) {
        var quill = Quill.find(node);
        quill.enable(enabled);
      });
    };

    $registrationsEnabled.on("change", toggleDisabledFields);
    toggleDisabledFields();
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/registrations_invite_form.js":
/*!**********************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/src/decidim/meetings/admin/registrations_invite_form.js ***!
  \**********************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/admin/field_dependent_inputs.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/field_dependent_inputs.component.js");

$(function () {
  var $attendeeType = $('[name="meeting_registration_invite[existing_user]"');
  (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__["default"])({
    controllerField: $attendeeType,
    wrapperSelector: ".attendee-fields",
    dependentFieldsSelector: ".attendee-fields--new-user",
    dependentInputSelector: "input",
    enablingCondition: function enablingCondition() {
      return $("#meeting_registration_invite_existing_user_false").is(":checked");
    }
  });
  (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__["default"])({
    controllerField: $attendeeType,
    wrapperSelector: ".attendee-fields",
    dependentFieldsSelector: ".attendee-fields--user-picker",
    dependentInputSelector: "input",
    enablingCondition: function enablingCondition() {
      return $("#meeting_registration_invite_existing_user_true").is(":checked");
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
/******/ 	/* webpack/runtime/jsonp chunk loading */
/******/ 	!function() {
/******/ 		// no baseURI
/******/ 		
/******/ 		// object to store loaded and loading chunks
/******/ 		// undefined = chunk not loaded, null = chunk preloaded/prefetched
/******/ 		// [resolve, reject, Promise] = chunk loading, 0 = chunk loaded
/******/ 		var installedChunks = {
/******/ 			"decidim_meetings_admin": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["vendors-node_modules_html5sortable_dist_html5sortable_es_js","_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-core_app_-8aee6a","_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-admin_app-16f163"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-meetings/app/packs/entrypoints/decidim_meetings_admin.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_meetings_admin.js.map