(self["webpackChunkapp"] = self["webpackChunkapp"] || []).push([["_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-core_app_-0235b8"],{

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map.js":
/*!*****************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map.js ***!
  \*****************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_map_factory__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/map/factory */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/factory.js");

$(function () {
  // Load the map controller factory method in the document.ready handler to
  // allow overriding it by any script that is loaded before the document is
  // ready.
  var $mapElements = $("[data-decidim-map]");

  if ($mapElements.length < 1 && $("#map").length > 0) {
    throw new Error("DEPRECATION: Please update your maps customizations or include 'decidim/map/legacy.js' for legacy support!");
  }

  $mapElements.each(function (_i, el) {
    var $map = $(el);
    var mapId = $map.attr("id");

    if (!mapId) {
      mapId = "map-".concat(Math.random().toString(36).substr(2, 9));
      $map.attr("id", mapId);
    }

    var mapConfig = $map.data("decidim-map");
    var ctrl = (0,src_decidim_map_factory__WEBPACK_IMPORTED_MODULE_0__["default"])(mapId, mapConfig);
    var map = ctrl.load();
    $map.data("map", map);
    $map.data("map-controller", ctrl);
    $map.trigger("configure.decidim", [map, mapConfig]);
    ctrl.start(); // Indicates the map is loaded with the map objects initialized and ready
    // to be used.

    $map.trigger("ready.decidim", [map, mapConfig]);
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller.js":
/*!****************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller.js ***!
  \****************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ MapController; }
/* harmony export */ });
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! leaflet */ "./node_modules/leaflet/dist/leaflet-src.js");
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(leaflet__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_map_icon__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/map/icon */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/icon.js");
/* harmony import */ var src_decidim_map_controller_registry__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/map/controller_registry */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller_registry.js");
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





var MapController = /*#__PURE__*/function () {
  function MapController(mapId, config) {
    _classCallCheck(this, MapController); // Remove the old map if there is already one with the same ID.


    var old = src_decidim_map_controller_registry__WEBPACK_IMPORTED_MODULE_2__["default"].getController(mapId);

    if (old) {
      old.remove();
    }

    this.mapId = mapId;
    this.config = $.extend({
      popupTemplateId: "marker-popup",
      markerColor: "#ef604d"
    }, config);
    this.map = null;
    this.eventHandlers = {};
    src_decidim_map_controller_registry__WEBPACK_IMPORTED_MODULE_2__["default"].setController(mapId, this);
  }

  _createClass(MapController, [{
    key: "getConfig",
    value: function getConfig() {
      return this.config;
    }
  }, {
    key: "getMap",
    value: function getMap() {
      return this.map;
    }
  }, {
    key: "load",
    value: function load() {
      this.map = leaflet__WEBPACK_IMPORTED_MODULE_0__.map(this.mapId);
      this.map.scrollWheelZoom.disable(); // Fix the keyboard navigation on the map

      this.map.on("popupopen", function (ev) {
        var $popup = $(ev.popup.getElement());
        $popup.attr("tabindex", 0).focus();
      });
      this.map.on("popupclose", function (ev) {
        $(ev.popup._source._icon).focus();
      });
      return this.map;
    } // Override this in the specific map controllers.

  }, {
    key: "start",
    value: function start() {}
  }, {
    key: "remove",
    value: function remove() {
      if (this.map) {
        this.map.remove();
        this.map = null;
      }
    }
  }, {
    key: "createIcon",
    value: function createIcon() {
      return new leaflet__WEBPACK_IMPORTED_MODULE_0__.DivIcon.SVGIcon.DecidimIcon({
        fillColor: this.config.markerColor,
        iconSize: leaflet__WEBPACK_IMPORTED_MODULE_0__.point(28, 36)
      });
    }
  }, {
    key: "setEventHandler",
    value: function setEventHandler(name, callback) {
      this.eventHandlers[name] = callback;
    }
  }, {
    key: "triggerEvent",
    value: function triggerEvent(eventName, payload) {
      var handler = this.eventHandlers[eventName];

      if (typeof handler === "function") {
        return Reflect.apply(handler, this, payload);
      }

      return null;
    }
  }]);

  return MapController;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/drag_marker.js":
/*!****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/drag_marker.js ***!
  \****************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ MapDragMarkerController; }
/* harmony export */ });
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! leaflet */ "./node_modules/leaflet/dist/leaflet-src.js");
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(leaflet__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_map_controller__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/map/controller */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller.js");
/* harmony import */ var src_decidim_vendor_leaflet_tilelayer_here__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/vendor/leaflet-tilelayer-here */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/leaflet-tilelayer-here.js");
/* harmony import */ var src_decidim_vendor_leaflet_tilelayer_here__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(src_decidim_vendor_leaflet_tilelayer_here__WEBPACK_IMPORTED_MODULE_2__);
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





var MapDragMarkerController = /*#__PURE__*/function (_MapController) {
  _inherits(MapDragMarkerController, _MapController);

  var _super = _createSuper(MapDragMarkerController);

  function MapDragMarkerController() {
    _classCallCheck(this, MapDragMarkerController);

    return _super.apply(this, arguments);
  }

  _createClass(MapDragMarkerController, [{
    key: "start",
    value: function start() {
      if (this.config.marker) {
        this.addMarker(this.config.marker);
      } else {
        this.map.fitWorld();
      }
    }
  }, {
    key: "addMarker",
    value: function addMarker(markerData) {
      var _this = this;

      if (markerData.latitude === null || markerData.longitude === null) {
        return;
      }

      var coordinates = {
        lat: markerData.latitude,
        lng: markerData.longitude
      };
      this.triggerEvent("coordinates", [coordinates]);
      this.marker = leaflet__WEBPACK_IMPORTED_MODULE_0__.marker(coordinates, {
        icon: this.createIcon(),
        keyboard: true,
        title: markerData.title,
        draggable: true
      });
      this.marker.on("drag", function (ev) {
        _this.triggerEvent("coordinates", [ev.target.getLatLng()]);
      });
      this.marker.addTo(this.map);
      var zoom = parseInt(this.config.zoom, 10) || 14;
      this.map.setView(coordinates, zoom);
    }
  }, {
    key: "getMarker",
    value: function getMarker() {
      return this.marker;
    }
  }, {
    key: "removeMarker",
    value: function removeMarker() {
      if (this.marker) {
        this.marker.remove();
        this.marker = null;
      }
    }
  }]);

  return MapDragMarkerController;
}(src_decidim_map_controller__WEBPACK_IMPORTED_MODULE_1__["default"]);



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/markers.js":
/*!************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/markers.js ***!
  \************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ MapMarkersController; }
/* harmony export */ });
/* harmony import */ var src_decidim_vendor_jquery_tmpl__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/vendor/jquery-tmpl */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/jquery-tmpl.js");
/* harmony import */ var src_decidim_vendor_jquery_tmpl__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_vendor_jquery_tmpl__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! leaflet */ "./node_modules/leaflet/dist/leaflet-src.js");
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(leaflet__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var src_decidim_map_controller__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/map/controller */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller.js");
/* harmony import */ var leaflet_markercluster__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! leaflet.markercluster */ "./node_modules/leaflet.markercluster/dist/leaflet.markercluster-src.js");
/* harmony import */ var leaflet_markercluster__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(leaflet_markercluster__WEBPACK_IMPORTED_MODULE_3__);
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






var MapMarkersController = /*#__PURE__*/function (_MapController) {
  _inherits(MapMarkersController, _MapController);

  var _super = _createSuper(MapMarkersController);

  function MapMarkersController() {
    _classCallCheck(this, MapMarkersController);

    return _super.apply(this, arguments);
  }

  _createClass(MapMarkersController, [{
    key: "start",
    value: function start() {
      this.markerClusters = null;

      if (Array.isArray(this.config.markers) && this.config.markers.length > 0) {
        this.addMarkers(this.config.markers);
      } else {
        this.map.fitWorld();
      }
    }
  }, {
    key: "addMarkers",
    value: function addMarkers(markersData) {
      var _this = this;

      if (this.markerClusters === null) {
        this.markerClusters = new leaflet__WEBPACK_IMPORTED_MODULE_1__.MarkerClusterGroup();
        this.map.addLayer(this.markerClusters);
      } // Pre-compiles the template


      $.template(this.config.popupTemplateId, $("#".concat(this.config.popupTemplateId)).html());
      var bounds = new leaflet__WEBPACK_IMPORTED_MODULE_1__.LatLngBounds(markersData.map(function (markerData) {
        return [markerData.latitude, markerData.longitude];
      }));
      markersData.forEach(function (markerData) {
        var marker = new leaflet__WEBPACK_IMPORTED_MODULE_1__.Marker([markerData.latitude, markerData.longitude], {
          icon: _this.createIcon(),
          keyboard: true,
          title: markerData.title
        });
        var node = document.createElement("div");
        $.tmpl(_this.config.popupTemplateId, markerData).appendTo(node);
        marker.bindPopup(node, {
          maxwidth: 640,
          minWidth: 500,
          keepInView: true,
          className: "map-info"
        }).openPopup();

        _this.markerClusters.addLayer(marker);
      }); // Make sure there is enough space in the map for the padding to be
      // applied. Otherwise the map will automatically zoom out (test it on
      // mobile). Make sure there is at least the same amount of width and
      // height available on both sides + the padding (i.e. 4x padding in
      // total).

      var size = this.map.getSize();

      if (size.y >= 400 && size.x >= 400) {
        this.map.fitBounds(bounds, {
          padding: [100, 100]
        });
      } else if (size.y >= 120 && size.x >= 120) {
        this.map.fitBounds(bounds, {
          padding: [30, 30]
        });
      } else {
        this.map.fitBounds(bounds);
      }
    }
  }, {
    key: "clearMarkers",
    value: function clearMarkers() {
      this.map.removeLayer(this.markerClusters);
      this.markerClusters = new leaflet__WEBPACK_IMPORTED_MODULE_1__.MarkerClusterGroup();
      this.map.addLayer(this.markerClusters);
    }
  }]);

  return MapMarkersController;
}(src_decidim_map_controller__WEBPACK_IMPORTED_MODULE_2__["default"]);



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/static.js":
/*!***********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/static.js ***!
  \***********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ MapStaticController; }
/* harmony export */ });
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! leaflet */ "./node_modules/leaflet/dist/leaflet-src.js");
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(leaflet__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_map_controller__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/map/controller */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller.js");
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



var openLink = window.open;

var MapStaticController = /*#__PURE__*/function (_MapController) {
  _inherits(MapStaticController, _MapController);

  var _super = _createSuper(MapStaticController);

  function MapStaticController() {
    _classCallCheck(this, MapStaticController);

    return _super.apply(this, arguments);
  }

  _createClass(MapStaticController, [{
    key: "start",
    value: function start() {
      var _this = this;

      this.map.removeControl(this.map.zoomControl);
      this.map.dragging.disable();
      this.map.touchZoom.disable();
      this.map.doubleClickZoom.disable();
      this.map.scrollWheelZoom.disable();
      this.map.boxZoom.disable();
      this.map.keyboard.disable();

      if (this.map.tap) {
        this.map.tap.disable();
      }

      if (this.config.latitude && this.config.longitude) {
        var coordinates = [this.config.latitude, this.config.longitude];
        this.map.panTo(coordinates);
        var marker = leaflet__WEBPACK_IMPORTED_MODULE_0__.marker(coordinates, {
          icon: this.createIcon(),
          keyboard: true,
          title: this.config.title
        }).addTo(this.map);

        marker._icon.removeAttribute("tabindex");
      }

      if (this.config.zoom) {
        this.map.setZoom(this.config.zoom);
      } else {
        this.map.setZoom(15);
      }

      if (this.config.link) {
        this.map._container.addEventListener("click", function (ev) {
          ev.preventDefault();

          _this.map._container.focus();

          openLink(_this.config.link, "_blank");
        });
      }
    }
  }]);

  return MapStaticController;
}(src_decidim_map_controller__WEBPACK_IMPORTED_MODULE_1__["default"]);



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller_registry.js":
/*!*************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller_registry.js ***!
  \*************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ MapControllerRegistry; }
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

var CONTROLLER_REGISTRY = {};

var MapControllerRegistry = /*#__PURE__*/function () {
  function MapControllerRegistry() {
    _classCallCheck(this, MapControllerRegistry);
  }

  _createClass(MapControllerRegistry, null, [{
    key: "getController",
    value: function getController(mapId) {
      return CONTROLLER_REGISTRY[mapId];
    }
  }, {
    key: "setController",
    value: function setController(mapId, map) {
      CONTROLLER_REGISTRY[mapId] = map;
    }
  }, {
    key: "findByMap",
    value: function findByMap(map) {
      return Object.values(CONTROLLER_REGISTRY).find(function (ctrl) {
        return ctrl.getMap() === map;
      });
    }
  }]);

  return MapControllerRegistry;
}();



/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/factory.js":
/*!*************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/factory.js ***!
  \*************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ createMapController; }
/* harmony export */ });
/* harmony import */ var src_decidim_map_controller_markers__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/map/controller/markers */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/markers.js");
/* harmony import */ var src_decidim_map_controller_static__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/map/controller/static */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/static.js");
/* harmony import */ var src_decidim_map_controller_drag_marker__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! src/decidim/map/controller/drag_marker */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/controller/drag_marker.js");



