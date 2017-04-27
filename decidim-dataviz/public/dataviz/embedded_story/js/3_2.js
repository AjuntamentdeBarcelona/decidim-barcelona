// Breadcrumb dimensions: width, height, spacing, width of tip/tail.
var b = {
  w: 150, h: 30, s: 3, t: 10
};

var ww = $('#sburst.wauto').width();
if ($(window).width()<limit) ww = $(window).width()-80;
var hh = windowHeight-180;

$('#explanation').css('top', hh/2-40)
$('#explanation').css('left', ww/2+10)
$('#explanation2').css('top', hh/2-30)
$('#explanation2').css('left', ww/2+10)


var width_3_2 = ww,
    height_3_2 = hh,
    radius = Math.min(width_3_2, height_3_2) / 2,
    modeBarri = "barri",
    modeCiutat = "ciutat",
    modeProposals, modeVotes, modeComments,
    mode_3_2 = modeCiutat,
    size_3_2 = null,
    vis, 
    partition, 
    arc,
    initDepth4, initDepth3, initDepth2;

// Breadcrumb dimensions: width, height, spacing, width of tip/tail.
var b = {
  w: 150, h: 30, s: 3, t: 10
};

// Mapping of step names to colors.
var colors = {
  "Bon viure": "#000000",
  "Economia plural": "#000000",
  "Bon govern": "#000000",
  "Transició ecològica": "#000000",
  "Justícia global": "#000000",

  "Autonomia personal i reconeixement de les cures": "#000000",
  "Educació i coneixement": "#000000",
  "Equitat de gènere i diversitat sexual": "#000000",
  "Cicles de vida": "#000000",
  "Habitatge": "#000000",
  "Sanitat i salut": "#000000",
  "Migració, interculturalitat i discriminació zero": "#000000",
  "Esports": "#000000",
  "Desenvolupament i economia de proximitat": "#000000",
  "Economia cooperativa, social i solidària": "#000000",
  "Ocupació de qualitat": "#000000",
  "Turisme sostenible": "#000000",
  "Medi ambient i espai públic": "#000000",
  "Urbanisme per als barris": "#000000",
  "Mobilitat sostenible": "#000000",
  "Energia i canvi climàtic": "#000000",
  "Participació ciutadana": "#000000",
  "Acció comunitària": "#000000",
  "Administració intel·ligent i inclusiva": "#000000",
  "Defensa i protecció dels Drets Humans": "#000000",
  "Justícia social": "#000000",
  "Cultura": "#000000",
  "Convivència i seguretat": "#000000",
  "Un nou lideratge públic": "#000000",
  "Verd urbà i biodiversitat": "#000000",
  "Govern transparent i rendició de comptes": "#000000",
  "Eficiència i professionalitat": "#000000",
  "Ciutat d’acollida": "#000000",
};

// Mapping of colors for the legend
var colors_legend = {
  "Bon viure": "#000000",
  "Economia plural": "#000000",
  "Bon govern": "#000000",
  "Transició ecològica": "#000000",
  "Justícia global": "#000000",
};

// Total size of all segments; we set this later, after loading the data.
var totalSize = 0; 

