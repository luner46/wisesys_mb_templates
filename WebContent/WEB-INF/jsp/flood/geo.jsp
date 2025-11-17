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
	<script type="text/javascript" src="/js/plugin/jquery/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/js/plugin/jquery/jquery-cookie-1.4.1.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="/css/style.css"/>
	<link rel="shortcut icon" href="/images/favicon/favicon.ico"/>
	<script type="text/javascript" src="/js/plugin/ol_4/ol.js" ></script>
	<script type="text/javascript" src="/js/plugin/ol_3/proj4.js"></script>
	<link rel="stylesheet" type="text/css" href="/js/plugin/ol_4/ol.css" />
	<link rel="apple-touch-icon-precomposed" href="/images/favicon/flat-design-touch.png"/>
	<script type="text/javascript">
	//let geoserver_path = "${geoserverPath}";
	//let map = "";
	
	<%-- 시작 함수 등록 --%>
	$(function() {
		if($.cookie("now_lon_lat")) {
			document.frm.action = "/floodsp/my.do";
			document.frm.submit();
			
		} else {
			if(navigator.geolocation) { //위치정보동의
				navigator.geolocation.getCurrentPosition(function(position) {
					let lat = position.coords.latitude;
					let lon = position.coords.longitude;
					
					document.frm.action = "/floodsp/my.do";
					document.frm.submit();
					
					$.cookie("now_lon_lat", lon.toString() + "," + lat.toString(), {expires: 30, path: "/"});
					
				}, function(e) {
					document.frm.action = "/floodsp/my.do";
					document.frm.submit();
					<%-- console.log("e.code:"+ e.code+ "/e:"+ e); --%>
				}, {
					enableHeighAccuracy : false,
					timeout : 5000,
					maximumAge : 0
				});
			} else {
				document.frm.action = "/floodsp/main.do";
				document.frm.submit();
			}
		}
		
		$(document).keydown(function(event) {
			if((event.ctrlKey) || (event.shiftKey) || event.keyCode == 122 || event.keyCode == 123) {
				return false;
			}
		});
		
	});
	
	</script>
</head>

	<body id="mapArea" oncontextmenu="return false">
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
			<input type="hidden" id="sample" name="wlobscd" value="${wlobscd}" />
		</form>
	</body>
</html>
	
