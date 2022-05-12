"use strict";
(self["webpackChunkapp"] = self["webpackChunkapp"] || []).push([["_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-admin_app-16f163"],{

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_buttons_by_position.component.js":
/*!*******************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_buttons_by_position.component.js ***!
  \*******************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ AutoButtonsByPositionComponent; }
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

var AutoButtonsByPositionComponent = /*#__PURE__*/function () {
  function AutoButtonsByPositionComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, AutoButtonsByPositionComponent);

    this.listSelector = options.listSelector;
    this.hideOnFirstSelector = options.hideOnFirstSelector;
    this.hideOnLastSelector = options.hideOnLastSelector;
    this.run();
  }

  _createClass(AutoButtonsByPositionComponent, [{
    key: "run",
    value: function run() {
      var $list = $(this.listSelector);
      var hideOnFirst = this.hideOnFirstSelector;
      var hideOnLast = this.hideOnLastSelector;

      if ($list.length === 1) {
        var $item = $list.first();
        $item.find(hideOnFirst).hide();
        $item.find(hideOnLast).hide();
      } else {
        $list.each(function (idx, el) {
          if (el.id === $list.first().attr("id")) {
            $(el).find(hideOnFirst).hide();
            $(el).find(hideOnLast).show();
          } else if (el.id === $list.last().attr("id")) {
            $(el).find(hideOnLast).hide();
            $(el).find(hideOnFirst).show();
          } else {
            $(el).find(hideOnLast).show();
            $(el).find(hideOnFirst).show();
          }
        });
      }
    }
  }]);

  return AutoButtonsByPositionComponent;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_label_by_position.component.js":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_label_by_position.component.js ***!
  \*****************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ AutoLabelByPositionComponent; }
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

var AutoLabelByPositionComponent = /*#__PURE__*/function () {
  function AutoLabelByPositionComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, AutoLabelByPositionComponent);

    this.listSelector = options.listSelector;
    this.labelSelector = options.labelSelector;
    this.onPositionComputed = options.onPositionComputed;
    this.run();
  }

  _createClass(AutoLabelByPositionComponent, [{
    key: "run",
    value: function run() {
      var _this = this;

      var $list = $(this.listSelector);
      $list.each(function (idx, el) {
        var $label = $(el).find(_this.labelSelector);
        var labelContent = $label.html();

        if (labelContent.match(/#(\d+)/)) {
          $label.html(labelContent.replace(/#(\d+)/, "#".concat(idx + 1)));
        } else {
          $label.html("".concat(labelContent, " #").concat(idx + 1));
        }

        if (_this.onPositionComputed) {
          _this.onPositionComputed(el, idx);
        }
      });
    }
  }]);

  return AutoLabelByPositionComponent;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/dynamic_fields.component.js":
/*!*********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/dynamic_fields.component.js ***!
  \*********************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createDynamicFields; }
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


var DynamicFieldsComponent = /*#__PURE__*/function () {
  function DynamicFieldsComponent() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck(this, DynamicFieldsComponent);

    this.wrapperSelector = options.wrapperSelector;
    this.containerSelector = options.containerSelector;
    this.fieldSelector = options.fieldSelector;
    this.addFieldButtonSelector = options.addFieldButtonSelector;
    this.addSeparatorButtonSelector = options.addSeparatorButtonSelector;
    this.addTitleAndDescriptionButtonSelector = options.addTitleAndDescriptionButtonSelector;
    this.fieldTemplateSelector = options.fieldTemplateSelector;
    this.separatorTemplateSelector = options.separatorTemplateSelector;
    this.TitleAndDescriptionTemplateSelector = options.TitleAndDescriptionTemplateSelector;
    this.removeFieldButtonSelector = options.removeFieldButtonSelector;
    this.moveUpFieldButtonSelector = options.moveUpFieldButtonSelector;
    this.moveDownFieldButtonSelector = options.moveDownFieldButtonSelector;
    this.onAddField = options.onAddField;
    this.onRemoveField = options.onRemoveField;
    this.onMoveUpField = options.onMoveUpField;
    this.onMoveDownField = options.onMoveDownField;
    this.placeholderId = options.placeholderId;
    this.elementCounter = 0;

    this._enableInterpolation();

    this._activateFields();

    this._bindEvents();
  }

  _createClass(DynamicFieldsComponent, [{
    key: "_enableInterpolation",
    value: function _enableInterpolation() {
      $.fn.replaceAttribute = function (attribute, placeholder, value) {
        $(this).find("[".concat(attribute, "*=").concat(placeholder, "]")).addBack("[".concat(attribute, "*=").concat(placeholder, "]")).each(function (index, element) {
          $(element).attr(attribute, $(element).attr(attribute).replace(placeholder, value));
        });
        return this;
      };

      $.fn.template = function (placeholder, value) {
        // See the comment below in the `_addField()` method regarding the
        // `<template>` tag support in IE11.
        var $subtemplate = $(this).find("template, .decidim-template");

        if ($subtemplate.length > 0) {
          $subtemplate.html(function (index, oldHtml) {
            return $(oldHtml).template(placeholder, value)[0].outerHTML;
          });
        } // Handle those subtemplates that are mapped with the `data-template`
        // attribute. This is also because of the IE11 support.


        var $subtemplateParents = $(this).find("[data-template]");

        if ($subtemplateParents.length > 0) {
          $subtemplateParents.each(function (_i, elem) {
            var $self = $(elem);
            var $tpl = $($self.data("template")); // Duplicate the sub-template with a unique ID as there may be
            // multiple parent templates referring to the same sub-template.

            var $subtpl = $($tpl[0].outerHTML);
            var subtemplateId = "".concat($tpl.attr("id"), "-").concat(value);
            var subtemplateSelector = "#".concat(subtemplateId);
            $subtpl.attr("id", subtemplateId);
            $self.attr("data-template", subtemplateSelector).data("template", subtemplateSelector);
            $tpl.after($subtpl);
            $subtpl.html(function (index, oldHtml) {
              return $(oldHtml).template(placeholder, value)[0].outerHTML;
            });
          });
        }

        $(this).replaceAttribute("id", placeholder, value);
        $(this).replaceAttribute("name", placeholder, value);
        $(this).replaceAttribute("data-tabs-content", placeholder, value);
        $(this).replaceAttribute("for", placeholder, value);
        $(this).replaceAttribute("tabs_id", placeholder, value);
        $(this).replaceAttribute("href", placeholder, value);
        return this;
      };
    }
  }, {
    key: "_bindEvents",
    value: function _bindEvents() {
      var _this = this;

      $(this.wrapperSelector).on("click", this.addFieldButtonSelector, function (event) {
        return _this._bindSafeEvent(event, function () {
          return _this._addField(_this.fieldTemplateSelector);
        });
      });

      if (this.addSeparatorButtonSelector) {
        $(this.wrapperSelector).on("click", this.addSeparatorButtonSelector, function (event) {
          return _this._bindSafeEvent(event, function () {
            return _this._addField(_this.separatorTemplateSelector);
          });
        });
      }

      if (this.addTitleAndDescriptionButtonSelector) {
        $(this.wrapperSelector).on("click", this.addTitleAndDescriptionButtonSelector, function (event) {
          return _this._bindSafeEvent(event, function () {
            return _this._addField(_this.TitleAndDescriptionTemplateSelector);
          });
        });
      }

      $(this.wrapperSelector).on("click", this.removeFieldButtonSelector, function (event) {
        return _this._bindSafeEvent(event, function (target) {
          return _this._removeField(target);
        });
      });

      if (this.moveUpFieldButtonSelector) {
        $(this.wrapperSelector).on("click", this.moveUpFieldButtonSelector, function (event) {
          return _this._bindSafeEvent(event, function (target) {
            return _this._moveUpField(target);
          });
        });
      }

      if (this.moveDownFieldButtonSelector) {
        $(this.wrapperSelector).on("click", this.moveDownFieldButtonSelector, function (event) {
          return _this._bindSafeEvent(event, function (target) {
            return _this._moveDownField(target);
          });
        });
      }
    }
  }, {
    key: "_bindSafeEvent",
    value: function _bindSafeEvent(event, cb) {
      event.preventDefault();
      event.stopPropagation();

      try {
        return cb(event.target);
      } catch (error) {
        console.error(error); // eslint-disable-line no-console

        return error;
      }
    } // Adds a field.
    //
    // template - A String matching the type of the template. Expected to be
    //  either ".decidim-question-template" or ".decidim-separator-template".

  }, {
    key: "_addField",
    value: function _addField() {
      var templateClass = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : ".decidim-template";
      var $wrapper = $(this.wrapperSelector);
      var $container = $wrapper.find(this.containerSelector); // Allow defining the template using a `data-template` attribute on the
      // wrapper element. This is to allow child templates which would otherwise
      // be impossible using `<script type="text/template">`. See the comment
      // below regarding the `<template>` tag and IE11.

      var templateSelector = $wrapper.data("template");
      var $template = null;

      if (templateSelector) {
        $template = $(templateSelector);
      }

      if ($template === null || $template.length < 1) {
        // To preserve IE11 backwards compatibility, the views are using
        // `<script type="text/template">` with a given `class` instead of
        // `<template>`. The `<template> tags are parsed in IE11 along with the
        // DOM which may cause the form elements inside them to break the forms
        // as they are submitted with them.
        $template = $wrapper.children("template, ".concat(templateClass));
      }

      var $newField = $($template.html()).template(this.placeholderId, this._getUID());
      $newField.find("ul.tabs").attr("data-tabs", true);
      var $lastQuestion = $container.find(this.fieldSelector).last();

      if ($lastQuestion.length > 0) {
        $lastQuestion.after($newField);
      } else {
        $newField.appendTo($container);
      }

      $newField.foundation();

      if (this.onAddField) {
        this.onAddField($newField);
      }
    }
  }, {
    key: "_removeField",
    value: function _removeField(target) {
      var $target = $(target);
      var $removedField = $target.parents(this.fieldSelector);
      var idInput = $removedField.find("input").filter(function (idx, input) {
        return input.name.match(/id/);
      });

      if (idInput.length > 0) {
        var deletedInput = $removedField.find("input").filter(function (idx, input) {
          return input.name.match(/delete/);
        });

        if (deletedInput.length > 0) {
          $(deletedInput[0]).val(true);
        }

        $removedField.addClass("hidden");
        $removedField.hide();
      } else {
        $removedField.remove();
      }

      if (this.onRemoveField) {
        this.onRemoveField($removedField);
      }
    }
  }, {
    key: "_moveUpField",
    value: function _moveUpField(target) {
      var $target = $(target);
      var $movedUpField = $target.parents(this.fieldSelector);
      $movedUpField.prev().before($movedUpField);

      if (this.onMoveUpField) {
        this.onMoveUpField($movedUpField);
      }
    }
  }, {
    key: "_moveDownField",
    value: function _moveDownField(target) {
      var $target = $(target);
      var $movedDownField = $target.parents(this.fieldSelector);
      $movedDownField.next().after($movedDownField);

      if (this.onMoveDownField) {
        this.onMoveDownField($movedDownField);
      }
    }
  }, {
    key: "_activateFields",
    value: function _activateFields() {
      var _this2 = this; // Move the `<script type="text/template">` elements to the bottom of the
      // list container so that they will not cause the question moving
      // functionality to break since it assumes that all children elements are
      // the dynamic field list child items.


      var $wrapper = $(this.wrapperSelector);
      var $container = $wrapper.find(this.containerSelector);
      $container.append($container.find("script"));
      $(this.fieldSelector).each(function (idx, el) {
        $(el).template(_this2.placeholderId, _this2._getUID());
        $(el).find("ul.tabs").attr("data-tabs", true);
      });
    }
  }, {
    key: "_getUID",
    value: function _getUID() {
      this.elementCounter += 1;
      return new Date().getTime() + this.elementCounter;
    }
  }]);

  return DynamicFieldsComponent;
}();

function createDynamicFields(options) {
  return new DynamicFieldsComponent(options);
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/sort_list.component.js":
/*!****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/sort_list.component.js ***!
  \****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createSortList; }
/* harmony export */ });
/* harmony import */ var html5sortable_dist_html5sortable_es__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! html5sortable/dist/html5sortable.es */ "./node_modules/html5sortable/dist/html5sortable.es.js");
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

function _classCallCheck(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}
/* eslint-disable require-jsdoc */




var SortListComponent = /*#__PURE__*/_createClass(
/**
 * Creates a sortable list using hmtl5sortable function.
 *
 * @param {String} sortListSelector The list selector that has to be sortable.
 * @param {Object} options An object containing the same options as html5sortable. It also includes
 *                an extra option `onSortUpdate`, a callback which returns the children collection
 *                whenever the list order has been changed.
 *
 * @returns {void} Nothing.
 */
function SortListComponent(sortListSelector, options) {
  _classCallCheck(this, SortListComponent);

  if ($(sortListSelector).length > 0) {
    (0,html5sortable_dist_html5sortable_es__WEBPACK_IMPORTED_MODULE_0__["default"])(sortListSelector, options)[0].addEventListener("sortupdate", function (event) {
      var $children = $(event.target).children();

      if (options.onSortUpdate) {
        options.onSortUpdate($children);
      }
    });
  }
});

function createSortList(sortListSelector, options) {
  return new SortListComponent(sortListSelector, options);
}

/***/ })

}]);
//# sourceMappingURL=_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-admin_app-16f163.js.map