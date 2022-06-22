/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/images sync recursive ^\\.\\/.*$":
/*!**************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/images/ sync ^\.\/.*$ ***!
  \**************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

var map = {
	"./decidim/assemblies/decidim_assemblies.svg": "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/images/decidim/assemblies/decidim_assemblies.svg"
};


function webpackContext(req) {
	var id = webpackContextResolve(req);
	return __webpack_require__(id);
}
function webpackContextResolve(req) {
	if(!__webpack_require__.o(map, req)) {
		var e = new Error("Cannot find module '" + req + "'");
		e.code = 'MODULE_NOT_FOUND';
		throw e;
	}
	return map[req];
}
webpackContext.keys = function webpackContextKeys() {
	return Object.keys(map);
};
webpackContext.resolve = webpackContextResolve;
module.exports = webpackContext;
webpackContext.id = "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/images sync recursive ^\\.\\/.*$";

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/entrypoints/decidim_assemblies.js":
/*!**************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/entrypoints/decidim_assemblies.js ***!
  \**************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var src_decidim_assemblies_assemblies__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! src/decidim/assemblies/assemblies */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/assemblies.js");
/* harmony import */ var src_decidim_assemblies_assemblies__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(src_decidim_assemblies_assemblies__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var src_decidim_assemblies_orgchart__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/assemblies/orgchart */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/orgchart.js");

 // Images

__webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/images sync recursive ^\\.\\/.*$");

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/assemblies.js":
/*!*****************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/assemblies.js ***!
  \*****************************************************************************************************************************************************************/
/***/ (function() {

$(function () {
  $(".show-more").on("click", function () {
    /* eslint-disable no-invalid-this */
    $(this).hide();
    $(".show-more-panel").removeClass("hide");
    $(".hide-more").show();
  });
  $(".hide-more").on("click", function () {
    $(this).hide();
    $(".show-more-panel").addClass("hide");
    $(".show-more").show();
  });
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/orgchart.js":
/*!***************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/src/decidim/assemblies/orgchart.js ***!
  \***************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var d3__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! d3 */ "./node_modules/d3/index.js");
/* harmony import */ var src_decidim_vizzs_renders__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/decidim/vizzs/renders */ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vizzs/renders.js");
/* eslint-disable require-jsdoc, max-lines, no-return-assign, func-style, id-length, no-plusplus, no-use-before-define, no-negated-condition, init-declarations, no-invalid-this, no-param-reassign, no-ternary, multiline-ternary, no-nested-ternary, no-eval, no-extend-native, prefer-reflect */

/* eslint dot-location: ["error", "property"], no-negated-condition: "error" */

/* eslint no-unused-expressions: ["error", { "allowTernary": true }] */

/* eslint no-unused-vars: 0 */

/* global d3 */

 // lib

var renderOrgCharts = function renderOrgCharts() {
  var $orgChartContainer = $(".js-orgchart");
  var $btnReset = $(".js-reset-orgchart");
  var dataDepicted = null;
  var fake = false;
  var orgchart = {}; // lib - https://bl.ocks.org/bumbeishvili/b96ba47ea21d14dfce6ebb859b002d3a

  var renderChartCollapsibleNetwork = function renderChartCollapsibleNetwork(params) {
    // exposed variables
    var attrs = {
      id: "id".concat(Math.floor(Math.random() * 1000000)),
      svgWidth: 960,
      svgHeight: 600,
      marginTop: 0,
      marginBottom: 5,
      marginRight: 0,
      marginLeft: 30,
      container: "body",
      distance: 150,
      hiddenChildLevel: 1,
      hoverOpacity: 0.2,
      maxTextDisplayZoomLevel: 1,
      lineStrokeWidth: 1.5,
      fakeRoot: false,
      nodeGutter: {
        x: 16,
        y: 8
      },
      childrenIndicatorRadius: 15,
      fakeBorderWidth: 32,
      data: null
    };
    /* ############### IF EXISTS OVERWRITE ATTRIBUTES FROM PASSED PARAM  #######  */

    var attrKeys = Object.keys(attrs);
    attrKeys.forEach(function (key) {
      if (params && params[key]) {
        attrs[key] = params[key];
      }
    }); // innerFunctions which will update visuals

    var updateData;

    var _collapse, _expand;

    var filter;
    var hierarchy = {}; // main chart object

    var main = function main(selection) {
      selection.each(function scope() {
        // calculated properties
        var calc = {};
        calc.chartLeftMargin = attrs.marginLeft;
        calc.chartTopMargin = attrs.marginTop;
        calc.chartWidth = attrs.svgWidth - attrs.marginRight - calc.chartLeftMargin;
        calc.chartHeight = attrs.svgHeight - attrs.marginBottom - calc.chartTopMargin; // ########################## HIERARCHY STUFF  #########################

        hierarchy.root = d3__WEBPACK_IMPORTED_MODULE_0__.hierarchy(attrs.data.root); // ###########################   BEHAVIORS #########################

        var behaviors = {}; // behaviors.zoom = d3.zoom().scaleExtent([0.75, 100, 8]).on("zoom", zoomed)

        behaviors.drag = d3__WEBPACK_IMPORTED_MODULE_0__.drag().on("start", dragstarted).on("drag", dragged).on("end", dragended); // ###########################   LAYOUTS #########################

        var layouts = {}; // custom radial layout

        layouts.radial = radial(); // ###########################   FORCE STUFF #########################

        var force = {};
        force.link = d3__WEBPACK_IMPORTED_MODULE_0__.forceLink().id(function (d) {
          return d.id;
        });
        force.charge = d3__WEBPACK_IMPORTED_MODULE_0__.forceManyBody().strength(-240);
        force.center = d3__WEBPACK_IMPORTED_MODULE_0__.forceCenter(calc.chartWidth / 2, calc.chartHeight / 2); // prevent collide

        force.collide = d3__WEBPACK_IMPORTED_MODULE_0__.forceCollide().radius(function (d) {
          // Creates an invented radius based on element measures: diagonal = 2 * radius = sqrt(width^2, height^2)
          var base = (d.bbox || {}).width + attrs.nodeGutter.x * 2;
          var height = (d.bbox || {}).height + attrs.nodeGutter.y * 2;
          var diagonal = Math.sqrt(Math.pow(base, 2) + Math.pow(height, 2));
          var fakeRadius = diagonal / 2; // return d3.max([attrs.nodeDistance * 3, fakeRadius])

          return fakeRadius * 1.5;
        }); // manually set x positions (which is calculated using custom radial layout)

        force.x = d3__WEBPACK_IMPORTED_MODULE_0__.forceX().strength(0.5).x(function (d) {
          // if node does not have children and is channel (depth=2) , then position it on parent's coordinate
          if (!d.children && d.depth > 2) {
            if (d.parent) {
              d = d.parent;
            }
          } // custom circle projection -  radius will be -  (d.depth - 1) * 150


          return projectCircle(d.proportion, (d.depth - 1) * attrs.distance)[0];
        }); // manually set y positions (which is calculated using d3.cluster)

        force.y = d3__WEBPACK_IMPORTED_MODULE_0__.forceY().strength(0.5).y(function (d) {
          // if node does not have children and is channel (depth=2) , then position it on parent's coordinate
          if (!d.children && d.depth > 2) {
            if (d.parent) {
              d = d.parent;
            }
          } // custom circle projection -  radius will be -  (d.depth - 1) * 150


          return projectCircle(d.proportion, (d.depth - 1) * attrs.distance)[1];
        }); // ---------------------------------  INITIALISE FORCE SIMULATION ----------------------------
        // get based on top parameter simulation

        force.simulation = d3__WEBPACK_IMPORTED_MODULE_0__.forceSimulation().force("link", force.link).force("charge", force.charge).force("center", force.center).force("collide", force.collide).force("x", force.x).force("y", force.y); // ###########################   HIERARCHY STUFF #########################
        // flatten root

        var arr = flatten(hierarchy.root); // hide members based on their depth

        arr.forEach(function (d) {
          // Hide fake root node
          if (attrs.fakeRoot && d.depth === 1) {
            d.hidden = true;
          }

          if (d.depth > attrs.hiddenChildLevel) {
            d._children = d.children;
            d.children = null;
          }
        }); // ####################################  DRAWINGS #######################
        // drawing containers

        var container = d3__WEBPACK_IMPORTED_MODULE_0__.select(this); // add svg

        var svg = container.patternify({
          tag: "svg",
          selector: "svg-chart-container"
        }).attr("width", attrs.svgWidth).attr("height", attrs.svgHeight); // .call(behaviors.zoom)
        // add container g element

        var chart = svg.patternify({
          tag: "g",
          selector: "chart"
        }).attr("transform", "translate(".concat(calc.chartLeftMargin, ",").concat(calc.chartTopMargin, ")")); // ################################   Chart Content Drawing ##################################
        // link wrapper

        var linksWrapper = chart.patternify({
          tag: "g",
          selector: "links-wrapper"
        }); // node wrapper

        var nodesWrapper = chart.patternify({
          tag: "g",
          selector: "nodes-wrapper"
        });
        var links, nodes; // reusable function which updates visual based on data change

        update(); // update visual based on data change

        function update(clickedNode) {
          // Show/hide reset button
          clickedNode ? $btnReset.removeClass("invisible") : $btnReset.addClass("invisible"); // set xy and proportion properties with custom radial layout

          layouts.radial(hierarchy.root); // nodes and links array

          var nodesArr = flatten(hierarchy.root, true).orderBy(function (d) {
            return d.depth;
          }).filter(function (d) {
            return !d.hidden;
          });
          var linksArr = hierarchy.root.links().filter(function (d) {
            return !d.source.hidden;
          }).filter(function (d) {
            return !d.target.hidden;
          }); // make new nodes to appear near the parents

          nodesArr.forEach(function (d) {
            if (clickedNode && clickedNode.id === (d.parent && d.parent.id)) {
              d.x = d.parent.x;
              d.y = d.parent.y;
            }
          }); // links

          links = linksWrapper.selectAll(".link").data(linksArr, function (d) {
            return d.target.id;
          });
          links.exit().remove();
          links = links.enter().append("line").attr("class", "link").merge(links); // node groups

          nodes = nodesWrapper.selectAll(".node").data(nodesArr, function (d) {
            return d.id;
          });
          nodes.exit().remove();
          var enteredNodes = nodes.enter().append("g").attr("class", "node"); // bind event handlers

          enteredNodes.on("click", nodeClick).on("mouseenter", nodeMouseEnter).on("mouseleave", nodeMouseLeave).call(behaviors.drag); // channels grandchildren

          enteredNodes.append("rect").attr("class", "as-card").attr("rx", 4).attr("ry", 4);
          enteredNodes.append("text").attr("class", "as-text").text(function (d) {
            return d.data.name;
          });
          enteredNodes.selectAll("text").each(function (d) {
            d.bbox = this.getBBox();
          });
          enteredNodes.selectAll("rect").attr("x", function (d) {
            return d.bbox.x - attrs.nodeGutter.x;
          }).attr("y", function (d) {
            return d.bbox.y - attrs.nodeGutter.y;
          }).attr("width", function (d) {
            return d.bbox.width + 2 * attrs.nodeGutter.x;
          }).attr("height", function (d) {
            return d.bbox.height + 2 * attrs.nodeGutter.y;
          }); // append circle & text only when there are children

          enteredNodes.append("circle").filter(function (d) {
            return Boolean(d.children) || Boolean(d._children);
          }).attr("class", "as-circle").attr("r", attrs.childrenIndicatorRadius).attr("cx", function (d) {
            return d.bbox.x + d.bbox.width + attrs.nodeGutter.x;
          }).attr("cy", function (d) {
            return d.bbox.y + d.bbox.height + attrs.nodeGutter.y;
          });
          enteredNodes.append("text").filter(function (d) {
            return Boolean(d.children) || Boolean(d._children);
          }).attr("class", "as-text").attr("dx", function (d) {
            return d.bbox.x + d.bbox.width + attrs.nodeGutter.x;
          }).attr("dy", attrs.childrenIndicatorRadius + 3).text(function (d) {
            return d3__WEBPACK_IMPORTED_MODULE_0__.max([(d.children || {}).length, (d._children || {}).length]);
          }); // merge  node groups and style it

          nodes = enteredNodes.merge(nodes); // force simulation

          force.simulation.nodes(nodesArr).on("tick", ticked); // links simulation

          force.simulation.force("link").links(links).id(function (d) {
            return d.id;
          }).distance(attrs.distance * 2).strength(2);
        } // ####################################### EVENT HANDLERS  ########################
        // zoom handler
        // function zoomed() {
        //   // get transform event
        //   let transform = d3.event.transform
        //   attrs.lastTransform = transform
        //
        //   // apply transform event props to the wrapper
        //   chart.attr("transform", transform)
        //
        //   svg.selectAll(".node").attr("transform", (d) => `translate(${d.x},${d.y}) scale(${1 / (attrs.lastTransform ? attrs.lastTransform.k : 1)})`)
        //   svg.selectAll(".link").attr("stroke-width", attrs.lineStrokeWidth / (attrs.lastTransform ? attrs.lastTransform.k : 1))
        // }
        // tick handler


        function ticked() {
          var fakeBorderWidth = attrs.fakeBorderWidth;

          var maxXValueAvailable = function maxXValueAvailable(value) {
            return Math.max(Math.min(calc.chartWidth - fakeBorderWidth, value), fakeBorderWidth);
          };

          var maxYValueAvailable = function maxYValueAvailable(value) {
            return Math.max(Math.min(calc.chartHeight - fakeBorderWidth, value), fakeBorderWidth);
          }; // set links position


          links.attr("x1", function (d) {
            return maxXValueAvailable(d.source.x);
          }).attr("y1", function (d) {
            return maxYValueAvailable(d.source.y);
          }).attr("x2", function (d) {
            return maxXValueAvailable(d.target.x);
          }).attr("y2", function (d) {
            return maxYValueAvailable(d.target.y);
          }); // set nodes position

          svg.selectAll(".node").attr("transform", function (d) {
            return "translate(".concat(maxXValueAvailable(d.x), ",").concat(maxYValueAvailable(d.y), ")");
          });
        } // handler drag start event


        function dragstarted() {
          // disable node fixing
          nodes.each(function (d) {
            d.fx = null;
            d.fy = null;
          });
        } // handle dragging event


        function dragged(d) {
          // make dragged node fixed
          d.fx = d3__WEBPACK_IMPORTED_MODULE_0__.event.x;
          d.fy = d3__WEBPACK_IMPORTED_MODULE_0__.event.y;
        } // -------------------- handle drag end event ---------------


        function dragended() {// we are doing nothing, here , aren't we?
        } // -------------------------- node mouse hover handler ---------------


        function nodeMouseEnter(d) {
          // get links
          var _links = hierarchy.root.links(); // get hovered node connected links


          var connectedLinks = _links.filter(function (l) {
            return l.source.id === d.id || l.target.id === d.id;
          }); // get hovered node linked nodes


          var linkedNodes = connectedLinks.map(function (s) {
            return s.source.id;
          }).concat(connectedLinks.map(function (c) {
            return c.target.id;
          })); // reduce all other nodes opacity

          nodesWrapper.selectAll(".node").filter(function (n) {
            return linkedNodes.indexOf(n.id) === -1;
          }).attr("opacity", attrs.hoverOpacity); // reduce all other links opacity

          linksWrapper.selectAll(".link").attr("opacity", attrs.hoverOpacity); // highlight hovered nodes connections

          linksWrapper.selectAll(".link").filter(function (l) {
            return l.source.id === d.id || l.target.id === d.id;
          }).attr("opacity", 1);
        } // --------------- handle mouseleave event ---------------


        function nodeMouseLeave() {
          // return things back to normal
          nodesWrapper.selectAll(".node").attr("opacity", 1);
          linksWrapper.selectAll(".link").attr("opacity", 1);
        } // --------------- handle node click event ---------------


        function nodeClick(d) {
          // free fixed nodes
          nodes.each(function (di) {
            di.fx = null;
            di.fy = null;
          }); // collapse or expand node

          if (d.children) {
            _collapse(d);
          } else if (d._children) {
            _expand(d);
          } else {// nothing is to collapse or expand
          }

          freeNodes();
        } // #########################################  UTIL FUNCS ##################################


        updateData = function updateData() {
          main.run();
        };

        _collapse = function collapse(d) {
          var deep = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : false;

          if (d.children) {
            if (deep) {
              d.children.forEach(function (e) {
                return _collapse(e, true);
              });
            }

            d._children = d.children;
            d.children = null;
          }

          update(d);
          force.simulation.restart();
          force.simulation.alphaTarget(0.15);
        };

        _expand = function expand(d) {
          var deep = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : false;

          if (d._children) {
            if (deep) {
              d._children.forEach(function (e) {
                return _expand(e, true);
              });
            }

            d.children = d._children;
            d._children = null;
          }

          update(d);
          force.simulation.restart();
          force.simulation.alphaTarget(0.15);
        }; // function slowDownNodes() {
        //   force.simulation.alphaTarget(0.05)
        // }
        // function speedUpNodes() {
        //   force.simulation.alphaTarget(0.45)
        // }


        function freeNodes() {
          d3__WEBPACK_IMPORTED_MODULE_0__.selectAll(".node").each(function (n) {
            n.fx = null;
            n.fy = null;
          });
        }

        function projectCircle(value, radius) {
          var r = radius || 0;
          var corner = value * 2 * Math.PI;
          return [Math.sin(corner) * r, -Math.cos(corner) * r];
        } // recursively loop on children and extract nodes as an array


        function flatten(root, clustered) {
          var nodesArray = [];
          var i = 0;

          function recurse(node, depth) {
            if (node.children) {
              node.children.forEach(function (child) {
                recurse(child, depth + 1);
              });
            }

            if (!node.id) {
              node.id = ++i;
            } else {
              ++i;
            }

            node.depth = depth;

            if (clustered) {
              if (!node.cluster) {
                // if cluster coordinates are not set, set it
                node.cluster = {
                  x: node.x,
                  y: node.y
                };
              }
            }

            nodesArray.push(node);
          }

          recurse(root, 1);
          return nodesArray;
        }

        function debug() {
          if (attrs.isDebug) {
            // stringify func
            var stringified = String(scope); // parse variable names

            var groupVariables = stringified // match var x-xx= {}
            .match(/var\s+([\w])+\s*=\s*{\s*}/gi) // match xxx
            .map(function (d) {
              return d.match(/\s+\w*/gi).filter(function (s) {
                return s.trim();
              });
            }) // get xxx
            .map(function (v) {
              return v[0].trim();
            }); // assign local variables to the scope

            groupVariables.forEach(function (v) {
              main["P_".concat(v)] = eval(v);
            });
          }
        }

        debug();
      });
    }; // ----------- PROTOTYEPE FUNCTIONS  ----------------------


    d3__WEBPACK_IMPORTED_MODULE_0__.selection.prototype.patternify = function (_params) {
      var selector = _params.selector;
      var elementTag = _params.tag;

      var _data = _params.data || [selector]; // pattern in action


      var selection = this.selectAll(".".concat(selector)).data(_data);
      selection.exit().remove();
      selection = selection.enter().append(elementTag).merge(selection);
      selection.attr("class", selector);
      return selection;
    }; // custom radial layout


    function radial() {
      return function (root) {
        recurse(root, 0, 1);

        function recurse(node, min, max) {
          node.proportion = (max + min) / 2;

          if (!node.x) {
            // if node has parent, match entered node positions to it's parent
            if (node.parent) {
              node.x = node.parent.x;
            } else {
              node.x = 0;
            }
          } // if node had parent, match entered node positions to it's parent


          if (!node.y) {
            if (node.parent) {
              node.y = node.parent.y;
            } else {
              node.y = 0;
            }
          } // recursively do the same for children


          if (node.children) {
            var offset = (max - min) / node.children.length;
            node.children.forEach(function (child, i) {
              var newMin = min + offset * i;
              var newMax = newMin + offset;
              recurse(child, newMin, newMax);
            });
          }
        }
      };
    } // https://github.com/bumbeishvili/d3js-boilerplates#orderby


    Array.prototype.orderBy = function (func) {
      this.sort(function (_a, _b) {
        var a = func(_a);
        var b = func(_b);

        if (typeof a === "string" || a instanceof String) {
          return a.localeCompare(b);
        }

        return a - b;
      });
      return this;
    }; // ##########################  BOILEPLATE STUFF ################
    // dinamic keys functions


    Object.keys(attrs).forEach(function (key) {
      // Attach variables to main function
      return main[key] = function (_) {
        var string = "attrs['".concat(key, "'] = _");

        if (!arguments.length) {
          return eval(" attrs['".concat(key, "'];"));
        }

        eval(string);
        return main;
      };
    }); // set attrs as property

    main.attrs = attrs; // debugging visuals

    main.debug = function (isDebug) {
      attrs.isDebug = isDebug;

      if (isDebug) {
        if (!window.charts) {
          window.charts = [];
        }

        window.charts.push(main);
      }

      return main;
    }; // exposed update functions


    main.data = function (value) {
      if (!arguments.length) {
        return attrs.data;
      }

      attrs.data = value;

      if (typeof updateData === "function") {
        updateData();
      }

      return main;
    }; // run  visual


    main.run = function () {
      d3__WEBPACK_IMPORTED_MODULE_0__.selectAll(attrs.container).call(main);
      return main;
    };

    main.filter = function (filterParams) {
      if (!arguments.length) {
        return attrs.filterParams;
      }

      attrs.filterParams = filterParams;

      if (typeof filter === "function") {
        filter();
      }

      return main;
    };

    main.reset = function () {
      hierarchy.root.children.forEach(function (e) {
        return _collapse(e, true);
      });
      main.run();
      return main;
    };

    return main;
  }; // initialization


  $orgChartContainer.each(function (i, container) {
    var $container = $(container);
    var width = $container.width();
    var height = width / (16 / 9);
    d3__WEBPACK_IMPORTED_MODULE_0__.json($container.data("url")).then(function (data) {
      // Make a fake previous node if the data entry is not hierarchical
      if (data instanceof Array) {
        fake = true;
        dataDepicted = {
          name: null,
          children: data
        };
      } else {
        dataDepicted = data;
      }

      orgchart = renderChartCollapsibleNetwork().svgHeight(height).svgWidth(width).fakeRoot(fake).container("#".concat(container.id)).data({
        root: dataDepicted
      }).debug(true).run();
    });
  }); // reset

  $btnReset.click(function () {
    orgchart.reset();
  });
};

$(function () {
  (0,src_decidim_vizzs_renders__WEBPACK_IMPORTED_MODULE_1__["default"])(renderOrgCharts);
});

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vizzs/renders.js":
/*!***************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-core/app/packs/src/decidim/vizzs/renders.js ***!
  \***************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": function() { return /* binding */ renderChart; }
/* harmony export */ });
/* eslint-disable require-jsdoc */
// renderChart receives a chart function as argument and renders it
// Also captures change.zf.tabs event and re-renders the chart
function renderChart(chart) {
  chart();
  $(document).on("change.zf.tabs", function () {
    chart();
  });
}

/***/ }),

/***/ "../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/images/decidim/assemblies/decidim_assemblies.svg":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/images/decidim/assemblies/decidim_assemblies.svg ***!
  \*****************************************************************************************************************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
module.exports = __webpack_require__.p + "media/images/decidim_assemblies-d9571d0b2d158eb891c8.svg";

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
/******/ 	/* webpack/runtime/publicPath */
/******/ 	!function() {
/******/ 		__webpack_require__.p = "/packs-test/";
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
/******/ 			"decidim_assemblies": 0
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
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, ["vendors-node_modules_d3_index_js"], function() { return __webpack_require__("../../../../.rbenv/versions/2.7.5/lib/ruby/gems/2.7.0/bundler/gems/decidim-f920e99dc728/decidim-assemblies/app/packs/entrypoints/decidim_assemblies.js"); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=decidim_assemblies.js.map