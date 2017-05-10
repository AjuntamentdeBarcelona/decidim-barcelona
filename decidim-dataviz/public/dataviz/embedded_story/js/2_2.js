function init_2_2(){
  d3.xml(i18next.t("r_2_2_svg"), "image/svg+xml", function(xml) {
    var importedNode = document.importNode(xml.documentElement, true);
    d3.select("#multicapa").node().appendChild(importedNode);

    //select node decidim.barcelona
    var node = d3.select("#multicapa #g2_2_12")[0];      
    //showInfo_2_2(node[0].id);
    $(node).find("path").addClass("active");

    d3.selectAll("#multicapa circle").on("click", function(d, i){
      showInfo_2_2(this.id);
      $(this).addClass("active");
    });

    d3.select("#multicapa #g2_2_12").on("click", function(d, i){
       showInfo_2_2(this.id);
       $(this).find("path").addClass("active");
    });
 });
}

function showInfo_2_2(id) {
  //document.body.style.cursor = "pointer";
  $("#index_3 div.text").hide();
  $("#index_3 ."+id).show();
  $("#multicapatext").css('background', '#d3d3d3')
    
 //responsive
  if($(window).width()<1150){
      $('#multicapatext').show();
      $("#multicapatext").css('background', '#ffffff');
      setTimeout(function(){
          $('#multicapatext').fadeOut()
      },5000)
  }

  $("#multicapa circle").removeClass("active");
  $("#multicapa #g2_2_12 path").removeClass("active");
    
}

function hideInfo_2_2() {
  if($(window).width()>=1150){
    //document.body.style.cursor = "default";
    $("#index_3 div.text").hide();
  }  
}