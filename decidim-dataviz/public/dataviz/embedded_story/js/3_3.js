var widthMap =$("#map_3_3").width();
    heightMap = windowHeight-180,
    hoverColor_3_3 = 'rgb(198,12,48)',
    defaultColor_3_3 = "#ddd",
    features_3_3 = {},
    maxValue = {"pob14":0, "dones":0, "rdf14":0, "aturdes14":0, "estudisuniv14":0, "pob14_1424":0, "pob14_2534":0, "pob14_3544":0, "pob14_4554":0, "pob14_5465":0, "pob14_mes65":0},
    colorMin = "#fff",
    colorMax = "#000",
    demoType = "pob14",
    scaleMap = 150000,
    mult = 1,
    xLeg = 50,//370,
    yLeg = 10;//430;

if ($(window).width()<600) {
    widthMap = $(window).width();
    scaleMap = 70000;
    mult = 0.5;
} else if ($(window).width()<limit) {
    widthMap = $(window).width()-80;
    scaleMap = 100000;
}  

// var w = parseInt(d3.select('#map_3_3').style('width'))/800*150000;

var projectionMap = d3.geo.mercator()    
    .center([2.0785562,41.3948975])    
    .scale(scaleMap)    
    // .scale(w)
    .translate([100, heightMap/2]);   

var pathMap = d3.geo.path().projection(projectionMap);

// Create SVG Element
var svgMap = d3.select("#map_3_3").append("svg")
    .attr("width", widthMap)
    .attr("height", heightMap);

function init_3_3() {
    //buttons
    $("#selectorDemo button").click( function() {
        $("#selectorDemo button").removeClass("active");
        $(this).addClass("active");
        demoType = $(this).data("type");
        fillMap_3_3(demoType);
        drawLegend_3_3(svgMap, xLeg, yLeg, 100, 5, colorMin, colorMax, 0, 0, 0, maxValue[demoType]);
        return false; 
    });

    // load map
    d3.json("data/distrdades4326.geojson", function(error, dataDistri) {

        //save district features
        for (distriKey in dataDistri.features) {
            if (dataDistri.features.hasOwnProperty(distriKey)) {
                features_3_3[dataDistri.features[distriKey].properties.c_distri] = dataDistri.features[distriKey].properties;
            }
        }
        //console.log("distrdades", features);

        //load PAM data
        d3.json("data/pamdades4326.geojson", function(error, dataPam) {

            //paint map
            svgMap.append("path")
                .datum(dataDistri.features)
                .attr("d", pathMap)
                .style("stroke", "#fff")
                .style("stroke-width", "1");

            svgMap.selectAll(".subunit")
                .data(dataDistri.features)
                .enter().append("path")
                .attr("d", pathMap)
                .attr("id", function(d) {
                    return "distri"+d.properties.c_distri;
                })
                .attr("class", "district")
                .style("stroke", "#fff")
                .style("stroke-width", "1")
                .style("fill", function(d) {
                    return defaultColor_3_3;
                })
                .on("mouseover", function(d) {
                    showDistrictInfo(d.properties.c_distri);
                })
                .on("mouseout", function(d) {
                    paintDefaultDistrict(d.properties.c_distri);
                });

            //paint circles
            for (pamKey in dataPam.features) {
                if (dataPam.features.hasOwnProperty(pamKey)) {
                    var coord = dataPam.features[pamKey].geometry.coordinates,
                        prop = dataPam.features[pamKey].properties;

                    var circleG = svgMap.append("g")
                        .attr("id",prop.c_distri)
                        .attr("class","circleValues")
                    /*.on("mouseover", function(d) {
                        showDistrictInfo(showDistrictInfo(this.id));
                    })
                    .on("mouseout", function(d) {
                        paintDefaultDistrict(this.id);
                    })*/;

                    //circle votos
                    circleG.append("circle")
                        .attr("cx", function (d) { return projectionMap(coord)[0]; })
                        .attr("cy", function (d) { return projectionMap(coord)[1]; })
                        .attr("r", parseInt(prop.votx1000hab)/5*2*mult+"px")
                        .attr("fill", "#000");

                    //circle propuestas
                    circleG.append("circle")
                        .attr("cx", function (d) { return projectionMap(coord)[0]; })
                        .attr("cy", function (d) { return projectionMap(coord)[1]; })
                        .attr("r", parseInt(prop.propx1000hab)*2*mult+"px")
                        .attr("fill", "#fff");

                    //save district pam data to features
                    features_3_3[prop.c_distri].pamdades = prop;

                    //get mx values
                    for (type in maxValue) {
                        var value = parseFloat(dataPam.features[pamKey].properties[type]);
                        if (value > maxValue[type]) {
                            maxValue[type] = value;
                        }
                    }
                }
            }
            //console.log("pamdades", features);

            //draw Barcelona boundaries
            /*d3.json("data/limitbcn4326.geojson", function(error, dataBcn) {
                svgMap.append("path")
                .datum(dataBcn.features)
                .attr("d", pathMap)
                .style("stroke", "#000")
                .style("stroke-width", "1");
            });*/

            fillMap_3_3(demoType);
            drawLegend_3_3(svgMap, xLeg, yLeg, 100, 5, colorMin, colorMax, 0, 0, 0, maxValue[demoType]);
        });
    });
}

