"use strict";
(self["webpackChunkapp"] = self["webpackChunkapp"] || []).push([["_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-forms_app-eb61c3"],{

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/autosortable_checkboxes.component.js":
/*!******************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/autosortable_checkboxes.component.js ***!
  \******************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createAutosortableCheckboxes; }
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

/* eslint-disable no-ternary */


var AutosortableCheckboxesComponent = /*#__PURE__*/function () {
  function AutosortableCheckboxesComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, AutosortableCheckboxesComponent);

    this.wrapperField = options.wrapperField;

    this._bindEvent();

    this._order();

    this._normalize();
  } // Order by position


  _createClass(AutosortableCheckboxesComponent, [{
    key: "_order",
    value: function _order() {
      var max = $(this.wrapperField).find(".collection-input").length;
      $(this.wrapperField).find(".collection-input").each(function (idx, el) {
        var $positionField = $(el).find("input[name$=\\[position\\]]");
        var position = $positionField.val() ? parseInt($positionField.val(), 10) : max;
        var $next = $(el).next();

        while ($next.length > 0) {
          var $nextPositionField = $next.find("input[name$=\\[position\\]]");
          var nextPosition = $nextPositionField.val() ? parseInt($nextPositionField.val(), 10) : max;

          if (position > nextPosition) {
            $next.insertBefore($(el));
          }

          $next = $next.next();
        }
      });
    }
  }, {
    key: "_findLastPosition",
    value: function _findLastPosition() {
      var lastPosition = 0;
      $(this.wrapperField).find(".collection-input").each(function (idx, el) {
        var $positionField = $(el).find("input[name$=\\[position\\]]");
        var position = parseInt($positionField.val(), 10);

        if (position > lastPosition) {
          lastPosition = position;
        }
      });
      return lastPosition;
    }
  }, {
    key: "_normalize",
    value: function _normalize() {
      $(this.wrapperField).find(".collection-input .position").each(function (idx, el) {
        var $positionField = $(el).parent().find("input[name$=\\[position\\]]");

        if ($positionField.val()) {
          $positionField.val(idx);
          $positionField.prop("disabled", false);
          $(el).html("".concat(idx + 1, ". "));
        }
      });
    }
  }, {
    key: "_bindEvent",
    value: function _bindEvent() {
      var _this = this;

      $(this.wrapperField).find("input[type=checkbox]").on("change", function (el) {
        var $parentLabel = $(el.target).parents("label");
        var $positionSelector = $parentLabel.find(".position");
        var $positionField = $parentLabel.find("input[name$=\\[position\\]]");

        var lastPosition = _this._findLastPosition();

        if (el.target.checked) {
          $positionField.val(lastPosition + 1);
          $positionField.prop("disabled", false);
          $positionSelector.html(lastPosition + 1);
        } else {
          $positionField.val("");
          $positionField.prop("disabled", true);
          $positionSelector.html("");
        }

        _this._order();

        _this._normalize();
      });
    }
  }]);

  return AutosortableCheckboxesComponent;
}();

function createAutosortableCheckboxes(options) {
  return new AutosortableCheckboxesComponent(options);
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/display_conditions.component.js":
/*!*************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/display_conditions.component.js ***!
  \*************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createDisplayConditions; }
/* harmony export */ });
function _typeof(obj) {
  "@babel/helpers - typeof";

  return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
    return typeof obj;
  } : function (obj) {
    return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
  }, _typeof(obj);
}

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
/* eslint-disable no-ternary, no-plusplus, require-jsdoc */


