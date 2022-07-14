/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_admin_navigation_maps.js":
/*!*******************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_admin_navigation_maps.js ***!
  \*******************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_navigation_maps_admin_navigation_maps_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/navigation_maps/admin/navigation_maps.js */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/admin/navigation_maps.js");
/* harmony import */ var entrypoints_decidim_admin_navigation_maps_scss__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! entrypoints/decidim_admin_navigation_maps.scss */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_admin_navigation_maps.scss");
 // CSS



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/admin/map_editor.js":
/*!**********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/admin/map_editor.js ***!
  \**********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ NavigationMapEditor; }
/* harmony export */ });
/* harmony import */ var src_decidim_navigation_maps_map_view_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/navigation_maps/map_view.js */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/map_view.js");
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
} // Creates a map




var NavigationMapEditor = /*#__PURE__*/function (_NavigationMapView) {
  _inherits(NavigationMapEditor, _NavigationMapView);

  var _super = _createSuper(NavigationMapEditor);

  function NavigationMapEditor(map_object, table_object) {
    var _this;

    _classCallCheck(this, NavigationMapEditor); // Call constructor of superclass to initialize superclass-derived members.


    _this = _super.call(this, map_object, function () {
      _this.createControls();

      if (_this.blueprint) {
        _this.createAreas();
      }
    });
    _this.table_object = table_object;

    _this.createAreaCallback = function () {};

    _this.editAreaCallback = function () {};

    _this.removeAreaCallback = function () {};

    return _this;
  }

  _createClass(NavigationMapEditor, [{
    key: "createControls",
    value: function createControls() {
      var _this2 = this;

      this.map.pm.addControls({
        position: "topleft",
        drawCircle: false,
        drawMarker: false,
        drawCircleMarker: false,
        drawPolyline: false,
        cutPolygon: false
      });
      this.map.on("pm:create", function (e) {
        var geojson = e.layer.toGeoJSON();
        _this2.blueprint[e.layer._leaflet_id] = geojson;

        _this2.attachEditorEvents(e.layer);

        _this2.createAreaCallback(e.layer._leaflet_id, e.layer, _this2);
      });
      this.map.on("pm:remove", function (e) {
        delete _this2.blueprint[e.layer._leaflet_id];

        _this2.removeAreaCallback(e.layer._leaflet_id, e.layer, _this2);
      });
    }
  }, {
    key: "editing",
    value: function editing() {
      var pm = this.map.pm;
      return pm.globalRemovalEnabled() || pm.globalDragModeEnabled() || pm.globalEditEnabled();
    }
  }, {
    key: "onCreateArea",
    value: // register callback to handle area edits,removals and creations
    function onCreateArea(callback) {
      this.createAreaCallback = callback;
    }
  }, {
    key: "onEditArea",
    value: function onEditArea(callback) {
      this.editAreaCallback = callback;
    }
  }, {
    key: "onRemoveArea",
    value: function onRemoveArea(callback) {
      this.removeCreateCallback = callback;
    }
  }, {
    key: "attachEditorEvents",
    value: function attachEditorEvents(layer) {
      var _this3 = this;

      layer.on("mouseover", function (e) {
        e.target.getElement().classList.add("selected");
      });
      layer.on("mouseout", function (e) {
        e.target.getElement().classList.remove("selected");
      });
      layer.on("pm:edit", function (e) {
        _this3.blueprint[e.target._leaflet_id] = e.target.toGeoJSON();

        _this3.editAreaCallback(e.target._leaflet_id, e.target, _this3);
      });
      layer.on("click", function (e) {
        if (!_this3.editing()) {
          _this3.clickAreaCallback(e.target._leaflet_id, e.target, _this3);
        }
      });
    }
  }, {
    key: "getBlueprint",
    value: function getBlueprint() {
      return this.blueprint;
    }
  }]);

  return NavigationMapEditor;
}(src_decidim_navigation_maps_map_view_js__WEBPACK_IMPORTED_MODULE_0__["default"]);



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/admin/navigation_maps.js":
/*!***************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/admin/navigation_maps.js ***!
  \***************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_navigation_maps_admin_map_editor_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/navigation_maps/admin/map_editor.js */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/admin/map_editor.js");
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// import "jquery-form"; // we use a CDN instead due a bug in webpacker

