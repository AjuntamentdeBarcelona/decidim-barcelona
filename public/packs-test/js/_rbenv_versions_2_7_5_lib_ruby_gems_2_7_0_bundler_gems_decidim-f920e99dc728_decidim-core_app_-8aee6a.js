(self["webpackChunkapp"] = self["webpackChunkapp"] || []).push([["_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-core_app_-8aee6a"],{

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor.js":
/*!********************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor.js ***!
  \********************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createQuillEditor; }
/* harmony export */ });
/* harmony import */ var src_decidim_editor_linebreak_module__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/editor/linebreak_module */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/linebreak_module.js");
/* harmony import */ var src_decidim_vendor_image_resize_min__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/vendor/image-resize.min */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/image-resize.min.js");
/* harmony import */ var src_decidim_vendor_image_resize_min__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(src_decidim_vendor_image_resize_min__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var src_decidim_vendor_image_upload_min__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/vendor/image-upload.min */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/image-upload.min.js");
/* harmony import */ var src_decidim_vendor_image_upload_min__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(src_decidim_vendor_image_upload_min__WEBPACK_IMPORTED_MODULE_2__);
function _toConsumableArray(arr) {
  return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread();
}

function _nonIterableSpread() {
  throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
}

function _unsupportedIterableToArray(o, minLen) {
  if (!o) return;
  if (typeof o === "string") return _arrayLikeToArray(o, minLen);
  var n = Object.prototype.toString.call(o).slice(8, -1);
  if (n === "Object" && o.constructor) n = o.constructor.name;
  if (n === "Map" || n === "Set") return Array.from(o);
  if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen);
}

function _iterableToArray(iter) {
  if (typeof Symbol !== "undefined" && iter[Symbol.iterator] != null || iter["@@iterator"] != null) return Array.from(iter);
}

function _arrayWithoutHoles(arr) {
  if (Array.isArray(arr)) return _arrayLikeToArray(arr);
}

function _arrayLikeToArray(arr, len) {
  if (len == null || len > arr.length) len = arr.length;

  for (var i = 0, arr2 = new Array(len); i < len; i++) {
    arr2[i] = arr[i];
  }

  return arr2;
}
/* eslint-disable require-jsdoc */





var quillFormats = ["bold", "italic", "link", "underline", "header", "list", "video", "image", "alt", "break", "width", "style", "code", "blockquote", "indent"];
function createQuillEditor(container) {
  var toolbar = $(container).data("toolbar");
  var disabled = $(container).data("disabled");
  var quillToolbar = [["bold", "italic", "underline", "linebreak"], [{
    list: "ordered"
  }, {
    list: "bullet"
  }], ["link", "clean"], ["code", "blockquote"], [{
    "indent": "-1"
  }, {
    "indent": "+1"
  }]];
  var addImage = $(container).data("editorImages");

  if (toolbar === "full") {
    quillToolbar = [[{
      header: [2, 3, 4, 5, 6, false]
    }]].concat(_toConsumableArray(quillToolbar), [["video"]]);
  } else if (toolbar === "basic") {
    quillToolbar = [].concat(_toConsumableArray(quillToolbar), [["video"]]);
  }

  if (addImage) {
    quillToolbar.push(["image"]);
  }

  var modules = {
    linebreak: {},
    toolbar: {
      container: quillToolbar,
      handlers: {
        "linebreak": src_decidim_editor_linebreak_module__WEBPACK_IMPORTED_MODULE_0__["default"]
      }
    }
  };
  var $input = $(container).siblings('input[type="hidden"]');
  container.innerHTML = $input.val() || "";
  var token = $('meta[name="csrf-token"]').attr("content");

  if (addImage) {
    modules.imageResize = {
      modules: ["Resize", "DisplaySize"]
    };
    modules.imageUpload = {
      url: $(container).data("uploadImagesPath"),
      method: "POST",
      name: "image",
      withCredentials: false,
      headers: {
        "X-CSRF-Token": token
      },
      callbackOK: function callbackOK(serverResponse, next) {
        $("div.ql-toolbar").last().removeClass("editor-loading");
        next(serverResponse.url);
      },
      callbackKO: function callbackKO(serverError) {
        $("div.ql-toolbar").last().removeClass("editor-loading");
        console.log("Image upload error: ".concat(serverError.message));
      },
      checkBeforeSend: function checkBeforeSend(file, next) {
        $("div.ql-toolbar").last().addClass("editor-loading");
        next(file);
      }
    };
  }

  var quill = new Quill(container, {
    modules: modules,
    formats: quillFormats,
    theme: "snow"
  });

  if (disabled) {
    quill.disable();
  }

  quill.on("text-change", function () {
    var text = quill.getText(); // Triggers CustomEvent with the cursor position
    // It is required in input_mentions.js

    var event = new CustomEvent("quill-position", {
      detail: quill.getSelection()
    });
    container.dispatchEvent(event);

    if (text === "\n" || text === "\n\n") {
      $input.val("");
    } else {
      $input.val(quill.root.innerHTML);
    }
  }); // After editor is ready, linebreak_module deletes two extraneous new lines

  quill.emitter.emit("editor-ready");

  if (addImage) {
    var text = $(container).data("dragAndDropHelpText");
    $(container).after("<p class=\"help-text\" style=\"margin-top:-1.5rem;\">".concat(text, "</p>"));
  } // After editor is ready, linebreak_module deletes two extraneous new lines


  quill.emitter.emit("editor-ready");
  return quill;
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/attribute_diff.js":
/*!***********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/attribute_diff.js ***!
  \***********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ attributeDiff; }
/* harmony export */ });
function _typeof(obj) {
  "@babel/helpers - typeof";

  return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
    return typeof obj;
  } : function (obj) {
    return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
  }, _typeof(obj);
}
/* eslint-disable require-jsdoc */
// ORGINAL: https://github.com/quilljs/delta/blob/ddda3bf088cda3ec03d5dbcc1179679d147f3a02/src/AttributeMap.ts


function attributeDiff(attributes1, attributes2) {
  var alpha = attributes1;
  var beta = attributes2;

  if (_typeof(alpha) !== "object") {
    alpha = {};
  }

  if (_typeof(beta) !== "object") {
    beta = {};
  }

  var attributes = Object.keys(alpha).concat(Object.keys(beta)).reduce(function (attrs, key) {
    // ORGINAL: import isEqual from 'lodash.isequal'; if (!isEqual(a[key], b[key]))
    if (alpha[key] !== beta[key]) {
      attrs[key] = null;

      if (beta[key]) {
        attrs[key] = beta[key];
      }
    }

    return attrs;
  }, {});

  if (Object.keys(attributes).length > 0) {
    return attributes;
  }

  return null;
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/history_override.js":
/*!*************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/history_override.js ***!
  \*************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ HistoryOverride; }
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

function _inherits(subClass, superClass) {
  if (typeof superClass !== "function" && superClass !== null) {
    throw new TypeError("Super expression must either be null or a function");
  }

  subClass.prototype = Object.create(superClass && superClass.prototype, {
    constructor: {
      value: subClass,
      writable: true,
      configurable: true
    }
  });
  Object.defineProperty(subClass, "prototype", {
    writable: false
  });
  if (superClass) _setPrototypeOf(subClass, superClass);
}

function _setPrototypeOf(o, p) {
  _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) {
    o.__proto__ = p;
    return o;
  };

  return _setPrototypeOf(o, p);
}

function _createSuper(Derived) {
  var hasNativeReflectConstruct = _isNativeReflectConstruct();

  return function _createSuperInternal() {
    var Super = _getPrototypeOf(Derived),
        result;

    if (hasNativeReflectConstruct) {
      var NewTarget = _getPrototypeOf(this).constructor;

      result = Reflect.construct(Super, arguments, NewTarget);
    } else {
      result = Super.apply(this, arguments);
    }

    return _possibleConstructorReturn(this, result);
  };
}

function _possibleConstructorReturn(self, call) {
  if (call && (_typeof(call) === "object" || typeof call === "function")) {
    return call;
  } else if (call !== void 0) {
    throw new TypeError("Derived constructors may only return object or undefined");
  }

  return _assertThisInitialized(self);
}

function _assertThisInitialized(self) {
  if (self === void 0) {
    throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
  }

  return self;
}

function _isNativeReflectConstruct() {
  if (typeof Reflect === "undefined" || !Reflect.construct) return false;
  if (Reflect.construct.sham) return false;
  if (typeof Proxy === "function") return true;

  try {
    Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {}));
    return true;
  } catch (e) {
    return false;
  }
}

function _getPrototypeOf(o) {
  _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) {
    return o.__proto__ || Object.getPrototypeOf(o);
  };
  return _getPrototypeOf(o);
}
/* eslint-disable require-jsdoc */


var History = Quill["import"]("modules/history");
History.DEFAULTS = {
  delay: 1000,
  maxStack: 100,
  userOnly: true
};
/**
 * Linebreak module brokes quill's default history class.
 * So here we are moving innerHTML to undo and redo stack
 * instead of deltas.
 */

var HistoryOverride = /*#__PURE__*/function (_History) {
  _inherits(HistoryOverride, _History);

  var _super = _createSuper(HistoryOverride);

  function HistoryOverride(quill, options) {
    var _this;

    _classCallCheck(this, HistoryOverride);

    _this = _super.call(this, quill, options);
    _this.lastRecorded = 0;
    _this.ignoreChange = false;
    _this.init = false;

    _this.quill.emitter.on("editor-ready", function () {
      _this.clear();

      var $input = $(_this.quill.container).siblings('input[type="hidden"]');

      _this.stack.undo.push({
        content: $input.val() || "",
        index: _this.quill.getLength() - 2
      });

      _this.lastLength = _this.quill.getLength();
    });
    /* eslint-disable max-params */


    _this.quill.on(Quill.events.EDITOR_CHANGE, function (eventName, delta, oldDelta, source) {
      if (!delta) {
        return;
      }

      if (!_this.init && eventName === "selection-change") {
        _this.stack.undo[0].index = delta.index;
      }

      if (eventName !== Quill.events.TEXT_CHANGE || _this.ignoreChange) {
        return;
      }

      if (!_this.options.userOnly || source === Quill.sources.USER) {
        _this.record(delta, oldDelta);
      }
    });

    _this.quill.keyboard.addBinding({
      key: "Z",
      shortKey: true
    }, _this.undo.bind(_assertThisInitialized(_this)));

    _this.quill.keyboard.addBinding({
      key: "Z",
      shortKey: true,
      shiftKey: true
    }, _this.redo.bind(_assertThisInitialized(_this)));

    if (/Win/i.test(navigator.platform)) {
      _this.quill.keyboard.addBinding({
        key: "Y",
        shortKey: true
      }, _this.redo.bind(_assertThisInitialized(_this)));
    }

    return _this;
  }
  /* eslint-enable max-params */


  _createClass(HistoryOverride, [{
    key: "change",
    value: function change(source, dest) {
      if (this.stack[source].length === 0) {
        return;
      }

      var obj = this.updateStacks(source, dest);

      if (!obj.content) {
        return;
      }

      if (!obj.index) {
        obj.index = 0;
      }

      this.lastRecorded = 0;
      this.ignoreChange = true;
      this.quill.setContents(this.quill.clipboard.convert(obj.content));
      this.ignoreChange = false;
      var index = obj.index;
      this.quill.setSelection(index);
    }
  }, {
    key: "updateStacks",
    value: function updateStacks(source, dest) {
      if (source === "undo") {
        if (this.stack.undo.length === 1) {
          return this.stack.undo[0];
        }

        this.stack[dest].push(this.stack.undo.pop());
        return this.stack.undo[this.stack.undo.length - 1];
      }

      var content = this.stack.redo.pop();
      this.stack.undo.push(content);
      return content;
    }
  }, {
    key: "record",
    value: function record(changeDelta) {
      if (changeDelta.ops.length === 0) {
        return;
      } else if (!this.init) {
        this.init = true;
      }

      this.stack.redo = [];
      var timestamp = Date.now(); // Should not return after length check, because after linebreak a keypress replaces invisible characters with
      // visible characters.
      // For example: <br><br></p> -> [press X] -> <br>X</p>.

      if (Math.abs(this.lastLength === this.quill.getLength()) || this.lastRecorded + this.options.delay > timestamp) {
        if (this.stack.undo.length > 1) {
          this.stack.undo.pop();
        }
      } else {
        this.lastLength = this.quill.getLength();

        if (this.lastRecorded + this.options.delay <= timestamp) {
          this.lastRecorded = timestamp;
        }
      }

      this.stack.undo.push({
        content: this.quill.container.firstChild.innerHTML,
        index: this.quill.getSelection()
      });
    }
  }, {
    key: "transform",
    value: function transform() {
      return;
    }
  }]);

  return HistoryOverride;
}(History);



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/linebreak_module.js":
/*!*************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/linebreak_module.js ***!
  \*************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ lineBreakButtonHandler; }
/* harmony export */ });
/* harmony import */ var src_decidim_editor_modified_enter__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/editor/modified_enter */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_enter.js");
/* harmony import */ var src_decidim_editor_modified_backspace_offset_any__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/editor/modified_backspace_offset_any */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_backspace_offset_any.js");
/* harmony import */ var src_decidim_editor_modified_backspace_offset1__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/editor/modified_backspace_offset1 */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_backspace_offset1.js");
/* harmony import */ var src_decidim_editor_history_override__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! src/decidim/editor/history_override */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/history_override.js");
function _typeof(obj) {
  "@babel/helpers - typeof";

  return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
    return typeof obj;
  } : function (obj) {
    return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
  }, _typeof(obj);
}