var DisplayCondition = /*#__PURE__*/function () {
  function DisplayCondition() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, DisplayCondition);

    this.wrapperField = options.wrapperField;
    this.type = options.type;
    this.conditionQuestion = options.conditionQuestion;
    this.answerOption = options.answerOption;
    this.mandatory = options.mandatory;
    this.value = options.value;
    this.onFulfilled = options.onFulfilled;
    this.bindEvent();
  }

  _createClass(DisplayCondition, [{
    key: "bindEvent",
    value: function bindEvent() {
      this.checkCondition();
      this.getInputsToListen().on("change", this.checkCondition.bind(this));
    }
  }, {
    key: "getInputValue",
    value: function getInputValue() {
      var $conditionWrapperField = $(".question[data-question-id='".concat(this.conditionQuestion, "']"));
      var $textInput = $conditionWrapperField.find("textarea, input[type='text']:not([name$=\\[custom_body\\]])");

      if ($textInput.length) {
        return $textInput.val();
      }

      var multipleInput = [];
      $conditionWrapperField.find(".radio-button-collection, .check-box-collection").find(".collection-input").each(function (idx, el) {
        var $input = $(el).find("input[name$=\\[body\\]]");
        var checked = $input.is(":checked");

        if (checked) {
          var text = $(el).find("input[name$=\\[custom_body\\]]").val();
          var value = $input.val();
          var id = $(el).find("input[name$=\\[answer_option_id\\]]").val();
          multipleInput.push({
            id: id,
            value: value,
            text: text
          });
        }
      });
      return multipleInput;
    }
  }, {
    key: "getInputsToListen",
    value: function getInputsToListen() {
      var $conditionWrapperField = $(".question[data-question-id='".concat(this.conditionQuestion, "']"));
      var $textInput = $conditionWrapperField.find("textarea, input[type='text']:not([name$=\\[custom_body\\]])");

      if ($textInput.length) {
        return $textInput;
      }

      return $conditionWrapperField.find(".collection-input").find("input:not([type='hidden'])");
    }
  }, {
    key: "checkAnsweredCondition",
    value: function checkAnsweredCondition(value) {
      if (_typeof(value) !== "object") {
        return Boolean(value);
      }

      return Boolean(value.some(function (it) {
        return it.value;
      }));
    }
  }, {
    key: "checkNotAnsweredCondition",
    value: function checkNotAnsweredCondition(value) {
      return !this.checkAnsweredCondition(value);
    }
  }, {
    key: "checkEqualCondition",
    value: function checkEqualCondition(value) {
      var _this = this;

      if (value.length) {
        return value.some(function (it) {
          return it.id === _this.answerOption.toString();
        });
      }

      return false;
    }
  }, {
    key: "checkNotEqualCondition",
    value: function checkNotEqualCondition(value) {
      var _this2 = this;

      if (value.length) {
        return value.every(function (it) {
          return it.id !== _this2.answerOption.toString();
        });
      }

      return false;
    }
  }, {
    key: "checkMatchCondition",
    value: function checkMatchCondition(value) {
      var regexp = new RegExp(this.value, "i");

      if (_typeof(value) !== "object") {
        return Boolean(value.match(regexp));
      }

      return value.some(function (it) {
        return it.text ? it.text.match(regexp) : it.value.match(regexp);
      });
    }
  }, {
    key: "checkCondition",
    value: function checkCondition() {
      var value = this.getInputValue();
      var fulfilled = false;

      switch (this.type) {
        case "answered":
          fulfilled = this.checkAnsweredCondition(value);
          break;

        case "not_answered":
          fulfilled = this.checkNotAnsweredCondition(value);
          break;

        case "equal":
          fulfilled = this.checkEqualCondition(value);
          break;

        case "not_equal":
          fulfilled = this.checkNotEqualCondition(value);
          break;

        case "match":
          fulfilled = this.checkMatchCondition(value);
          break;

        default:
          fulfilled = false;
          break;
      }

      this.onFulfilled(fulfilled);
    }
  }]);

  return DisplayCondition;
}();

