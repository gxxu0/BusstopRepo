$(document).ready(function() {

	link_page();
	init();
	
});


// 글 등록
function busstop_add_list() {

	document.listForm2.action = "/insertBusstop.do";
	document.listForm2.submit();
}


// 글 등록
function busstop_register() {

	if ($('#nodeNm').val() == '') {
		alert('정류장명칭을 입력하세요.')
		return;
	}
	// 글 등록 form
	var formData = $("#detailForm").serialize();

	$.ajax({
		url : "/insertBusstop2.do",
		type : "POST",
		data : formData,
		success : function(data) {
			console.log(data);
			var result = confirm("새로운 버스정류장 위치를 등록하시겠습니까?");
			if(result){
			    alert("위치 등록이 되었습니다.");
				opener.location.reload(); // 부모창 리로드
				window.close(); // 자식창 끄기
			}else{
			    
			}
			
		},
		error : function(error) {
			console.log("error" + error);
		},
	})
}

// 글 수정
function busstop_edit(nodeIdValue) {

	document.listForm2.action = "/updateBusView.do";
	document.listForm2.submit(nodeIdValue);
	
}

// 글 수정 버튼 누른 후
function busstop_edit_btn(){
	if ($('#nodeNm').val() == '') {
		alert('정류장명칭을 입력하세요.')
		return;
	}
	var formDataModify = $("#modifyForm").serialize();
	$.ajax({
		url : "/updateBusstop.do",
		type : "POST",
		data :formDataModify,
		success : function(data) {
			var result = confirm("버스정류장 위치를 수정하시겠습니까?");
			if(result){
			    alert("위치 수정이 완료되었습니다.");
			    opener.location.reload(); // 부모창 리로드
				window.close(); // 자식창 끄기
			}else{
			    
			}
			

		},
		error : function(error) {
			console.log("error" + error);
		},
	})
}

// 글 목록
function selectList(button) {
	document.listForm2.action = "/BusStopList.do";
}

// 글 삭제
function busstop_delete() {

	var nodeId = $("#nodeId").val();
	console.log(nodeId);
	$.ajax({
		url : "/deleteBusStop.do",
		type : "POST",
		data : {
			"nodeId":nodeId
		},
		success : function(data) {
			console.log(data);
			console.log("성공");
			opener.location.reload(); // 부모창 리로드
			window.close(); // 자식창 끄기

		},
		error : function(error) {
			console.log("error" + error);
		},
	})
}

// 검색어 입력 후 enter -> 검색 O
function searchEvt() {
	var searchCondition = $("#searchCondition").val();
	var searchKeyword = $("#searchKeyword").val();
	if (window.event.keyCode == 13) {
		link_page(1);
    }
}
// 검색 (키워드)
$("#searchBtn").click(function() {
	var searchCondition = $("#searchCondition").val();
	var searchKeyword = $("#searchKeyword").val();
	if (document.getElementById("searchKeyword").value == '' ) {
		alert('검색할 키워드를 입력하세요');
	} else{
		link_page(1);
	}
});