function fillMap_3_3(type) {
    //fill with color mapped from demographic data
    var colorMap = d3.scale.linear()
    .domain([0,maxValue[type]])
    .range([colorMin,colorMax]);

    d3.selectAll(".district")
    .style("fill", function(d) {
        var value = features_3_3[d.properties.c_distri].pamdades[type];
        features_3_3[d.properties.c_distri].fillColor = colorMap(value);
        if (value) {
            return colorMap(value);
        } else {
            return colorMin;
        }
    });
}

function showDistrictInfo(id) {
    d3.selectAll("path#distri"+id).style("fill", hoverColor_3_3);

    if (id !== undefined) {
        var pam = features_3_3[id].pamdades;

        //pamdades
        var htmlText = "";
        if (pam.districte !== undefined) htmlText += "<div class='box3'>"+pam.districte+ "</div>";
        //if (pam.c_distri !== undefined) htmlText += " [" + pam.c_distri + "]<br /><br />";
        if (pam.propostes !== undefined) htmlText += "<strong>" + pam.propostes+ "</strong> "+i18next.t("r_3_3_8")+"<br />";
        if (pam.vots !== undefined) htmlText += "<strong>" + pam.vots+ "</strong> "+i18next.t("r_3_3_10")+"<br />";
        if (pam.comentaris !== undefined) htmlText += "<strong>" + pam.comentaris+ "</strong> "+i18next.t("r_3_3_12")+"<br />";
        if (pam.meetings !== undefined) htmlText += "<strong>" + pam.meetings+ "</strong> "+i18next.t("r_3_3_35")+"<br />";
        if (pam.proppercentotal !== undefined) htmlText += "<strong>" + pam.proppercentotal+ "</strong> "+i18next.t("r_3_3_9")+"<br />";
        if (pam.votspercenttotal !== undefined) htmlText += "<strong>" + pam.votspercenttotal+ "%</strong> "+i18next.t("r_3_3_11")+"<br /><br />";
/*
        if (pam.usuaruisunicprop !== undefined) htmlText += "<strong>" + pam.usuaruisunicprop+ "</strong> "+i18next.t("r_3_3_16")+"<br />";
        if (pam.propxavgusuariunic !== undefined) htmlText += "<strong>" + pam.propxavgusuariunic+ "</strong> "+i18next.t("r_3_3_17")+"<br />";
        if (pam.votsavgusuariunic !== undefined) htmlText += "<strong>" + pam.votsavgusuariunic+ "</strong> "+i18next.t("r_3_3_18")+"<br /><br />";
*/        
        if (pam.area !== undefined) htmlText += "<strong>" + pam.area+ "</strong> "+i18next.t("r_3_3_31")+"<br /><br />";

        switch(demoType) {
            case "pob14":
                if (pam.pob14 !== undefined) htmlText += "<strong>" + pam.pob14+ "</strong> "+i18next.t("r_3_3_13")+"<br />";
                if (pam.propx1000hab !== undefined) htmlText += "<strong>" + pam.propx1000hab+ "</strong> "+i18next.t("r_3_3_14")+"<br />";
                if (pam.votx1000hab !== undefined) htmlText += "<strong>" + pam.votx1000hab+ "</strong> "+i18next.t("r_3_3_15")+"<br /><br />";
                break;
            case "dones":
                if (pam.homes !== undefined) htmlText += "<strong>" + pam.homes+ "</strong> "+i18next.t("r_3_3_29")+"<br />";
                if (pam.dones !== undefined) htmlText += "<strong>" + pam.dones+ "</strong> "+i18next.t("r_3_3_30")+"<br />";
                break;
            case "pob25_65":
                var menos25 = pam.pob14_menys15+pam.pob14_1424;
                if (pam.pob14_menys15 !== undefined && pam.pob14_1424 !== undefined) htmlText += "<strong>" + menos25+ "</strong> "+i18next.t("r_3_3_23")+"<br />";
                if (pam.pob14_2534 !== undefined) htmlText += "<strong>" + pam.pob14_2534+ "</strong> "+i18next.t("r_3_3_24")+"<br />";
                if (pam.pob14_3544 !== undefined) htmlText += "<strong>" + pam.pob14_3544+ "</strong> "+i18next.t("r_3_3_25")+"<br />";
                if (pam.pob14_4554 !== undefined) htmlText += "<strong>" + pam.pob14_4554+ "</strong> "+i18next.t("r_3_3_26")+"<br />";
                if (pam.pob14_5465 !== undefined) htmlText += "<strong>" + pam.pob14_5465+ "</strong> "+i18next.t("r_3_3_27")+"<br />";
                if (pam.pob14_mes65 !== undefined) htmlText += "<strong>" + pam.pob14_mes65+ "</strong> "+i18next.t("r_3_3_28")+"<br />";
                break;
            case "rdf14":
                if (pam.rdf14 !== undefined) htmlText += "<strong>" + pam.rdf14+ "</strong> "+i18next.t("r_3_3_20")+"<br />";
                break;
            case "aturdes14":
                if (pam.aturdes14 !== undefined) htmlText += "<strong>" + pam.aturdes14+ "</strong> "+i18next.t("r_3_3_19")+"<br />";
                break;
            case "estudisuniv14":
                if (pam.estudisuniv14 !== undefined) htmlText += "<strong>" + pam.estudisuniv14+ "</strong> "+i18next.t("r_3_3_22")+"<br />";
                if (pam.estudisno14 !== undefined) htmlText += "<strong>" + pam.estudisno14+ "</strong> "+i18next.t("r_3_3_21")+"<br />";
                break;
        }

        $("#mapText").empty();
        $("#mapText").append(htmlText);
        $("#mapText").css('background', '#d3d3d3')
        
        //responsive
        if($(window).width()<1150){
            $("#mapText").css('background', '#ffffff');
            $('#mapText').show()
            setTimeout(function(){
                 $('#mapText').fadeOut();
            },5000)
        }
    }
}