function init_3_2() {
  modeProposals = $("#buttonProposals").text();
  modeVotes = $("#buttonVotes").text();
  modeComments = $("#buttonComments").text();

  if (!size_3_2) size_3_2 = modeProposals;

  //selected element, tienen que coincidir con términos utilizados en csv
  //initDepth4 = i18next.t("r_3_4_8");  //ciudadano
  //initDepth3 = i18next.t("r_1_2_1_7");  //sanidad y salud
  //initDepth2 = i18next.t("r_1_2_1");  //vivir bien
  //initDepth1 = i18next.t("r_3_2_2_2");  //vivir bien

  initDepth4 = i18next.t("r_3_2_3_1");  //ciudadano
  initDepth3 = i18next.t("r_3_2_3_2");  //sanidad y salud
  initDepth2 = i18next.t("r_3_2_3_3");  //vivir bien
  initDepth1 = i18next.t("r_3_2_3_4");  //vivir bien

  // Dimensions of sunburst.
    
  d3.select("#total").text(d3.select("#total").attr("default-"+size_3_2));
  d3.select("#total1").text("[100%]");
  d3.select("#total2").text(size_3_2);

  vis = d3.select("#chart").append("svg:svg")
      .attr("width", width_3_2)
      .attr("height", height_3_2)
      .append("svg:g")
      .attr("id", "container")
      .attr("transform", "translate(" + width_3_2 / 2 + "," + height_3_2 / 2 + ")");

  partition = d3.layout.partition()
      .size([2 * Math.PI, radius * radius])
      .value(function(d) { 
        if (size_3_2 === modeVotes) return d.sizeVotes; 
        else if (size_3_2 === modeComments) return d.sizeComments; 
        return d.sizeProposals; 
      });

  arc = d3.svg.arc()
      .startAngle(function(d) { return d.x; })
      .endAngle(function(d) { return d.x + d.dx; })
      .innerRadius(function(d) { return Math.sqrt(d.y); })
      .outerRadius(function(d) { return Math.sqrt(d.y + d.dy); });


  // Use d3.text and d3.csv.parseRows so that we do not need to have a header
  // row, and can receive the csv as an array of arrays.
  d3.text("data/3_2_"+mode_3_2+"_"+lng+".csv", function(text) {
    var csv = d3.csv.parseRows(text);
    var json = buildHierarchy(csv);
    createVisualization(json);

    //preseleccionar elementos
    //var activeEle = d3.selectAll("path.sb").filter(".active");
    var nodes = partition.nodes(json);
    for (id in nodes) {
      var d = nodes[id];
      if (d.name.toUpperCase() === initDepth4.toUpperCase() && 
            d.parent !== undefined && d.parent.name.toUpperCase() === initDepth3.toUpperCase() && 
            d.parent.parent !== undefined && d.parent.parent.name.toUpperCase() === initDepth2.toUpperCase() &&
            d.parent.parent.parent !== undefined && d.parent.parent.parent.name.toUpperCase() === initDepth1.toUpperCase()) {
        mouseover(d);
          
      }
    }

  });
}

// Main function to draw and set up the visualization, once we have the data.
function createVisualization(json) {

  // Basic setup of page elements.
  //initializeBreadcrumbTrail();
  //drawLegend();
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
      .attr("class", function(d) {
        /*if (d.name.toUpperCase() === initDepth4.toUpperCase() && 
            d.parent !== undefined && d.parent.name.toUpperCase() === initDepth3.toUpperCase() && 
            d.parent.parent !== undefined && d.parent.parent.name.toUpperCase() === initDepth2.toUpperCase() &&
            d.parent.parent.parent !== undefined && d.parent.parent.parent.name.toUpperCase() === initDepth1.toUpperCase()) {
          return "sb active";          
        }*/
        return "sb";
      })
      .attr("fill", "#ddd")
      .attr("fill-rule", "evenodd")
      .style("fill", function(d) { return colors[d.name]; })
      .style("opacity", 1)
      .on("mouseover", mouseover);

  // Add the mouseleave handler to the bounding circle.
  d3.select("#container").on("mouseleave", mouseleave);

  // Get total size of the tree = value of root node from partition.
  totalSize = path.node().__data__.value;

  d3.selectAll("path.sb").style("fill", '#000000');
    
  d3.select("#explanation").style("visibility", "hidden");
  d3.select("#explanation2").style("visibility", "hidden"); 
    
 };


// Fade all but the current sequence, and show it in the breadcrumb trail.
function mouseover(d) {

  var percentage = (100 * d.value / totalSize).toPrecision(3);
  var percentageString = "[" + percentage + "%]";
  if (percentage < 0.1) {
    percentageString = "< 0.1%";
  }

  d3.select("#total").text(d.value);
  d3.select("#total1").text(percentageString);
  d3.select("#total2").text(size_3_2);


  d3.select("#explanation").style("visibility", "");
 d3.select("#explanation2").style("visibility", "");
    
  var sequenceArray = getAncestors(d);
  updateBreadcrumbs(sequenceArray, percentageString);

  // Fade all the segments.
  d3.selectAll("path.sb").style("opacity", 0.5);
 d3.selectAll("path.sb").style("fill", '#000000');

  // Then highlight only those that are an ancestor of the current segment.
  vis.selectAll("path.sb")
      .filter(function(node) {
                return (sequenceArray.indexOf(node) >= 0);
              })
     .style("fill", 'rgb(198,12,48)')
      .style("opacity", 1);
}

