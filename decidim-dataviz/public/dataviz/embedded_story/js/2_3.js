function init_2_3(){
   var calendari,
         hoverColor = 'rgb(198,12,48)';

   $.when(
      $.getJSON( "data/calendari.json", {})   
      .done (function( data ) { 
         calendari = data;
      })  
      .fail(function(data) {    
         console.log("json error");
      })
   ).then(function() { 

      d3.xml("svg/calendari.svg", "image/svg+xml", function(xml) {
         var importedNode = document.importNode(xml.documentElement, true);
         d3.select("#calendari").node().appendChild(importedNode);
         
          var htmlText = "<div class='box6'>";
            htmlText += "<div class='col4'><div class='cp'>"+i18next.t("r_2_3_4_1")+": <br><b></b></div></div>";
            htmlText += "<div class='col4'><div class='cc'>"+i18next.t("r_2_3_4_2")+": <br><b></b></div></div>";
            htmlText += "<div class='col4'><div class='cd'>"+i18next.t("r_2_3_4_3")+": <br><b></b></div></div>";
            htmlText += "<div class='col4'><div class='ct'>"+i18next.t("r_2_3_4_4")+": <br><b></b></div></div>";
            htmlText += "</div>"
                
            $("#text-container").empty();
            $("#text-container").append(htmlText);
          
          
         d3.selectAll("#calendari circle").on("mouseover", function(d, i){
            var id = this.id.substring(this.id.indexOf("_")+1);
            var node = calendari[id];
            var htmlText = "<div class='box6'>";
            //htmlText += "<h1>Setmana: "+node.setmana+"</h1>";
            htmlText += "<div class='col4'><div class='cp'>"+i18next.t("r_2_3_4_1")+": <br><b>"+node.propostes+"</b></div></div>";
            htmlText += "<div class='col4'><div class='cc'>"+i18next.t("r_2_3_4_2")+": <br><b>"+node.cites+"</b></div></div>";
            htmlText += "<div class='col4'><div class='cd'>"+i18next.t("r_2_3_4_3")+": <br><b>"+node.debats+"</b></div></div>";
            htmlText += "<div class='col4'><div class='ct'>"+i18next.t("r_2_3_4_4")+": <br><b>"+node.tweets+"</b></div></div>";
            htmlText += "</div>"
                
            $("#text-container").empty();
            $("#text-container").append(htmlText);

            d3.selectAll("#calendari circle").classed("active", false);
            d3.selectAll("#calendari line").classed("active", false);
            d3.selectAll("#calendari text").classed("active", false);
            d3.selectAll("#calendari .setmana_"+id).classed("active", true);
         });
      });
   });
}