var siBGDM2 = [];
function siBSDMF() {

	  var xhr = new XMLHttpRequest();
	  var url = 'https://apis.data.go.kr/B553077/api/open/sdsc2/baroApi';
	  var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'TVFo1GZot0KSCrEPGFWQUBefAD7Iq231jlkHSxDP26gpdn09b%2FHWx63ylTZmwquz6h6lHHYRH9nTwNEhFcJxag%3D%3D';
	  queryParams += '&' + encodeURIComponent('resId') + '=' + encodeURIComponent('dong');
	  queryParams += '&' + encodeURIComponent('catId') + '=' + encodeURIComponent('zone');
	  queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
	  xhr.open('POST', url + queryParams);

	  var sidoMData;
	  var sidoMDataNm;
	  var sidoMDataCd;
	  var siGnguNm;
	  var lDongNm;
	  xhr.onreadystatechange = function () {
	        if (this.readyState == 4 && this.status == 200) {
	            var response = JSON.parse(this.responseText);
	            sidoMData = response;
	            sidoMData = sidoMData.body.items;
	            for (var i = 0; i < sidoMData.length; i++) {
	                siBGDM2.push(response.body.items[i]);
	            }

	        }
	    };
	    xhr.send('');
	    console.log('siBGDM2',siBGDM2);

}
// 페이지 이동
function link_page(pageNo, searchCondition, searchKeyword) {

	$("#pageIndex").val(pageNo);
	var submitObj = new Object();
	submitObj.pageIndex = pageNo;

	var searchKeyword = $("#searchKeyword").val();
	var searchCondition = $("#searchCondition").val();
	
	
	
	$.ajax({
		url : "/BusStopListAjax.do",
		type : "POST",
		dataType : 'json',
		data : {
			"pageIndex" : pageNo,
			searchCondition : searchCondition,
			searchKeyword : searchKeyword
		},
		success : function(data) {

			var pageVO = data[0].pageVO;
			var result = new Array;
			result = data[0].busList;
			var realEnd = pageVO.realEnd;
			var startDate = pageVO.startDate;
			var startButtonDate = startDate - 1;
			var endDate = pageVO.endDate;
			var endButtonDate = endDate + 1;
			var pageIndex = pageVO.pageIndex;
			var resultCnt = data[0].pagination.resultCnt;
			var totalPageCnt = data[0].totalPageCnt;
			var totalrecCnt = data[0].pagination.totalRecordCount;
			var recordCountPerPage = data[0].pagination.recordCountPerPage;
			var searchKeyword = submitObj.searchWrd;
			var searchCondition = submitObj.searchCondition;
			console.log(data[0]);
			
			
			var content = '';
			var content2 = '';

			var i = data[0].pagination.totalRecordCount - ((data[0].pagination.currentPageNo - 1) * data[0].pageVO.recordCountPerPage);
	
			var info = document.getElementById("info"); // 팝업창 문구
			info.innerHTML = '<span>' + totalrecCnt + '</span>';
			
            
            


			siBSDMF();
			for (var k = 0; k < data[0].busList.length; k++) {
				var checkString = data[0].busList[k].admin_nm;

			    // 정규표현식을 사용하여 문자열에 숫자가 있는지 확인
			    function hasNumber(str) {
			        return /\d/.test(str);
			    }

			    if (hasNumber(checkString)) {
			        console.log("문자열에 숫자가 포함되어 있습니다.");
			        var adminEx = checkString;
			        const stringWithoutComma = adminEx.replace(/,/g, '');

			        // 검색 결과를 저장할 배열
			        const foundItems = [];

			        // siBGDM2 배열을 순회하며 검색
			        for (let i = 0; i < siBGDM2.length; i++) {
			            const ldongCdValue = siBGDM2[i].ldongCd.slice(0, 8);
			            if(siBGDM2[i].ldongNm == '000'){
			            	
			            }
			            // ldongCd 값이 targetLdongCdValues 배열에 포함되어 있는지 확인
			            if (stringWithoutComma.includes(ldongCdValue)) {
			                //console.log(siBGDM2[i].ctprvnNm, siBGDM2[i].signguNm, siBGDM2[i].ldongNm);
			            	result[k].city_name = siBGDM2[i].signguNm;
			                result[k].admin_nm = siBGDM2[i].ctprvnNm + ' ' + siBGDM2[i].signguNm + ' ' + siBGDM2[i].ldongNm;
			                break;
			            }
			        }
			    } else {
			        console.log("문자열에 숫자가 포함되어 있지 않습니다.");
			    }

			    var nodeIdValue = result[k].node_id;
			    console.log(result[k]);
			    content += '<tr class="memList">'
				content += '<td align="center" class="no" style="font-weight: bold;">' + i + '</td>';
				content += '<td align="center" class="nodeId" id="nodeId">'+ result[k].node_id + '</td>';
				content += '<td align="center" class="nodeNm"  id="nodeNm" title='+result[k].node_nm+'>' + result[k].node_nm + '</td>';
				content += '<td align="center" class="gpsLati"  id="gpsLati" title='+result[k].gps_lati+'>' + result[k].gps_lati + '</td>';
				content += '<td align="center" class="gpsLong" id="gpsLong" title='+result[k].gps_long+'>' + result[k].gps_long + '</td>';
				content += '<td align="center" class="collectdTime" id="collectdTime" title='+result[k].collectd_time+'>' + result[k].collectd_time + '</td>';
				content += '<td align="center" class="nodeMobileId" id="nodeMobileId" title='+result[k].node_mobile_id+'>' + result[k].node_mobile_id + '</td>';
				content += '<td align="center" class="cityCd" id="cityCd" title='+result[k].city_cd+'>' + result[k].city_cd + '</td>';
				content += '<td align="center" class="cityName" id="cityName" title='+result[k].city_name+'>' + result[k].city_name + '</td>';
				content += '<td align="center" class="adminNm" id="adminNm" title='+result[k].admin_nm+'>' + result[k].admin_nm + '</td>';
				content += '<td align="center" class="tDate" id="tDate" title='+result[k].tdate+'>' + result[k].tdate + '</td>';
				content += '</tr>';
				
				i--;
			}
			content += '<input type="hidden" name="nodeId" id="nodeId" value="'+ nodeIdValue+'" />';
			$(".trTable").html(content);

			content2 = '<ol class="pagination" id="pagination">';
			content2 += '<input type="hidden" id="pageIndex" name="pageIndex" value="1">';
	
			if (pageVO.prev) {
				content2 += '<li class="prev_end"><a href="javascript:void(0);" onclick="link_page(1); return false;" ><<</a></li>';
				content2 += '<li class="prev_end"><a href="javascript:void(0);"  onclick="link_page('+ startButtonDate + '); return false;" ><</a></li>';
			}

			
			for (var num = startDate; num <= endDate; num++) {
				if (num == pageIndex) {
					content2 += '<li class="prev_end"><a href="javascript:void(0);" onclick="link_page('+ num + '); return false;" title="'+ num
							+ '"  class="num on" style="color:#557C55;">'
							+ num + '</a></li>';
				} else {
					content2 += '<li class="prev_end"><a href="javascript:void(0);" onclick="link_page('
							+ num
							+ '); return false;" title="'
							+ num
							+ '" class="num">' + num + '</a></li>';
				}
			}

			
			if (pageVO.next) {
				content2 += '<li class="prev_end"><a href="javascript:void(0);"  onclick="link_page('
						+ endButtonDate
						+ '); return false;" >></a></li>';
				content2 += '<li class="prev_end"><a href="javascript:void(0);" onclick="link_page('
						+ pageVO.realEnd
						+ '); return false;">>></a></li>';
			}
	
			content2 += '</ol>';
			content2 += '</div>';
	

			// 배경지도 선택 select
			initBaseLayerSelect(map); // 페이지 변경 시 지도 마커도 위치 변경
			map.addLayer(wmsLayer);
			wmsLayer.setVisible(true);

			$(".paging").html(content2);
	
		},
		error : function(error) {
			console.log("error");
		},
	})
};
// 좌표계 설정
initProj();