var DisplayConditionsComponent = /*#__PURE__*/function () {
  function DisplayConditionsComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, DisplayConditionsComponent);

    this.wrapperField = options.wrapperField;
    this.conditions = {};
    this.showCount = 0;
    this.initializeConditions();
  }

  _createClass(DisplayConditionsComponent, [{
    key: "initializeConditions",
    value: function initializeConditions() {
      var _this3 = this;

      var $conditionElements = this.wrapperField.find(".display-condition");
      $conditionElements.each(function (idx, el) {
        var $condition = $(el);
        var id = $condition.data("id");
        _this3.conditions[id] = {};
        _this3.conditions[id] = new DisplayCondition({
          wrapperField: _this3.wrapperField,
          type: $condition.data("type"),
          conditionQuestion: $condition.data("condition"),
          answerOption: $condition.data("option"),
          mandatory: $condition.data("mandatory"),
          value: $condition.data("value"),
          onFulfilled: function onFulfilled(fulfilled) {
            _this3.onFulfilled(id, fulfilled);
          }
        });
      });
    }
  }, {
    key: "mustShow",
    value: function mustShow() {
      var conditions = Object.values(this.conditions);
      var mandatoryConditions = conditions.filter(function (condition) {
        return condition.mandatory;
      });
      var nonMandatoryConditions = conditions.filter(function (condition) {
        return !condition.mandatory;
      });

      if (mandatoryConditions.length) {
        return mandatoryConditions.every(function (condition) {
          return condition.fulfilled;
        });
      }

      return nonMandatoryConditions.some(function (condition) {
        return condition.fulfilled;
      });
    }
  }, {
    key: "onFulfilled",
    value: function onFulfilled(id, fulfilled) {
      this.conditions[id].fulfilled = fulfilled;

      if (this.mustShow()) {
        this.showQuestion();
      } else {
        this.hideQuestion();
      }
    }
  }, {
    key: "showQuestion",
    value: function showQuestion() {
      this.wrapperField.fadeIn();
      this.wrapperField.find("input, textarea").prop("disabled", null);
      this.showCount++;
    }
  }, {
    key: "hideQuestion",
    value: function hideQuestion() {
      if (this.showCount) {
        this.wrapperField.fadeOut();
      } else {
        this.wrapperField.hide();
      }

      this.wrapperField.find("input, textarea").prop("disabled", "disabled");
    }
  }]);

  return DisplayConditionsComponent;
}();

