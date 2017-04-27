var graphPropuestasData,
    hoverColor = 'rgb(198,12,48)',
    originalColor = '#000000',
    disableColor = '#ddd',
    graphPropostes,
    activeId = 0;


function init_3_4() {
  $.when(
    $.getJSON( "data/comments_2.json", {})   
    .done (function( data ) { 
      graphPropuestasData = data;
    })  
    .fail(function(data) {    
      console.log("json error");
    })
  ).then(function() { 
    //console.log("json loaded!");

    var s = new sigma({ 
      graph: graphPropuestasData,
      //container: 'graph-propostes',
      settings: {
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
        maxEdgeSize:0.1
        //minNodeSize: 2,
          //autoRescale:false,
      },
      renderer: {
        container: 'graph-propostes',
        type: 'canvas'
      }
    });

    graphPropostes = s;

    //save initial node and edge color
    s.graph.nodes().forEach(function(n) { 
        
        n.color ='#000000';
        n.originalColor = n.color;
        //n.size =  n.size*2
    });
    s.graph.edges().forEach(function(e) {
        e.hidden = false;
        e.color = '#909090';
    });
    s.settings('maxNodeSize', 35);
    s.settings('minNodeSize', 1);
    s.refresh();

    s.bind('clickNode', function(e) {
      //only if selected and not eje/linea
      if (e.data.node.color === originalColor && !e.data.node.id.startsWith("s")) {
        //console.log("click",e.data.node.id);
        var nodeId = e.data.node.id,
            node = s.graph.nodes(nodeId),
            dataProposal,
            htmlText = "<h1>"+node.label+"</h1>",
            url = "https://decidim.barcelona/api/proposals/"+nodeId.substring(1)+".json";

        //load proposal
        $.when(
          /*$.ajax({
              crossDomain: true,
              dataType: 'jsonp',
              jsonpCallback: '',
              contentType: "application/json",
              jsonp: false,
              url: "https://decidim.barcelona/api/proposals/"+nodeId.substring(1)+".json"
          })*/
          //$.getJSON('http://whateverorigin.org/get?url=' + encodeURIComponent(url), {})
          $.getJSON( "https://decidim.barcelona/api/proposals/"+nodeId.substring(1)+".json", {})   
          .done (function( data ) {
            console.log(data);
            dataProposal = data;
          })
          .fail(function(data) {    
            console.log("json error",data);
              //mostrar info local
            var url = "https://decidim.barcelona/proposals/"+nodeId.substring(1);
            htmlText += "<p><a href='"+url+"'>"+url+"</a></p>";

            $("#text-proposals").empty();
            $("#text-proposals").append(htmlText);
            $("#text-proposals").css('background', '#d3d3d3');
             
            //responsive
            if($(window).width()<1150){
              $("#text-proposals").show();
              $("#text-proposals").css('background', '#ffffff');
              setTimeout(function(){
                 $("#text-proposals").fadeOut();
              },5000)
            }
          })
        ).then(function() {
          //cargar api
          htmlText += "<p>"+dataProposal.summary+"</p>";
          htmlText += "<p>"+dataProposal.district.name+"</p>";
          htmlText += "<p>"+dataProposal.source+"</p>";
          htmlText += "<p>"+dataProposal.total_votes+"</p>";
          htmlText += "<p>"+dataProposal.total_comments+"</p>";
          htmlText += "<p>"+dataProposal.category.name+"</p>";
          htmlText += "<p>"+dataProposal.subcategory.name+"</p>";
          htmlText += "<p><a href='"+dataProposal.url+"'>"+dataProposal.url+"</a></p>";

          $("#text-proposals").empty();
          $("#text-proposals").append(htmlText);
          $("#text-proposals").css('background', '#d3d3d3');
           
          //responsive
          if($(window).width()<1150){
            $("#text-proposals").show();
            $("#text-proposals").css('background', '#ffffff');
            setTimeout(function(){
               $("#text-proposals").fadeOut();
            },5000)
          }
            
        });

        if (activeId !== 0) s.graph.nodes(activeId).color = originalColor;
        activeId = nodeId;
        node.color = hoverColor;
        s.refresh();
      }
    });

    /*s.bind('overNode', function(e) {
      if (e.data.node.color === originalColor) {
        e.data.node.color = hoverColor;
        s.refresh();
      }
    });

    s.bind('outNode', function(e) {
      e.data.node.color = originalColor;
      s.refresh();
    });*/

    /*s.bind('clickStage', function(e) {
      showDefaultState(s);
    });*/

    /*$( "#graph-propostes" ).mouseleave(function() {
      showDefaultState(s);
    });*/
  });
}

function showDefaultState(s) {
  s.graph.nodes().forEach(function(n) {
    n.color = n.originalColor;
  });
  s.refresh();
}

function filterPropostes(type, id) {
  graphPropostes.graph.nodes().forEach(function(n) {
    switch (type) {
      case "all":
        n.color = n.originalColor;
        break;
      case "district":
      case "source":
      case "comments":
        if (n.attributes[type] === id) {
          n.color = n.originalColor;
        } else {
          n.color = disableColor;
        }
        break;
      case "ttvotes":
      case "ttcoments": 
        if (n.attributes[type] === "1") {
          n.color = n.originalColor;
        } else {
          n.color = disableColor;
        }
        break;
    }
  });
  graphPropostes.refresh();
}

$("#selectorPropostes button").click(function(){
  var id = $(this).data("id");
  if (id === undefined) id = $(this).data("i18n").substring(2);
  filterPropostes($(this).data("type"), id);
  $('#selectorPropostes button').each(function(){$(this).removeClass('active')})
  $(this).addClass('active');
});