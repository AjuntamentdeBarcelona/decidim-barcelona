/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_navigation_maps.js":
/*!*************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_navigation_maps.js ***!
  \*************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_navigation_maps_navigation_maps_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/navigation_maps/navigation_maps.js */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/navigation_maps.js");
/* harmony import */ var entrypoints_decidim_navigation_maps_scss__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! entrypoints/decidim_navigation_maps.scss */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_navigation_maps.scss");
 // CSS



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

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/navigation_maps.js":
/*!*********************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/navigation_maps.js ***!
  \*********************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_navigation_maps_map_view_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/navigation_maps/map_view.js */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/src/decidim/navigation_maps/map_view.js");
/* harmony import */ var jsviews_jsrender__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! jsviews/jsrender */ "./node_modules/jsviews/jsrender.js");
/* harmony import */ var jsviews_jsrender__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jsviews_jsrender__WEBPACK_IMPORTED_MODULE_1__);


$(function () {
  var $maps = $(".navigation_maps .map");
  var $tabs = $("#navigation_maps-tabs");
  var maps = {};
  var tmpl = $.templates("#navigation_maps-popup");
  $maps.each(function () {
    var id = $(this).data("id");
    maps[id] = new src_decidim_navigation_maps_map_view_js__WEBPACK_IMPORTED_MODULE_0__["default"](this);
    maps[id].onSetLayerProperties(function (layer, props) {
      if (!props.popup) {
        var node = document.createElement("div");
        var html = tmpl.render(props);
        $(node).html(html);
        layer.bindPopup(node, {
          maxHeight: 400,
          // autoPan: false,
          maxWidth: 640,
          minWidth: 200,
          keepInView: true,
          className: "navigation_map-info map-info-".concat(id, "-").concat(layer._leaflet_id)
        });
      }
    });
    maps[id].onClickArea(function (area) {
      var popup = area.feature.properties && area.feature.properties.link && area.feature.properties.popup;

      if (popup) {
        location = area.feature.properties.link;
      }
    });
  });
  $tabs.on("change.zf.tabs", function (e, $tab, $content) {
    var id = $content.find(".map").data("id");
    maps[id].reload();
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_navigation_maps.scss":
/*!***************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_navigation_maps.scss ***!
  \***************************************************************************************************************************************************/
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
/******/ 			"decidim_navigation_maps": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["vendors-node_modules_leaflet_dist_leaflet-src_js","vendors-node_modules_geoman-io_leaflet-geoman-free_dist_leaflet-geoman_min_js-node_modules_ge-a7faae","vendors-node_modules_jsviews_jsrender_js"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/gems/decidim-navigation_maps-1.3.4/app/packs/entrypoints/decidim_navigation_maps.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_navigation_maps.js.map