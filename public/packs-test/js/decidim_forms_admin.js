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

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/entrypoints/decidim_forms_admin.js":
/*!**********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/entrypoints/decidim_forms_admin.js ***!
  \**********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_forms_admin_collapsible_questions__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/forms/admin/collapsible_questions */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/collapsible_questions.js");
/* harmony import */ var src_decidim_forms_admin_collapsible_questions__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_forms_admin_collapsible_questions__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _src_decidim_forms_admin_forms__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../src/decidim/forms/admin/forms */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/forms.js");


window.Decidim.createEditableForm = _src_decidim_forms_admin_forms__WEBPACK_IMPORTED_MODULE_1__["default"];

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_buttons_by_min_items.component.js":
/*!**************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_buttons_by_min_items.component.js ***!
  \**************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ AutoButtonsByMinItemsComponent; }
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

var AutoButtonsByMinItemsComponent = /*#__PURE__*/function () {
  function AutoButtonsByMinItemsComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, AutoButtonsByMinItemsComponent);

    this.listSelector = options.listSelector;
    this.minItems = options.minItems;
    this.hideOnMinItemsOrLessSelector = options.hideOnMinItemsOrLessSelector;
    this.run();
  }

  _createClass(AutoButtonsByMinItemsComponent, [{
    key: "run",
    value: function run() {
      var $list = $(this.listSelector);
      var $items = $list.find(this.hideOnMinItemsOrLessSelector);

      if ($list.length <= this.minItems) {
        $items.hide();
      } else {
        $items.show();
      }
    }
  }]);

  return AutoButtonsByMinItemsComponent;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_select_options_by_total_items.component.js":
/*!***********************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_select_options_by_total_items.component.js ***!
  \***********************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ AutoSelectOptionsByTotalItemsComponent; }
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

var AutoSelectOptionsByTotalItemsComponent = /*#__PURE__*/function () {
  function AutoSelectOptionsByTotalItemsComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, AutoSelectOptionsByTotalItemsComponent);

    this.wrapperSelector = options.wrapperSelector;
    this.selectSelector = options.selectSelector;
    this.listSelector = options.listSelector;
  }

  _createClass(AutoSelectOptionsByTotalItemsComponent, [{
    key: "run",
    value: function run() {
      var $list = $(this.listSelector);
      var $selectField = $list.parents(this.wrapperSelector).find(this.selectSelector);
      $selectField.find("option").slice(1).remove();

      for (var idx = 2; idx <= $list.length; idx += 1) {
        $("<option value=\"".concat(idx, "\">").concat(idx, "</option>")).appendTo($selectField);
      }
    }
  }]);

  return AutoSelectOptionsByTotalItemsComponent;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_select_options_from_url.component.js":
/*!*****************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_select_options_from_url.component.js ***!
  \*****************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ AutoSelectOptionsFromUrl; }
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

var AutoSelectOptionsFromUrl = /*#__PURE__*/function () {
  function AutoSelectOptionsFromUrl() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, AutoSelectOptionsFromUrl);

    this.$source = options.source;
    this.$select = options.select;
    this.sourceToParams = options.sourceToParams;
    this.run();
  }

  _createClass(AutoSelectOptionsFromUrl, [{
    key: "run",
    value: function run() {
      this.$source.on("change", this._onSourceChange.bind(this));

      this._onSourceChange();
    }
  }, {
    key: "_onSourceChange",
    value: function _onSourceChange() {
      var select = this.$select;
      var params = this.sourceToParams(this.$source);
      var url = this.$source.data("url");
      $.getJSON(url, params, function (data) {
        select.find("option:not([value=''])").remove();
        var selectedValue = select.data("selected");
        data.forEach(function (option) {
          var optionElement = $("<option value=\"".concat(option.id, "\">").concat(option.body, "</option>")).appendTo(select);

          if (option.id === selectedValue) {
            optionElement.attr("selected", true);
          }
        });

        if (selectedValue) {
          select.val(selectedValue);
        }
      });
    }
  }]);

  return AutoSelectOptionsFromUrl;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/collapsible_questions.js":
/*!************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/collapsible_questions.js ***!
  \************************************************************************************************************************************************************************/
