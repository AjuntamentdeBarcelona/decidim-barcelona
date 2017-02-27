
var width = 1500;
var height = 600;
var radius = Math.min(width, height) / 2;

// Breadcrumb dimensions: width, height, spacing, width of tip/tail.
var b = {
  w: 300, h: 30, s: 3, t: 10
};

// Mapping of step names to colors.
var colors = {
  "Bon viure": "#660000",
  "Economia plural": "#000099",
  "Bon govern": "#2E0854",
  "Transició ecològica": "#004c00",
  "Justícia global": "#b27300",

  "Autonomia personal i reconeixement de les cures": "#d69999",
  "Educació i coneixement": "#d69999",
  "Equitat de gènere i diversitat sexual": "#d69999",
  "Cicles de vida": "#d69999",
  "Habitatge": "#d69999",
  "Sanitat i salut": "#d69999",
  "Migració interculturalitat i discriminació zero": "#d69999",
  "Esports": "#d69999",
  "Desenvolupament i economia de proximitat": "#7f7fff",
  "Economia cooperativa social i solidària": "#7f7fff",
  "Ocupació de qualitat": "#7f7fff",
  "Turisme sostenible": "#7f7fff",
  "Medi ambient i espai públic": "#7fbf7f",
  "Urbanisme per als barris": "#7fbf7f",
  "Mobilitat sostenible": "#7fbf7f",
  "Energia i canvi climàtic": "#7fbf7f",
  "Participació ciutadana": "#d8b2d8",
  "Acció comunitària": "#d8b2d8",
  "Administració intel·ligent i inclusiva": "#d8b2d8",
  "Defensa i protecció dels Drets Humans": "#d69999",
  "Justícia social": "#d69999",
  "Cultura": "#d69999",
  "Convivència i seguretat": "#d69999",
  "Un nou lideratge públic": "#7f7fff",
  "Verd urbà i biodiversitat": "#7fbf7f",
  "Govern transparent i rendició de comptes": "#d8b2d8",
  "Eficiència i professionalitat": "#d8b2d8",
  "Ciutat d’acollida": "#ffd27f",
};

// Mapping of colors for the legend
var colors_legend = {
  "Bon viure": "#660000",
  "Economia plural": "#000099",
  "Bon govern": "#2E0854",
  "Transició ecològica": "#004c00",
  "Justícia global": "#b27300",
};


// Total size of all segments; we set this later, after loading the data.
var totalSize = 0; 

var vis = d3.select("#chart-container").append("svg:svg")
    //responsive SVG needs these 2 attributes and no width and height attr
    .attr("preserveAspectRatio", "xMinYMin meet")
    .attr("viewBox", "0 -50 1000 700")
    //class to make it responsive
    .classed("svg-content-responsive", true)
    .attr("width", 1500)
    .append("svg:g")
    .attr("id", "container")
    .attr("transform", "translate(" + width / 4 + "," + ((height / 2) + 30) + ")");

var partition = d3.layout.partition()
    .size([2 * Math.PI, radius * radius])
    .value(function(d) { return d.size; });

var arc = d3.svg.arc()
    .startAngle(function(d) { return d.x; })
    .endAngle(function(d) { return d.x + d.dx; })
    .innerRadius(function(d) { return Math.sqrt(d.y); })
    .outerRadius(function(d) { return Math.sqrt(d.y + d.dy); });


// Use d3.text and d3.csv.parseRows so that we do not need to have a header
// row, and can receive the csv as an array of arrays.
d3.text(d3.select("#sequences").attr("data")+".csv", function(text) {
  var csv = d3.csv.parseRows(text);
  var json = buildHierarchy(csv);
  createVisualization(json);
});