function paintDefaultDistrict(id) {
    d3.selectAll("path#distri"+id)
    .transition()
    .duration(250)
    .style("fill", features_3_3[id].fillColor);
    if($(window).width()>=1150){
        $("#mapText").css('background', '#ffffff');
        $("#mapText").empty();}
}


//http://bl.ocks.org/darrenjaworski/5397362
//http://bl.ocks.org/darrenjaworski/5874214
function drawLegend_3_3(svg, x, y, w, h, startColor, endColor, min, max, tickMin, tickMax) {
    svg.select(".legend").remove();

    var group = svg.append("g").attr("class", "legend");

    var r = 2;
    group.append("circle")
        .attr("cx", x+2*r)
        .attr("cy", y)
        .attr("r", 2*r+"px")
        .attr("stroke", "#000")
        .attr("fill", "#fff");
    group.append("text")
        .text(i18next.t("r_3_3_33"))
        .attr("x", x+15)
        .attr("y", y+r)
        .attr("font-size", "14px")
        .attr("fill", "#000");

    group.append("circle")
        .attr("cx", x+2*r)
        .attr("cy", y+20+r)
        .attr("r", 2*r+"px")
        .attr("fill", "#000");
    group.append("text")
        .text(i18next.t("r_3_3_34"))
        .attr("x", x+15)
        .attr("y", y+20+2*r)
        .attr("font-size", "14px")
        .attr("fill", "#000");

    var txt = $("#selectorDemo button.active").data("i18n");
    if (txt === undefined) txt = i18next.t("r_3_3_4") + " " + $("#selectorDemo button.active").text();
    else txt = i18next.t(txt.substring(6));

    group.append("text")
        .text(txt)
        .attr("x", x)
        .attr("y", y+55)
        .attr("font-size", "14px")
        .attr("fill", "#000");

    //move real legend down
    y = y+60;

    var legend = group.append("defs")
        .append("svg:linearGradient")
        .attr("id", "gradient")
        .attr("x1", "0%")
        .attr("y1", "100%")
        .attr("x2", "100%")
        .attr("y2", "100%")
        .attr("spreadMethod", "pad");

    legend.append("stop")
        .attr("offset", "0%")
        .attr("stop-color", startColor)
        .attr("stop-opacity", 1);

    legend.append("stop")
        .attr("offset", "100%")
        .attr("stop-color", endColor)
        .attr("stop-opacity", 1);

    group.append("rect")
        .attr("width", w)
        .attr("height", h)
        .style("fill", "url(#gradient)")
        .attr("transform", "translate("+x+","+y+")");

    var col = d3.scale.linear()
        .range([0, w])
        .domain([0, 100]);

    var ticks = col;
    if (min !== undefined && max !== undefined) {
        ticks = d3.scale.quantile()
            .range([0, min*w/100, max*w/100, w])
            .domain([0, min, max, 100]);
    }

    if (tickMin !== undefined && tickMax !== undefined) {
        ticks = d3.scale.quantile()
            .range([0, w])
            .domain([Number((tickMin).toFixed(1)), Number((tickMax).toFixed(1))]);
    }

    var xAxis = d3.svg.axis()
        .scale(ticks)
        .ticks(4)
        .orient("bottom");

    var posy = y + h;
    group.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate("+x+","+posy+")")
        .call(xAxis)
        /*.append("text")
        .attr("x", x)
        .attr("y", y+30)
        .text("axis title")*/;
}