function _toConsumableArray(arr) {
  return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread();
}

function _nonIterableSpread() {
  throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
}

function _unsupportedIterableToArray(o, minLen) {
  if (!o) return;
  if (typeof o === "string") return _arrayLikeToArray(o, minLen);
  var n = Object.prototype.toString.call(o).slice(8, -1);
  if (n === "Object" && o.constructor) n = o.constructor.name;
  if (n === "Map" || n === "Set") return Array.from(o);
  if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen);
}

function _iterableToArray(iter) {
  if (typeof Symbol !== "undefined" && iter[Symbol.iterator] != null || iter["@@iterator"] != null) return Array.from(iter);
}

function _arrayWithoutHoles(arr) {
  if (Array.isArray(arr)) return _arrayLikeToArray(arr);
}

function _arrayLikeToArray(arr, len) {
  if (len == null || len > arr.length) len = arr.length;

  for (var i = 0, arr2 = new Array(len); i < len; i++) {
    arr2[i] = arr[i];
  }

  return arr2;
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

function _inherits(subClass, superClass) {
  if (typeof superClass !== "function" && superClass !== null) {
    throw new TypeError("Super expression must either be null or a function");
  }

  subClass.prototype = Object.create(superClass && superClass.prototype, {
    constructor: {
      value: subClass,
      writable: true,
      configurable: true
    }
  });
  Object.defineProperty(subClass, "prototype", {
    writable: false
  });
  if (superClass) _setPrototypeOf(subClass, superClass);
}

function _setPrototypeOf(o, p) {
  _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) {
    o.__proto__ = p;
    return o;
  };

  return _setPrototypeOf(o, p);
}

function _createSuper(Derived) {
  var hasNativeReflectConstruct = _isNativeReflectConstruct();

  return function _createSuperInternal() {
    var Super = _getPrototypeOf(Derived),
        result;

    if (hasNativeReflectConstruct) {
      var NewTarget = _getPrototypeOf(this).constructor;

      result = Reflect.construct(Super, arguments, NewTarget);
    } else {
      result = Super.apply(this, arguments);
    }

    return _possibleConstructorReturn(this, result);
  };
}

function _possibleConstructorReturn(self, call) {
  if (call && (_typeof(call) === "object" || typeof call === "function")) {
    return call;
  } else if (call !== void 0) {
    throw new TypeError("Derived constructors may only return object or undefined");
  }

  return _assertThisInitialized(self);
}

function _assertThisInitialized(self) {
  if (self === void 0) {
    throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
  }

  return self;
}

function _isNativeReflectConstruct() {
  if (typeof Reflect === "undefined" || !Reflect.construct) return false;
  if (Reflect.construct.sham) return false;
  if (typeof Proxy === "function") return true;

  try {
    Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {}));
    return true;
  } catch (e) {
    return false;
  }
}

function _getPrototypeOf(o) {
  _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) {
    return o.__proto__ || Object.getPrototypeOf(o);
  };
  return _getPrototypeOf(o);
}
/* eslint-disable require-jsdoc */





 // Disable warning messages from overwritting modules

Quill.debug("error"); // It all started with these snippets of code: https://github.com/quilljs/quill/issues/252

var Delta = Quill["import"]("delta");
var Break = Quill["import"]("blots/break");
var Embed = Quill["import"]("blots/embed");
var Scroll = Quill["import"]("blots/scroll");
var Parchment = Quill["import"]("parchment");
Quill.register({
  "modules/history": src_decidim_editor_history_override__WEBPACK_IMPORTED_MODULE_3__["default"]
}, true);
var icons = Quill["import"]("ui/icons");
icons.linebreak = "⏎";

var SmartBreak = /*#__PURE__*/function (_Break) {
  _inherits(SmartBreak, _Break);

  var _super = _createSuper(SmartBreak);

  function SmartBreak() {
    _classCallCheck(this, SmartBreak);

    return _super.apply(this, arguments);
  }

  _createClass(SmartBreak, [{
    key: "length",
    value: function length() {
      return 1;
    }
  }, {
    key: "value",
    value: function value() {
      return "\n";
    }
  }, {
    key: "insertInto",
    value: function insertInto(parent, ref) {
      // Embed.prototype.insertInto.call(this, parent, ref);
      Reflect.apply(Embed.prototype.insertInto, this, [parent, ref]);
    }
  }]);

  return SmartBreak;
}(Break);

Quill.register(SmartBreak); // Override quill/blots/scroll.js

var ScrollOvderride = /*#__PURE__*/function (_Scroll) {
  _inherits(ScrollOvderride, _Scroll);

  var _super2 = _createSuper(ScrollOvderride);

  function ScrollOvderride() {
    _classCallCheck(this, ScrollOvderride);

    return _super2.apply(this, arguments);
  }

  _createClass(ScrollOvderride, [{
    key: "optimize",
    value: function optimize() {
      var mutations = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : [];
      var context = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

      if (this.batch === true) {
        return;
      }

      this.parchmentOptimize(mutations, context);

      if (mutations.length > 0) {
        // quill/core/emitter.js, Emitter.events.SCROLL_OPTIMIZE = "scroll-optimize"
        this.emitter.emit("scroll-optimize", mutations, context);
      }
    } // Override parchment/src/blot/scroll.ts

  }, {
    key: "parchmentOptimize",
    value: function parchmentOptimize() {
      var _this = this;

      var mutations = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : [];
      var context = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {}; // super.optimize(context);

      Reflect.apply(Parchment.Container.prototype.optimize, this, [context]); // We must modify mutations directly, cannot make copy and then modify
      // let records = [].slice.call(this.observer.takeRecords());

      var records = _toConsumableArray(this.observer.takeRecords()); // Array.push currently seems to be implemented by a non-tail recursive function
      // so we cannot just mutations.push.apply(mutations, this.observer.takeRecords());


      while (records.length > 0) {
        mutations.push(records.pop());
      }

      var mark = function mark(blot, markParent) {
        if (!blot || blot === _this) {
          return;
        }

        if (!blot.domNode.parentNode) {
          return;
        }

        if (blot.domNode.__blot && blot.domNode.__blot.mutations === null) {
          blot.domNode.__blot.mutations = [];
        }

        if (markParent) {
          mark(blot.parent);
        }
      };

      var optimize = function optimize(blot) {
        // Post-order traversal
        if (!blot.domNode.__blot) {
          return;
        }

        if (blot instanceof Parchment.Container) {
          blot.children.forEach(optimize);
        }

        blot.optimize(context);
      };

      var remaining = mutations;

      for (var ind = 0; remaining.length > 0; ind += 1) {
        // MAX_OPTIMIZE_ITERATIONS = 100
        if (ind >= 100) {
          throw new Error("[Parchment] Maximum optimize iterations reached");
        }

        remaining.forEach(function (mutation) {
          var blot = Parchment.find(mutation.target, true);

          if (!blot) {
            return;
          }

          if (blot.domNode === mutation.target) {
            if (mutation.type === "childList") {
              mark(Parchment.find(mutation.previousSibling, false));
              mutation.addedNodes.forEach(function (node) {
                var child = Parchment.find(node, false);
                mark(child, false);

                if (child instanceof Parchment.Container) {
                  child.children.forEach(function (grandChild) {
                    mark(grandChild, false);
                  });
                }
              });
            } else if (mutation.type === "attributes") {
              mark(blot.prev);
            }
          }

          mark(blot);
        });
        this.children.forEach(optimize);
        remaining = _toConsumableArray(this.observer.takeRecords());
        records = remaining.slice();

        while (records.length > 0) {
          mutations.push(records.pop());
        }
      }
    }
  }]);

  return ScrollOvderride;
}(Scroll);