$(function () {
  var $maps = $(".navigation_maps.admin .map");
  var $progress = $(".navigation_maps.admin .progress");
  var $bar = $(".navigation_maps.admin .progress-meter");
  var $loading = $(".navigation_maps.admin .loading");
  var $callout = $(".navigation_maps.admin .callout");
  var $modal = $("#mapEditModal");
  var $form = $("form");
  var $tabs = $("#navigation_maps-tabs");
  var $accordion = $(".navigation_maps.admin .accordion");
  var editors = {};
  var new_areas = {};
  $maps.each(function (_i, el) {
    var id = $(el).data("id");
    var table = document.getElementById("navigation_maps-table-".concat(id));
    editors[id] = new src_decidim_navigation_maps_admin_map_editor_js__WEBPACK_IMPORTED_MODULE_0__["default"](el, table);
    editors[id].onCreateArea(function (area_id) {
      new_areas[area_id] = true;
    });
    editors[id].onClickArea(function (area_id, area) {
      $modal.find(".modal-content").html("");
      $modal.addClass("loading").foundation("open");
      $callout.hide();
      $callout.removeClass("alert success"); // "new" form insted of editing

      var rel = new_areas[area_id] ? "new" : area_id;
      $modal.find(".modal-content").load("/admin/navigation_maps/blueprints/".concat(id, "/areas/").concat(rel), function () {
        var $input1 = $modal.find('input[name="blueprint_area[area_id]"]');
        var $input2 = $modal.find('input[name="blueprint_area[area_type]"]');
        var $input3 = $modal.find('input[name="blueprint_area[area]"]');
        var a = area.toGeoJSON();
        $modal.removeClass("loading");

        if ($input1.length) {
          $input1.val(area_id);
        }

        if ($input2.length) {
          $input2.val(a.type);
        }

        if ($input3.length) {
          $input3.val(JSON.stringify(a));
        }

        $modal.find("ul[data-tabs=true]").each(function () {
          new Foundation.Tabs($(el)); // eslint-disable-line
        });
      });
    });
  }); // Rails AJAX events

  document.body.addEventListener("ajax:error", function (responseText) {
    $callout.contents("p").html("".concat(responseText.detail[0].message, ": <strong>").concat(responseText.detail[0].error, "</strong>"));
    $callout.addClass("alert");
  });
  document.body.addEventListener("ajax:success", function (responseText) {
    if (new_areas[responseText.detail[0].area]) {
      delete new_areas[responseText.detail[0].area];
    }

    var blueprint_id = responseText.detail[0].blueprint_id;
    var area_id = responseText.detail[0].area_id;
    var area = responseText.detail[0].area;
    editors[blueprint_id].setLayerProperties(editors[blueprint_id].map._layers[area_id], area);
    editors[blueprint_id].blueprint[area_id] = area;
    $callout.contents("p").html(responseText.detail[0].message);
    $callout.addClass("success");
  });
  document.body.addEventListener("ajax:complete", function () {
    $callout.show();
    $modal.foundation("close");
  });
  $tabs.on("change.zf.tabs", function (e, $tab, $content) {
    var id = $content.find(".map").data("id");

    if (id) {
      editors[id].reload();
    }
  });
  $accordion.on("down.zf.accordion", function () {
    var id = $accordion.find(".map").data("id");

    if (id) {
      editors[id].reload();
    }
  }); // If a new item si going to be created o the image is changed a reload is needed

  var needsReload = function needsReload() {
    var reload = false;

    if ($form.find("#map-new input:checked").length) {
      return true;
    }

    if ($form.find(".delete-tab input[type=checkbox]:checked").length) {
      return true;
    }

    $form.find("input[type=file],input[tabs_id=blueprints___title]").each(function (_i, el) {
      if ($(el).val()) {
        reload = true;
        return false;
      }
    });
    return reload;
  };

  $form.ajaxForm({
    url: $form.find("[name=action]").val(),
    beforeSerialize: function beforeSerialize() {
      Object.keys(editors).forEach(function (key) {
        var editor = editors[key];
        $("#blueprints_".concat(editor.id, "_blueprint")).val(JSON.stringify(editor.getBlueprint()));
      });
    },
    beforeSend: function beforeSend() {
      var percentVal = "0%";
      $bar.width(percentVal).html(percentVal);
      $progress.show();
      $callout.hide();
      $callout.removeClass("alert success");
      $loading.show();
    },
    uploadProgress: function uploadProgress(event, position, total, percentComplete) {
      // eslint-disable-line
      var percentVal = "".concat(percentComplete, "%");
      $bar.width(percentVal).html(percentVal);
    },
    success: function success(responseText) {
      $callout.show();
      $progress.hide();
      $callout.contents("p").html(responseText);
      $callout.addClass("success");
      $loading.hide();

      if (needsReload()) {
        $loading.show();
        location.reload();
      }
    },
    error: function error(xhr) {
      $loading.hide();
      $callout.show();
      $callout.contents("p").html(xhr.responseText);
      $callout.addClass("alert");
    }
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/map_view.js":
/*!**************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/map_view.js ***!
  \**************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ NavigationMapView; }
/* harmony export */ });
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! leaflet */ "./node_modules/leaflet/dist/leaflet-src.js");
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(leaflet__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var leaflet_dist_leaflet_css__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! leaflet/dist/leaflet.css */ "./node_modules/leaflet/dist/leaflet.css");
/* harmony import */ var _geoman_io_leaflet_geoman_free__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @geoman-io/leaflet-geoman-free */ "./node_modules/@geoman-io/leaflet-geoman-free/dist/leaflet-geoman.min.js");
/* harmony import */ var _geoman_io_leaflet_geoman_free__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(_geoman_io_leaflet_geoman_free__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var _geoman_io_leaflet_geoman_free_dist_leaflet_geoman_css__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @geoman-io/leaflet-geoman-free/dist/leaflet-geoman.css */ "./node_modules/@geoman-io/leaflet-geoman-free/dist/leaflet-geoman.css");
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
} // Creates a map view







