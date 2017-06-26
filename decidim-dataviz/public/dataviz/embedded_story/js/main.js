if($(window).width() < 800){
  window.windowHeight = $(window).width() * 1.2;
} else {
  window.windowHeight = $(window).width() * 0.7;
}

var lng = "ca",
    ns = "translation",
    mode = 'full',
    limit = 1024; // ancho limite

    $('.container').each(function(index) {
        if($('.w300', this).length == 1){
            $('.wauto', this).css('width', $(this).width()-400-14 );
        }else{
            $('.wauto', this).css('width', $(this).width());
        }
    });

$(window).resize(function(){
    var h = windowHeight;

    mtop = 60;
    mbot = 20;
    var hh = h-mtop-mbot-0;
    
    //$('.slide').height(h-mtop-mbot); 
    $('.slide').css('padding-top', mtop);
    $('.slide').css('margin-bottom', mbot+10);
    $('.graph').height(hh);
    $('#graph-propostes').height(windowHeight-240);
        
    if($(window).width()<limit){
            $('body').css('line-height', '1');
            $('.container').each(function(index) {
                
                if($('.w300', this).length == 1){
                    $('.w300', this).css('height', 'none');
                    $('.w300', this).css('width',$(window).width());
                    $('.wauto', this).css('height', hh);
                    $('.wauto', this).css('width', $(window).width() );
                    $('#graph', this).css('width', $(window).width() );
                }else{ 
                    $('.wauto', this).css('height', hh);
                    //$('.w300', this).css('height', hh);
                    $('.w300', this).css('width', $(window).width());
                    $('.wauto', this).css('width', $(window).width() );
                    $('#graph', this).css('width', $(window).width() );
                }
            });
            
            mode = 'compact';           
        
    }else if ($(window).width()>=limit) {
    

            $('.container').each(function(index) {
                if($('.w300', this).length == 1){
                     $('.wauto', this).css('height', hh);
                     $('.w300', this).css('width', '400');
                    $('.wauto', this).css('width', $(this).width()-400-14 );
                    $('#graph', this).css('width', $(this).width()-400-14 );
                }else{
                     $('.wauto', this).css('height', hh);
                    $('.w300', this).css('height', hh);
                    
                    $('.wauto', this).css('width', $(this).width() );
                    $('#graph', this).css('width', $(this).width() );
                }
            });
            mode = 'full';
        
    }
    
    imgrefresh()
});

function imgrefresh(){
    var r
    $('.wauto img').each(function(index){
        $(this).load(function(){
            w=this.width; 
            h= this.height;
            r=h/w;
            var ww;
            var an;
            
            if($(window).width()>limit){
                ww=limit;
            }else{
                ww=$(window).width();
            }
            
            if($(window).width()<limit){an=$(window).width()}
            else{an=ww-460}
            rr=windowHeight/an;
            
            if (r>rr){ //big
                $(this).height(windowHeight-130);
            } else{
                $(this).width('90%');
            }
        })
    })  
    

    
}

function menu(){ 
    $('.menu2').empty();
    $( ".section" ).each(function( index ) {
        tit = $(this).attr('title');
        $(this).attr('id', 'index_'+index);
        
        //$( ".menu2" ).append( "<div class='bola' id='id_m_"+index+"' title='"+tit+"'>*</div>");
        //$('#id_m_'+index).append('<a href="#index_'+index+'"> *</a>')
        $( ".menu2" ).append( "<a href='#index_"+index+"'> <div class='bola' id='id_m_"+index+"' title='"+tit+"'></div></a>");
        
        $('#index').append("<div class='box6'><a href='#index_"+index+"'> "+tit+"</a></div>");

        $(this).appear();
        $(this).on('appear', function(event, $all_appeared_elements){
            $('.chapter').html($("#id_m_"+index).attr('title'));
            
            $('.bola.active').css('background-color', 'rgb(0,0,0)');
            $('.bola.active').removeClass('active');
            
            $('.bola#id_m_'+index).css('background-color', 'rgb(198,12,48)');
            $('.bola#id_m_'+index).addClass('active');
        });
    });
    $( ".menu2" ).append( "<div class='chapter'><div>" );
    $('.section').first().trigger('appear');
    
    
    /*--------------*/
    
    popups = ['#text-eixos','#multicapatext','#mapText','#text-proposals'];
    for (p in popups){
        $(popups[p]).click(function(){
            if($(window).width()<800){
                $(this).fadeOut();
            }
        })
    }
}

function textos(){
    i18next
    .use(window.i18nextBrowserLanguageDetector)
    .use(window.i18nextXHRBackend)
    .init({
      debug: false,
      load: 'languageOnly',
      fallbackLng: "ca",
      lngWhitelist: ['ca', 'es'],
      backend: {
        loadPath: 'lng/{{lng}}/{{ns}}.json',
        crossDomain: true,
      },
      detection: {
        // order and from where user language should be detected
        order: ['querystring', 'cookie', 'localStorage', 'navigator', 'htmlTag'],
        // keys or params to lookup language from
        lookupQuerystring: 'lng',
        lookupCookie: 'i18next',
        lookupLocalStorage: 'i18nextLng',
        // cache user language on
        caches: ['localStorage', 'cookie'],
      }
    }, function(err, t) {
        //i18next loaded
      jqueryI18next.init(i18next, $);

        //lng = localStorage.getItem("i18nextLng");
        lng = window.i18next.language;
        ns = "";

        if (lng !== "ca" && lng !== "es" && lng !== "en") {
            lng = "ca";
        }
        $('body').localize();
        initVis();
        
    }); 
};