;
Quill.register("blots/scroll", ScrollOvderride, true);
Parchment.register(ScrollOvderride);
function lineBreakButtonHandler(quill) {
  var range = quill.selection.getRange()[0];
  var currentLeaf = quill.getLeaf(range.index)[0];
  var nextLeaf = quill.getLeaf(range.index + 1)[0];
  var previousChar = quill.getText(range.index - 1, 1); // Insert a second break if:
  // At the end of the editor, OR next leaf has a different parent (<p>)

  if (nextLeaf === null || currentLeaf.parent !== nextLeaf.parent) {
    quill.insertEmbed(range.index, "break", true, "user");
    quill.insertEmbed(range.index, "break", true, "user");
  } else if (previousChar === "\n") {
    var delta = new Delta().retain(range.index).insert("\n");
    quill.updateContents(delta, Quill.sources.USER);
  } else {
    quill.insertEmbed(range.index, "break", true, "user");
  } // Now that we've inserted a line break, move the cursor forward


  quill.setSelection(range.index + 1, Quill.sources.SILENT);
}
Quill.register("modules/linebreak", function (quill) {
  quill.getModule("toolbar").addHandler("linebreak", function () {
    lineBreakButtonHandler(quill);
  });
  quill.emitter.on("editor-ready", function () {
    var length = quill.getLength();
    var text = quill.getText(length - 2, 2); // Remove extraneous new lines

    if (text === "\n\n") {
      quill.deleteText(quill.getLength() - 2, 2);
    }
  });
  quill.clipboard.addMatcher("BR", function (node) {
    var _node$parentNode;

    if ((node === null || node === void 0 ? void 0 : (_node$parentNode = node.parentNode) === null || _node$parentNode === void 0 ? void 0 : _node$parentNode.tagName) === "A") {
      return new Delta().insert("\n");
    }

    return new Delta().insert({
      "break": ""
    });
  });
  (0,src_decidim_editor_modified_enter__WEBPACK_IMPORTED_MODULE_0__["default"])(quill);
  (0,src_decidim_editor_modified_backspace_offset_any__WEBPACK_IMPORTED_MODULE_1__["default"])(quill);
  (0,src_decidim_editor_modified_backspace_offset1__WEBPACK_IMPORTED_MODULE_2__["default"])(quill);
  return;
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_backspace_offset1.js":
/*!***********************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_backspace_offset1.js ***!
  \***********************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ backspaceBindings; }
/* harmony export */ });
/* harmony import */ var src_decidim_editor_attribute_diff__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/editor/attribute_diff */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/attribute_diff.js");
function _slicedToArray(arr, i) {
  return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _unsupportedIterableToArray(arr, i) || _nonIterableRest();
}

function _nonIterableRest() {
  throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
}

function _unsupportedIterableToArray(o, minLen) {
  if (!o) return;
  if (typeof o === "string") return _arrayLikeToArray(o, minLen);
  var n = Object.prototype.toString.call(o).slice(8, -1);
  if (n === "Object" && o.constructor) n = o.constructor.name;
  if (n === "Map" || n === "Set") return Array.from(o);
  if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen);
}

function _arrayLikeToArray(arr, len) {
  if (len == null || len > arr.length) len = arr.length;

  for (var i = 0, arr2 = new Array(len); i < len; i++) {
    arr2[i] = arr[i];
  }

  return arr2;
}

function _iterableToArrayLimit(arr, i) {
  var _i = arr == null ? null : typeof Symbol !== "undefined" && arr[Symbol.iterator] || arr["@@iterator"];

  if (_i == null) return;
  var _arr = [];
  var _n = true;
  var _d = false;

  var _s, _e;

  try {
    for (_i = _i.call(arr); !(_n = (_s = _i.next()).done); _n = true) {
      _arr.push(_s.value);

      if (i && _arr.length === i) break;
    }
  } catch (err) {
    _d = true;
    _e = err;
  } finally {
    try {
      if (!_n && _i["return"] != null) _i["return"]();
    } finally {
      if (_d) throw _e;
    }
  }

  return _arr;
}

function _arrayWithHoles(arr) {
  if (Array.isArray(arr)) return arr;
}
/* eslint-disable require-jsdoc */



var Delta = Quill["import"]("delta");

var previousChar = function previousChar(quill, range) {
  return quill.getText(range.index - 1, 1);
};

var beforePreviousChar = function beforePreviousChar(quill, range) {
  return quill.getText(range.index - 2, 1);
};

var nextChar = function nextChar(quill, range) {
  return quill.getText(range.index, 1);
};

var handleListSelection = function handleListSelection(quill, range) {
  var lastCharacterOfPreviousLine = quill.getText(range.index - 3, 1);

  if (nextChar(quill, range) === "\n" || lastCharacterOfPreviousLine !== "\n") {
    quill.setSelection(range.index - 1, Quill.sources.SILENT);
  } else {
    quill.setSelection(range.index - 3, Quill.sources.SILENT);
  }
};

var moveSelectionToPreviousLine = function moveSelectionToPreviousLine(quill, range) {
  var lastCharacterOfPreviousLine = quill.getText(range.index - 3, 1);

  if (nextChar(quill, range) === "\n" || lastCharacterOfPreviousLine !== "\n") {
    quill.setSelection(range.index - 1, Quill.sources.SILENT);
  } else {
    quill.setSelection(range.index - 3, Quill.sources.SILENT);
  }
};

function backspaceBindings(quill) {
  quill.keyboard.addBinding({
    key: 8,
    offset: 1,
    collapsed: true
  }, function (range, context) {
    var length = 1;

    if (/[\uD800-\uDBFF][\uDC00-\uDFFF]$/.test(context.prefix)) {
      length = 2;
    }

    if (range.index === 0 || quill.getLength() <= 1) {
      return;
    }

    var formats = {};

    var _quill$getLine = quill.getLine(range.index),
        _quill$getLine2 = _slicedToArray(_quill$getLine, 1),
        line = _quill$getLine2[0];

    var delta = new Delta().retain(range.index - length)["delete"](length);

    if (context.offset === 1 && previousChar(quill, range) === "\n") {
      var _quill$getLine3 = quill.getLine(range.index - 2),
          _quill$getLine4 = _slicedToArray(_quill$getLine3, 1),
          prev = _quill$getLine4[0];

      if (prev && prev.statics.blotName === "list-item") {
        formats = handleListSelection(quill, range);

        if (prev !== null && prev.length() > 1) {
          var curFormats = line.formats();
          var prevFormats = quill.getFormat(range.index - 2, 1);
          formats = (0,src_decidim_editor_attribute_diff__WEBPACK_IMPORTED_MODULE_0__["default"])(curFormats, prevFormats) || {};
          length += 1;
        }

        delta = new Delta().retain(range.index - 2)["delete"](2);
        moveSelectionToPreviousLine(quill, range);
      } else {
        delta = new Delta().retain(range.index - 1)["delete"](1);

        if (range.index < 2) {
          delta = new Delta()["delete"](1).retain(range.index + line.length() - 1);
        } else if (previousChar(quill, range) === "\n" && beforePreviousChar(quill, range) === "\n") {
          delta = new Delta().retain(range.index - 2)["delete"](2);
        }
      }
    } else {
      var _quill$getLine5 = quill.getLine(range.index - 1),
          _quill$getLine6 = _slicedToArray(_quill$getLine5, 1),
          _prev = _quill$getLine6[0];

      if (_prev) {
        var isPrevLineEmpty = _prev.statics.blotName === "block" && _prev.length() <= 1;

        if (!isPrevLineEmpty) {
          var _curFormats = line.formats();

          var _prevFormats = quill.getFormat(range.index - 1, 1);

          formats = (0,src_decidim_editor_attribute_diff__WEBPACK_IMPORTED_MODULE_0__["default"])(_curFormats, _prevFormats) || {};

          if (Object.keys(formats).length > 0) {
            // line.length() - 1 targets \n in line, another -1 for newline being deleted
            var formatDelta = new Delta().retain(range.index + line.length() - 2).retain(1, formats);
            delta = delta.compose(formatDelta);
          }
        }
      }
    }

    quill.updateContents(delta, Quill.sources.USER);

    if (Object.keys(formats).length > 0) {
      quill.formatLine(range.index - length, length, formats, Quill.sources.USER);
    }

    quill.focus();
  }); // Put this backspace binding to second

  quill.keyboard.bindings[8].splice(1, 0, quill.keyboard.bindings[8].pop());
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_backspace_offset_any.js":
/*!**************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_backspace_offset_any.js ***!
  \**************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ backspaceBindingsRangeAny; }
/* harmony export */ });
/* harmony import */ var src_decidim_editor_attribute_diff__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/editor/attribute_diff */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/attribute_diff.js");
function _slicedToArray(arr, i) {
  return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _unsupportedIterableToArray(arr, i) || _nonIterableRest();
}

function _nonIterableRest() {
  throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
}

function _unsupportedIterableToArray(o, minLen) {
  if (!o) return;
  if (typeof o === "string") return _arrayLikeToArray(o, minLen);
  var n = Object.prototype.toString.call(o).slice(8, -1);
  if (n === "Object" && o.constructor) n = o.constructor.name;
  if (n === "Map" || n === "Set") return Array.from(o);
  if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen);
}

function _arrayLikeToArray(arr, len) {
  if (len == null || len > arr.length) len = arr.length;

  for (var i = 0, arr2 = new Array(len); i < len; i++) {
    arr2[i] = arr[i];
  }

  return arr2;
}

function _iterableToArrayLimit(arr, i) {
  var _i = arr == null ? null : typeof Symbol !== "undefined" && arr[Symbol.iterator] || arr["@@iterator"];

  if (_i == null) return;
  var _arr = [];
  var _n = true;
  var _d = false;

  var _s, _e;

  try {
    for (_i = _i.call(arr); !(_n = (_s = _i.next()).done); _n = true) {
      _arr.push(_s.value);

      if (i && _arr.length === i) break;
    }
  } catch (err) {
    _d = true;
    _e = err;
  } finally {
    try {
      if (!_n && _i["return"] != null) _i["return"]();
    } finally {
      if (_d) throw _e;
    }
  }

  return _arr;
}

function _arrayWithHoles(arr) {
  if (Array.isArray(arr)) return arr;
}
/* eslint-disable require-jsdoc */



