/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/entrypoints/decidim_term_customizer_admin.js":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/entrypoints/decidim_term_customizer_admin.js ***!
  \*****************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_term_customizer_admin_multifield_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/term_customizer/admin/multifield/component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/multifield/component.js");
/* harmony import */ var src_decidim_term_customizer_admin_constraint_fields__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/term_customizer/admin/constraint_fields */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/constraint_fields.js");
/* harmony import */ var src_decidim_term_customizer_admin_constraint_fields__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(src_decidim_term_customizer_admin_constraint_fields__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var src_decidim_term_customizer_admin_translation_sets_admin__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/term_customizer/admin/translation_sets_admin */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translation_sets_admin.js");
/* harmony import */ var src_decidim_term_customizer_admin_translation_sets_admin__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(src_decidim_term_customizer_admin_translation_sets_admin__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var src_decidim_term_customizer_admin_translations_admin_bulk__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/term_customizer/admin/translations_admin_bulk */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translations_admin_bulk.js");
/* harmony import */ var src_decidim_term_customizer_admin_translations_admin_bulk__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(src_decidim_term_customizer_admin_translations_admin_bulk__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var src_decidim_term_customizer_admin_translations_admin__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! src/decidim/term_customizer/admin/translations_admin */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translations_admin.js");
/* harmony import */ var src_decidim_term_customizer_admin_translations_admin__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(src_decidim_term_customizer_admin_translations_admin__WEBPACK_IMPORTED_MODULE_4__);

 // import "app/packs/src/decidim/term_customizer/admin/multifield"





/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/constraint_fields.js":
/*!***************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/constraint_fields.js ***!
  \***************************************************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var initConstraintFields = function initConstraintFields($section) {
    var $select = $("select.constraint-subject-selector", $section);
    var $modelSelect = $("select.constraint-subject-model-selector", $section);
    $select.on("change init",
    /* @this HTMLElement */
    function () {
      var val = $(this).val();
      $("[data-manifest]", $section).hide();
      $("[data-manifest=\"".concat(val, "\"]"), $section).show();
    }).trigger("init");
    $modelSelect.on("change init",
    /* @this HTMLElement */
    function () {
      var $container = $(this).parents(".manifest-container");
      var val = $(this).val();
      $("[data-components]", $container).hide();
      $("[data-components=\"".concat(val, "\"]"), $container).show();
    }).trigger("init");
  };

  $.fn.constraintSection = function () {
    $(this).each(
    /**
     * @this HTMLElement
     * @return {void}
     */
    function () {
      var $section = $(this);
      initConstraintFields($section);
    });
  };
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/multifield/component.js":
/*!******************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/multifield/component.js ***!
  \******************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/admin/auto_label_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_label_by_position.component.js");
/* harmony import */ var src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/admin/auto_buttons_by_position.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/auto_buttons_by_position.component.js");
/* harmony import */ var src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/admin/dynamic_fields.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/dynamic_fields.component.js");
/* harmony import */ var src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/admin/sort_list.component */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-admin/app/packs/src/decidim/admin/sort_list.component.js");




$(function () {
  var initMultifield = function initMultifield($wrapper) {
    var wrapperSelector = "#".concat($wrapper.attr("id"));
    var placeholderId = $wrapper.data("placeholder-id");
    var fieldSelector = ".multifield-field";
    var autoLabelByPosition = new src_decidim_admin_auto_label_by_position_component__WEBPACK_IMPORTED_MODULE_0__["default"]({
      listSelector: "".concat(wrapperSelector, " .multifield-field:not(.hidden)"),
      labelSelector: ".card-title span:first",
      onPositionComputed: function onPositionComputed(el, idx) {
        $(el).find("input.position-input").val(idx);
      }
    });
    var autoButtonsByPosition = new src_decidim_admin_auto_buttons_by_position_component__WEBPACK_IMPORTED_MODULE_1__["default"]({
      listSelector: "".concat(wrapperSelector, " .multifield-field:not(.hidden)"),
      hideOnFirstSelector: ".move-up-field",
      hideOnLastSelector: ".move-down-field"
    });

    var createSortableList = function createSortableList() {
      (0,src_decidim_admin_sort_list_component__WEBPACK_IMPORTED_MODULE_3__["default"])("".concat(wrapperSelector, " .fields-list:not(.published)"), {
        handle: ".multifield-field-divider",
        placeholder: '<div style="border-style: dashed; border-color: #000"></div>',
        forcePlaceholderSize: true,
        onSortUpdate: function onSortUpdate() {
          autoLabelByPosition.run();
        }
      });
    };

    var hideDeletedSection = function hideDeletedSection($target) {
      var inputDeleted = $target.find("input[name$=\\[deleted\\]]").val();

      if (inputDeleted === "true") {
        $target.addClass("hidden");
        $target.hide();
      }
    };

    (0,src_decidim_admin_dynamic_fields_component__WEBPACK_IMPORTED_MODULE_2__["default"])({
      placeholderId: placeholderId,
      wrapperSelector: wrapperSelector,
      containerSelector: ".multifield-fields-list",
      fieldSelector: fieldSelector,
      addFieldButtonSelector: ".add-field",
      removeFieldButtonSelector: ".remove-field",
      moveUpFieldButtonSelector: ".move-up-field",
      moveDownFieldButtonSelector: ".move-down-field",
      onAddField: function onAddField($newField) {
        createSortableList();
        autoLabelByPosition.run();
        autoButtonsByPosition.run();
        $wrapper.trigger("add-field-section", $newField);
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
      hideDeletedSection($target);
    });
    autoLabelByPosition.run();
    autoButtonsByPosition.run();
  };

  $.fn.multifield = function () {
    $(this).each(
    /**
     * @this HTMLElement
     * @return {void}
     */
    function () {
      var $elem = $(this);
      var id = $elem.attr("id");

      if (!id || id.length < 1) {
        id = "multifield-".concat(Math.random().toString(16).slice(2));
        $elem.attr("id", id);
      }

      initMultifield($elem);
    });
  };
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translation_sets_admin.js":
/*!********************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translation_sets_admin.js ***!
  \********************************************************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var $fields = $("form.translation-sets-form .multifield-fields");
  $fields.multifield();
  $fields.on("add-field-section",
  /* @this HTMLElement */
  function (ev, newField) {
    $(newField).constraintSection();
  });
  $(".constraints-list .constraint-section", $fields).each(function (_i, el) {
    $(el).constraintSection();
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translations_admin.js":
/*!****************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translations_admin.js ***!
  \****************************************************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  var $search = $("#data_picker-autocomplete");
  var $results = $("#add-translations-results");
  var $template = $("template", $results);
  var $form = $search.parents("form");
  var currentSearch = "";
  var selectedTerms = [];
  $search.on("keyup", function () {
    currentSearch = $search.val();
  }); // Prevent accidental submit on the autocomplete field

  $form.on("submit", function (ev) {
    return ev.preventDefault();
  }); // jquery.autocomplete is calling this method which is apparently removed from
  // newer jQuery versions.

  $.isObject = $.isPlainObject; // eslint-disable-line id-length

  var customizeAutocomplete = function customizeAutocomplete(ac) {
    var $ac = $("#".concat(ac.mainContainerId));
    var $acWrap = $("<div />");
    $ac.css({
      top: "",
      left: ""
    });
    $acWrap.css({
      position: "relative"
    });
    $acWrap.append($ac); // Move the element to correct position in the DOM to control its alignment
    // better.

    $search.after($acWrap); // Do not set the top and left CSS attributes on the element

    ac.fixPosition = function () {}; // Hack the suggest method to exclude values that are already selected.


    ac.origSuggest = ac.suggest;

    ac.suggest = function () {
      // Filter out the selected items from the list
      ac.suggestions = ac.suggestions.filter(function (val) {
        return !selectedTerms.includes(val);
      });
      ac.data = ac.data.filter(function (val) {
        return !selectedTerms.includes(val.value);
      });
      return ac.origSuggest();
    }; // Customize the onKeyPress to allow spaces because we do not want
    // selection to happen on space press.
    //
    // Original code at: https://git.io/JzjAM


    ac.onKeyPress = function (ev) {
      if (ac.disabled || !ac.enabled) {
        return;
      }

      switch (ev.keyCode) {
        case 27:
          // ESC
          ac.el.val(ac.currentValue);
          ac.hide();
          break;

        case 9:
        case 13:
          // TAB or RETURN
          if (ac.suggestions.length === 1) {
            ac.select(0);
          } else if (ac.selectedIndex === -1) {
            ac.hide();
            return;
          } else {
            ac.select(ac.selectedIndex);
          }

          if (ev.keyCode === 9) {
            return;
          }

          break;

        case 38:
          // UP
          ac.moveUp();
          break;

        case 40:
          // DOWN
          ac.moveDown();
          break;
        // DISABLED:
        // case 32:
        //   // SPACE
        //   if (ac.selectedIndex === -1) {
        //     break;
        //   }
        //   ac.select(ac.selectedIndex);
        //   break;

        default:
          return;
      }

      ev.stopImmediatePropagation();
      ev.preventDefault();
    };

    return ac;
  }; // Customized methods for the autocomplete to add our hacks


  $.fn.tcAutocomplete = function (options) {
    $(this).each(function (_i, el) {
      var $el = $(el);
      var ac = customizeAutocomplete($el.autocomplete(options));
      $el.data("autocomplete", ac);
    });
  };

  $search.tcAutocomplete({
    width: "100%",
    minChars: 2,
    noCache: true,
    serviceUrl: $form.attr("action"),
    delimiter: "||",
    deferRequestBy: 500,
    // Custom format result because of some weird bugs in the old version of the
    // jquery.autocomplete library.
    formatResult: function formatResult(term, itemData) {
      var sanitizedSearch = term.replace(/[-/\\^$*+?.()|[\]{}]/g, "\\$&");
      var re = new RegExp("(".concat(sanitizedSearch, ")"), "gi");
      var value = "".concat(itemData.value, " - ").concat(itemData.data);
      return value.replace(re, "<strong>$1</strong>");
    },
    onSelect: function onSelect(suggestion, itemData) {
      var modelId = itemData.data;
      var title = itemData.value; // Mark the term as selected

      selectedTerms.push(suggestion);
      var template = $template.html();
      template = template.replace(new RegExp("{{translation_key}}", "g"), modelId);
      template = template.replace(new RegExp("{{translation_term}}", "g"), title);
      var $newRow = $(template);
      $("table tbody", $results).append($newRow);
      $results.removeClass("hide"); // Add it to the autocomplete form

      var $field = $("<input type=\"hidden\" name=\"keys[]\" value=\"".concat(modelId, "\">"));
      $form.append($field); // Listen to the click event on the remove button

      $(".remove-translation-key", $newRow).on("click", function (ev) {
        ev.preventDefault();
        $newRow.remove();
        $field.remove();
        selectedTerms = selectedTerms.filter(function (val) {
          return val !== suggestion;
        });

        if ($("table tbody tr", $results).length < 1) {
          $results.addClass("hide");
        }
      });
      $search.val(currentSearch);
      setTimeout(function () {
        $search.data("autocomplete").suggest();
      }, 20);
    }
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translations_admin_bulk.js":
/*!*********************************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/src/decidim/term_customizer/admin/translations_admin_bulk.js ***!
  \*********************************************************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable no-invalid-this */
$(document).ready(function () {
  var selectedTranslationsCount = function selectedTranslationsCount() {
    return $(".table-list .js-check-all-translation:checked").length;
  };

  window.selectedTranslationsCountUpdate = function () {
    if (selectedTranslationsCount() === 0) {
      $("#js-selected-translation-count").text("");
    } else {
      $("#js-selected-translation-count").text(selectedTranslationsCount());
    }
  };

  var showBulkActionsButton = function showBulkActionsButton() {
    if (selectedTranslationsCount() > 0) {
      $("#js-bulk-actions-button").removeClass("hide");
    }
  };

  var hideBulkActionsButton = function hideBulkActionsButton() {
    var force = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : false;

    if (selectedTranslationsCount() === 0 || force === true) {
      $("#js-bulk-actions-button").addClass("hide");
      $("#js-bulk-actions-dropdown").removeClass("is-open");
    }
  };

  window.showOtherActionsButtons = function () {
    $("#js-other-actions-wrapper").removeClass("hide");
  };

  var hideOtherActionsButtons = function hideOtherActionsButtons() {
    $("#js-other-actions-wrapper").addClass("hide");
  };

  window.hideBulkActionForms = function () {
    return $(".js-bulk-action-form").addClass("hide");
  };

  if ($(".js-bulk-action-form").length) {
    window.hideBulkActionForms();
    $("#js-bulk-actions-button").addClass("hide");
    $("#js-bulk-actions-dropdown ul li button").click(function (ev) {
      ev.preventDefault();
      var action = $(ev.target).data("action");

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
      $(".js-check-all-translation").prop("checked", $(this).prop("checked"));

      if ($(this).prop("checked")) {
        $(".js-check-all-translation").closest("tr").addClass("selected");
        showBulkActionsButton();
      } else {
        $(".js-check-all-translation").closest("tr").removeClass("selected");
        hideBulkActionsButton();
      }

      window.selectedTranslationsCountUpdate();
    }); // translation checkbox change

    $(".table-list").on("change", ".js-check-all-translation", function () {
      var translationId = $(this).val();
      var checked = $(this).prop("checked"); // uncheck "select all", if one of the listed checkbox item is unchecked

      if ($(this).prop("checked") === false) {
        $(".js-check-all").prop("checked", false);
      } // check "select all" if all checkbox translations are checked


      if ($(".js-check-all-translation:checked").length === $(".js-check-all-translation").length) {
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

      if ($(".js-check-all-translation:checked").length === 0) {
        hideBulkActionsButton();
      }

      $(".js-bulk-action-form").find(".js-translation-id-".concat(translationId)).prop("checked", checked);
      window.selectedTranslationCountUpdate();
    });
    $(".js-cancel-bulk-action").on("click", function () {
      window.hideBulkActionForms();
      showBulkActionsButton();
      window.showOtherActionsButtons();
    });
  }
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
/******/ 	/* webpack/runtime/jsonp chunk loading */
/******/ 	!function() {
/******/ 		// no baseURI
/******/ 		
/******/ 		// object to store loaded and loading chunks
/******/ 		// undefined = chunk not loaded, null = chunk preloaded/prefetched
/******/ 		// [resolve, reject, Promise] = chunk loading, 0 = chunk loaded
/******/ 		var installedChunks = {
/******/ 			"decidim_term_customizer_admin": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["vendors-node_modules_html5sortable_dist_html5sortable_es_js","_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-admin_app-16f163"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-module-term_customizer-6b5e50d9ae4c/app/packs/entrypoints/decidim_term_customizer_admin.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_term_customizer_admin.js.map