// 행정경계 on off 설정
function mapDicOnOff(){
	var t = document.getElementById("mapDicOnOff");
	if(t.innerHTML=="행정경계 켜기"){
		t.textContent = '행정경계 끄기';
		wmsLayer.setVisible(true);
	}
	else{
		t.textContent="행정경계 켜기";
		wmsLayer.setVisible(false);
	}
}

// 마커 클릭 끄고 등록 on off 설정
function markerOnOff(){
	var m = document.getElementById("markerOnOff");
	if(m.innerHTML=="마커 클릭 켜기"){
		m.textContent = '마커 클릭 끄기';
        map.on('click', handleMapClick);
	}
	else{
		m.textContent="마커 클릭 켜기";
        map.un('click', handleMapClick);
	}
}

// geoserver레이어 초기설정
var wmsSource = new ol.source.TileWMS({
	url: 'http://localhost:8090/geoserver/koreadistrict/wms',
	params: {
		'LAYERS' : 'koreadistrict:korea_district', 
		'VERSION' : '1.1.0',
		'STYLES' : '',
        'FORMAT': 'image/png',
		'BBOX' : '746110.2515145557,1458754.0441563274,1387947.6818815223,2068443.9546290115',
		'TILED': true
		},
	serverType : 'geoserver',
	crossOrigin : 'anonymous'
});
console.log("wmsSource : " , wmsSource);


var wmsLayer = new ol.layer.Tile({
	source : wmsSource,
	visible: true,
});

var view = new ol.View({
	center : ol.proj.transform([ 127.100616, 37.402142 ], 'EPSG:4326',
	'EPSG:3857'),
zoom : 9
});

// map 생성
var map = new ol.Map({
	target : 'map',
	layer : [wmsLayer],
	view : view,
	target : document.getElementById('map'),

});