// Restore everything to full opacity when moving off the visualization.
function mouseleave(d) {

  console.log("leave",d);

  // Hide the breadcrumb trail
  d3.select("#trail").style("visibility", "hidden");

  // Deactivate all segments during transition.
  d3.selectAll("path.sb").on("mouseover", null);

  // Transition each segment to full opacity and then reactivate it.
  d3.selectAll("path.sb")
      .transition()
      .duration(1000)
      .style("opacity", 1)
      .style("fill", '#000000')
      .each("end", function() {
              d3.select(this).on("mouseover", mouseover);
            });

  d3.select("#explanation").style("visibility", "hidden");
  d3.select("#explanation2").style("visibility", "hidden"); 
  d3.select("#total").text(d3.select("#total").attr("default-"+size_3_2));
  d3.select("#total1").text("[100%]");
  d3.select("#total2").text(size_3_2);
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
  var trail = d3.select("#sequence").append("svg:svg")
      .attr("width", 500)
      .attr("height", 50)
      .attr("id", "trail");
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
    //console.log(nodeArray)
    $('#explanation2').empty();
    for (n in nodeArray){
        //console.log(nodeArray[n])
        $('#explanation2').append('<div>'+nodeArray[n].name+'</div>');
    } 
        
/*
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
*/
}

function drawLegend() {

  // Dimensions of legend item: width, height, spacing, radius of rounded rect.
  var li = {
    w: 150, h: 30, s: 3, r: 3
  };

  var legend = d3.select("#legend").append("svg:svg")
      .attr("width", li.w)
      .attr("height", d3.keys(colors_legend).length * (li.h + li.s));

  var g = legend.selectAll("g")
      .data(d3.entries(colors_legend))
      .enter().append("svg:g")
      .attr("transform", function(d, i) {
              return "translate(0," + i * (li.h + li.s) + ")";
           });

  g.append("svg:rect")
      .attr("rx", li.r)
      .attr("ry", li.r)
      .attr("width", li.w)
      .attr("height", li.h)
      .style("fill", function(d) { return d.value; });

  g.append("svg:text")
      .attr("x", li.w / 2)
      .attr("y", li.h / 2)
      .attr("dy", "0.35em")
      .attr("text-anchor", "middle")
      .text(function(d) { return d.key; });
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
    var sizeProposals = +csv[i][1];
    var sizeVotes = +csv[i][2];
    var sizeComments = +csv[i][3];
    if (isNaN(sizeProposals)) { // e.g. if this is a header row
      continue;
    }
    //console.log(sequence,sizeProposals,sizeVotes,sizeComments);

    var parts = sequence.split("---");
    //ignore resume lines
    if (parts.length === 4) {
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
          childNode = {"name": nodeName, "sizeProposals": sizeProposals, "sizeVotes": sizeVotes, "sizeComments": sizeComments};
          children.push(childNode);
        }
      }
    }
  }
  return root;
};

/******* buttons & reset *********/
$("#buttonBarri").click(function(){
      $('#sidebar2 button.but1').each(function(){$(this).removeClass('active')})
      $("#buttonBarri").addClass('active');
      if (mode_3_2 !== modeBarri) {
        reset_3_2(modeBarri, size_3_2);
      }
});

$("#buttonCiutat").click(function(){
    $('#sidebar2 button.but1').each(function(){$(this).removeClass('active')})
    $("#buttonCiutat").addClass('active');
        if (mode_3_2 !== modeCiutat) {
        reset_3_2(modeCiutat, size_3_2);
        }
});

$("#buttonProposals").click(function(){
    $('#sidebar2 button.but2').each(function(){$(this).removeClass('active')})
    $("#buttonProposals").addClass('active');
  if (size_3_2 !== modeProposals) {
    reset_3_2(mode_3_2, modeProposals);
  }
});

$("#buttonVotes").click(function(){
    $('#sidebar2 button.but2').each(function(){$(this).removeClass('active')})
    $("#buttonVotes").addClass('active');
  if (size_3_2 !== modeVotes) {
    reset_3_2(mode_3_2, modeVotes);
  }
});

$("#buttonComments").click(function(){
    $('#sidebar2 button.but2').each(function(){$(this).removeClass('active')})
    $("#buttonComments").addClass('active');
  if (size_3_2 !== modeComments) {
    reset_3_2(mode_3_2, modeComments);
  }
});

function reset_3_2(resetMode, resetSize) {
  d3.select("#chart svg").remove();
  d3.select("#legend svg").remove();
  mode_3_2 = resetMode;
  size_3_2 = resetSize;
  init_3_2();
}