/**
 * A factory method that creates a new map controller instance. This method
 * can be overridden in order to return different types of maps for
 * differently configured map elements.
 *
 * For instance, one map could pass an extra `type` configuration with the
 * value "custom" for the map element, this factory method would identify
 * it and then return a different controller for that map than the default.
 * This would allow this types of maps to function differently.
 *
 * An example how to use in the ERB view:
 *   <%= dynamic_map_for type: "custom" do %>
 *     <%= javascript_pack_tag "map_customization" %>
 *   <% end %>
 *
 * And then the actual customization at `map_customization.js.es6`:
 *   var originalCreateMapController = window.Decidim.createMapController;
 *   window.Decidim.createMapController = (mapId, config) => {
 *     if (config.type === "custom") {
 *       // Obviously you need to implement CustomMapController for this to
 *       // work.
 *       return new window.Decidim.CustomMapController(mapId, config);
 *     }
 *
 *     return originalCreateMapController(mapId, config);
 *   }
 *
 * @param {string} mapId The ID of the map element.
 * @param {Object} config The map configuration object.
 * @returns {MapController} The controller for the map.
 */

function createMapController(mapId, config) {
  if (config.type === "static") {
    return new src_decidim_map_controller_static__WEBPACK_IMPORTED_MODULE_1__["default"](mapId, config);
  } else if (config.type === "drag-marker") {
    return new src_decidim_map_controller_drag_marker__WEBPACK_IMPORTED_MODULE_2__["default"](mapId, config);
  }

  return new src_decidim_map_controller_markers__WEBPACK_IMPORTED_MODULE_0__["default"](mapId, config);
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/icon.js":
/*!**********************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/map/icon.js ***!
  \**********************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! leaflet */ "./node_modules/leaflet/dist/leaflet-src.js");