// 지도
function init(pageNo) {

	$.ajax({
		url : "/BusStopList.do",
		dataType : 'json',
		data : {
			"x" : 127.93283035546874,
			"y" : 36.91140156558966
		},
		success : function(data) {
			map.addLayer(wmsLayer); // 지속해서 wms를 사용할 수 있도록 ajax에 위치.
			
		},
		error : function(error) {
			console.log("error" + error);
		},
	})

}

// 배경지도 레이어 추가
addBaseLayer(map);

// option으로 지도 선택
selectOptionMap(map);

// 좌표계(변환)
function initProj() {

	// google 좌표계
	proj4.defs('EPSG:4326', '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs');

	// UTM-K 좌표계
	proj4.defs('EPSG:5179','+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs');

	// 중부원점(GRS80) [200,000 500,000]
	proj4.defs('EPSG:5181','+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +units=m +no_defs');

	//
	proj4.defs('EPSG:5187','+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs');

	proj4.defs('EPSG:5186','+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs');
	proj4.defs('EPSG:5188','+proj=tmerc +lat_0=38 +lon_0=131 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs');

	// 현 지도 좌표체계
	proj4.defs([['EPSG:5179','+title=EPSG 5179 (long/lat) +proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs' ],
					['EPSG:5174','+title=EPSG 5174 (long/lat) +proj=tmerc +lat_0=38 +lon_0=127.0028902777778 +k=1 +x_0=200000 +y_0=500000 +ellps=bessel +units=m +no_defs +towgs84=-115.80,474.99,674.11,1.16,-2.31,-1.63,6.43' ] ])


}

// 구글좌표계
function addBaseLayer(map) {

	// ------------------------------
	// google layers

	// google road
	var googleRoadLayer = new ol.layer.Tile({
		source : new ol.source.XYZ({
			projection : 'EPSG:3857',
			url : 'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}',
			crossOrigin : 'anonymous'
		}),
		id : 'google_road',
		visible : false
	});
	map.addLayer(googleRoadLayer);

	// google terrain
	var googleTerrainLayer = new ol.layer.Tile({
		source : new ol.source.XYZ({
			projection : 'EPSG:3857',
			url : 'http://mt0.google.com/vt/lyrs=p&hl=en&x={x}&y={y}&z={z}',
			crossOrigin : 'anonymous'
		}),
		id : 'google_terrain',
		visible : false
	});
	map.addLayer(googleTerrainLayer);

	// google altered road
	var googleAlteredRoadLayer = new ol.layer.Tile({
		source : new ol.source.XYZ({
			projection : 'EPSG:3857',
			url : 'http://mt0.google.com/vt/lyrs=r&hl=en&x={x}&y={y}&z={z}',
			crossOrigin : 'anonymous'
		}),
		id : 'google_altered_road',
		visible : false
	});
	map.addLayer(googleAlteredRoadLayer);

	// google satellite
	var googleSatelliteLayer = new ol.layer.Tile({
		source : new ol.source.XYZ({
			projection : 'EPSG:3857',
			url : 'http://mt0.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}',
			crossOrigin : 'anonymous'
		}),
		id : 'google_satellite',
		visible : false
	});
	map.addLayer(googleSatelliteLayer);

	// google terrain only
	var googleTerrainOnlyLayer = new ol.layer.Tile({
		source : new ol.source.XYZ({
			projection : 'EPSG:3857',
			url : 'http://mt0.google.com/vt/lyrs=t&hl=en&x={x}&y={y}&z={z}',
			crossOrigin : 'anonymous'
		}),
		id : 'google_terrain_only',
		visible : false
	});
	map.addLayer(googleTerrainOnlyLayer);

	// google hybrid
	var googleHybridLayer = new ol.layer.Tile({
		source : new ol.source.XYZ({
			projection : 'EPSG:3857',
			url : 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}',
			crossOrigin : 'anonymous'
		}),
		id : 'google_hybrid',
		visible : false
	});
	map.addLayer(googleHybridLayer);

}

