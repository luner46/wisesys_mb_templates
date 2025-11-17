<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Cache-Control" content="No-Cache"/>
	<meta name="robots" content="noindex, nofollow"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no"/>
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title></title>
	<script type="text/javascript" src="/js/plugin/jquery/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="/js/plugin/jquery/jquery-cookie-1.4.1.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="/css/style.css"/>
	<link rel="shortcut icon" href="/images/favicon/favicon.ico"/>
	<script type="text/javascript" src="/js/plugin/ol_4/ol.js" ></script>
	<script type="text/javascript" src="/js/plugin/ol_3/proj4.js"></script>
	<script type="text/javascript" src="/js/common_lib.js"></script>
	<link rel="stylesheet" type="text/css" href="/js/plugin/ol_4/ol.css" />
	<link rel="apple-touch-icon-precomposed" href="/images/favicon/flat-design-touch.png"/>
	<script type="text/javascript">
	//let geoserver_path = "${geoserverPath}";
	//let map = "";
	
	<%-- 시작 함수 등록 --%>
	$(function() {
		let hybrid = new ol.layer.Tile({
			name : "hybrid",
			visible: true,
			extent: [-20037508.3428, -20037508.3428, 20037508.3428, 20037508.3428],
			source: new ol.source.XYZ({
				url: "https://xdworld.vworld.kr/2d/Hybrid/service/{z}/{x}/{y}.png"
			})
		});
		
		let toco_map = new ol.layer.Tile({
			name : "toco_map",
			visible: true,
			extent: [-20037508.3428, -20037508.3428, 20037508.3428, 20037508.3428],
			source: new ol.source.XYZ({
				url: "https://223.130.175.62/floodsp_tiles_repo/base_adm_tile/{z}/{x}/{y}.png"
			})
		});
		
		let hybrid_map = new ol.layer.Tile({
			name : "toco_map",
			visible: true,
			//extent: [-20037508.3428, -20037508.3428, 20037508.3428, 20037508.3428],
			source: new ol.source.XYZ({
				url: "https://floodsp.hrfcosys.co.kr/upload_hybrid/{z}/{x}/{y}.png"
			})
		});
		
	    let main_layer = new ol.layer.Vector({ //메인레이어
	        source: new ol.source.Vector(),
	        name: "now_lon_lat"
	    });
	    
	    let lat = $("#lat").val();
	    let lon = $("#lon").val();
	    let sp_yn = $("#spyn").val();
	    let sp_zoom = "12";
	    
	    //console.log($("#lat").val());
	    //console.log(parseFloat($("#lat").val()) +0.76);
	    
		if(sp_yn == '1') { //creat map center-zoom yn
			splat = $("#splat").val();
			splon = $("#splon").val();
			sp_zoom = $("#spzoom").val();
		}
		
		let init_coordinate = ol.proj.fromLonLat([parseFloat(lon), parseFloat(lat) + 0.0003]);
		
		let map = new ol.Map({
	   		logo: false,
	   		controls: ol.control.defaults({attribution: false, zoom: false}),
	   		interactions: ol.interaction.defaults({pinchRotate: false}),
	   		target: "map",
	   		//layers: [satellite, hybrid, main_layer],
	   		layers: [toco_map, hybrid_map, main_layer, hybrid],
	        view: new ol.View({
				projection: ol.proj.get("EPSG:2097"),
			  	center: init_coordinate,
			  	zoom: sp_zoom,
			  	minZoom :12,
			  	maxZoom :18
			})
	   	});
		
		hybrid.setZIndex(1);
		
        let sb = $("#sb").val();
        
		if(sb == "2") {
			console.log("aaa");
			let wlobscd = $("#wlobscd").val();
			map.addLayer(eval("tile_" + wlobscd));
			
		} else {
		    let res_data = {};
		    
		    switch(sb) {
		    	case "1":
		    		res_data = { //han
		    	    	name: "layer_comp_han_100", 
		    	    	extent: [14064959.1257, 4368222.3476, 14404068.1536, 4645116.1887],
		    			url: "/floodsp_tiles_repo/comp_han_100yr/{z}/{x}/{y}.png"   	
		    	    }; break;
		    		
		    	case "2":
		    		res_data = { //nak
		    			name: "layer_comp_nak_100",
		    	    	extent: [14194496.0400, 4118953.0041, 14562140.5482, 4519256.1799],
		    			url: "/floodsp_tiles_repo/comp_nak_100yr/{z}/{x}/{y}.png"   	
		    	    }; break;
		    		
		    	case "3":
		    		res_data = { //kum
		    	    	name: "layer_comp_kum_100",
		    	    	extent: [14052500.4539, 4228125.5462, 14254367.1647, 4445377.5341],
		    			url: "/floodsp_tiles_repo/comp_kum_100yr/{z}/{x}/{y}.png"    	
		    	    }; break;
		    		
		    	case "4":
		    		res_data = { //yus
		    			name: "layer_comp_yus_100",
		    	    	extent: [14043735.6337, 3926417.6719, 14235452.8314, 42275462.6364],
		    			url: "/floodsp_tiles_repo/comp_ysj_100yr_new_new/{z}/{x}/{y}.png"    	
		    	    }; break;
					
				case "5":
		    		res_data = { //yus
		    			name: "layer_comp_yus_100",
		    	    	extent: [14043735.6337, 3926417.6719, 14235452.8314, 42275462.6364],
		    			url: "/floodsp_tiles_repo/comp_ysj_100yr_new/{z}/{x}/{y}.png"    	
		    	    }; break;
		    }
		    
		    if(sb !== "9") {
		    	let result_tile = new ol.layer.Tile({
		    		name : res_data.name,
		    		visible: true,
		    		wrapX: false,
		    		crossOrigin: 'anonymous',
		    		extent: res_data.extent, 
		    		source: new ol.source.XYZ({
		    			minZoom: 10,
		    			maxZoom: 12,
		    			url: res_data.url
		    		})
		    	});
			    
				map.addLayer(result_tile); 
		    }
		}
		
	    
	    selectMarker(init_coordinate, main_layer);
		
		$(document).keydown(function(event) {
			if((event.ctrlKey) || (event.shiftKey) || event.keyCode == 122 || event.keyCode == 123) {
				return false;
			}
		});
	});
	
	
	<%-- 마커 설정 --%>
	function selectMarker(marker_coordinate, main_layer){
		let obsnm = $('#obsnm').val();
		
		//console.log(marker_coordinate);
		
		let sp_geom = new ol.geom.Point(marker_coordinate);
		
		main_layer.getSource().clear();
		
        let bs_style = new ol.style.Style({ //텍스트배경스타일
        	image: new ol.style.Icon({
                //anchor: [0.5, 99.5],
                //scale: 1.0,
                anchorOrigin: 'bottom-left',
                anchorXUnits: "fraction",
                anchorYUnits: "pixels",
                src: "/images/temp3.png"
            }),
            text: new ol.style.Text({
				font: "bold 1.2em Verdana",
                textBaseline: "bottom",
				text:  obsnm,
		        //text:  "광주광역시(장록교)",
		        overflow: true,
		        fill: new ol.style.Fill({
	          		color: "#FFFFFF"
	        	}),
	        	stroke: new ol.style.Stroke({
		          color: "#000000",
		          width: 4.0
		        })
	      	})
        });
        
        let sp_style = new ol.style.Style({ //특보지점스타일
        	image: new ol.style.Icon({
                //anchor: [0.5, 70.0],
                //scale: 1.0,
                anchorXUnits: "fraction",
                anchorYUnits: "pixels",
                src: "/images/red.png"
            })
        });
		
		let sp_marker = new ol.Feature();
		let bs_marker = new ol.Feature();
		
		sp_marker.setStyle(sp_style);
		bs_marker.setStyle(bs_style);
		
		bs_marker.setGeometry(sp_geom);
		sp_marker.setGeometry(sp_geom);
		
		main_layer.getSource().addFeature(bs_marker);
		main_layer.getSource().addFeature(sp_marker);
		main_layer.setZIndex(7);
	}
	
	</script>
