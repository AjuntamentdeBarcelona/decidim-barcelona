var graphData,
    hoverColor = 'rgb(198,12,48)',
    disableColor = '#ddd';

function init_2_4() {
  $.when(
    $.getJSON( "data/users_2.json", {})   
    .done (function( data ) { 
      graphData = data;
    })  
    .fail(function(data) {    
      console.log("json error");
    })
  ).then(function() { 
    //console.log("json loaded!");

    var s = new sigma({ 
      graph: graphData,
      //container: 'graph-users',
      settings: {
        zoomMin: 1,
        zoomMax: 1,
        enableHovering: true,
        drawLabels: false,
        defaultEdgeColor: '#000',
        defaultNodeColor: '#000',
        defaultLabelHoverColor: '#fff',
        labelHoverShadowColor: '#fff',
        defaultHoverLabelBGColor: hoverColor,
        font: "'Source Sans Pro', Helvetica, Arial, sans-serif",
        fontStyle: "",
        defaultLabelSize: 24,
        nodeHoverColor: 'default',
        defaultNodeHoverColor: hoverColor,
        sideMargin:0,
        scalingMode:'outside',
          mouseWheelEnabled: false,
        //minNodeSize: 2,
          //autoRescale:false,
      },
      renderer: {
        container: 'graph-users',
        type: 'canvas'
      }
    });

    //save initial node and edge color
    s.graph.nodes().forEach(function(n) { 
        n.color ='#000000';
        n.originalColor = n.color;
        n.size =  n.size*2
    });
    s.graph.edges().forEach(function(e) {
        e.hidden = true;
        e.color = '#000000';
    });
    s.settings('maxNodeSize', 35);
    s.settings('minNodeSize', 1);
    s.refresh();

    s.bind('overNode', function(e) {
      var nodeId = e.data.node.id;

      // hightlight neighbours
      var toKeep = s.graph.neighbours(nodeId);
      toKeep[nodeId] = e.data.node;

      s.graph.nodes().forEach(function(n) {
        if (!toKeep[n.id]) {
          n.color = disableColor;
        } else {
          n.color =hoverColor;
        }
      });

      s.graph.edges().forEach(function(e) {
        if (toKeep[e.source] && toKeep[e.target]) {
          e.hidden = false;
        } else {
          e.hidden = true;
        }
      });

      s.refresh();
    });

    s.bind('clickStage', function(e) {
      showDefaultState(s);
    });

    $( "#graph-users" ).mouseleave(function() {
      showDefaultState(s);
    });

    //bounce so graph can't be moved out of vision
    s.cameras[0].bind('coordinatesUpdated', function(e) {
      if (s.cameras[0].x < 0) s.cameras[0].x = 0;
      if (s.cameras[0].y < 0) s.cameras[0].y = 0;
      if (s.cameras[0].x > 0) s.cameras[0].x = 0;
      if (s.cameras[0].y > 0) s.cameras[0].y = 0;
    });
  });
}

function showDefaultState(s) {
  s.graph.nodes().forEach(function(n) {
    n.color = n.originalColor;
  });

  s.graph.edges().forEach(function(e) {
    e.hidden = true;
  });

  s.refresh();
}

// return object with every neighbour of a node
sigma.classes.graph.addMethod('neighbours', function(nodeId) {
  //sigma code
  var k,
      neighbours = {},
      index = this.allNeighborsIndex[nodeId] || {};

  for (k in index)
    neighbours[k] = this.nodesIndex[k];

  return neighbours;

  //linkorious code
  /*var k,
      neighbours = {},
      index = this.allNeighborsIndex.get(nodeId).keyList() || {};

  for (k in index)
    neighbours[index[k]] = this.nodesIndex.get(index[k]);

  return neighbours;*/
});