/* harmony import */ var leaflet__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(leaflet__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var leaflet_svgicon__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! leaflet-svgicon */ "./node_modules/leaflet-svgicon/index.js");


leaflet__WEBPACK_IMPORTED_MODULE_0__.DivIcon.SVGIcon = leaflet_svgicon__WEBPACK_IMPORTED_MODULE_1__.SVGIcon;
leaflet__WEBPACK_IMPORTED_MODULE_0__.DivIcon.SVGIcon.DecidimIcon = leaflet__WEBPACK_IMPORTED_MODULE_0__.DivIcon.SVGIcon.extend({
  options: {
    fillColor: "#ef604d",
    opacity: 0
  },
  _createPathDescription: function _createPathDescription() {
    return "M14 1.17a11.685 11.685 0 0 0-11.685 11.685c0 11.25 10.23 20.61 10.665 21a1.5 1.5 0 0 0 2.025 0c0.435-.435 10.665-9.81 10.665-21A11.685 11.685 0 0 0 14 1.17Zm0 17.415A5.085 5.085 0 1 1 19.085 13.5 5.085 5.085 0 0 1 14 18.585Z";
  },
  _createCircle: function _createCircle() {
    return "";
  },
  // Improved version of the _createSVG, essentially the same as in later
  // versions of Leaflet. It adds the `px` values after the width and height
  // CSS making the focus borders work correctly across all browsers.
  _createSVG: function _createSVG() {
    var path = this._createPath();

    var circle = this._createCircle();

    var text = this._createText();

    var className = "".concat(this.options.className, "-svg");
    var style = "width:".concat(this.options.iconSize.x, "px; height:").concat(this.options.iconSize.y, "px;");
    var svg = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" class=\"".concat(className, "\" style=\"").concat(style, "\">").concat(path).concat(circle).concat(text, "</svg>");
    return svg;
  }
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/jquery-tmpl.js":
/*!********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/jquery-tmpl.js ***!
  \********************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable */

/*
 * jQuery Templating Plugin
 * Copyright 2010, John Resig
 * Dual licensed under the MIT or GPL Version 2 licenses.
 */
;

(function (jQuery, undefined) {
  var oldManip = jQuery.fn.domManip,
      tmplItmAtt = "_tmplitem",
      htmlExpr = /^[^<]*(<[\w\W]+>)[^>]*$|\{\{\! /,
      newTmplItems = {},
      wrappedItems = {},
      appendToTmplItems,
      topTmplItem = {
    key: 0,
    data: {}
  },
      itemKey = 0,
      cloneIndex = 0,
      stack = [];

  function newTmplItem(options, parentItem, fn, data) {
    // Returns a template item data structure for a new rendered instance of a template (a 'template item').
    // The content field is a hierarchical array of strings and nested items (to be
    // removed and replaced by nodes field of dom elements, once inserted in DOM).
    var newItem = {
      data: data || (parentItem ? parentItem.data : {}),
      _wrap: parentItem ? parentItem._wrap : null,
      tmpl: null,
      parent: parentItem || null,
      nodes: [],
      calls: tiCalls,
      nest: tiNest,
      wrap: tiWrap,
      html: tiHtml,
      update: tiUpdate
    };

    if (options) {
      jQuery.extend(newItem, options, {
        nodes: [],
        parent: parentItem
      });
    }

    if (fn) {
      // Build the hierarchical content to be used during insertion into DOM
      newItem.tmpl = fn;
      newItem._ctnt = newItem._ctnt || newItem.tmpl(jQuery, newItem);
      newItem.key = ++itemKey; // Keep track of new template item, until it is stored as jQuery Data on DOM element

      (stack.length ? wrappedItems : newTmplItems)[itemKey] = newItem;
    }

    return newItem;
  } // Override appendTo etc., in order to provide support for targeting multiple elements. (This code would disappear if integrated in jquery core).


  jQuery.each({
    appendTo: "append",
    prependTo: "prepend",
    insertBefore: "before",
    insertAfter: "after",
    replaceAll: "replaceWith"
  }, function (name, original) {
    jQuery.fn[name] = function (selector) {
      var ret = [],
          insert = jQuery(selector),
          elems,
          i,
          l,
          tmplItems,
          parent = this.length === 1 && this[0].parentNode;
      appendToTmplItems = newTmplItems || {};

      if (parent && parent.nodeType === 11 && parent.childNodes.length === 1 && insert.length === 1) {
        insert[original](this[0]);
        ret = this;
      } else {
        for (i = 0, l = insert.length; i < l; i++) {
          cloneIndex = i;
          elems = (i > 0 ? this.clone(true) : this).get();
          jQuery.fn[original].apply(jQuery(insert[i]), elems);
          ret = ret.concat(elems);
        }

        cloneIndex = 0;
        ret = this.pushStack(ret, name, insert.selector);
      }

      tmplItems = appendToTmplItems;
      appendToTmplItems = null;
      jQuery.tmpl.complete(tmplItems);
      return ret;
    };
  });
  jQuery.fn.extend({
    // Use first wrapped element as template markup.
    // Return wrapped set of template items, obtained by rendering template against data.
    tmpl: function tmpl(data, options, parentItem) {
      return jQuery.tmpl(this[0], data, options, parentItem);
    },
    // Find which rendered template item the first wrapped DOM element belongs to
    tmplItem: function tmplItem() {
      return jQuery.tmplItem(this[0]);
    },
    // Consider the first wrapped element as a template declaration, and get the compiled template or store it as a named template.
    template: function template(name) {
      return jQuery.template(name, this[0]);
    },
    domManip: function domManip(args, table, callback, options) {
      // This appears to be a bug in the appendTo, etc. implementation
      // it should be doing .call() instead of .apply(). See #6227
      if (args[0] && args[0].nodeType) {
        var dmArgs = jQuery.makeArray(arguments),
            argsLength = args.length,
            i = 0,
            tmplItem;

        while (i < argsLength && !(tmplItem = jQuery.data(args[i++], "tmplItem"))) {}

        if (argsLength > 1) {
          dmArgs[0] = [jQuery.makeArray(args)];
        }

        if (tmplItem && cloneIndex) {
          dmArgs[2] = function (fragClone) {
            // Handler called by oldManip when rendered template has been inserted into DOM.
            jQuery.tmpl.afterManip(this, fragClone, callback);
          };
        }

        oldManip.apply(this, dmArgs);
      } else {
        oldManip.apply(this, arguments);
      }

      cloneIndex = 0;

      if (!appendToTmplItems) {
        jQuery.tmpl.complete(newTmplItems);
      }

      return this;
    }
  });
  jQuery.extend({
    // Return wrapped set of template items, obtained by rendering template against data.
    tmpl: function tmpl(_tmpl, data, options, parentItem) {
      var ret,
          topLevel = !parentItem;

      if (topLevel) {
        // This is a top-level tmpl call (not from a nested template using {{tmpl}})
        parentItem = topTmplItem;
        _tmpl = jQuery.template[_tmpl] || jQuery.template(null, _tmpl);
        wrappedItems = {}; // Any wrapped items will be rebuilt, since this is top level
      } else if (!_tmpl) {
        // The template item is already associated with DOM - this is a refresh.
        // Re-evaluate rendered template for the parentItem
        _tmpl = parentItem.tmpl;
        newTmplItems[parentItem.key] = parentItem;
        parentItem.nodes = [];

        if (parentItem.wrapped) {
          updateWrapped(parentItem, parentItem.wrapped);
        } // Rebuild, without creating a new template item


        return jQuery(build(parentItem, null, parentItem.tmpl(jQuery, parentItem)));
      }

      if (!_tmpl) {
        return []; // Could throw...
      }

      if (typeof data === "function") {
        data = data.call(parentItem || {});
      }

      if (options && options.wrapped) {
        updateWrapped(options, options.wrapped);
      }

      ret = jQuery.isArray(data) ? jQuery.map(data, function (dataItem) {
        return dataItem ? newTmplItem(options, parentItem, _tmpl, dataItem) : null;
      }) : [newTmplItem(options, parentItem, _tmpl, data)];
      return topLevel ? jQuery(build(parentItem, null, ret)) : ret;
    },
    // Return rendered template item for an element.
    tmplItem: function tmplItem(elem) {
      var tmplItem;

      if (elem instanceof jQuery) {
        elem = elem[0];
      }

      while (elem && elem.nodeType === 1 && !(tmplItem = jQuery.data(elem, "tmplItem")) && (elem = elem.parentNode)) {}

      return tmplItem || topTmplItem;
    },
    // Set:
    // Use $.template( name, tmpl ) to cache a named template,
    // where tmpl is a template string, a script element or a jQuery instance wrapping a script element, etc.
    // Use $( "selector" ).template( name ) to provide access by name to a script block template declaration.
    // Get:
    // Use $.template( name ) to access a cached template.
    // Also $( selectorToScriptBlock ).template(), or $.template( null, templateString )
    // will return the compiled template, without adding a name reference.
    // If templateString includes at least one HTML tag, $.template( templateString ) is equivalent
    // to $.template( null, templateString )
    template: function template(name, tmpl) {
      if (tmpl) {
        // Compile template and associate with name
        if (typeof tmpl === "string") {
          // This is an HTML string being passed directly in.
          tmpl = buildTmplFn(tmpl);
        } else if (tmpl instanceof jQuery) {
          tmpl = tmpl[0] || {};
        }

        if (tmpl.nodeType) {
          // If this is a template block, use cached copy, or generate tmpl function and cache.
          tmpl = jQuery.data(tmpl, "tmpl") || jQuery.data(tmpl, "tmpl", buildTmplFn(tmpl.innerHTML));
        }

        return typeof name === "string" ? jQuery.template[name] = tmpl : tmpl;
      } // Return named compiled template


      return name ? typeof name !== "string" ? jQuery.template(null, name) : jQuery.template[name] || // If not in map, treat as a selector. (If integrated with core, use quickExpr.exec)
      jQuery.template(null, htmlExpr.test(name) ? name : jQuery(name)) : null;
    },
    encode: function encode(text) {
      // Do HTML encoding replacing < > & and ' and " by corresponding entities.
      return ("" + text).split("<").join("&lt;").split(">").join("&gt;").split('"').join("&#34;").split("'").join("&#39;");
    }
  });
  jQuery.extend(jQuery.tmpl, {
    tag: {
      "tmpl": {
        _default: {
          $2: "null"
        },
        open: "if($notnull_1){_=_.concat($item.nest($1,$2));}" // tmpl target parameter can be of type function, so use $1, not $1a (so not auto detection of functions)
        // This means that {{tmpl foo}} treats foo as a template (which IS a function).
        // Explicit parens can be used if foo is a function that returns a template: {{tmpl foo()}}.

      },
      "wrap": {
        _default: {
          $2: "null"
        },
        open: "$item.calls(_,$1,$2);_=[];",
        close: "call=$item.calls();_=call._.concat($item.wrap(call,_));"
      },
      "each": {
        _default: {
          $2: "$index, $value"
        },
        open: "if($notnull_1){$.each($1a,function($2){with(this){",
        close: "}});}"
      },
      "if": {
        open: "if(($notnull_1) && $1a){",
        close: "}"
      },
      "else": {
        _default: {
          $1: "true"
        },
        open: "}else if(($notnull_1) && $1a){"
      },
      "html": {
        // Unecoded expression evaluation.
        open: "if($notnull_1){_.push($1a);}"
      },
      "=": {
        // Encoded expression evaluation. Abbreviated form is ${}.
        _default: {
          $1: "$data"
        },
        open: "if($notnull_1){_.push($.encode($1a));}"
      },
      "!": {
        // Comment tag. Skipped by parser
        open: ""
      }
    },
    // This stub can be overridden, e.g. in jquery.tmplPlus for providing rendered events
    complete: function complete(items) {
      newTmplItems = {};
    },
    // Call this from code which overrides domManip, or equivalent
    // Manage cloning/storing template items etc.
    afterManip: function afterManip(elem, fragClone, callback) {
      // Provides cloned fragment ready for fixup prior to and after insertion into DOM
      var content = fragClone.nodeType === 11 ? jQuery.makeArray(fragClone.childNodes) : fragClone.nodeType === 1 ? [fragClone] : []; // Return fragment to original caller (e.g. append) for DOM insertion

      callback.call(elem, fragClone); // Fragment has been inserted:- Add inserted nodes to tmplItem data structure. Replace inserted element annotations by jQuery.data.

      storeTmplItems(content);
      cloneIndex++;
    }
  }); //========================== Private helper functions, used by code above ==========================

  function build(tmplItem, nested, content) {
    // Convert hierarchical content into flat string array
    // and finally return array of fragments ready for DOM insertion
    var frag,
        ret = content ? jQuery.map(content, function (item) {
      return typeof item === "string" ? // Insert template item annotations, to be converted to jQuery.data( "tmplItem" ) when elems are inserted into DOM.
      tmplItem.key ? item.replace(/(<\w+)(?=[\s>])(?![^>]*_tmplitem)([^>]*)/g, "$1 " + tmplItmAtt + "=\"" + tmplItem.key + "\" $2") : item : // This is a child template item. Build nested template.
      build(item, tmplItem, item._ctnt);
    }) : // If content is not defined, insert tmplItem directly. Not a template item. May be a string, or a string array, e.g. from {{html $item.html()}}.
    tmplItem;

    if (nested) {
      return ret;
    } // top-level template


    ret = ret.join(""); // Support templates which have initial or final text nodes, or consist only of text
    // Also support HTML entities within the HTML markup.

    ret.replace(/^\s*([^<\s][^<]*)?(<[\w\W]+>)([^>]*[^>\s])?\s*$/, function (all, before, middle, after) {
      frag = jQuery(middle).get();
      storeTmplItems(frag);

      if (before) {
        frag = unencode(before).concat(frag);
      }

      if (after) {
        frag = frag.concat(unencode(after));
      }
    });
    return frag ? frag : unencode(ret);
  }

  function unencode(text) {
    // Use createElement, since createTextNode will not render HTML entities correctly
    var el = document.createElement("div");
    el.innerHTML = text;
    return jQuery.makeArray(el.childNodes);
  } // Generate a reusable function that will serve to render a template against data


  function buildTmplFn(markup) {
    return new Function("jQuery", "$item", "var $=jQuery,call,_=[],$data=$item.data;" + // Introduce the data as local variables using with(){}
    "with($data){_.push('" + // Convert the template into pure JavaScript
    jQuery.trim(markup).replace(/([\\'])/g, "\\$1").replace(/[\r\t\n]/g, " ").replace(/\$\{([^\}]*)\}/g, "{{= $1}}").replace(/\{\{(\/?)(\w+|.)(?:\(((?:[^\}]|\}(?!\}))*?)?\))?(?:\s+(.*?)?)?(\(((?:[^\}]|\}(?!\}))*?)\))?\s*\}\}/g, function (all, slash, type, fnargs, target, parens, args) {
      var tag = jQuery.tmpl.tag[type],
          def,
          expr,
          exprAutoFnDetect;

      if (!tag) {
        throw "Template command not found: " + type;
      }

      def = tag._default || [];

      if (parens && !/\w$/.test(target)) {
        target += parens;
        parens = "";
      }

      if (target) {
        target = unescape(target);
        args = args ? "," + unescape(args) + ")" : parens ? ")" : ""; // Support for target being things like a.toLowerCase();
        // In that case don't call with template item as 'this' pointer. Just evaluate...

        expr = parens ? target.indexOf(".") > -1 ? target + parens : "(" + target + ").call($item" + args : target;
        exprAutoFnDetect = parens ? expr : "(typeof(" + target + ")==='function'?(" + target + ").call($item):(" + target + "))";
      } else {
        exprAutoFnDetect = expr = def.$1 || "null";
      }

      fnargs = unescape(fnargs);
      return "');" + tag[slash ? "close" : "open"].split("$notnull_1").join(target ? "typeof(" + target + ")!=='undefined' && (" + target + ")!=null" : "true").split("$1a").join(exprAutoFnDetect).split("$1").join(expr).split("$2").join(fnargs ? fnargs.replace(/\s*([^\(]+)\s*(\((.*?)\))?/g, function (all, name, parens, params) {
        params = params ? "," + params + ")" : parens ? ")" : "";
        return params ? "(" + name + ").call($item" + params : all;
      }) : def.$2 || "") + "_.push('";
    }) + "');}return _;");
  }

  function updateWrapped(options, wrapped) {
    // Build the wrapped content.
    options._wrap = build(options, true, // Suport imperative scenario in which options.wrapped can be set to a selector or an HTML string.
    jQuery.isArray(wrapped) ? wrapped : [htmlExpr.test(wrapped) ? wrapped : jQuery(wrapped).html()]).join("");
  }

  function unescape(args) {
    return args ? args.replace(/\\'/g, "'").replace(/\\\\/g, "\\") : null;
  }

  function outerHtml(elem) {
    var div = document.createElement("div");
    div.appendChild(elem.cloneNode(true));
    return div.innerHTML;
  } // Store template items in jQuery.data(), ensuring a unique tmplItem data data structure for each rendered template instance.


  function storeTmplItems(content) {
    var keySuffix = "_" + cloneIndex,
        elem,
        elems,
        newClonedItems = {},
        i,
        l,
        m;

    for (i = 0, l = content.length; i < l; i++) {
      if ((elem = content[i]).nodeType !== 1) {
        continue;
      }

      elems = elem.getElementsByTagName("*");

      for (m = elems.length - 1; m >= 0; m--) {
        processItemKey(elems[m]);
      }

      processItemKey(elem);
    }

    function processItemKey(el) {
      var pntKey,
          pntNode = el,
          pntItem,
          tmplItem,
          key; // Ensure that each rendered template inserted into the DOM has its own template item,

      if (key = el.getAttribute(tmplItmAtt)) {
        while (pntNode.parentNode && (pntNode = pntNode.parentNode).nodeType === 1 && !(pntKey = pntNode.getAttribute(tmplItmAtt))) {}

        if (pntKey !== key) {
          // The next ancestor with a _tmplitem expando is on a different key than this one.
          // So this is a top-level element within this template item
          // Set pntNode to the key of the parentNode, or to 0 if pntNode.parentNode is null, or pntNode is a fragment.
          pntNode = pntNode.parentNode ? pntNode.nodeType === 11 ? 0 : pntNode.getAttribute(tmplItmAtt) || 0 : 0;

          if (!(tmplItem = newTmplItems[key])) {
            // The item is for wrapped content, and was copied from the temporary parent wrappedItem.
            tmplItem = wrappedItems[key];
            tmplItem = newTmplItem(tmplItem, newTmplItems[pntNode] || wrappedItems[pntNode], null, true);
            tmplItem.key = ++itemKey;
            newTmplItems[itemKey] = tmplItem;
          }

          if (cloneIndex) {
            cloneTmplItem(key);
          }
        }

        el.removeAttribute(tmplItmAtt);
      } else if (cloneIndex && (tmplItem = jQuery.data(el, "tmplItem"))) {
        // This was a rendered element, cloned during append or appendTo etc.
        // TmplItem stored in jQuery data has already been cloned in cloneCopyEvent. We must replace it with a fresh cloned tmplItem.
        cloneTmplItem(tmplItem.key);
        newTmplItems[tmplItem.key] = tmplItem;
        pntNode = jQuery.data(el.parentNode, "tmplItem");
        pntNode = pntNode ? pntNode.key : 0;
      }

      if (tmplItem) {
        pntItem = tmplItem; // Find the template item of the parent element.
        // (Using !=, not !==, since pntItem.key is number, and pntNode may be a string)

        while (pntItem && pntItem.key != pntNode) {
          // Add this element as a top-level node for this rendered template item, as well as for any
          // ancestor items between this item and the item of its parent element
          pntItem.nodes.push(el);
          pntItem = pntItem.parent;
        } // Delete content built during rendering - reduce API surface area and memory use, and avoid exposing of stale data after rendering...


        delete tmplItem._ctnt;
        delete tmplItem._wrap; // Store template item as jQuery data on the element

        jQuery.data(el, "tmplItem", tmplItem);
      }

      function cloneTmplItem(key) {
        key = key + keySuffix;
        tmplItem = newClonedItems[key] = newClonedItems[key] || newTmplItem(tmplItem, newTmplItems[tmplItem.parent.key + keySuffix] || tmplItem.parent, null, true);
      }
    }
  } //---- Helper functions for template item ----


  function tiCalls(content, tmpl, data, options) {
    if (!content) {
      return stack.pop();
    }

    stack.push({
      _: content,
      tmpl: tmpl,
      item: this,
      data: data,
      options: options
    });
  }

  function tiNest(tmpl, data, options) {
    // nested template, using {{tmpl}} tag
    return jQuery.tmpl(jQuery.template(tmpl), data, options, this);
  }

  function tiWrap(call, wrapped) {
    // nested template, using {{wrap}} tag
    var options = call.options || {};
    options.wrapped = wrapped; // Apply the template, which may incorporate wrapped content,

    return jQuery.tmpl(jQuery.template(call.tmpl), call.data, options, call.item);
  }

  function tiHtml(filter, textOnly) {
    var wrapped = this._wrap;
    return jQuery.map(jQuery(jQuery.isArray(wrapped) ? wrapped.join("") : wrapped).filter(filter || "*"), function (e) {
      return textOnly ? e.innerText || e.textContent : e.outerHTML || outerHtml(e);
    });
  }

  function tiUpdate() {
    var coll = this.nodes;
    jQuery.tmpl(null, null, null, this).insertBefore(coll[0]);
    jQuery(coll).remove();
  }
})(jQuery);

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/leaflet-tilelayer-here.js":
/*!*******************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vendor/leaflet-tilelayer-here.js ***!
  \*******************************************************************************************************************************************************************/
/***/ (function() {

/* eslint-disable */
// 🍂class TileLayer.HERE
// Tile layer for HERE maps tiles.
L.TileLayer.HERE = L.TileLayer.extend({
  options: {
    subdomains: '1234',
    minZoom: 2,
    maxZoom: 18,
    // 🍂option scheme: String = 'normal.day'
    // The "map scheme", as documented in the HERE API.
    scheme: 'normal.day',
    // 🍂option resource: String = 'maptile'
    // The "map resource", as documented in the HERE API.
    resource: 'maptile',
    // 🍂option mapId: String = 'newest'
    // Version of the map tiles to be used, or a hash of an unique map
    mapId: 'newest',
    // 🍂option format: String = 'png8'
    // Image format to be used (`png8`, `png`, or `jpg`)
    format: 'png8',
    // 🍂option appId: String = ''
    // Required option. The `app_id` provided as part of the HERE credentials
    appId: '',
    // 🍂option appCode: String = ''
    // Required option. The `app_code` provided as part of the HERE credentials
    appCode: '',
    // 🍂option useCIT: boolean = false
    // Whether to use the CIT when loading the here-maptiles
    useCIT: false,
    // 🍂option useHTTPS: boolean = true
    // Whether to use HTTPS when loading the here-maptiles
    useHTTPS: true,
    // 🍂option language: String = ''
    // The language of the descriptions on the maps that are loaded
    language: '',
    // 🍂option language: String = ''
    // The second language of the descriptions on the maps that are loaded
    language2: ''
  },
  initialize: function initialize(options) {
    options = L.setOptions(this, options); // Decide if this scheme uses the aerial servers or the basemap servers

    var schemeStart = options.scheme.split('.')[0];
    options.tileResolution = 256; // {Base URL}{Path}/{resource (tile type)}/{map id}/{scheme}/{zoom}/{column}/{row}/{size}/{format}
    // ?apiKey={YOUR_API_KEY}
    // &{param}={value}

    var params = ['apiKey=' + encodeURIComponent(options.apiKey)]; // Fallback to old app_id,app_code if no apiKey passed

    if (!options.apiKey) {
      params = ['app_id=' + encodeURIComponent(options.appId), 'app_code=' + encodeURIComponent(options.appCode)];
    }

    if (options.language) {
      params.push('lg=' + encodeURIComponent(options.language));
    }

    if (options.language2) {
      params.push('lg2=' + encodeURIComponent(options.language2));
    }

    var urlQuery = '?' + params.join('&');
    var path = '/maptile/2.1/{resource}/{mapId}/{scheme}/{z}/{x}/{y}/{tileResolution}/{format}' + urlQuery;
    var attributionPath = '/maptile/2.1/copyright/{mapId}?apiKey={apiKey}';
    var baseUrl = 'maps.ls.hereapi.com'; // Old style with apiId/apiCode for compatibility

    if (!options.apiKey) {
      // make sure the CIT-url can be used
      baseUrl = 'maps' + (options.useCIT ? '.cit' : '') + '.api.here.com';
      attributionPath = '/maptile/2.1/copyright/{mapId}?app_id={appId}&app_code={appCode}';
    }

    var tileServer = 'base.' + baseUrl;

    if (schemeStart == 'satellite' || schemeStart == 'terrain' || schemeStart == 'hybrid') {
      tileServer = 'aerial.' + baseUrl;
    }

    if (options.scheme.indexOf('.traffic.') !== -1) {
      tileServer = 'traffic' + baseUrl;
    }

    var protocol = 'http' + (options.useHTTPS ? 's' : '');
    var tileUrl = protocol + '://{s}.' + tileServer + path;
    this._attributionUrl = L.Util.template(protocol + '://1.' + tileServer + attributionPath, this.options);
    L.TileLayer.prototype.initialize.call(this, tileUrl, options);
    this._attributionText = '';
  },
  onAdd: function onAdd(map) {
    L.TileLayer.prototype.onAdd.call(this, map);

    if (!this._attributionBBoxes) {
      this._fetchAttributionBBoxes();
    }
  },
  onRemove: function onRemove(map) {
    //
    // Remove the attribution text, and clear the cached text so it will be recalculated
    // if/when we are shown again.
    //
    this._map.attributionControl.removeAttribution(this._attributionText);

    this._attributionText = '';

    this._map.off('moveend zoomend resetview', this._findCopyrightBBox, this); //
    // Call the prototype last, once we've tidied up our own changes
    //


    L.TileLayer.prototype.onRemove.call(this, map);
  },
  _fetchAttributionBBoxes: function _onMapMove() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = L.bind(function () {
      if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        this._parseAttributionBBoxes(JSON.parse(xmlhttp.responseText));
      }
    }, this);
    xmlhttp.open("GET", this._attributionUrl, true);
    xmlhttp.send();
  },
  _parseAttributionBBoxes: function _parseAttributionBBoxes(json) {
    if (!this._map) {
      return;
    }

    var providers = json[this.options.scheme.split('.')[0]] || json.normal;

    for (var i = 0; i < providers.length; i++) {
      if (providers[i].boxes) {
        for (var j = 0; j < providers[i].boxes.length; j++) {
          var box = providers[i].boxes[j];
          providers[i].boxes[j] = L.latLngBounds([[box[0], box[1]], [box[2], box[3]]]);
        }
      }
    }

    this._map.on('moveend zoomend resetview', this._findCopyrightBBox, this);

    this._attributionProviders = providers;

    this._findCopyrightBBox();
  },
  _findCopyrightBBox: function _findCopyrightBBox() {
    if (!this._map) {
      return;
    }

    var providers = this._attributionProviders;
    var visibleProviders = [];

    var zoom = this._map.getZoom();

    var visibleBounds = this._map.getBounds();

    for (var i = 0; i < providers.length; i++) {
      if (providers[i].minLevel <= zoom && providers[i].maxLevel >= zoom) {
        if (!providers[i].boxes) {
          // No boxes = attribution always visible
          visibleProviders.push(providers[i]);
        } else {
          for (var j = 0; j < providers[i].boxes.length; j++) {
            var box = providers[i].boxes[j];

            if (visibleBounds.intersects(box)) {
              visibleProviders.push(providers[i]);
              break;
            }
          }
        }
      }
    }

    var attributions = ['<a href="https://legal.here.com/en-gb/terms" target="_blank" rel="noopener noreferrer">HERE maps</a>'];

    for (var i = 0; i < visibleProviders.length; i++) {
      var provider = visibleProviders[i];
      attributions.push('<abbr title="' + provider.alt + '">' + provider.label + '</abbr>');
    }

    var attributionText = '© ' + attributions.join(', ') + '. ';

    if (attributionText !== this._attributionText) {
      this._map.attributionControl.removeAttribution(this._attributionText);

      this._map.attributionControl.addAttribution(this._attributionText = attributionText);
    }
  }
});

L.tileLayer.here = function (opts) {
  return new L.TileLayer.HERE(opts);
};

/***/ })

}]);
//# sourceMappingURL=_rbenv_versions_2_7_5_lib_ruby_gems_2_7_0_bundler_gems_decidim-f920e99dc728_decidim-core_app_-0235b8.js.map