/***/ (function() {

(function () {
  $("button.collapse-all").on("click", function () {
    $(".collapsible").addClass("hide");
    $(".question--collapse .icon-expand").removeClass("hide");
    $(".question--collapse .icon-collapse").addClass("hide");
  });
  $("button.expand-all").on("click", function () {
    $(".collapsible").removeClass("hide");
    $(".question--collapse .icon-expand").addClass("hide");
    $(".question--collapse .icon-collapse").removeClass("hide");
  });
})(window);

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/forms.js":
/*!********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/forms.js ***!
  \********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createEditableForm; }
/* harmony export */ });
/* harmony import */ var src_decidim_forms_admin_auto_buttons_by_min_items_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/forms/admin/auto_buttons_by_min_items.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_buttons_by_min_items.component.js");
/* harmony import */ var src_decidim_forms_admin_auto_select_options_by_total_items_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/forms/admin/auto_select_options_by_total_items.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_select_options_by_total_items.component.js");
/* harmony import */ var src_decidim_forms_admin_auto_select_options_from_url_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/forms/admin/auto_select_options_from_url.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/auto_select_options_from_url.component.js");
/* harmony import */ var src_decidim_forms_admin_live_text_update_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/forms/admin/live_text_update.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/live_text_update.component.js");
/* harmony import */ var src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! src/decidim/admin/auto_buttons_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_buttons_by_position.component.js");
/* harmony import */ var src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! src/decidim/admin/auto_label_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_label_by_position.component.js");
/* harmony import */ var src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! src/decidim/admin/sort_list.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/sort_list.component.js");
/* harmony import */ var src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! src/decidim/admin/dynamic_fields.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/dynamic_fields.component.js");
/* harmony import */ var src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! src/decidim/admin/field_dependent_inputs.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/field_dependent_inputs.component.js");
/* harmony import */ var src_decidim_editor__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! src/decidim/editor */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor.js");
/* eslint-disable max-lines */

/* eslint-disable require-jsdoc */










