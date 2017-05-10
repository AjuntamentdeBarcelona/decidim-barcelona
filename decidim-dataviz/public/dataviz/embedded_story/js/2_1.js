var graphData, textData,
    eixosNum = 5,
    hoverColor = 'rgb(198,12,48)';

function init_2_1() {
  $.when(
    $.getJSON( "data/2_1.json", {})   
    .done (function( data ) { 
      graphData = data;
    })  
    .fail(function(data) {    
      console.log("json error");
    })
  ).then(function() { 
    //console.log("json loaded!");

    // initialize sigma
    var s = new sigma({ 
      graph: graphData,
      //container: 'graph-eixos',
      settings: {
        zoomMin: 1,
        zoomMax: 1,
        sideMargin: 50,
        drawLabels: false,
        enableHovering: true,
        minNodeSize: 3,
        maxNodeSize: 30,
        defaultEdgeColor: '#000',
        defaultNodeColor: '#000',
        nodeHoverColor: 'default',
        defaultNodeHoverColor: hoverColor,
        defaultLabelHoverColor: '#fff',
        labelHoverShadowColor: '#fff',
        defaultHoverLabelBGColor: hoverColor,
        font: "'Source Sans Pro', Helvetica, Arial, sans-serif",
        fontStyle: "",
        defaultLabelSize: 24,
        mouseWheelEnabled: false,
       // scalingMode:'outside'
      },
      renderer: {
        container: 'graph-eixos',
        type: 'canvas'
      }
    });

    $.when(
      $.getJSON( "data/2_1_text.json", {})   
      .done (function( data ) { 
        textData = data;
      })  
      .fail(function(data) {    
        console.log("json error");
      })
    ).then(function() { 
      //console.log("json loaded!");

      //set initial nodes
      s.graph.nodes().forEach(function(n) {
        n.label = textData[n.id]["title_"+lng].toUpperCase();
        n.color='#000';
        n.originalColor = n.color;
        n.size = n.size*5;
        //esconder líneas
        /*if (n.id > eixosNum){ 
          n.hidden = true;
        }*/
      });
        
      s.graph.edges().forEach(function(e) {
        e.originalColor = '#000000';
        e.color = '#000000';

      });
      s.refresh();

      //turn on initial label
      s.renderers[0].dispatchEvent('overNode', {node:s.graph.nodes(0)});

      s.bind('clickNode', function(e) {
        var nodeId = e.data.node.id;

        // show hide child nodes = 29 lineas
        /*if (nodeId > 0 && nodeId <= eixosNum) {
          var toKeep = s.graph.childrenAndEixos(nodeId);
          toKeep[nodeId] = e.data.node;

          s.graph.nodes().forEach(function(n) {
            if (toKeep[n.id]) {
              n.hidden = false;
            } else {
              n.hidden = true;
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
        }*/

        //console.log(textData[e.data.node.id]["text_"+lng]);

        if (nodeId > 0) {
          var node = textData[nodeId];
          var htmlText = "<div class='box3'>"+node["title_"+lng].toUpperCase()+"</div>";
          htmlText += "<p>"+node["text_"+lng]+"</p>";

          var urlStr = node["url"];
          if (urlStr) {
            //insert locale setting
            //https://decidim.barcelona/categories?locale=es#category_1
            var url = "";
            var hashIndex = urlStr.indexOf("#");
            if (hashIndex !== -1) {
              url = urlStr.substring(0,hashIndex);
              url += "?locale="+lng;
              url += urlStr.substring(hashIndex);
            } else {
              url = urlStr;
            }
            htmlText += "<p><a href='"+url+"'>"+urlStr+"</a></p>";
          }
          $("#text-eixos").empty();
          $("#text-eixos").append(htmlText);
          $("#text-eixos").css('background', '#d3d3d3')
            
          //responsive    
          if($(window).width()<1149){
              $("#text-eixos").css('background', '#ffffff')
              $("#text-eixos").show();
              setTimeout(function(){
                 $("#text-eixos").fadeOut();
              }, 5000)
          }

          //paint node red
          s.graph.nodes().forEach(function(n) { 
            if (n.id !== e.data.node.id){ 
              n.color = n.originalColor;
            }
          });
          e.data.node.color = hoverColor;
          s.refresh();
        }
      });

      s.bind('overNode', function(e) {
        var nodeId = e.data.node.id;

        if (nodeId > 0) {
          s.renderers[0].dispatchEvent('outNode', {node:s.graph.nodes(0)});
          document.body.style.cursor = "pointer";
        
          //else s.renderers[0].dispatchEvent('overNode', {node:s.graph.nodes(0)});
          //set hover node color
          /*s.graph.nodes().forEach(function(n) { 
            if (n.id == e.data.node.id){ 
              n.color = hoverColor;
            }
          }); 
          s.refresh();*/
        }
      });

      s.bind('outNode', function(e) {
        document.body.style.cursor = "default";
        //set default node color
        /*s.graph.nodes().forEach(function(n) { 
          if (n.id == e.data.node.id){ 
            n.color = n.originalColor;
          }
        });
        s.refresh();*/
      });

      //bounce so graph can't be moved out of vision
      s.cameras[0].bind('coordinatesUpdated', function(e) {
        if (s.cameras[0].x < 0) s.cameras[0].x = 0;
        if (s.cameras[0].y < 0) s.cameras[0].y = 0;
        if (s.cameras[0].x > 0) s.cameras[0].x = 0;
        if (s.cameras[0].y > 0) s.cameras[0].y = 0;
      });
    });
  });
}

// return object with every parent and child of a node
sigma.classes.graph.addMethod('childrenAndEixos', function(nodeId) {
  //original sigma code
  var k,
      childrenAndEixos = {},
      index = this.allNeighborsIndex[nodeId] || {};

  for (var i=0; i<=eixosNum; i++)
    childrenAndEixos[i] = this.nodesIndex[i];

  for (k in index)
    if (k > eixosNum)
      childrenAndEixos[k] = this.nodesIndex[k];

  return childrenAndEixos;

  //linkorious code
  /*var k,
      childrenAndEixos = {},
      index = this.allNeighborsIndex.get(nodeId).keyList() || {};

  for (var i=0; i<=eixosNum; i++)
    childrenAndEixos[i] = this.nodesIndex.get(i);

  for (k in index) 
    if (index[k] > eixosNum)
      childrenAndEixos[index[k]] = this.nodesIndex.get(k);

  return childrenAndEixos;*/
});