// 지도 선택(select - option)
function selectOptionMap(map) {

	// add select option
	var html = '';
	$.each(map.getLayers().getArray(), function(i, v) {
		html += '<option value="' + v.get('id') + '">' + v.get('id')
				+ '</option>';
	});
	$('#baseLayer').append(html);

}
function addMarkerMulti(map) {

	// 게시판 데이터를 Element로 가져오기
	var eleNodeId = document.getElementsByClassName('nodeId');
	var eleNodeNm = document.getElementsByClassName('nodeNm');
	var eleGpsLati = document.getElementsByClassName('gpsLati');
	var eleGpsLong = document.getElementsByClassName('gpsLong');
	var eleCityCd = document.getElementsByClassName('cityCd');
	var eleCityName = document.getElementsByClassName('cityName');
	var eleAdminNm = document.getElementsByClassName('adminNm');
	var eleTdate = document.getElementsByClassName('tDate');

	var data = [];
	var dataNm = [];
	var dataId = [];
	var llati;
	var llong;
	var llId;
	var lnodeNm;
	
	const dataObj = [];
	
	var cnt = document.getElementsByClassName('trTable')[0]
			.getElementsByTagName('tr');
	for (var i = 0; i < cnt.length; i++) {
		llati = Number(eleGpsLati[i].innerText);
		llong = Number(eleGpsLong[i].innerText);
		llId = eleNodeId[i].innerText;
		lnodeNm = eleNodeNm[i].innerText;
		data.push([ llong, llati ]);
		dataNm.push(lnodeNm);
		dataId.push(llId);
	}
	
	for (var i = 0; i < cnt.length; i++) {
		  var llId = eleNodeId[i].innerText;
		  var lnodeNm = eleNodeNm[i].innerText;
		  var llati = Number(eleGpsLati[i].innerText);
		  var llong = Number(eleGpsLong[i].innerText);
		  var lcityCd = eleCityCd[i].innerText;
		  var lcityName = eleCityName[i].innerText;
		  var ladminNm = eleAdminNm[i].innerText;
		  var ltDate = eleTdate[i].innerText;

		  dataObj.push({llId,lnodeNm,llati,llong,lcityCd,lcityName,ladminNm,ltDate});
	}
	
	var markerSource = new ol.source.Vector();
	for (var i = 0; i < data.length; i++) {
		var point_feature = new ol.Feature({
			geometry : new ol.geom.Point(data[i]).transform('EPSG:4326',
					'EPSG:3857'),
			name : dataObj[i].lnodeNm,
			id : dataObj[i].llId,
			dataObj : dataObj[i]

		});
		// addFeature로 markerSource에 등록한 point를 담는다.
		markerSource.addFeature(point_feature);


		// point의 style을 변경
		var markerStyle = new ol.style.Style({
			image : new ol.style.Icon({ // 마커 이미지
				opacity : 1, // 투명도 1=100%
				scale : 0.089, // 크기 1=100%

				// marker 이미지, 해당 point를 marker로 변경한다.
				src : '/css/busstop/marker.png?ver=1'
			}),
			// html의 css, z-index 기능이다.
			zindex : 10
		});

		// 마커 레이어 생성
		markerLayer = new ol.layer.Vector({
			source : markerSource, // 마커 feacture들
			style : markerStyle
		// 마커 스타일
		});


		// 지도에 마커가 그려진 레이어 추가
		map.addLayer(markerLayer);
		
		}
}