function backspaceBindingsRangeAny(quill) {
  quill.keyboard.addBinding({
    key: 8,
    altKey: null,
    ctrlKey: null,
    metaKey: null,
    shiftKey: null,
    collapsed: true
  }, function (range, context) {
    var length = 1;

    if (range.index === 0 || quill.getLength() <= 1) {
      return;
    }

    var _quill$getLine = quill.getLine(range.index),
        _quill$getLine2 = _slicedToArray(_quill$getLine, 1),
        line = _quill$getLine2[0];

    var formats = {};

    if (context.offset === 0) {
      var _quill$getLine3 = quill.getLine(range.index - 1),
          _quill$getLine4 = _slicedToArray(_quill$getLine3, 1),
          prev = _quill$getLine4[0];

      if (prev !== null && prev.length() > 1) {
        var curFormats = line.formats();
        var prevFormats = quill.getFormat(range.index - 1, 1);
        formats = (0,src_decidim_editor_attribute_diff__WEBPACK_IMPORTED_MODULE_0__["default"])(curFormats, prevFormats) || {};
        var previousLineLength = quill.getLine(range.index - 1)[1];
        var previousChar = quill.getText(range.index - 1, 1);
        var beforePreviousChar = quill.getText(range.index - 2, 1);

        if (previousLineLength && previousLineLength === 1 && beforePreviousChar === "\n") {
          if (prevFormats && prevFormats.list) {
            quill.setSelection(range.index - 2, Quill.sources.SILENT);
          } else if (previousChar === "\n" && beforePreviousChar === "\n") {
            length += 1;
          }
        }
      }
    }

    if (/[\uD800-\uDBFF][\uDC00-\uDFFF]$/.test(context.prefix)) {
      length += 1;
    }

    quill.deleteText(range.index - length, length, Quill.sources.USER);

    if (Object.keys(formats).length > 0) {
      quill.formatLine(range.index - length, length, formats, Quill.sources.USER);
    }

    quill.focus();
  }); // Put this backspace binding to second (after backspce_offset1 it's going to be third)

  quill.keyboard.bindings[8].splice(1, 0, quill.keyboard.bindings[8].pop());
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_enter.js":
/*!***********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/editor/modified_enter.js ***!
  \***********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ addEnterBindings; }
/* harmony export */ });
/* eslint-disable require-jsdoc */
var Parchment = Quill["import"]("parchment");
var Delta = Quill["import"]("delta");

var getLineFormats = function getLineFormats(context) {
  return Object.keys(context.format).reduce(function (formats, format) {
    // See Parchment registry.ts => (1 << 3) | ((1 << 2) - 1) = 8 | 3 = 11
    var blockScope = 11;

    if (Parchment.query(format, blockScope) && !Array.isArray(context.format[format])) {
      formats[format] = context.format[format];
    }

    return formats;
  }, {});
};

var continueFormats = function continueFormats(quill, context, lineFormats) {
  Object.keys(context.format).forEach(function (name) {
    if (typeof lineFormats[name] !== "undefined" && lineFormats[name] !== null) {
      return;
    }

    if (Array.isArray(context.format[name])) {
      return;
    }

    if (name === "link") {
      return;
    }

    quill.format(name, context.format[name], Quill.sources.USER);
  });
};

var lineBreakHandler = function lineBreakHandler(quill, range, context) {
  var _currentLeaf$next, _currentLeaf$next$dom, _nextLeaf$parent, _nextLeaf$parent$domN;

  var currentLeaf = quill.getLeaf(range.index)[0];
  var nextLeaf = quill.getLeaf(range.index + 1)[0];
  var previousChar = quill.getText(range.index - 1, 1);
  var formats = quill.getFormat(range.index);

  if ((currentLeaf === null || currentLeaf === void 0 ? void 0 : (_currentLeaf$next = currentLeaf.next) === null || _currentLeaf$next === void 0 ? void 0 : (_currentLeaf$next$dom = _currentLeaf$next.domNode) === null || _currentLeaf$next$dom === void 0 ? void 0 : _currentLeaf$next$dom.tagName) === "A" || (nextLeaf === null || nextLeaf === void 0 ? void 0 : (_nextLeaf$parent = nextLeaf.parent) === null || _nextLeaf$parent === void 0 ? void 0 : (_nextLeaf$parent$domN = _nextLeaf$parent.domNode) === null || _nextLeaf$parent$domN === void 0 ? void 0 : _nextLeaf$parent$domN.tagName) === "A") {
    quill.insertEmbed(range.index, "break", true, "user");
    quill.removeFormat(range.index, 1, Quill.sources.SILENT);
  } else {
    quill.insertEmbed(range.index, "break", true, "user");
  }

  if (nextLeaf === null) {
    quill.insertEmbed(range.index, "break", true, "user");
  } else if (context.offset === 1 && previousChar === "\n") {
    var delta = new Delta().retain(range.index).insert("\n");
    quill.updateContents(delta, Quill.sources.USER);
  }

  Object.keys(formats).forEach(function (format) {
    quill.format(format, context.format[format], Quill.sources.USER);
  });
  quill.setSelection(range.index + 1, Quill.sources.SILENT);
  var lineFormats = getLineFormats(context);
  continueFormats(quill, context, lineFormats);
};