function createEditableForm() {
  var wrapperSelector = ".questionnaire-questions";
  var fieldSelector = ".questionnaire-question";
  var questionTypeSelector = "select[name$=\\[question_type\\]]";
  var answerOptionFieldSelector = ".questionnaire-question-answer-option";
  var answerOptionsWrapperSelector = ".questionnaire-question-answer-options";
  var answerOptionRemoveFieldButtonSelector = ".remove-answer-option";
  var matrixRowFieldSelector = ".questionnaire-question-matrix-row";
  var matrixRowsWrapperSelector = ".questionnaire-question-matrix-rows";
  var matrixRowRemoveFieldButtonSelector = ".remove-matrix-row";
  var addMatrixRowButtonSelector = ".add-matrix-row";
  var maxChoicesWrapperSelector = ".questionnaire-question-max-choices";
  var displayConditionFieldSelector = ".questionnaire-question-display-condition";
  var displayConditionsWrapperSelector = ".questionnaire-question-display-conditions";
  var displayConditionRemoveFieldButtonSelector = ".remove-display-condition";
  var displayConditionQuestionSelector = "select[name$=\\[decidim_condition_question_id\\]]";
  var displayConditionAnswerOptionSelector = "select[name$=\\[decidim_answer_option_id\\]]";
  var displayConditionTypeSelector = "select[name$=\\[condition_type\\]]";
  var deletedInputSelector = "input[name$=\\[deleted\\]]";
  var displayConditionValueWrapperSelector = ".questionnaire-question-display-condition-value";
  var displayconditionAnswerOptionWrapperSelector = ".questionnaire-question-display-condition-answer-option";
  var addDisplayConditionButtonSelector = ".add-display-condition";

  var removeDisplayConditionsForFirstQuestion = function removeDisplayConditionsForFirstQuestion() {
    $(fieldSelector).each(function (idx, el) {
      var $question = $(el);

      if (idx) {
        $question.find(displayConditionsWrapperSelector).find(deletedInputSelector).val("false");
        $question.find(displayConditionsWrapperSelector).show();
      } else {
        $question.find(displayConditionsWrapperSelector).find(deletedInputSelector).val("true");
        $question.find(displayConditionsWrapperSelector).hide();
      }
    });
  };

  var autoButtonsByPosition = new src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_4__["default"]({
    listSelector: ".questionnaire-question:not(.hidden)",
    hideOnFirstSelector: ".move-up-question",
    hideOnLastSelector: ".move-down-question"
  });
  var autoLabelByPosition = new src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_5__["default"]({
    listSelector: ".questionnaire-question:not(.hidden)",
    labelSelector: ".card-title span:first",
    onPositionComputed: function onPositionComputed(el, idx) {
      $(el).find("input[name$=\\[position\\]]:not([name*=\\[matrix_rows\\]])").val(idx);
      autoButtonsByPosition.run();
      removeDisplayConditionsForFirstQuestion();
    }
  });
  var MULTIPLE_CHOICE_VALUES = ["single_option", "multiple_option", "sorting", "matrix_single", "matrix_multiple"];
  var MATRIX_VALUES = ["matrix_single", "matrix_multiple"];

  var createAutoMaxChoicesByNumberOfAnswerOptions = function createAutoMaxChoicesByNumberOfAnswerOptions(fieldId) {
    return new src_decidim_forms_admin_auto_select_options_by_total_items_component__WEBPACK_IMPORTED_MODULE_1__["default"]({
      wrapperSelector: fieldSelector,
      selectSelector: "".concat(maxChoicesWrapperSelector, " select"),
      listSelector: "#".concat(fieldId, " ").concat(answerOptionsWrapperSelector, " .questionnaire-question-answer-option:not(.hidden)")
    });
  };

  var createAutoButtonsByMinItemsForAnswerOptions = function createAutoButtonsByMinItemsForAnswerOptions(fieldId) {
    return new src_decidim_forms_admin_auto_buttons_by_min_items_component__WEBPACK_IMPORTED_MODULE_0__["default"]({
      wrapperSelector: fieldSelector,
      listSelector: "#".concat(fieldId, " ").concat(answerOptionsWrapperSelector, " .questionnaire-question-answer-option:not(.hidden)"),
      minItems: 2,
      hideOnMinItemsOrLessSelector: answerOptionRemoveFieldButtonSelector
    });
  };

  var createAutoSelectOptionsFromUrl = function createAutoSelectOptionsFromUrl($field) {
    return new src_decidim_forms_admin_auto_select_options_from_url_component__WEBPACK_IMPORTED_MODULE_2__["default"]({
      source: $field.find(displayConditionQuestionSelector),
      select: $field.find(displayConditionAnswerOptionSelector),
      sourceToParams: function sourceToParams($element) {
        return {
          id: $element.val()
        };
      }
    });
  };

  var createSortableList = function createSortableList() {
    (0,src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_6__["default"])(".questionnaire-questions-list:not(.published)", {
      handle: ".question-divider",
      placeholder: '<div style="border-style: dashed; border-color: #000"></div>',
      forcePlaceholderSize: true,
      onSortUpdate: function onSortUpdate() {
        autoLabelByPosition.run();
        autoButtonsByPosition.run();
      }
    });
  };

  var createDynamicQuestionTitle = function createDynamicQuestionTitle(fieldId) {
    var targetSelector = "#".concat(fieldId, " .question-title-statement");
    var locale = $(targetSelector).data("locale");
    var maxLength = $(targetSelector).data("max-length");
    var omission = $(targetSelector).data("omission");
    var placeholder = $(targetSelector).data("placeholder");
    return (0,src_decidim_forms_admin_live_text_update_component__WEBPACK_IMPORTED_MODULE_3__["default"])({
      inputSelector: "#".concat(fieldId, " input[name$=\\[body_").concat(locale, "\\]]"),
      targetSelector: targetSelector,
      maxLength: maxLength,
      omission: omission,
      placeholder: placeholder
    });
  };

  var createCollapsibleQuestion = function createCollapsibleQuestion($target) {
    var $collapsible = $target.find(".collapsible");

    if ($collapsible.length > 0) {
      var collapsibleId = $collapsible.attr("id").replace("-question-card", "");
      var toggleAttr = "".concat(collapsibleId, "-question-card button--collapse-question-").concat(collapsibleId, " button--expand-question-").concat(collapsibleId);
      $target.find(".question--collapse").data("toggle", toggleAttr);
    }
  };

  var createDynamicFieldsForAnswerOptions = function createDynamicFieldsForAnswerOptions(fieldId) {
    var autoButtons = createAutoButtonsByMinItemsForAnswerOptions(fieldId);
    var autoSelectOptions = createAutoMaxChoicesByNumberOfAnswerOptions(fieldId);
    return (0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_7__["default"])({
      placeholderId: "questionnaire-question-answer-option-id",
      wrapperSelector: "#".concat(fieldId, " ").concat(answerOptionsWrapperSelector),
      containerSelector: ".questionnaire-question-answer-options-list",
      fieldSelector: answerOptionFieldSelector,
      addFieldButtonSelector: ".add-answer-option",
      fieldTemplateSelector: ".decidim-answer-option-template",
      removeFieldButtonSelector: answerOptionRemoveFieldButtonSelector,
      onAddField: function onAddField() {
        autoButtons.run();
        autoSelectOptions.run();
      },
      onRemoveField: function onRemoveField() {
        autoButtons.run();
        autoSelectOptions.run();
      }
    });
  };

  var dynamicFieldsForAnswerOptions = {};

  var createDynamicFieldsForMatrixRows = function createDynamicFieldsForMatrixRows(fieldId) {
    return (0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_7__["default"])({
      placeholderId: "questionnaire-question-matrix-row-id",
      wrapperSelector: "#".concat(fieldId, " ").concat(matrixRowsWrapperSelector),
      containerSelector: ".questionnaire-question-matrix-rows-list",
      fieldSelector: matrixRowFieldSelector,
      addFieldButtonSelector: addMatrixRowButtonSelector,
      fieldTemplateSelector: ".decidim-matrix-row-template",
      removeFieldButtonSelector: matrixRowRemoveFieldButtonSelector,
      onAddField: function onAddField() {},
      onRemoveField: function onRemoveField() {}
    });
  };

  var dynamicFieldsForMatrixRows = {};

  var isMultipleChoiceOption = function isMultipleChoiceOption(value) {
    return MULTIPLE_CHOICE_VALUES.indexOf(value) >= 0;
  };

  var isMatrix = function isMatrix(value) {
    return MATRIX_VALUES.indexOf(value) >= 0;
  };

  var getSelectedQuestionType = function getSelectedQuestionType(select) {
    var selectedOption = select.options[select.selectedIndex];
    return $(selectedOption).data("type");
  };

  var onDisplayConditionQuestionChange = function onDisplayConditionQuestionChange($field) {
    var $questionSelector = $field.find(displayConditionQuestionSelector);
    var selectedQuestionType = getSelectedQuestionType($questionSelector[0]);
    var isMultiple = isMultipleChoiceOption(selectedQuestionType);
    var conditionTypes = ["answered", "not_answered"];

    if (isMultiple) {
      conditionTypes.push("equal");
      conditionTypes.push("not_equal");
    }

    conditionTypes.push("match");
    var $conditionTypeSelect = $field.find(displayConditionTypeSelector);
    $conditionTypeSelect.find("option").each(function (idx, option) {
      var $option = $(option);
      var value = $option.val();

      if (!value) {
        return;
      }

      $option.show();

      if (conditionTypes.indexOf(value) < 0) {
        $option.hide();
      }
    });

    if (conditionTypes.indexOf($conditionTypeSelect.val()) < 0) {
      $conditionTypeSelect.val(conditionTypes[0]);
    }

    $conditionTypeSelect.trigger("change");
  };

  var onDisplayConditionTypeChange = function onDisplayConditionTypeChange($field) {
    var value = $field.find(displayConditionTypeSelector).val();
    var $valueWrapper = $field.find(displayConditionValueWrapperSelector);
    var $answerOptionWrapper = $field.find(displayconditionAnswerOptionWrapperSelector);
    var $questionSelector = $field.find(displayConditionQuestionSelector);
    var selectedQuestionType = getSelectedQuestionType($questionSelector[0]);
    var isMultiple = isMultipleChoiceOption(selectedQuestionType);

    if (value === "match") {
      $valueWrapper.show();
    } else {
      $valueWrapper.hide();
    }

    if (isMultiple && (value === "not_equal" || value === "equal")) {
      $answerOptionWrapper.show();
    } else {
      $answerOptionWrapper.hide();
    }
  };

  var initializeDisplayConditionField = function initializeDisplayConditionField($field) {
    var autoSelectByUrl = createAutoSelectOptionsFromUrl($field);
    autoSelectByUrl.run();
    $field.find(displayConditionQuestionSelector).on("change", function () {
      onDisplayConditionQuestionChange($field);
    });
    $field.find(displayConditionTypeSelector).on("change", function () {
      onDisplayConditionTypeChange($field);
    });
    onDisplayConditionTypeChange($field);
    onDisplayConditionQuestionChange($field);
  };

  var createDynamicFieldsForDisplayConditions = function createDynamicFieldsForDisplayConditions(fieldId) {
    return (0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_7__["default"])({
      placeholderId: "questionnaire-question-display-condition-id",
      wrapperSelector: "#".concat(fieldId, " ").concat(displayConditionsWrapperSelector),
      containerSelector: ".questionnaire-question-display-conditions-list",
      fieldSelector: displayConditionFieldSelector,
      addFieldButtonSelector: addDisplayConditionButtonSelector,
      removeFieldButtonSelector: displayConditionRemoveFieldButtonSelector,
      onAddField: function onAddField($field) {
        initializeDisplayConditionField($field);
      },
      onRemoveField: function onRemoveField() {}
    });
  };

  var dynamicFieldsForDisplayConditions = {};

  var setupInitialQuestionAttributes = function setupInitialQuestionAttributes($target) {
    var fieldId = $target.attr("id");
    var $fieldQuestionTypeSelect = $target.find(questionTypeSelector);
    createCollapsibleQuestion($target);
    createDynamicQuestionTitle(fieldId);
    (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_8__["default"])({
      controllerField: $fieldQuestionTypeSelect,
      wrapperSelector: fieldSelector,
      dependentFieldsSelector: answerOptionsWrapperSelector,
      dependentInputSelector: "".concat(answerOptionFieldSelector, " input"),
      enablingCondition: function enablingCondition($field) {
        return isMultipleChoiceOption($field.val());
      }
    });
    (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_8__["default"])({
      controllerField: $fieldQuestionTypeSelect,
      wrapperSelector: fieldSelector,
      dependentFieldsSelector: maxChoicesWrapperSelector,
      dependentInputSelector: "select",
      enablingCondition: function enablingCondition($field) {
        return $field.val() === "multiple_option" || $field.val() === "matrix_multiple";
      }
    });
    (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_8__["default"])({
      controllerField: $fieldQuestionTypeSelect,
      wrapperSelector: fieldSelector,
      dependentFieldsSelector: matrixRowsWrapperSelector,
      dependentInputSelector: "".concat(matrixRowFieldSelector, " input"),
      enablingCondition: function enablingCondition($field) {
        return isMatrix($field.val());
      }
    });
    dynamicFieldsForAnswerOptions[fieldId] = createDynamicFieldsForAnswerOptions(fieldId);
    dynamicFieldsForMatrixRows[fieldId] = createDynamicFieldsForMatrixRows(fieldId);
    dynamicFieldsForDisplayConditions[fieldId] = createDynamicFieldsForDisplayConditions(fieldId);
    var dynamicFieldsAnswerOptions = dynamicFieldsForAnswerOptions[fieldId];
    var dynamicFieldsMatrixRows = dynamicFieldsForMatrixRows[fieldId];

    var onQuestionTypeChange = function onQuestionTypeChange() {
      if (isMultipleChoiceOption($fieldQuestionTypeSelect.val())) {
        var nOptions = $fieldQuestionTypeSelect.parents(fieldSelector).find(answerOptionFieldSelector).length;

        if (nOptions === 0) {
          dynamicFieldsAnswerOptions._addField();

          dynamicFieldsAnswerOptions._addField();
        }
      }

      if (isMatrix($fieldQuestionTypeSelect.val())) {
        var nRows = $fieldQuestionTypeSelect.parents(fieldSelector).find(matrixRowFieldSelector).length;

        if (nRows === 0) {
          dynamicFieldsMatrixRows._addField();

          dynamicFieldsMatrixRows._addField();
        }
      }
    };

    $fieldQuestionTypeSelect.on("change", onQuestionTypeChange);
    onQuestionTypeChange();
  };

  var hideDeletedQuestion = function hideDeletedQuestion($target) {
    var inputDeleted = $target.find("input[name$=\\[deleted\\]]").val();

    if (inputDeleted === "true") {
      $target.addClass("hidden");
      $target.hide();
    }
  };

  (0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_7__["default"])({
    placeholderId: "questionnaire-question-id",
    wrapperSelector: wrapperSelector,
    containerSelector: ".questionnaire-questions-list",
    fieldSelector: fieldSelector,
    addFieldButtonSelector: ".add-question",
    addSeparatorButtonSelector: ".add-separator",
    addTitleAndDescriptionButtonSelector: ".add-title-and-description",
    fieldTemplateSelector: ".decidim-question-template",
    separatorTemplateSelector: ".decidim-separator-template",
    TitleAndDescriptionTemplateSelector: ".decidim-title-and-description-template",
    removeFieldButtonSelector: ".remove-question",
    moveUpFieldButtonSelector: ".move-up-question",
    moveDownFieldButtonSelector: ".move-down-question",
    onAddField: function onAddField($field) {
      setupInitialQuestionAttributes($field);
      createSortableList();
      $field.find(".editor-container").each(function (idx, el) {
        (0,src_decidim_editor__WEBPACK_IMPORTED_MODULE_9__["default"])(el);
      });
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
    },
    onRemoveField: function onRemoveField($field) {
      autoLabelByPosition.run();
      autoButtonsByPosition.run();
      $field.find(answerOptionRemoveFieldButtonSelector).each(function (idx, el) {
        dynamicFieldsForAnswerOptions[$field.attr("id")]._removeField(el);
      });
      $field.find(matrixRowRemoveFieldButtonSelector).each(function (idx, el) {
        dynamicFieldsForMatrixRows[$field.attr("id")]._removeField(el);
      });
      $field.find(displayConditionRemoveFieldButtonSelector).each(function (idx, el) {
        dynamicFieldsForDisplayConditions[$field.attr("id")]._removeField(el);
      });
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
    hideDeletedQuestion($target);
    setupInitialQuestionAttributes($target);
  });
  $(displayConditionFieldSelector).each(function (idx, el) {
    var $field = $(el);
    initializeDisplayConditionField($field);
  });
  autoLabelByPosition.run();
  autoButtonsByPosition.run();
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/live_text_update.component.js":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/admin/live_text_update.component.js ***!
  \*****************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createLiveTextUpdateComponent; }
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

/**
 * This component allows for an element's text value to be updated with the value
 * of an input whenever this input's value is changed.
 *
 * @param {object} options
 *
 * Available options:
 * {string} `inputSelector`:  The query selector to locate the input element
 * {string} `targetSelector`: The query selector to locate the target element
 * {number} `maxLength`: The maximum characters from the input value to be displayed in the target
 * {string} `omission`: The string used to shorten the value to the given maxLength (e.g. "...")
 * {string} `placeholder`: The string to be displayed in the target element when the input has no value
 */


var LiveTextUpdateComponent = /*#__PURE__*/function () {
  function LiveTextUpdateComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, LiveTextUpdateComponent);

    this.inputSelector = options.inputSelector;
    this.targetSelector = options.targetSelector;
    this.maxLength = options.maxLength;
    this.omission = options.omission;
    this.placeholder = options.placeholder;

    this._bindEvent();

    this._run();
  }

  _createClass(LiveTextUpdateComponent, [{
    key: "_run",
    value: function _run() {
      var $input = $(this.inputSelector);
      var $target = $(this.targetSelector);
      var text = $input.val() || this.placeholder; // truncate string

      if (text.length > this.maxLength) {
        text = text.substring(0, this.maxLength - this.omission.length) + this.omission;
      }

      $target.text(text);
    }
  }, {
    key: "_bindEvent",
    value: function _bindEvent() {
      var $input = $(this.inputSelector);
      $input.on("change", this._run.bind(this));
    }
  }]);

  return LiveTextUpdateComponent;
}();

function createLiveTextUpdateComponent(options) {
  return new LiveTextUpdateComponent(options);
}

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
/******/ 			"decidim_forms_admin": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["vendors-node_modules_html5sortable_dist_html5sortable_es_js","_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-core_app_-8aee6a","_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-admin_app-16f163"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/entrypoints/decidim_forms_admin.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_forms_admin.js.map