function initBaseLayerSelect(map) {
	// select event
	$('#baseLayer').change(function() {
		var layerId = $(this).val();
		$.each(map.getLayers().getArray(), function(i, v) {
			if (layerId == v.get('id')) {
				v.setVisible(true);
				//addMarker(map); //초기위치
				addMarkerMulti(map); //정류장 마커 위치

			} else {
				v.setVisible(false);
			}
		});

	});

	// 마커 위 popup
	var container = document.getElementById('popup'); // 팝업창
	var content = document.getElementById("popup-content"); // 팝업창 문구


	// 클릭 시, 현재 위치의 정보를 DB에 저장하기
	map.on("dblclick",function(e){
			var coordinate = e.coordinate;

			// 좌표계 변환
			var wgs84 = proj4('EPSG:3857','EPSG:4326', [ coordinate[0],coordinate[1] ]);

			var pre_Lati = wgs84[1]; // 위도
			var pre_Long = wgs84[0]; // 경도
			
			var frm = document.frmPopup;
			var url = "/insertBusstop.do";
			var title = "testpop";
			var status = "toolbar=no, width=700, height=660, directories=no, status=no,    resizable=no";
			window.open("", title, status);

			frm.target = title;
			frm.action = url;
			frm.gpsLati.value = pre_Lati;
			frm.gpsLong.value = pre_Long;
			frm.method = "post";
			frm.submit();
	})
	map.on("dblclick",function(e) {
		if (map.hasFeatureAtPixel(e.pixel)) {

			const feature = map.forEachFeatureAtPixel(e.pixel,function(feature, layer) {
				if (layer !== null) {
					return feature;
				}
			});

				if (feature) {
					var geometry = feature.getGeometry();

					const dataObj = feature.get('dataObj');
					console.log(dataObj);
					content.innerHTML = '<div>' + dataObj.llId + '</div>';
					content.innerHTML += '<div>' + dataObj.lnodeNm + '</div>';
					
				
				var coordinate = e.coordinate;
				overlay.setPosition(coordinate);
				
				// 좌표계 변환
				var wgs84 = proj4('EPSG:3857','EPSG:4326', [ coordinate[0],coordinate[1] ]);

				var frm = document.frmPopup;
				frm.nodeId.value = dataObj.llId;
				
				var url = "/updateBusView.do";
				var title = "testpop";
				var status = "toolbar=no, width=700, height=660, directories=no, status=no,    scrollorbars=no, resizable=no";
				window.open("", title, status);
				frm.target = title;
				frm.action = url;
				frm.method = "post";
				frm.submit();
				//const target = document.querySelector('#map');
				//const listenerList = getEventListeners( target );
				//target.removeEventListener('click', listenerList.click[1].listener );
				}
			
		} else {
			
		}
	});
	
	var hover = null;
	
	//특정 함수가 여러번 반복 실행될 경우, 정해진 지연시간동안 반복된 호출을 마지막에 딱 1번만 호출하도록 제어
	//호출하고자 하는 함수를 첫 번째 인자로 넣고 지연시간 을 두 번째 인자로 넣음.
	var debouncedHover = _.debounce(function(evt) {
	  map.getTargetElement().style.cursor = map.hasFeatureAtPixel(evt.pixel) ? 'pointer' : '';

	  //hover 시 팝업창 문구
	  var hoverContent = document.getElementById("popup-Hover-content"); // 팝업창 문구
	  var hoverFeature = map.forEachFeatureAtPixel(evt.pixel, function (feature) {
          return feature;
      });
	  if (hoverFeature) {
		  var dataObj = hoverFeature.get('dataObj');
		  const point = `${dataObj.llong},${dataObj.llati}`;
	  		//좌표 -> 주소 얻기
	  		$.ajax({
	  		    url: "https://api.vworld.kr/req/address?",
	  		    type: "GET",
	  		    dataType: 'jsonp',
	  		    data: {
	  		        service: "address",
	  		        request: "getaddress",
	  		        version: "2.0",
	  		        crs: "EPSG:4326",
	  		        type: "BOTH",
	  		        point: point,
	  		        format: "json",
	  		        errorformat: "json",
	  		        key: "ED44681F-5399-33EF-BD09-94203C9E7C94",
	  		    },
	  		    success: function(result) {
	  		    	hoverContent.innerHTML = '<span>' + dataObj.lnodeNm + ' [' + result.response.result[0].text + ']' +  '</span>';
	  		    },
	  		    error: function(error) {
	  		        console.log("error");
	  		    },
	  		});
      } else {
          hoverContent.innerHTML = '';
      }
	  
	  //hover 시 pointer효과
	  if (hover !== null) {
	    if(hover.get('index') == '001'){
	      hover.setStyle(createStyle('/css/busstop/marker.png?ver=1'));
	      console.log('Hover 효과 해제');
	    }    
	    hover = null;
	  }  
	  map.forEachFeatureAtPixel(evt.pixel, function(f) {
	    hover = f;
	    return true;
	  });
	  if(hover){
	    if(hover.get('index')  == '001'){
	      console.log('Hover 효과');
	      hover.setStyle(createStyle('/css/busstop/marker.png?ver=1'));
	    }
	  }
	}, 100);
	map.on('pointermove', debouncedHover);

	var overlay = new ol.Overlay({
		element : container,
		autoPan : true,
		autoPanAnimation : {
			duration : 250
		},
		offset : [ 1, -30 ]
	});

	map.addOverlay(overlay);
	// 초기값
	$('#baseLayer').val('google_road').trigger('change');

}