// Main function to draw and set up the visualization, once we have the data.
function createVisualization(json) {

  // Basic setup of page elements.
  initializeBreadcrumbTrail();
  drawLegend();
  d3.select("#togglelegend").on("click", toggleLegend);

  // Bounding circle underneath the sunburst, to make it easier to detect
  // when the mouse leaves the parent g.
  vis.append("svg:circle")
      .attr("r", radius)
      .style("opacity", 0);

  // For efficiency, filter nodes to keep only those large enough to see.
  var nodes = partition.nodes(json)
      .filter(function(d) {
      return (d.dx > 0.005); // 0.005 radians = 0.29 degrees
      });

  var path = vis.data([json]).selectAll("path")
      .data(nodes)
      .enter().append("svg:path")
      .attr("display", function(d) { return d.depth ? null : "none"; })
      .attr("d", arc)
      .attr("fill", "#ddd")
      .attr("fill-rule", "evenodd")
      .style("fill", function(d) { return colors[d.name]; })
      .style("opacity", 1)
      .on("mouseover", mouseover);

  // Add the mouseleave handler to the bounding circle.
  d3.select("#container").on("mouseleave", mouseleave);

  // Get total size of the tree = value of root node from partition.
  totalSize = path.node().__data__.value;
 };

// Fade all but the current sequence, and show it in the breadcrumb trail.
function mouseover(d) {

  var percentage = (100 * d.value / totalSize).toPrecision(3);
  var percentageString = percentage + "%";
  if (percentage < 0.1) {
    percentageString = "< 0.1%";
  }

  d3.select("#text2")
      //.text(percentage);
      .text(d.value);

  d3.select("#text2")
      .style("visibility", "")
      .style("  text-align", "center");

  d3.select("#text3")
      .style("visibility", "")
      .style("  text-align", "center");

  var sequenceArray = getAncestors(d);
  updateBreadcrumbs(sequenceArray, percentageString);

  // Fade all the segments.
  d3.selectAll("path")
      .style("opacity", 0.3);

  // Then highlight only those that are an ancestor of the current segment.
  vis.selectAll("path")
      .filter(function(node) {
                return (sequenceArray.indexOf(node) >= 0);
              })
      .style("opacity", 1);
}

// Restore everything to full opacity when moving off the visualization.
function mouseleave(d) {

  // Hide the breadcrumb trail
  d3.select("#trail").style("visibility", "hidden");

  // Deactivate all segments during transition.
  d3.selectAll("path").on("mouseover", null);

  // Transition each segment to full opacity and then reactivate it.
  d3.selectAll("path")
      .transition()
      .duration(1000)
      .style("opacity", 1)
      .each("end", function() {
              d3.select(this).on("mouseover", mouseover);
            });

  //d3.select("#explanation").style("visibility", "hidden");
    d3.select("#text2").text(d3.select("#total").attr("default"));
}

// Given a node in a partition layout, return an array of all of its ancestor
// nodes, highest first, but excluding the root.
function getAncestors(node) {
  var path = [];
  var current = node;
  while (current.parent) {
    path.unshift(current);
    current = current.parent;
  }
  return path;
}

function initializeBreadcrumbTrail() {
  // Add the svg area.
  var trail = vis.append("svg:g")
      .attr("id", "trail")
	  .attr("transform", function(d, i) {
              return "translate(-360,-370)";
           });
  // Add the label at the end, for the percentage.
  trail.append("svg:text")
    .attr("id", "endlabel")
    .style("fill", "#000");
}

// Generate a string that describes the points of a breadcrumb polygon.
function breadcrumbPoints(d, i) {
  var points = [];
  points.push("0,0");
  points.push(b.w + ",0");
  points.push(b.w + b.t + "," + (b.h / 2));
  points.push(b.w + "," + b.h);
  points.push("0," + b.h);
  if (i > 0) { // Leftmost breadcrumb; don't include 6th vertex.
    points.push(b.t + "," + (b.h / 2));
  }
  return points.join(" ");
}

// Update the breadcrumb trail to show the current sequence and percentage.
function updateBreadcrumbs(nodeArray, percentageString) {

  // Data join; key function combines name and depth (= position in sequence).
  var g = d3.select("#trail")
      .selectAll("g")
      .data(nodeArray, function(d) { return d.name + d.depth; });

  // Add breadcrumb and label for entering nodes.
  var entering = g.enter().append("svg:g");

  entering.append("svg:polygon")
      .attr("points", breadcrumbPoints)
      .style("fill", function(d) { return colors[d.name]; });

  entering.append("svg:text")
      .attr("x", (b.w + b.t) / 2)
      .attr("y", b.h / 2)
      .attr("dy", "0.35em")
      .attr("text-anchor", "middle")
      .text(function(d) { return d.name; });

  // Set position for entering and updating nodes.
  g.attr("transform", function(d, i) {
    return "translate(" + i * (b.w + b.s) + ", 0)";
  });

  // Remove exiting nodes.
  g.exit().remove();

  // Now move and update the percentage at the end.
  d3.select("#trail").select("#endlabel")
      .attr("x", 30 + (nodeArray.length) * (b.w + b.s))
      .attr("y", b.h / 2)
      .attr("dy", "0.35em")
      .attr("text-anchor", "start")
      .text(percentageString);

  // Make the breadcrumb trail visible, if it's hidden.
  d3.select("#trail")
      .style("visibility", "");

}

