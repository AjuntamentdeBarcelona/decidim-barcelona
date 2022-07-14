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

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/admin/assemblies.js":
/*!***********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/admin/assemblies.js ***!
  \***********************************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var $assemblyScopeEnabled = $("#assembly_scopes_enabled");
  var $assemblyScopeId = $("#assembly_scope_id");

  if ($(".edit_assembly, .new_assembly").length > 0) {
    $assemblyScopeEnabled.on("change", function (event) {
      var checked = event.target.checked;
      window.theDataPicker.enabled($assemblyScopeId, checked);
    });
    window.theDataPicker.enabled($assemblyScopeId, $assemblyScopeEnabled.prop("checked"));
  }

  var $form = $(".assembly_form_admin");

  if ($form.length > 0) {
    var $privateSpace = $form.find("#private_space");
    var $isTransparent = $form.find("#is_transparent");
    var $specialFeatures = $form.find("#special_features");

    var toggleDisabledHiddenFields = function toggleDisabledHiddenFields() {
      var enabledPrivateSpace = $privateSpace.find("input[type='checkbox']").prop("checked");
      $isTransparent.find("input[type='checkbox']").attr("disabled", "disabled");
      $specialFeatures.hide();

      if (enabledPrivateSpace) {
        $isTransparent.find("input[type='checkbox']").attr("disabled", !enabledPrivateSpace);
        $specialFeatures.show();
      }
    };

    $privateSpace.on("change", toggleDisabledHiddenFields);
    toggleDisabledHiddenFields();
    var $assemblyType = $form.find("#assembly_assembly_type");
    var $assemblyTypeOther = $form.find("#assembly_type_other");
    var $assemblyCreatedBy = $form.find("#assembly_created_by");
    var $assemblyCreatedByOther = $form.find("#created_by_other");

    var toggleDependsOnSelect = function toggleDependsOnSelect($target, $showDiv) {
      var value = $target.val();
      $showDiv.hide();

      if (value === "others") {
        $showDiv.show();
      }
    };

    $assemblyType.on("change", function (ev) {
      var $target = $(ev.target);
      toggleDependsOnSelect($target, $assemblyTypeOther);
    });
    $assemblyCreatedBy.on("change", function (ev) {
      var $target = $(ev.target);
      toggleDependsOnSelect($target, $assemblyCreatedByOther);
    });
    toggleDependsOnSelect($assemblyType, $assemblyTypeOther);
    toggleDependsOnSelect($assemblyCreatedBy, $assemblyCreatedByOther);
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/admin/assembly_members.js":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/admin/assembly_members.js ***!
  \*****************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/admin/field_dependent_inputs.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/field_dependent_inputs.component.js");

$(function () {
  var $assemblyMemberType = $("#assembly_member_existing_user");
  (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__["default"])({
    controllerField: $assemblyMemberType,
    wrapperSelector: ".user-fields",
    dependentFieldsSelector: ".user-fields--full-name",
    dependentInputSelector: "input",
    enablingCondition: function enablingCondition($field) {
      return $field.val() === "false";
    }
  });
  (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__["default"])({
    controllerField: $assemblyMemberType,
    wrapperSelector: ".user-fields",
    dependentFieldsSelector: ".user-fields--non-user-avatar",
    dependentInputSelector: "input",
    enablingCondition: function enablingCondition($field) {
      return $field.val() === "false";
    }
  });
  (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__["default"])({
    controllerField: $assemblyMemberType,
    wrapperSelector: ".user-fields",
    dependentFieldsSelector: ".user-fields--user-picker",
    dependentInputSelector: "input",
    enablingCondition: function enablingCondition($field) {
      return $field.val() === "true";
    }
  });
  var $assemblyMemberPosition = $("#assembly_member_position");
  (0,src_decidim_admin_field_dependent_inputs_component__WEBPACK_IMPORTED_MODULE_0__["default"])({
    controllerField: $assemblyMemberPosition,
    wrapperSelector: ".position-fields",
    dependentFieldsSelector: ".position-fields--position-other",
    dependentInputSelector: "input",
    enablingCondition: function enablingCondition($field) {
      return $field.val() === "other";
    }
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/slug_form.js":
/*!***********************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/slug_form.js ***!
  \***********************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var $wrapper = $(".slug");
  var $input = $wrapper.find("input");
  var $target = $wrapper.find("span.slug-url-value");
  $input.on("keyup", function (event) {
    $target.html(event.target.value);
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
/*!********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/entrypoints/decidim_assemblies_admin.js ***!
  \********************************************************************************************************************************************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_assemblies_admin_assemblies__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/assemblies/admin/assemblies */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/admin/assemblies.js");
/* harmony import */ var src_decidim_assemblies_admin_assemblies__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_assemblies_admin_assemblies__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_assemblies_admin_assembly_members__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/assemblies/admin/assembly_members */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/admin/assembly_members.js");
/* harmony import */ var src_decidim_slug_form__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/slug_form */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/slug_form.js");
/* harmony import */ var src_decidim_slug_form__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(src_decidim_slug_form__WEBPACK_IMPORTED_MODULE_2__);



}();
/******/ })()
;
//# sourceMappingURL=decidim_assemblies_admin.js.map