</head>

	<body id="mapArea">
		<form name="frm" method="post">
			<input type="hidden" id="obsnm" name="obsnm" value="${obsnm}" />
			<input type="hidden" id="lat" name="lat" value="${lat}" />
			<input type="hidden" id="lon" name="lon" value="${lon}" />
			<input type="hidden" id="splat" name="splat" value="${splat}" />
			<input type="hidden" id="splon" name="splon" value="${splon}" />
			<input type="hidden" id="spzoom" name="spzoom" value="${spzoom}" />
			<input type="hidden" id="spyn" name="spyn" value="${spyn}" />
			<input type="hidden" id="sb" name="sb" value="${sb}" />
			<input type="hidden" id="sample" name="sample" value="${sample}" />
			<input type="hidden" id="wlobscd" name="wlobscd" value="${wlobscd}" />
			
			<div id="container" class="wrap">
				<!-- <form name="form" id="form" onsubmit="return false;"> -->
					<!-- <input type="hidden" name="currentPage" value="1"/> -->
					<!-- <input type="hidden" name="countPerPage" value="20"/> 요청 변수 설정 (페이지당 출력 개수. countPerPage 범위 : 0 < n <= 100) -->
					<!-- <input type="hidden" name="resultType" id="resultType" value="json"/> 요청 변수 설정 (검색결과형식 설정, json) --> 
					<!--  <input type="hidden" name="confmKey" value="U01TX0FVVEgyMDIxMTEwMTE4MTg1MTExMTgyODY="/>요청 변수 설정 (승인키) -->
					
					<div id="map" class="map"></div>
					
					<div class="legend_open" id="legend"><a><img src="/images/legend_img.png" alt="범례" /></a></div>
			</div>
		</form>
	</body>
</html>
	