function addEnterBindings(quill) {
  quill.keyboard.addBinding({
    key: 13,
    shiftKey: true
  }, function (range, context) {
    lineBreakHandler(quill, range, context);
  }); // HAX: make our SHIFT+ENTER binding the second (first is added below) in order to override Quill defaults

  quill.keyboard.bindings[13].unshift(quill.keyboard.bindings[13].pop());
  quill.keyboard.addBinding({
    key: 13,
    shiftKey: false
  }, function (range, context) {
    var lineFormats = getLineFormats(context);
    var previousChar = quill.getText(range.index - 1, 1);
    var nextChar = quill.getText(range.index, 1);
    var delta = new Delta().retain(range.index).insert("\n", lineFormats); // const length = context.prefix.length;

    if (previousChar === "" || previousChar === "\n") {
      if (lineFormats.list && nextChar === "\n") {
        if (quill.getLength() - range.index > 2) {
          var endFormatDelta = new Delta().retain(range.index - 1)["delete"](1);
          quill.updateContents(endFormatDelta, Quill.sources.USER);
        } else {
          // Delete empty list item and end the list
          var _endFormatDelta = new Delta().retain(range.index - 1)["delete"](1).retain(range.index).insert("\n");

          quill.updateContents(_endFormatDelta, Quill.sources.USER);
          quill.setSelection(range.index + 1, Quill.sources.SILENT);
        }
      } else {
        quill.updateContents(delta, Quill.sources.USER);

        if (context.offset === 1 && previousChar === "\n") {
          quill.setSelection(range.index + 1, Quill.sources.SILENT);
        } else {
          quill.setSelection(range.index + 2, Quill.sources.SILENT);
        }
      }
    } else {
      quill.updateContents(delta, Quill.sources.USER);
      quill.setSelection(range.index + 1, Quill.sources.SILENT);
    }

    quill.focus();
    continueFormats(quill, context, lineFormats);
  }); // Replace the default enter handling because we have modified the break element

  quill.keyboard.bindings[13].unshift(quill.keyboard.bindings[13].pop());
  return;
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/image-resize.min.js":
/*!*************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/image-resize.min.js ***!
  \*************************************************************************************************************************************************************/
/***/ (function(module, exports, __webpack_require__) {

/* module decorator */ module = __webpack_require__.nmd(module);
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;function _typeof(obj) {
  "@babel/helpers - typeof";

  return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
    return typeof obj;
  } : function (obj) {
    return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
  }, _typeof(obj);
}
/* eslint-disable */


!function (t, e) {
  "object" == ( false ? 0 : _typeof(exports)) && "object" == ( false ? 0 : _typeof(module)) ? module.exports = e() :  true ? !(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_FACTORY__ = (e),
		__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
		(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
		__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__)) : 0;
}(this, function () {
  return function (t) {
    function e(o) {
      if (n[o]) return n[o].exports;
      var r = n[o] = {
        i: o,
        l: !1,
        exports: {}
      };
      return t[o].call(r.exports, r, r.exports, e), r.l = !0, r.exports;
    }

    var n = {};
    return e.m = t, e.c = n, e.i = function (t) {
      return t;
    }, e.d = function (t, n, o) {
      e.o(t, n) || Object.defineProperty(t, n, {
        configurable: !1,
        enumerable: !0,
        get: o
      });
    }, e.n = function (t) {
      var n = t && t.__esModule ? function () {
        return t["default"];
      } : function () {
        return t;
      };
      return e.d(n, "a", n), n;
    }, e.o = function (t, e) {
      return Object.prototype.hasOwnProperty.call(t, e);
    }, e.p = "", e(e.s = 38);
  }([function (t, e) {
    function n(t) {
      var e = _typeof(t);

      return null != t && ("object" == e || "function" == e);
    }

    t.exports = n;
  }, function (t, e, n) {
    var o = n(22),
        r = "object" == (typeof self === "undefined" ? "undefined" : _typeof(self)) && self && self.Object === Object && self,
        i = o || r || Function("return this")();
    t.exports = i;
  }, function (t, e) {
    function n(t) {
      return null != t && "object" == _typeof(t);
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t) {
      var e = -1,
          n = null == t ? 0 : t.length;

      for (this.clear(); ++e < n;) {
        var o = t[e];
        this.set(o[0], o[1]);
      }
    }

    var r = n(75),
        i = n(76),
        a = n(77),
        s = n(78),
        u = n(79);
    o.prototype.clear = r, o.prototype["delete"] = i, o.prototype.get = a, o.prototype.has = s, o.prototype.set = u, t.exports = o;
  }, function (t, e, n) {
    function o(t, e) {
      for (var n = t.length; n--;) {
        if (r(t[n][0], e)) return n;
      }

      return -1;
    }

    var r = n(8);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return null == t ? void 0 === t ? u : s : c && c in Object(t) ? i(t) : a(t);
    }

    var r = n(16),
        i = n(64),
        a = n(87),
        s = "[object Null]",
        u = "[object Undefined]",
        c = r ? r.toStringTag : void 0;
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e) {
      var n = t.__data__;
      return r(e) ? n["string" == typeof e ? "string" : "hash"] : n.map;
    }

    var r = n(73);
    t.exports = o;
  }, function (t, e, n) {
    var o = n(11),
        r = o(Object, "create");
    t.exports = r;
  }, function (t, e) {
    function n(t, e) {
      return t === e || t !== t && e !== e;
    }

    t.exports = n;
  }, function (t, e, n) {
    "use strict";

    function o(t, e) {
      if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function");
    }

    n.d(e, "a", function () {
      return r;
    });

    var r = function t(e) {
      o(this, t), this.onCreate = function () {}, this.onDestroy = function () {}, this.onUpdate = function () {}, this.overlay = e.overlay, this.img = e.img, this.options = e.options, this.requestUpdate = e.onUpdate;
    };
  }, function (t, e, n) {
    function o(t, e, n) {
      "__proto__" == e && r ? r(t, e, {
        configurable: !0,
        enumerable: !0,
        value: n,
        writable: !0
      }) : t[e] = n;
    }

    var r = n(21);
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e) {
      var n = i(t, e);
      return r(n) ? n : void 0;
    }

    var r = n(48),
        i = n(65);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return null != t && i(t.length) && !r(t);
    }

    var r = n(13),
        i = n(30);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      if (!i(t)) return !1;
      var e = r(t);
      return e == s || e == u || e == a || e == c;
    }

    var r = n(5),
        i = n(0),
        a = "[object AsyncFunction]",
        s = "[object Function]",
        u = "[object GeneratorFunction]",
        c = "[object Proxy]";
    t.exports = o;
  }, function (t, e) {
    t.exports = function (t) {
      return t.webpackPolyfill || (t.deprecate = function () {}, t.paths = [], t.children || (t.children = []), Object.defineProperty(t, "loaded", {
        enumerable: !0,
        get: function get() {
          return t.l;
        }
      }), Object.defineProperty(t, "id", {
        enumerable: !0,
        get: function get() {
          return t.i;
        }
      }), t.webpackPolyfill = 1), t;
    };
  }, function (t, e, n) {
    var o = n(11),
        r = n(1),
        i = o(r, "Map");
    t.exports = i;
  }, function (t, e, n) {
    var o = n(1),
        r = o.Symbol;
    t.exports = r;
  }, function (t, e) {
    function n(t, e, n) {
      switch (n.length) {
        case 0:
          return t.call(e);

        case 1:
          return t.call(e, n[0]);

        case 2:
          return t.call(e, n[0], n[1]);

        case 3:
          return t.call(e, n[0], n[1], n[2]);
      }

      return t.apply(e, n);
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t, e, n) {
      (void 0 === n || i(t[e], n)) && (void 0 !== n || e in t) || r(t, e, n);
    }

    var r = n(10),
        i = n(8);
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e, n, l, f) {
      t !== e && a(e, function (a, c) {
        if (u(a)) f || (f = new r()), s(t, e, c, n, o, l, f);else {
          var p = l ? l(t[c], a, c + "", t, e, f) : void 0;
          void 0 === p && (p = a), i(t, c, p);
        }
      }, c);
    }

    var r = n(41),
        i = n(18),
        a = n(46),
        s = n(51),
        u = n(0),
        c = n(32);
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e) {
      return a(i(t, e, r), t + "");
    }

    var r = n(26),
        i = n(89),
        a = n(90);
    t.exports = o;
  }, function (t, e, n) {
    var o = n(11),
        r = function () {
      try {
        var t = o(Object, "defineProperty");
        return t({}, "", {}), t;
      } catch (t) {}
    }();

    t.exports = r;
  }, function (t, e, n) {
    (function (e) {
      var n = "object" == _typeof(e) && e && e.Object === Object && e;
      t.exports = n;
    }).call(e, n(107));
  }, function (t, e, n) {
    var o = n(88),
        r = o(Object.getPrototypeOf, Object);
    t.exports = r;
  }, function (t, e) {
    function n(t, e) {
      return !!(e = null == e ? o : e) && ("number" == typeof t || r.test(t)) && t > -1 && t % 1 == 0 && t < e;
    }

    var o = 9007199254740991,
        r = /^(?:0|[1-9]\d*)$/;
    t.exports = n;
  }, function (t, e) {
    function n(t) {
      var e = t && t.constructor;
      return t === ("function" == typeof e && e.prototype || o);
    }

    var o = Object.prototype;
    t.exports = n;
  }, function (t, e) {
    function n(t) {
      return t;
    }

    t.exports = n;
  }, function (t, e, n) {
    var o = n(47),
        r = n(2),
        i = Object.prototype,
        a = i.hasOwnProperty,
        s = i.propertyIsEnumerable,
        u = o(function () {
      return arguments;
    }()) ? o : function (t) {
      return r(t) && a.call(t, "callee") && !s.call(t, "callee");
    };
    t.exports = u;
  }, function (t, e) {
    var n = Array.isArray;
    t.exports = n;
  }, function (t, e, n) {
    (function (t) {
      var o = n(1),
          r = n(102),
          i = "object" == _typeof(e) && e && !e.nodeType && e,
          a = i && "object" == _typeof(t) && t && !t.nodeType && t,
          s = a && a.exports === i,
          u = s ? o.Buffer : void 0,
          c = u ? u.isBuffer : void 0,
          l = c || r;
      t.exports = l;
    }).call(e, n(14)(t));
  }, function (t, e) {
    function n(t) {
      return "number" == typeof t && t > -1 && t % 1 == 0 && t <= o;
    }

    var o = 9007199254740991;
    t.exports = n;
  }, function (t, e, n) {
    var o = n(49),
        r = n(54),
        i = n(86),
        a = i && i.isTypedArray,
        s = a ? r(a) : o;
    t.exports = s;
  }, function (t, e, n) {
    function o(t) {
      return a(t) ? r(t, !0) : i(t);
    }

    var r = n(43),
        i = n(50),
        a = n(12);
    t.exports = o;
  }, function (t, e, n) {
    "use strict";

    e.a = {
      modules: ["DisplaySize", "Toolbar", "Resize"],
      overlayStyles: {
        position: "absolute",
        boxSizing: "border-box",
        border: "1px dashed #444"
      },
      handleStyles: {
        position: "absolute",
        height: "12px",
        width: "12px",
        backgroundColor: "white",
        border: "1px solid #777",
        boxSizing: "border-box",
        opacity: "0.80"
      },
      displayStyles: {
        position: "absolute",
        font: "12px/1.0 Arial, Helvetica, sans-serif",
        padding: "4px 8px",
        textAlign: "center",
        backgroundColor: "white",
        color: "#333",
        border: "1px solid #777",
        boxSizing: "border-box",
        opacity: "0.80",
        cursor: "default"
      },
      toolbarStyles: {
        position: "absolute",
        top: "-12px",
        right: "0",
        left: "0",
        height: "0",
        minWidth: "100px",
        font: "12px/1.0 Arial, Helvetica, sans-serif",
        textAlign: "center",
        color: "#333",
        boxSizing: "border-box",
        cursor: "default"
      },
      toolbarButtonStyles: {
        display: "inline-block",
        width: "24px",
        height: "24px",
        background: "white",
        border: "1px solid #999",
        verticalAlign: "middle"
      },
      toolbarButtonSvgStyles: {
        fill: "#444",
        stroke: "#444",
        strokeWidth: "2"
      }
    };
  }, function (t, e, n) {
    "use strict";

    function o(t, e) {
      if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function");
    }

    function r(t, e) {
      if (!t) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
      return !e || "object" != _typeof(e) && "function" != typeof e ? t : e;
    }

    function i(t, e) {
      if ("function" != typeof e && null !== e) throw new TypeError("Super expression must either be null or a function, not " + _typeof(e));
      t.prototype = Object.create(e && e.prototype, {
        constructor: {
          value: t,
          enumerable: !1,
          writable: !0,
          configurable: !0
        }
      }), e && (Object.setPrototypeOf ? Object.setPrototypeOf(t, e) : t.__proto__ = e);
    }

    var a = n(9);
    n.d(e, "a", function () {
      return s;
    });

    var s = function (t) {
      function e() {
        var t, n, i, a;
        o(this, e);

        for (var s = arguments.length, u = Array(s), c = 0; c < s; c++) {
          u[c] = arguments[c];
        }

        return n = i = r(this, (t = e.__proto__ || Object.getPrototypeOf(e)).call.apply(t, [this].concat(u))), i.onCreate = function () {
          i.display = document.createElement("div"), Object.assign(i.display.style, i.options.displayStyles), i.overlay.appendChild(i.display);
        }, i.onDestroy = function () {}, i.onUpdate = function () {
          if (i.display && i.img) {
            var t = i.getCurrentSize();
            if (i.display.innerHTML = t.join(" &times; "), t[0] > 120 && t[1] > 30) Object.assign(i.display.style, {
              right: "4px",
              bottom: "4px",
              left: "auto"
            });else if ("right" == i.img.style["float"]) {
              var e = i.display.getBoundingClientRect();
              Object.assign(i.display.style, {
                right: "auto",
                bottom: "-" + (e.height + 4) + "px",
                left: "-" + (e.width + 4) + "px"
              });
            } else {
              var n = i.display.getBoundingClientRect();
              Object.assign(i.display.style, {
                right: "-" + (n.width + 4) + "px",
                bottom: "-" + (n.height + 4) + "px",
                left: "auto"
              });
            }
          }
        }, i.getCurrentSize = function () {
          return [i.img.width, Math.round(i.img.width / i.img.naturalWidth * i.img.naturalHeight)];
        }, a = n, r(i, a);
      }

      return i(e, t), e;
    }(a.a);
  }, function (t, e, n) {
    "use strict";

    function o(t, e) {
      if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function");
    }

    function r(t, e) {
      if (!t) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
      return !e || "object" != _typeof(e) && "function" != typeof e ? t : e;
    }

    function i(t, e) {
      if ("function" != typeof e && null !== e) throw new TypeError("Super expression must either be null or a function, not " + _typeof(e));
      t.prototype = Object.create(e && e.prototype, {
        constructor: {
          value: t,
          enumerable: !1,
          writable: !0,
          configurable: !0
        }
      }), e && (Object.setPrototypeOf ? Object.setPrototypeOf(t, e) : t.__proto__ = e);
    }

    var a = n(9);
    n.d(e, "a", function () {
      return s;
    });

    var s = function (t) {
      function e() {
        var t, n, i, a;
        o(this, e);

        for (var s = arguments.length, u = Array(s), c = 0; c < s; c++) {
          u[c] = arguments[c];
        }

        return n = i = r(this, (t = e.__proto__ || Object.getPrototypeOf(e)).call.apply(t, [this].concat(u))), i.onCreate = function () {
          i.boxes = [], i.addBox("nwse-resize"), i.addBox("nesw-resize"), i.addBox("nwse-resize"), i.addBox("nesw-resize"), i.positionBoxes();
        }, i.onDestroy = function () {
          i.setCursor("");
        }, i.positionBoxes = function () {
          var t = -parseFloat(i.options.handleStyles.width) / 2 + "px",
              e = -parseFloat(i.options.handleStyles.height) / 2 + "px";
          [{
            left: t,
            top: e
          }, {
            right: t,
            top: e
          }, {
            right: t,
            bottom: e
          }, {
            left: t,
            bottom: e
          }].forEach(function (t, e) {
            Object.assign(i.boxes[e].style, t);
          });
        }, i.addBox = function (t) {
          var e = document.createElement("div");
          Object.assign(e.style, i.options.handleStyles), e.style.cursor = t, e.style.width = i.options.handleStyles.width + "px", e.style.height = i.options.handleStyles.height + "px", e.addEventListener("mousedown", i.handleMousedown, !1), i.overlay.appendChild(e), i.boxes.push(e);
        }, i.handleMousedown = function (t) {
          i.dragBox = t.target, i.dragStartX = t.clientX, i.preDragWidth = i.img.width || i.img.naturalWidth, i.setCursor(i.dragBox.style.cursor), document.addEventListener("mousemove", i.handleDrag, !1), document.addEventListener("mouseup", i.handleMouseup, !1);
        }, i.handleMouseup = function () {
          i.setCursor(""), document.removeEventListener("mousemove", i.handleDrag), document.removeEventListener("mouseup", i.handleMouseup);
        }, i.handleDrag = function (t) {
          if (i.img) {
            var e = t.clientX - i.dragStartX;
            i.dragBox === i.boxes[0] || i.dragBox === i.boxes[3] ? i.img.width = Math.round(i.preDragWidth - e) : i.img.width = Math.round(i.preDragWidth + e), i.requestUpdate();
          }
        }, i.setCursor = function (t) {
          [document.body, i.img].forEach(function (e) {
            e.style.cursor = t;
          });
        }, a = n, r(i, a);
      }

      return i(e, t), e;
    }(a.a);
  }, function (t, e, n) {
    "use strict";

    function o(t, e) {
      if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function");
    }

    function r(t, e) {
      if (!t) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
      return !e || "object" != _typeof(e) && "function" != typeof e ? t : e;
    }

    function i(t, e) {
      if ("function" != typeof e && null !== e) throw new TypeError("Super expression must either be null or a function, not " + _typeof(e));
      t.prototype = Object.create(e && e.prototype, {
        constructor: {
          value: t,
          enumerable: !1,
          writable: !0,
          configurable: !0
        }
      }), e && (Object.setPrototypeOf ? Object.setPrototypeOf(t, e) : t.__proto__ = e);
    }

    var a = n(105),
        s = n.n(a),
        u = n(104),
        c = n.n(u),
        l = n(106),
        f = n.n(l),
        p = n(9);
    n.d(e, "a", function () {
      return b;
    });

    var d = window.Quill.imports.parchment,
        h = new d.Attributor.Style("float", "float"),
        y = new d.Attributor.Style("margin", "margin"),
        v = new d.Attributor.Style("display", "display"),
        b = function (t) {
      function e() {
        var t, n, i, a;
        o(this, e);

        for (var u = arguments.length, l = Array(u), p = 0; p < u; p++) {
          l[p] = arguments[p];
        }

        return n = i = r(this, (t = e.__proto__ || Object.getPrototypeOf(e)).call.apply(t, [this].concat(l))), i.onCreate = function () {
          i.toolbar = document.createElement("div"), Object.assign(i.toolbar.style, i.options.toolbarStyles), i.overlay.appendChild(i.toolbar), i._defineAlignments(), i._addToolbarButtons();
        }, i.onDestroy = function () {}, i.onUpdate = function () {}, i._defineAlignments = function () {
          i.alignments = [{
            icon: s.a,
            apply: function apply() {
              v.add(i.img, "inline"), h.add(i.img, "left"), y.add(i.img, "0 1em 1em 0");
            },
            isApplied: function isApplied() {
              return "left" == h.value(i.img);
            }
          }, {
            icon: c.a,
            apply: function apply() {
              v.add(i.img, "block"), h.remove(i.img), y.add(i.img, "auto");
            },
            isApplied: function isApplied() {
              return "auto" == y.value(i.img);
            }
          }, {
            icon: f.a,
            apply: function apply() {
              v.add(i.img, "inline"), h.add(i.img, "right"), y.add(i.img, "0 0 1em 1em");
            },
            isApplied: function isApplied() {
              return "right" == h.value(i.img);
            }
          }];
        }, i._addToolbarButtons = function () {
          var t = [];
          i.alignments.forEach(function (e, n) {
            var o = document.createElement("span");
            t.push(o), o.innerHTML = e.icon, o.addEventListener("click", function () {
              t.forEach(function (t) {
                return t.style.filter = "";
              }), e.isApplied() ? (h.remove(i.img), y.remove(i.img), v.remove(i.img)) : (i._selectButton(o), e.apply()), i.requestUpdate();
            }), Object.assign(o.style, i.options.toolbarButtonStyles), n > 0 && (o.style.borderLeftWidth = "0"), Object.assign(o.children[0].style, i.options.toolbarButtonSvgStyles), e.isApplied() && i._selectButton(o), i.toolbar.appendChild(o);
          });
        }, i._selectButton = function (t) {
          t.style.filter = "invert(20%)";
        }, a = n, r(i, a);
      }

      return i(e, t), e;
    }(p.a);
  }, function (t, e, n) {
    var o = n(17),
        r = n(20),
        i = n(63),
        a = n(101),
        s = r(function (t) {
      return t.push(void 0, i), o(a, void 0, t);
    });
    t.exports = s;
  }, function (t, e, n) {
    "use strict";

    function o(t, e) {
      if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function");
    }

    Object.defineProperty(e, "__esModule", {
      value: !0
    });

    var r = n(37),
        i = n.n(r),
        a = n(33),
        s = n(34),
        u = n(36),
        c = n(35),
        l = {
      DisplaySize: s.a,
      Toolbar: u.a,
      Resize: c.a
    },
        f = function t(e) {
      var n = this,
          r = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {};
      o(this, t), this.initializeModules = function () {
        n.removeModules(), n.modules = n.moduleClasses.map(function (t) {
          return new (l[t] || t)(n);
        }), n.modules.forEach(function (t) {
          t.onCreate();
        }), n.onUpdate();
      }, this.onUpdate = function () {
        n.repositionElements(), n.modules.forEach(function (t) {
          t.onUpdate();
        });
      }, this.removeModules = function () {
        n.modules.forEach(function (t) {
          t.onDestroy();
        }), n.modules = [];
      }, this.handleClick = function (t) {
        if (t.target && t.target.tagName && "IMG" === t.target.tagName.toUpperCase()) {
          if (n.img === t.target) return;
          n.img && n.hide(), n.show(t.target);
        } else n.img && n.hide();
      }, this.show = function (t) {
        n.img = t, n.showOverlay(), n.initializeModules();
      }, this.showOverlay = function () {
        n.overlay && n.hideOverlay(), n.quill.setSelection(null), n.setUserSelect("none"), document.addEventListener("keyup", n.checkImage, !0), n.quill.root.addEventListener("input", n.checkImage, !0), n.overlay = document.createElement("div"), Object.assign(n.overlay.style, n.options.overlayStyles), n.quill.root.parentNode.appendChild(n.overlay), n.repositionElements();
      }, this.hideOverlay = function () {
        n.overlay && (n.quill.root.parentNode.removeChild(n.overlay), n.overlay = void 0, document.removeEventListener("keyup", n.checkImage), n.quill.root.removeEventListener("input", n.checkImage), n.setUserSelect(""));
      }, this.repositionElements = function () {
        if (n.overlay && n.img) {
          var t = n.quill.root.parentNode,
              e = n.img.getBoundingClientRect(),
              o = t.getBoundingClientRect();
          Object.assign(n.overlay.style, {
            left: e.left - o.left - 1 + t.scrollLeft + "px",
            top: e.top - o.top + t.scrollTop + "px",
            width: e.width + "px",
            height: e.height + "px"
          });
        }
      }, this.hide = function () {
        n.hideOverlay(), n.removeModules(), n.img = void 0;
      }, this.setUserSelect = function (t) {
        ["userSelect", "mozUserSelect", "webkitUserSelect", "msUserSelect"].forEach(function (e) {
          n.quill.root.style[e] = t, document.documentElement.style[e] = t;
        });
      }, this.checkImage = function (t) {
        n.img && (46 != t.keyCode && 8 != t.keyCode || window.Quill.find(n.img).deleteAt(0), n.hide());
      }, this.quill = e;
      var s = !1;
      r.modules && (s = r.modules.slice()), this.options = i()({}, r, a.a), s !== !1 && (this.options.modules = s), document.execCommand("enableObjectResizing", !1, "false"), this.quill.root.addEventListener("click", this.handleClick, !1), this.quill.root.parentNode.style.position = this.quill.root.parentNode.style.position || "relative", this.moduleClasses = this.options.modules, this.modules = [];
    };

    e["default"] = f, window.Quill && window.Quill.register("modules/imageResize", f);
  }, function (t, e, n) {
    function o(t) {
      var e = -1,
          n = null == t ? 0 : t.length;

      for (this.clear(); ++e < n;) {
        var o = t[e];
        this.set(o[0], o[1]);
      }
    }

    var r = n(66),
        i = n(67),
        a = n(68),
        s = n(69),
        u = n(70);
    o.prototype.clear = r, o.prototype["delete"] = i, o.prototype.get = a, o.prototype.has = s, o.prototype.set = u, t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      var e = -1,
          n = null == t ? 0 : t.length;

      for (this.clear(); ++e < n;) {
        var o = t[e];
        this.set(o[0], o[1]);
      }
    }

    var r = n(80),
        i = n(81),
        a = n(82),
        s = n(83),
        u = n(84);
    o.prototype.clear = r, o.prototype["delete"] = i, o.prototype.get = a, o.prototype.has = s, o.prototype.set = u, t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      var e = this.__data__ = new r(t);
      this.size = e.size;
    }

    var r = n(3),
        i = n(92),
        a = n(93),
        s = n(94),
        u = n(95),
        c = n(96);
    o.prototype.clear = i, o.prototype["delete"] = a, o.prototype.get = s, o.prototype.has = u, o.prototype.set = c, t.exports = o;
  }, function (t, e, n) {
    var o = n(1),
        r = o.Uint8Array;
    t.exports = r;
  }, function (t, e, n) {
    function o(t, e) {
      var n = a(t),
          o = !n && i(t),
          l = !n && !o && s(t),
          p = !n && !o && !l && c(t),
          d = n || o || l || p,
          h = d ? r(t.length, String) : [],
          y = h.length;

      for (var v in t) {
        !e && !f.call(t, v) || d && ("length" == v || l && ("offset" == v || "parent" == v) || p && ("buffer" == v || "byteLength" == v || "byteOffset" == v) || u(v, y)) || h.push(v);
      }

      return h;
    }

    var r = n(53),
        i = n(27),
        a = n(28),
        s = n(29),
        u = n(24),
        c = n(31),
        l = Object.prototype,
        f = l.hasOwnProperty;
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e, n) {
      var o = t[e];
      s.call(t, e) && i(o, n) && (void 0 !== n || e in t) || r(t, e, n);
    }

    var r = n(10),
        i = n(8),
        a = Object.prototype,
        s = a.hasOwnProperty;
    t.exports = o;
  }, function (t, e, n) {
    var o = n(0),
        r = Object.create,
        i = function () {
      function t() {}

      return function (e) {
        if (!o(e)) return {};
        if (r) return r(e);
        t.prototype = e;
        var n = new t();
        return t.prototype = void 0, n;
      };
    }();

    t.exports = i;
  }, function (t, e, n) {
    var o = n(62),
        r = o();
    t.exports = r;
  }, function (t, e, n) {
    function o(t) {
      return i(t) && r(t) == a;
    }

    var r = n(5),
        i = n(2),
        a = "[object Arguments]";
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return !(!a(t) || i(t)) && (r(t) ? d : u).test(s(t));
    }

    var r = n(13),
        i = n(74),
        a = n(0),
        s = n(97),
        u = /^\[object .+?Constructor\]$/,
        c = Function.prototype,
        l = Object.prototype,
        f = c.toString,
        p = l.hasOwnProperty,
        d = RegExp("^" + f.call(p).replace(/[\\^$.*+?()[\]{}|]/g, "\\$&").replace(/hasOwnProperty|(function).*?(?=\\\()| for .+?(?=\\\])/g, "$1.*?") + "$");
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return a(t) && i(t.length) && !!s[r(t)];
    }

    var r = n(5),
        i = n(30),
        a = n(2),
        s = {};
    s["[object Float32Array]"] = s["[object Float64Array]"] = s["[object Int8Array]"] = s["[object Int16Array]"] = s["[object Int32Array]"] = s["[object Uint8Array]"] = s["[object Uint8ClampedArray]"] = s["[object Uint16Array]"] = s["[object Uint32Array]"] = !0, s["[object Arguments]"] = s["[object Array]"] = s["[object ArrayBuffer]"] = s["[object Boolean]"] = s["[object DataView]"] = s["[object Date]"] = s["[object Error]"] = s["[object Function]"] = s["[object Map]"] = s["[object Number]"] = s["[object Object]"] = s["[object RegExp]"] = s["[object Set]"] = s["[object String]"] = s["[object WeakMap]"] = !1, t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      if (!r(t)) return a(t);
      var e = i(t),
          n = [];

      for (var o in t) {
        ("constructor" != o || !e && u.call(t, o)) && n.push(o);
      }

      return n;
    }

    var r = n(0),
        i = n(25),
        a = n(85),
        s = Object.prototype,
        u = s.hasOwnProperty;
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e, n, o, g, x, m) {
      var _ = t[n],
          j = e[n],
          w = m.get(j);
      if (w) return void r(t, n, w);
      var O = x ? x(_, j, n + "", t, e, m) : void 0,
          S = void 0 === O;

      if (S) {
        var E = l(j),
            A = !E && p(j),
            z = !E && !A && v(j);
        O = j, E || A || z ? l(_) ? O = _ : f(_) ? O = s(_) : A ? (S = !1, O = i(j, !0)) : z ? (S = !1, O = a(j, !0)) : O = [] : y(j) || c(j) ? (O = _, c(_) ? O = b(_) : (!h(_) || o && d(_)) && (O = u(j))) : S = !1;
      }

      S && (m.set(j, O), g(O, j, o, x, m), m["delete"](j)), r(t, n, O);
    }

    var r = n(18),
        i = n(56),
        a = n(57),
        s = n(58),
        u = n(71),
        c = n(27),
        l = n(28),
        f = n(99),
        p = n(29),
        d = n(13),
        h = n(0),
        y = n(100),
        v = n(31),
        b = n(103);
    t.exports = o;
  }, function (t, e, n) {
    var o = n(98),
        r = n(21),
        i = n(26),
        a = r ? function (t, e) {
      return r(t, "toString", {
        configurable: !0,
        enumerable: !1,
        value: o(e),
        writable: !0
      });
    } : i;
    t.exports = a;
  }, function (t, e) {
    function n(t, e) {
      for (var n = -1, o = Array(t); ++n < t;) {
        o[n] = e(n);
      }

      return o;
    }

    t.exports = n;
  }, function (t, e) {
    function n(t) {
      return function (e) {
        return t(e);
      };
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t) {
      var e = new t.constructor(t.byteLength);
      return new r(e).set(new r(t)), e;
    }

    var r = n(42);
    t.exports = o;
  }, function (t, e, n) {
    (function (t) {
      function o(t, e) {
        if (e) return t.slice();
        var n = t.length,
            o = c ? c(n) : new t.constructor(n);
        return t.copy(o), o;
      }

      var r = n(1),
          i = "object" == _typeof(e) && e && !e.nodeType && e,
          a = i && "object" == _typeof(t) && t && !t.nodeType && t,
          s = a && a.exports === i,
          u = s ? r.Buffer : void 0,
          c = u ? u.allocUnsafe : void 0;
      t.exports = o;
    }).call(e, n(14)(t));
  }, function (t, e, n) {
    function o(t, e) {
      var n = e ? r(t.buffer) : t.buffer;
      return new t.constructor(n, t.byteOffset, t.length);
    }

    var r = n(55);
    t.exports = o;
  }, function (t, e) {
    function n(t, e) {
      var n = -1,
          o = t.length;

      for (e || (e = Array(o)); ++n < o;) {
        e[n] = t[n];
      }

      return e;
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t, e, n, o) {
      var a = !n;
      n || (n = {});

      for (var s = -1, u = e.length; ++s < u;) {
        var c = e[s],
            l = o ? o(n[c], t[c], c, n, t) : void 0;
        void 0 === l && (l = t[c]), a ? i(n, c, l) : r(n, c, l);
      }

      return n;
    }

    var r = n(44),
        i = n(10);
    t.exports = o;
  }, function (t, e, n) {
    var o = n(1),
        r = o["__core-js_shared__"];
    t.exports = r;
  }, function (t, e, n) {
    function o(t) {
      return r(function (e, n) {
        var o = -1,
            r = n.length,
            a = r > 1 ? n[r - 1] : void 0,
            s = r > 2 ? n[2] : void 0;

        for (a = t.length > 3 && "function" == typeof a ? (r--, a) : void 0, s && i(n[0], n[1], s) && (a = r < 3 ? void 0 : a, r = 1), e = Object(e); ++o < r;) {
          var u = n[o];
          u && t(e, u, o, a);
        }

        return e;
      });
    }

    var r = n(20),
        i = n(72);
    t.exports = o;
  }, function (t, e) {
    function n(t) {
      return function (e, n, o) {
        for (var r = -1, i = Object(e), a = o(e), s = a.length; s--;) {
          var u = a[t ? s : ++r];
          if (n(i[u], u, i) === !1) break;
        }

        return e;
      };
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t, e, n, a, s, u) {
      return i(t) && i(e) && (u.set(e, t), r(t, e, void 0, o, u), u["delete"](e)), t;
    }

    var r = n(19),
        i = n(0);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      var e = a.call(t, u),
          n = t[u];

      try {
        t[u] = void 0;
      } catch (t) {}

      var o = s.call(t);
      return e ? t[u] = n : delete t[u], o;
    }

    var r = n(16),
        i = Object.prototype,
        a = i.hasOwnProperty,
        s = i.toString,
        u = r ? r.toStringTag : void 0;
    t.exports = o;
  }, function (t, e) {
    function n(t, e) {
      return null == t ? void 0 : t[e];
    }

    t.exports = n;
  }, function (t, e, n) {
    function o() {
      this.__data__ = r ? r(null) : {}, this.size = 0;
    }

    var r = n(7);
    t.exports = o;
  }, function (t, e) {
    function n(t) {
      var e = this.has(t) && delete this.__data__[t];
      return this.size -= e ? 1 : 0, e;
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t) {
      var e = this.__data__;

      if (r) {
        var n = e[t];
        return n === i ? void 0 : n;
      }

      return s.call(e, t) ? e[t] : void 0;
    }

    var r = n(7),
        i = "__lodash_hash_undefined__",
        a = Object.prototype,
        s = a.hasOwnProperty;
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      var e = this.__data__;
      return r ? void 0 !== e[t] : a.call(e, t);
    }

    var r = n(7),
        i = Object.prototype,
        a = i.hasOwnProperty;
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e) {
      var n = this.__data__;
      return this.size += this.has(t) ? 0 : 1, n[t] = r && void 0 === e ? i : e, this;
    }

    var r = n(7),
        i = "__lodash_hash_undefined__";
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return "function" != typeof t.constructor || a(t) ? {} : r(i(t));
    }

    var r = n(45),
        i = n(23),
        a = n(25);
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e, n) {
      if (!s(n)) return !1;

      var o = _typeof(e);

      return !!("number" == o ? i(n) && a(e, n.length) : "string" == o && e in n) && r(n[e], t);
    }

    var r = n(8),
        i = n(12),
        a = n(24),
        s = n(0);
    t.exports = o;
  }, function (t, e) {
    function n(t) {
      var e = _typeof(t);

      return "string" == e || "number" == e || "symbol" == e || "boolean" == e ? "__proto__" !== t : null === t;
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t) {
      return !!i && i in t;
    }

    var r = n(60),
        i = function () {
      var t = /[^.]+$/.exec(r && r.keys && r.keys.IE_PROTO || "");
      return t ? "Symbol(src)_1." + t : "";
    }();

    t.exports = o;
  }, function (t, e) {
    function n() {
      this.__data__ = [], this.size = 0;
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t) {
      var e = this.__data__,
          n = r(e, t);
      return !(n < 0) && (n == e.length - 1 ? e.pop() : a.call(e, n, 1), --this.size, !0);
    }

    var r = n(4),
        i = Array.prototype,
        a = i.splice;
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      var e = this.__data__,
          n = r(e, t);
      return n < 0 ? void 0 : e[n][1];
    }

    var r = n(4);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return r(this.__data__, t) > -1;
    }

    var r = n(4);
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e) {
      var n = this.__data__,
          o = r(n, t);
      return o < 0 ? (++this.size, n.push([t, e])) : n[o][1] = e, this;
    }

    var r = n(4);
    t.exports = o;
  }, function (t, e, n) {
    function o() {
      this.size = 0, this.__data__ = {
        hash: new r(),
        map: new (a || i)(),
        string: new r()
      };
    }

    var r = n(39),
        i = n(3),
        a = n(15);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      var e = r(this, t)["delete"](t);
      return this.size -= e ? 1 : 0, e;
    }

    var r = n(6);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return r(this, t).get(t);
    }

    var r = n(6);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      return r(this, t).has(t);
    }

    var r = n(6);
    t.exports = o;
  }, function (t, e, n) {
    function o(t, e) {
      var n = r(this, t),
          o = n.size;
      return n.set(t, e), this.size += n.size == o ? 0 : 1, this;
    }

    var r = n(6);
    t.exports = o;
  }, function (t, e) {
    function n(t) {
      var e = [];
      if (null != t) for (var n in Object(t)) {
        e.push(n);
      }
      return e;
    }

    t.exports = n;
  }, function (t, e, n) {
    (function (t) {
      var o = n(22),
          r = "object" == _typeof(e) && e && !e.nodeType && e,
          i = r && "object" == _typeof(t) && t && !t.nodeType && t,
          a = i && i.exports === r,
          s = a && o.process,
          u = function () {
        try {
          return s && s.binding && s.binding("util");
        } catch (t) {}
      }();

      t.exports = u;
    }).call(e, n(14)(t));
  }, function (t, e) {
    function n(t) {
      return r.call(t);
    }

    var o = Object.prototype,
        r = o.toString;
    t.exports = n;
  }, function (t, e) {
    function n(t, e) {
      return function (n) {
        return t(e(n));
      };
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t, e, n) {
      return e = i(void 0 === e ? t.length - 1 : e, 0), function () {
        for (var o = arguments, a = -1, s = i(o.length - e, 0), u = Array(s); ++a < s;) {
          u[a] = o[e + a];
        }

        a = -1;

        for (var c = Array(e + 1); ++a < e;) {
          c[a] = o[a];
        }

        return c[e] = n(u), r(t, this, c);
      };
    }

    var r = n(17),
        i = Math.max;
    t.exports = o;
  }, function (t, e, n) {
    var o = n(52),
        r = n(91),
        i = r(o);
    t.exports = i;
  }, function (t, e) {
    function n(t) {
      var e = 0,
          n = 0;
      return function () {
        var a = i(),
            s = r - (a - n);

        if (n = a, s > 0) {
          if (++e >= o) return arguments[0];
        } else e = 0;

        return t.apply(void 0, arguments);
      };
    }

    var o = 800,
        r = 16,
        i = Date.now;
    t.exports = n;
  }, function (t, e, n) {
    function o() {
      this.__data__ = new r(), this.size = 0;
    }

    var r = n(3);
    t.exports = o;
  }, function (t, e) {
    function n(t) {
      var e = this.__data__,
          n = e["delete"](t);
      return this.size = e.size, n;
    }

    t.exports = n;
  }, function (t, e) {
    function n(t) {
      return this.__data__.get(t);
    }

    t.exports = n;
  }, function (t, e) {
    function n(t) {
      return this.__data__.has(t);
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t, e) {
      var n = this.__data__;

      if (n instanceof r) {
        var o = n.__data__;
        if (!i || o.length < s - 1) return o.push([t, e]), this.size = ++n.size, this;
        n = this.__data__ = new a(o);
      }

      return n.set(t, e), this.size = n.size, this;
    }

    var r = n(3),
        i = n(15),
        a = n(40),
        s = 200;
    t.exports = o;
  }, function (t, e) {
    function n(t) {
      if (null != t) {
        try {
          return r.call(t);
        } catch (t) {}

        try {
          return t + "";
        } catch (t) {}
      }

      return "";
    }

    var o = Function.prototype,
        r = o.toString;
    t.exports = n;
  }, function (t, e) {
    function n(t) {
      return function () {
        return t;
      };
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t) {
      return i(t) && r(t);
    }

    var r = n(12),
        i = n(2);
    t.exports = o;
  }, function (t, e, n) {
    function o(t) {
      if (!a(t) || r(t) != s) return !1;
      var e = i(t);
      if (null === e) return !0;
      var n = f.call(e, "constructor") && e.constructor;
      return "function" == typeof n && n instanceof n && l.call(n) == p;
    }

    var r = n(5),
        i = n(23),
        a = n(2),
        s = "[object Object]",
        u = Function.prototype,
        c = Object.prototype,
        l = u.toString,
        f = c.hasOwnProperty,
        p = l.call(Object);
    t.exports = o;
  }, function (t, e, n) {
    var o = n(19),
        r = n(61),
        i = r(function (t, e, n, r) {
      o(t, e, n, r);
    });
    t.exports = i;
  }, function (t, e) {
    function n() {
      return !1;
    }

    t.exports = n;
  }, function (t, e, n) {
    function o(t) {
      return r(t, i(t));
    }

    var r = n(59),
        i = n(32);
    t.exports = o;
  }, function (t, e) {
    t.exports = '<svg viewbox="0 0 18 18">\n  <line class="ql-stroke" x1="15" x2="3" y1="9" y2="9"></line>\n  <line class="ql-stroke" x1="14" x2="4" y1="14" y2="14"></line>\n  <line class="ql-stroke" x1="12" x2="6" y1="4" y2="4"></line>\n</svg>';
  }, function (t, e) {
    t.exports = '<svg viewbox="0 0 18 18">\n  <line class="ql-stroke" x1="3" x2="15" y1="9" y2="9"></line>\n  <line class="ql-stroke" x1="3" x2="13" y1="14" y2="14"></line>\n  <line class="ql-stroke" x1="3" x2="9" y1="4" y2="4"></line>\n</svg>';
  }, function (t, e) {
    t.exports = '<svg viewbox="0 0 18 18">\n  <line class="ql-stroke" x1="15" x2="3" y1="9" y2="9"></line>\n  <line class="ql-stroke" x1="15" x2="5" y1="14" y2="14"></line>\n  <line class="ql-stroke" x1="15" x2="9" y1="4" y2="4"></line>\n</svg>';
  }, function (t, e) {
    var n;

    n = function () {
      return this;
    }();

    try {
      n = n || Function("return this")() || (0, eval)("this");
    } catch (t) {
      "object" == (typeof window === "undefined" ? "undefined" : _typeof(window)) && (n = window);
    }

    t.exports = n;
  }]);
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/image-upload.min.js":
/*!*************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/image-upload.min.js ***!
  \*************************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable */

/* Origin: https://github.com/Platoniq/quill-image-upload */
(function () {
  var exports = {};
  "use strict";

  Object.defineProperty(exports, "__esModule", {
    value: true
  });

  var _createClass = function () {
    function e(e, t) {
      for (var a = 0; a < t.length; a++) {
        var i = t[a];
        i.enumerable = i.enumerable || false;
        i.configurable = true;
        if ("value" in i) i.writable = true;
        Object.defineProperty(e, i.key, i);
      }
    }

    return function (t, a, i) {
      if (a) e(t.prototype, a);
      if (i) e(t, i);
      return t;
    };
  }();

  function _classCallCheck(e, t) {
    if (!(e instanceof t)) {
      throw new TypeError("Cannot call a class as a function");
    }
  }

  var ImageUpload = exports.ImageUpload = function () {
    function e(t) {
      var a = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

      _classCallCheck(this, e);

      this.quill = t;
      this.options = a;
      this.quill.getModule("toolbar").addHandler("image", this.selectLocalImage.bind(this));
      this.handleDrop = this.handleDrop.bind(this);
      this.handlePaste = this.handlePaste.bind(this);
      this.quill.root.addEventListener("drop", this.handleDrop, false);
      this.quill.root.addEventListener("paste", this.handlePaste, false);
    }

    _createClass(e, [{
      key: "selectLocalImage",
      value: function e() {
        var t = this;
        var a = document.createElement("input");
        a.setAttribute("type", "file");
        a.click();

        a.onchange = function () {
          var e = a.files[0];

          if (/^image\//.test(e.type)) {
            var i = t.options.checkBeforeSend || t.checkBeforeSend.bind(t);
            i(e, t.sendToServer.bind(t));
          } else {
            console.warn("You could only upload images.");
          }
        };
      }
    }, {
      key: "checkBeforeSend",
      value: function e(t, a) {
        a(t);
      }
    }, {
      key: "sendToServer",
      value: function e(t) {
        var a = this;

        if (this.options.customUploader) {
          this.options.customUploader(t, function (e) {
            a.insert(e);
          });
        } else {
          var i = this.options.url,
              n = this.options.method || "POST",
              s = this.options.name || "image",
              o = this.options.headers || {},
              r = this.options.callbackOK || this.uploadImageCallbackOK.bind(this),
              l = this.options.callbackKO || this.uploadImageCallbackKO.bind(this);

          if (i) {
            var d = new FormData();
            d.append(s, t);

            if (this.options.csrf) {
              d.append(this.options.csrf.token, this.options.csrf.hash);
            }

            var c = new XMLHttpRequest();
            c.open(n, i, true);

            for (var u in o) {
              c.setRequestHeader(u, o[u]);
            }

            c.onload = function () {
              if (c.status === 200) {
                r(JSON.parse(c.responseText), a.insert.bind(a));
              } else {
                l({
                  code: c.status,
                  type: c.statusText,
                  body: c.responseText
                });
              }
            };

            if (this.options.withCredentials) {
              c.withCredentials = true;
            }

            c.send(d);
          } else {
            var f = new FileReader();

            f.onload = function (e) {
              r(e.target.result, a.insert.bind(a));
            };

            f.readAsDataURL(t);
          }
        }
      }
    }, {
      key: "handleDrop",
      value: function e(t) {
        t.preventDefault();

        if (t.dataTransfer && t.dataTransfer.files && t.dataTransfer.files.length) {
          if (document.caretRangeFromPoint) {
            var a = document.getSelection();
            var i = document.caretRangeFromPoint(t.clientX, t.clientY);

            if (a && i) {
              a.setBaseAndExtent(i.startContainer, i.startOffset, i.startContainer, i.startOffset);
            }
          }

          this.readFiles(t.dataTransfer.files, this.sendToServer.bind(this));
        }
      }
    }, {
      key: "handlePaste",
      value: function e(t) {
        var a = this;
        var i = Quill["import"]("delta");

        if (t.clipboardData && t.clipboardData.items && t.clipboardData.items.length) {
          this.readFiles(t.clipboardData.items, function (e) {
            var t = a.quill.getSelection();

            if (t) {
              a.quill.updateContents(new i().retain(t.index - 1)["delete"](1));
            }

            setTimeout(function () {
              return a.sendToServer(e.getAsFile());
            }, 0);
          });
        }
      }
    }, {
      key: "readFiles",
      value: function e(t, a) {
        var i = this;
        [].forEach.call(t, function (e) {
          if (!/^image\//.test(e.type)) {
            return;
          }

          var t = new FileReader();

          t.onload = function (t) {
            var n = i.options.checkBeforeSend || i.checkBeforeSend.bind(i);
            n(e, a);
          };

          var n = e.getAsFile ? e.getAsFile() : e;

          if (n instanceof Blob) {
            t.readAsDataURL(n);
          }
        });
      }
    }, {
      key: "insert",
      value: function e(t) {
        var a = (this.quill.getSelection() || {}).index || this.quill.getLength();
        this.quill.insertEmbed(a, "image", t, "user");
      }
    }, {
      key: "uploadImageCallbackOK",
      value: function e(t, a) {
        a(t);
      }
    }, {
      key: "uploadImageCallbackKO",
      value: function e(t) {
        alert(t);
      }
    }]);

    return e;
  }();

  window.Quill.register('modules/imageUpload', exports.ImageUpload);
})();

/***/ })

}]);
//# sourceMappingURL=_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-core_app_-8aee6a.js.map