// 초기 위치 기본 마커
/*function addMarker(map) {
	var markerSource = new ol.source.Vector();
	var point_feature = new ol.Feature({
		geometry : new ol.geom.Point([ 126.95659953, 37.578220423 ]).transform(
				'EPSG:4326', 'EPSG:3857'),
		id : "초기 위치"
	});

	// markerSource에 등록한 point를 담는다. addFeature를 이용해서, 여러개의 point를 source에 담는다.
	markerSource.addFeature(point_feature);

	// style을 활용해서, point의 style을 변경한다.
	var markerStyle = new ol.style.Style({
		image : new ol.style.Icon({ // 마커 이미지
			opacity : 1, // 투명도 1=100%
			scale : 0.1, // 크기 1=100%

			// marker 이미지, 해당 point를 marker로 변경한다.
			src : '/css/busstop/marker.png?ver=1'
		}),
		zindex : 10
	});

	// 마커 레이어 생성
	markerLayer = new ol.layer.Vector({
		source : markerSource, // 마커 feacture들
		style : markerStyle // 마커 스타일
	});

	// 지도에 마커가 그려진 레이어 추가
	map.addLayer(markerLayer);


}*/

function getFeatureInfo(url) {
  return new Promise((resolve, reject) => {
    fetch(url)
      .then(response => response.json())
      .then(jsonResponse => resolve(jsonResponse))
      .catch(error => reject(error));
  });
}


var koreaDic; // 응답(response)변수 저장
map.on ('click',function(e) { 

	console.log("click");
	
    var viewResolution =  /** @type {number} */ (view.getResolution());
    var url = wmsSource.getGetFeatureInfoUrl(
        e.coordinate,
        viewResolution,
        'EPSG:3857',
        { 'INFO_FORMAT': 'application/json', 'FEATURE_COUNT': 1}
    );
	
    if (url) {
    	getFeatureInfo(url)
    	.then(jsonResponse => {
            koreaDic = jsonResponse.features[0];
//            console.log(koreaDic);
            const koreaDicProp = koreaDic.properties;
            const koreaDic_SigCd = koreaDicProp[Object.keys(koreaDicProp)[0]];
            const koreaDic_SigKorNm = koreaDic.id.split('.')[1]; // id값
// console.log(koreaDic_SigCd);
// console.log(koreaDic_SigKorNm);

        	// 검색 키워드를 도시명으로 설정(변경)
        	searchCondition = $("#searchCondition").val(1).prop("selected",true);
        	// 검색창에 koreaDic_SigKorNm 값을 설정
        	searchKeyword = $("#searchKeyword").val(koreaDicProp[Object.keys(koreaDicProp)[2]]);
            link_page(1, searchCondition, searchKeyword);
          })
          .catch(error => console.error(error));
    }
//    console.log(koreaDic);
    e.stopPropagation();
    
    // wmsSource.updateParams({ 'CQL_FILTER': `[sig_cd= ${koreaDic_SigCd}]` });
	// 클릭한 행정구역만 필터링하기

    //행정경계 별 클릭 위치 주소 역지오코딩
	var geoContent = document.getElementById("geoCoding-content"); // 팝업창 문구
	
	//클릭 시, 브이월크 역지오 코딩 API 좌표 -> 주소 얻기
	var coordinate = e.coordinate;
	// 좌표계 변환
	var wgs84 = proj4('EPSG:3857','EPSG:4326', [ coordinate[0],coordinate[1] ]);

	var pre_Lati = wgs84[1]; // 위도
	var pre_Long = wgs84[0]; // 경도
    
	const point = `${pre_Long},${pre_Lati}`;
//	console.log(point);
	
	//좌표 -> 주소 얻기
	$.ajax({
	    url: "https://api.vworld.kr/req/address?",
	    type: "GET",
	    dataType: 'jsonp',
	    data: {
	        service: "address",
	        request: "getaddress",
	        version: "2.0",
	        crs: "EPSG:4326",
	        type: "BOTH",
	        point: point,
	        format: "json",
	        errorformat: "json",
	        key: "ED44681F-5399-33EF-BD09-94203C9E7C94",
	    },
	    success: function(result) {
//	    	console.log(result.response.result[0].text);
	    	geoContent.innerHTML = '<span>' + result.response.result[0].text + '</span>';
//	        console.log(result);
	    },
	    error: function(error) {
	        console.log("error");
	    },
	});

});