function drawLegend() {

  // Dimensions of legend item: width, height, spacing, radius of rounded rect.
  var li = {
    w: 150, h: 30, s: 3, r: 3
  };


  var g1 = vis.append("svg:g")
      .attr("transform", function(d, i) {
              return "translate(0,0)";
           });
  g1
      .append("rect")
	  .attr("x", -60)
	  .attr("y", -30)
	  .attr("rx", 5)
	  .attr("ry", 5)
	  .attr("width", 120)
	  .attr("height", 80)
	  .attr("class", "explanation-box");
  g1
      .append("svg:text").attr("id", "text2")
      .classed("text-explanation", true)
      .attr("x", -40)
      .attr("y", 0)
      .attr("width", 60)
      .attr("height", 30)
      .attr("dy", "0.35em");
  g1
      .append("svg:text").attr("id", "text3")
      .classed("text-explanation", true)
      .attr("x", -40)
      .attr("y", 30)
      .attr("width", 60)
      .attr("height", 30)
      .attr("dy", "0.35em");
	  
			
  var legend = vis.append("svg:g")
      .attr("id", "legend")
      .attr("width", li.w)
      .attr("height", d3.keys(colors_legend).length * (li.h + li.s));
  var g = legend.selectAll("g")
      .data(d3.entries(colors_legend))
      .enter().append("svg:g")
      .attr("transform", function(d, i) {
              return "translate(320," + (i * (li.h + li.s) -310) + ")";
           });

  g.append("svg:rect")
      .attr("rx", li.r)
      .attr("ry", li.r)
      .attr("width", li.w)
      .attr("height", li.h)
      .style("fill", function(d) { return d.value; });

  g.append("svg:text")
      .classed("text-legend", true)
      .attr("x", li.w / 2)
      .attr("y", li.h / 2)
      .attr("dy", "0.35em")
      .attr("text-anchor", "middle")
      .text(function(d) { return d.key; });
	  

  // Dimensions of sunburst.
  d3.select("#text2").text(d3.select("#total").attr("default"));
  d3.select("#text3").text(d3.select("#total").attr("desc"));
}

function toggleLegend() {
  var legend = d3.select("#legend");
  if (legend.style("visibility") == "hidden") {
    legend.style("visibility", "");
  } else {
    legend.style("visibility", "hidden");
  }
}

// Take a 2-column CSV and transform it into a hierarchical structure suitable
// for a partition layout. The first column is a sequence of step names, from
// root to leaf, separated by hyphens. The second column is a count of how 
// often that sequence occurred.
function buildHierarchy(csv) {
  var root = {"name": "root", "children": []};
  for (var i = 0; i < csv.length; i++) {
    var sequence = csv[i][0];
    var size = +csv[i][1];
    if (isNaN(size)) { // e.g. if this is a header row
      continue;
    }
    var parts = sequence.split("---");
    var currentNode = root;
    for (var j = 0; j < parts.length; j++) {
      var children = currentNode["children"];
      var nodeName = parts[j];
      var childNode;
      if (j + 1 < parts.length) {
   // Not yet at the end of the sequence; move down the tree.
 	var foundChild = false;
 	for (var k = 0; k < children.length; k++) {
 	  if (children[k]["name"] == nodeName) {
 	    childNode = children[k];
 	    foundChild = true;
 	    break;
 	  }
 	}
  // If we don't already have a child node for this branch, create it.
 	if (!foundChild) {
 	  childNode = {"name": nodeName, "children": []};
 	  children.push(childNode);
 	}
 	currentNode = childNode;
      } else {
 	// Reached the end of the sequence; create a leaf node.
 	childNode = {"name": nodeName, "size": size};
 	children.push(childNode);
      }
    }
  }
  return root;
};