function createDisplayConditions(options) {
  return new DisplayConditionsComponent(options);
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/forms.js":
/*!**************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/forms.js ***!
  \**************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_forms_option_attached_inputs_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/forms/option_attached_inputs.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/option_attached_inputs.component.js");
/* harmony import */ var src_decidim_forms_autosortable_checkboxes_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/forms/autosortable_checkboxes.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/autosortable_checkboxes.component.js");
/* harmony import */ var src_decidim_forms_display_conditions_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/forms/display_conditions.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/display_conditions.component.js");
/* harmony import */ var src_decidim_forms_max_choices_alert_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/forms/max_choices_alert.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/max_choices_alert.component.js");
/* eslint-disable require-jsdoc */




$(function () {
  $(".radio-button-collection, .check-box-collection").each(function (idx, el) {
    (0,src_decidim_forms_option_attached_inputs_component__WEBPACK_IMPORTED_MODULE_0__["default"])({
      wrapperField: $(el),
      controllerFieldSelector: "input[type=radio], input[type=checkbox]",
      dependentInputSelector: "input[type=text], input[type=hidden]"
    });
  });
  $.unique($(".check-box-collection").parents(".answer")).each(function (idx, el) {
    var maxChoices = $(el).data("max-choices");

    if (maxChoices) {
      (0,src_decidim_forms_max_choices_alert_component__WEBPACK_IMPORTED_MODULE_3__["default"])({
        wrapperField: $(el),
        controllerFieldSelector: "input[type=checkbox]",
        controllerCollectionSelector: ".check-box-collection",
        alertElement: $(el).find(".max-choices-alert"),
        maxChoices: maxChoices
      });
    }
  });
  $(".sortable-check-box-collection").each(function (idx, el) {
    (0,src_decidim_forms_autosortable_checkboxes_component__WEBPACK_IMPORTED_MODULE_1__["default"])({
      wrapperField: $(el)
    });
  });
  $(".answer-questionnaire .question[data-conditioned='true']").each(function (idx, el) {
    (0,src_decidim_forms_display_conditions_component__WEBPACK_IMPORTED_MODULE_2__["default"])({
      wrapperField: $(el)
    });
  });
  var $form = $("form.answer-questionnaire");

  if ($form.length > 0) {
    $form.find("input, textarea, select").on("change", function () {
      $form.data("changed", true);
    });
    var safePath = $form.data("safe-path").split("?")[0];
    $(document).on("click", "a", function (event) {
      window.exitUrl = event.currentTarget.href;
    });
    $(document).on("submit", "form", function (event) {
      window.exitUrl = event.currentTarget.action;
    });
    window.addEventListener("beforeunload", function (event) {
      var exitUrl = window.exitUrl;
      var hasChanged = $form.data("changed");
      window.exitUrl = null;

      if (!hasChanged || exitUrl && exitUrl.includes(safePath)) {
        return;
      }

      event.returnValue = true;
    });
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/max_choices_alert.component.js":
/*!************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/max_choices_alert.component.js ***!
  \************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createMaxChoicesAlertComponent; }
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


var MaxChoicesAlertComponent = /*#__PURE__*/function () {
  function MaxChoicesAlertComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, MaxChoicesAlertComponent);

    this.wrapperField = options.wrapperField;
    this.alertElement = options.alertElement;
    this.controllerFieldSelector = options.controllerFieldSelector;
    this.controllerCollectionSelector = options.controllerCollectionSelector;
    this.maxChoices = options.maxChoices;
    this.controllerSelector = this.wrapperField.find(this.controllerFieldSelector);

    this._bindEvent();

    this._run();
  }

  _createClass(MaxChoicesAlertComponent, [{
    key: "_run",
    value: function _run() {
      var _this = this;

      var rows = this.wrapperField.find(this.controllerCollectionSelector);
      var alert = false;
      rows.each(function (rowIdx, row) {
        var checked = $(row).find(_this.controllerFieldSelector).filter(function (checkboxIdx, checkbox) {
          return $(checkbox).is(":checked");
        });
        alert = alert || checked.length > _this.maxChoices;
      });

      if (alert) {
        this.alertElement.show();
      } else {
        this.alertElement.hide();
      }
    }
  }, {
    key: "_bindEvent",
    value: function _bindEvent() {
      var _this2 = this;

      this.controllerSelector.on("change", function () {
        _this2._run();
      });
    }
  }]);

  return MaxChoicesAlertComponent;
}();

function createMaxChoicesAlertComponent(options) {
  return new MaxChoicesAlertComponent(options);
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/option_attached_inputs.component.js":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-forms/app/packs/src/decidim/forms/option_attached_inputs.component.js ***!
  \*****************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createOptionAttachedInputs; }
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


var OptionAttachedInputsComponent = /*#__PURE__*/function () {
  function OptionAttachedInputsComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, OptionAttachedInputsComponent);

    this.wrapperField = options.wrapperField;
    this.controllerFieldSelector = options.controllerFieldSelector;
    this.dependentInputSelector = options.dependentInputSelector;
    this.controllerSelector = this.wrapperField.find(this.controllerFieldSelector);

    this._bindEvent();

    this._run();
  }

  _createClass(OptionAttachedInputsComponent, [{
    key: "_run",
    value: function _run() {
      var _this = this;

      this.controllerSelector.each(function (idx, el) {
        var $field = $(el);
        var enabled = $field.is(":checked");
        $field.parents("div.collection-input").find(_this.dependentInputSelector).prop("disabled", !enabled);
      });
    }
  }, {
    key: "_bindEvent",
    value: function _bindEvent() {
      var _this2 = this;

      this.controllerSelector.on("change", function () {
        _this2._run();
      });
    }
  }]);

  return OptionAttachedInputsComponent;
}();

function createOptionAttachedInputs(options) {
  return new OptionAttachedInputsComponent(options);
}

/***/ })

}]);
//# sourceMappingURL=_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-forms_app-eb61c3.js.map