function interaccions(){
    var desc = [['r_3_1_3_2', 10859],['r_3_1_3_6', 165087],['r_3_1_3_5',18191], ['r_3_1_3_4', 13210],['r_3_1_3_3',13614] ],
        //elements = [10859,165087,18191,13210,13614],
        //elements = [54,825,90,66,68],
        elements = [108,1650,182,132,136],
        area=$('#interaccions').parent().height()*$('#interaccions').parent().width();
    
    var total = 0;
    $.each(elements,function() {
        total += this;
    });

    for (e in elements){

        $('#interaccions').append('<div class="r_intro2 i'+e+'"><div class="inter_data"></div></div>');

        size=2*Math.sqrt(area*(total/elements[e])/3.1415)/150;
        for (i = 0; i < elements[e]; i++) { 
            $('.r_intro2.i'+e).append('<div class="bola2" style="height:'+size+'px; width:'+size+'px"></div>');
        }
    } 
    
    $('.i0').mouseover(function(){
        $('.inter_data').each(function(index){
            $(this).html('');
            $(this).width(0);
            $(this).height(0);
        })
        $('.i0 .inter_data').width($('.i0').width());
        $('.i0 .inter_data').height($('.i0').height());
        $('.i0 .inter_data').html('<div>'+i18next.t(desc[0][0])+'</div>'+'<div>'+desc[0][1]+'</div>');
    });
    
    $('.i1').mouseover(function(){
         $('.inter_data').each(function(index){
            $(this).html('');
            $(this).width(0);
            $(this).height(0);
        })
        $('.i1 .inter_data').width($('.i1').width());
        $('.i1 .inter_data').height($('.i1').height());
        $('.i1 .inter_data').html('<div>'+i18next.t(desc[1][0])+'</div>'+'<div>'+desc[1][1]+'</div>');
    });

    $('.i2').mouseover(function(){
         $('.inter_data').each(function(index){
            $(this).html('');
            $(this).width(0);
            $(this).height(0);
        })
        $('.i2 .inter_data').width($('.i2').width())
        $('.i2 .inter_data').height($('.i2').height())
        $('.i2 .inter_data').html('<div>'+i18next.t(desc[2][0])+'</div>'+'<div>'+desc[2][1]+'</div>');
    });

    $('.i3').mouseover(function(){
         $('.inter_data').each(function(index){
            $(this).html('');
            $(this).width(0);
            $(this).height(0);
        })
        $('.i3 .inter_data').width($('.i3').width());
        $('.i3 .inter_data').height($('.i3').height());
        $('.i3 .inter_data').html('<div>'+i18next.t(desc[3][0])+'</div>'+'<div>'+desc[3][1]+'</div>');
    });

    $('.i4').mouseover(function(){
         $('.inter_data').each(function(index){
            $(this).html('');
            $(this).width(0);
            $(this).height(0);
        })
        $('.i4 .inter_data').width($('.i4').width());
        $('.i4 .inter_data').height($('.i4').height());
        $('.i4 .inter_data').html('<div>'+i18next.t(desc[4][0])+'</div>'+'<div>'+desc[4][1]+'</div>');
    });
    
     $('.i5').mouseover(function(){
         $('.inter_data').each(function(index){
            $(this).html('');
            $(this).width(0);
            $(this).height(0);
        })
        $('.i5 .inter_data').width($('.i5').width());
        $('.i5 .inter_data').height($('.i5').height());
        $('.i5 .inter_data').html('<div>'+i18next.t(desc[5][0])+'</div>'+'<div>'+desc[5][1]+'</div>');
    });
    
    
    $('.inter_data, .inter_data div').mouseleave(
        function(){
            $('.inter_data').each(function(index){
            $(this).html('');
            $(this).width(0);
            $(this).height(0);
        })
        }
    )
}

$(document).ready(function() {
    $(window).trigger('resize');
    textos();
    
});


function titol(){
    var maxh =windowHeight/5;
    if (maxh > 160){maxh=160}
    $('.box2').each(function(index) {
        //var w = $(window).width()/ $(this).width()*17.5;
        var w = $(this).parent().width()/ $(this).width()*17.5;
        if (w>maxh){w=maxh}
        $(this).css('font-size', w);
    })
}

function initVis() {
    $(window).trigger('resize');
    
    titol();
    menu();
    imgrefresh();
    
    init_2_1();
    init_2_2();
    interaccions();
    init_2_3();
    init_2_4();
    init_3_2();  
    init_3_3();  
    init_3_4();
}