var NavigationMapView = /*#__PURE__*/function () {
  function NavigationMapView(map_object, imageDecorator) {
    var _this = this;

    _classCallCheck(this, NavigationMapView);

    this.features = {};
    this.map_object = map_object;
    this.id = map_object.dataset.id;
    this.image_path = map_object.dataset.image;
    this.blueprint = map_object.dataset.blueprint ? JSON.parse(map_object.dataset.blueprint) : {};
    this.image = new Image();

    this.image.onload = function () {
      _this.createMap();

      if (typeof imageDecorator === "function") {
        imageDecorator(_this);
      } else if (_this.blueprint) {
        _this.createAreas();
      }
    };

    this.image.src = this.image_path;

    this.clickAreaCallback = function () {};

    this.setLayerPropertiesCallback = function () {};
  }

  _createClass(NavigationMapView, [{
    key: "createMap",
    value: function createMap() {
      var bounds = [[0, 0], [this.image.height, this.image.width]];
      this.map = L.map(this.map_object, {
        minZoom: -1,
        maxZoom: 2,
        crs: L.CRS.Simple,
        noWrap: true,
        zoomSnap: 0,
        // zoomDelta: 0.1,
        maxBounds: [[0, 0], [this.image.height, this.image.width]],
        center: [this.image.height / 2, this.image.width / 2],
        zoom: -1,
        scrollWheelZoom: false,
        attributionControl: false
      });
      L.imageOverlay(this.image.src, bounds).addTo(this.map);
      this.fitBounds();
    }
  }, {
    key: "fitBounds",
    value: function fitBounds() {
      var image_ratio = this.image.height / this.image.width;
      var map_ratio = this.map_object.offsetHeight / this.map_object.offsetWidth;

      if (image_ratio > map_ratio) {
        this.map.fitBounds([[0, 0], [0, this.image.width]]);
      } else {
        this.map.fitBounds([[0, 0], [this.image.height, 0]]);
      }

      this.map.setView([this.image.height / 2, this.image.width / 2]);
    }
  }, {
    key: "createAreas",
    value: function createAreas() {
      var _this2 = this;

      this.forEachBlueprint(function (id, geoarea) {
        new L.GeoJSON(geoarea, {
          onEachFeature: function onEachFeature(feature, layer) {
            layer._leaflet_id = id;

            _this2.setLayerProperties(layer, geoarea);

            _this2.attachEditorEvents(layer);
          }
        }).addTo(_this2.map);
      });
    }
  }, {
    key: "setLayerProperties",
    value: function setLayerProperties(layer, area) {
      var props = area.properties;

      if (props) {
        if (props.color) {
          layer.setStyle({
            fillColor: props.color,
            color: props.color
          });
        }

        this.setLayerPropertiesCallback(layer, props);
      }
    }
  }, {
    key: "attachEditorEvents",
    value: function attachEditorEvents(layer) {
      var _this3 = this;

      layer.on("mouseover", function (e) {
        e.target.getElement().classList.add("selected");
      });
      layer.on("mouseout", function (e) {
        e.target.getElement().classList.remove("selected");
      });
      layer.on("click", function (e) {
        _this3.clickAreaCallback(e.target, _this3);
      });
    }
  }, {
    key: "onClickArea",
    value: // register callback to handle area clicks
    function onClickArea(callback) {
      this.clickAreaCallback = callback;
    }
  }, {
    key: "onSetLayerProperties",
    value: function onSetLayerProperties(callback) {
      this.setLayerPropertiesCallback = callback;
    }
  }, {
    key: "forEachBlueprint",
    value: function forEachBlueprint(decorator) {
      for (var id in this.blueprint) {
        var geoarea = this.blueprint[id]; // avoid non-polygons for the moment

        if (geoarea.geometry && geoarea.geometry.type === "Polygon") {
          decorator(id, geoarea);
        }
      }
    }
  }, {
    key: "reload",
    value: function reload() {
      if (this.map) {
        this.map.invalidateSize(true);
        this.fitBounds();
      }
    }
  }]);

  return NavigationMapView;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_admin_navigation_maps.scss":
/*!*********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_admin_navigation_maps.scss ***!
  \*********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
// extracted by mini-css-extract-plugin


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
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
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
/******/ 			"decidim_admin_navigation_maps": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["vendors-node_modules_leaflet_dist_leaflet-src_js","vendors-node_modules_geoman-io_leaflet-geoman-free_dist_leaflet-geoman_min_js-node_modules_ge-a7faae"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_admin_navigation_maps.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_admin_navigation_maps.js.map