<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title style="text-align:center;"><spring:message code="title.busstop" /></title>
<link rel="icon" href="#?ver=1" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/busstop.css?ver=1'/>" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/ol.css?ver=1'/>" />
<!--<script src="<c:url value='/css/busstop/ol.js?ver=1'/>"></script> -->
<script src="<c:url value='/css/busstop/proj4.js?ver=1'/>"></script>
<script src="https://openlayers.org/en/v3.20.1/build/ol.js?ver=1" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js?ver=1"></script>
<script defer="defer" src="/js/busstop/busstop.js?ver=1"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js?ver=1"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js?ver=1"></script>
<style>
.page_tag {
	margin: 0 5px;
}

.pagination {
	display: inlie-block;
	margin-top: 20px;
}

.pagination li {
	display: inline;
	margin: 0 10px;
}

.pagination li a {
	text-decoration-line: none;
}

.pagination li a:hover {
	text-decoration-line: underline;
}
#toggleDiv{
	right: 4rem;
    top: 2rem;
    backgroun-color: white;
    border: 0;
    position: absolute;
}
.toggleSwitch {
	width: 50px;
    height: 25px;
    display: block;
    position: relative;
    border-radius: 30px;
    background-color: #fff;
    box-shadow: 0 0 16px 3px rgba(0 0 0 / 15%);
    cursor: pointer;
}

.toggleSwitch .toggleButton {
    width: 20px;
    height: 20px;
    position: absolute;
    top: 50%;
    left: 5px;
    transform: translateY(-50%);
    border-radius: 50%;
    background: #7ab96e;
}


#toggle:checked ~ .toggleSwitch .toggleButton {
  left: calc(100% - 24px);
  background: #1e4117;
}

.toggleSwitch, .toggleButton {
  transition: all 0.2s ease-in;
}
</style>

</head>

<body>
	<main id="section-Box"> 
	<section style="width:200px;">
		<div id="title">
			<div id="title-busStop">
				<div class="img"></div>
				<a href="/"><div class="text">Bus Stop</div></a>
			</div>
			<div style="border-bottom: 1px solid gray; margin: 1rem 0 0 0.5rem; "></div>
			
			<div id="clickChart-table">
				<div class="img"></div>
				<div class="text">Table</div>
			</div>
			<div id="clickChart">
				<div class="img"></div>
				<div class="text">Bar</div>
			</div>
		</div>
		
	</section>
	<section id="section-table"> <c:out value="${mapList}" /> <form:form commandName="pageVO" id="listForm2" name="listForm2">
		
		<div class="table-title" style="margin-top: 2rem;">
			<spring:message code="title.busstop.header" />
		</div>
		<div id="search">
			<div class="searchSelect">
				<label for="searchCondition" style="visibility: hidden;"></label>
				<form:select path="searchCondition" cssClass="txt">
					<form:option value="${1}" label="정류장 명칭" id="node_nm" />
					<form:option value="${2}" label="도시명" id="city_name" />
				</form:select>
			</div>
			<label for="searchKeyword" style="visibility: hidden; display: none;"></label>
			<div>
				<form:input path="searchKeyword" cssClass="txt" value="${pageVO.searchKeyword}" id="searchKeyword" onkeypress="if(event.keyCode=='13'){event.preventDefault(); searchEvt();}" />
			</div>
			<div id="searchButton">
				<button type="button" id="searchBtn">
					<spring:message code="button.search" />
				</button>
			</div>
			<div id="searchRec">
				총 건수 : <span id="info"><c:out value="${pageVO.totCnt}" /></span>
			</div>
			
		</div>
		<div id="table-Box">
			<table id="table">
				<colgroup>
					<col width="50" />
					<col width="200" />
					<col width="200" />
					<col width="200" />
					<col width="200" />
					<col width="400"  colspan="2"/>
				</colgroup>
				<thead>
					<tr>
						<th style="border-radius: 20px 0 0 0;">No</th>
						<th><spring:message code="title.busstop.nodeId" /></th>
						<th><spring:message code="title.busstop.nodeNm" /></th>
						<th><spring:message code="title.busstop.gpsLati" /></th>
						<th><spring:message code="title.busstop.gpsLong" /></th>
						<th style="border-radius: 0 20px 0 0;" colspan="2"></th>
					</tr>
				</thead>

				<tbody class="trTable">
					<c:set var="num" value="${pagination.totalRecordCount - ((pagination.currentPageNo-1) * 10)}" />
					<c:forEach var="busList" items="${busList}" varStatus="sts">
						<tr>
							<td align="center" class="no" style="font-weight: bold;"><c:out value="${num}" /></td>
							<td align="center" class="nodeId" id="nodeId" title="nodeId"><c:out value="${busList.node_id}" /></td>
							<td align="center" class="nodeNm" id="nodeNm"><c:out value="${busList.node_nm}" /></td>
							<td align="center" class="gpsLati" id="gpsLati" titld="gpsLati"><c:out value="${busList.gps_lati}" /></td>
							<td align="center" class="gpsLong" id="gpsLong"><c:out value="${busList.gps_long}" /></td>
							<td style="display: none;" align="center" class="collectdTime listtd" id="collectdTime"><c:out value="${busList.collectd_time}" /></td>
							<td style="display: none;" align="center" class="nodeMobileId listtd" id="nodeMobileId"><c:out value="${busList.node_mobile_id}" /></td>
							<td style="display: none;" align="center" class="cityCd listtd" id="cityCd"><c:out value="${busList.city_cd}" /></td>
							<td style="display: none;" align="center" class="cityName listtd" id="cityName"><c:out value="${busList.city_name}" /></td>
							<td style="display: none;" align="center" class="adminNm listtd" id="adminNm"><c:out value="${busList.admin_nm}" /></td>
							<td style="display: none;" align="center" class="tDate listtd" id="tDate"><c:out value="${busList.tdate}" /></td>
							<td align="center" class="toggleBottom listtd" id="toggleBottom"></td>
						</tr>
						<c:set var="num" value="${num-1 }" />
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="paging fr">
			<c:set var="pageIndex" value="1" />
			<ol class="pagination" id="pagination">
				<c:if test="${pageVO.prev}">
					<li class="page_tag"><a href="javascript:void(0);" onclick="link_page(1); return false;"><<</a></li>
					<li class="page_tag"><a href="javascript:void(0);" onclick="link_page(${pageVO.startDate - 1}); return false;"><</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageVO.startDate}" end="${pageVO.endDate}">
					<li class="page_tag"><a href="javascript:void(0);" onclick="link_page(${num}); return false;" class="num ${pageIndex eq num ? 'on':'' }" title="${num}">${num}</a></li>
				</c:forEach>
				<c:if test="${pageVO.next}">
					<li class="page_tag"><a href="javascript:void(0);" onclick="link_page(${pageVO.endDate + 1}); return false;">></a></li>
					<li class="page_tag"><a href="javascript:void(0);" onclick="link_page(${pageVO.realEnd }); return false;">>></a></li>
				</c:if>
				<li class="page_tag"><a href="javascript:void(0);" onclick="link_page(11); return false;">></a></li>
				<li class="page_tag"><a href="javascript:void(0);" onclick="link_page(${pageVO.realEnd }); return false;">>></a></li>

			</ol>
		</div>
		
		<div class="table-title" >
			정류소 별 경유노선 목록 조회
		</div>
		<div id="table-Box-busTransit">
			<table id="table">
				<colgroup>
					<col width="50" />
					<col width="150" />
					<col width="200" />
					<col width="200" />
					<col width="150" />
					<col width="150" />
				</colgroup>
				<thead>
					<tr>
						<th style="border-radius: 20px 0 0 0;">No</th>
						<th>노선ID</th>
						<th>노선번호</th>
						<th>노선유형</th>
						<th>종점</th>
						<th style="border-radius: 0 20px 0 0;">기점</th>
					</tr>
				</thead>
			
			
				<tbody class="trTablebusTransit">
					<c:set var="num"/>
					<c:forEach var="busList" items="${busList}" varStatus="sts">
						<tr>
							<td align="center" class="no" style="font-weight: bold;"></td>
							<td align="center" class="nodeId" id="nodeId" title="nodeId"></td>
							<td align="center" class="nodeNm" id="nodeNm"></td>
							<td align="center" class="gpsLati" id="gpsLati" titld="gpsLati"></td>
							<td align="center" class="gpsLong" id="gpsLong"></td>
							<td align="center" class="collectdTime listtd" id="collectdTime"></td>
							</tr>
						<c:set var="num" value="${num-1 }" />
					</c:forEach>
				</tbody>
			</table>
		</div>
	</form:form> 
	</section>
	<div id="section-chart">
		<div id="toggleDiv">
			 <input type="checkbox" id="toggle" hidden> 

			<label title="전국 버스정류장 위치 개수 table 열기" id="toggleSwitch" for="toggle" class="toggleSwitch" style="margin-left: 1rem;">
			  <span class="toggleButton"></span>
			</label>
		</div>
		<div class="chart">
		  <canvas id="myChart"  width="400" height="400" style="margin-top:3rem;"></canvas>
			
			<canvas id="doughnut-chart" width="300" height="300" style="margin-top:3rem;"></canvas>
		</div>
		
		<div id="chartTableDiv">
			<table id="chartTable">
				<tr>
						<th>No</th>
						<th>도시명</th>
						<th>도시코드</th>
						<th>개수</th>
					</tr>
			</table>
		</div>
	</div>
	<div id="section-chart-doughnut" style="display: none;">
		<button id="parkPannel-close-doughnut"></button>
	</div>
	<section id="section-map">
	<form name="frmPopup" method="post">
		<input type="hidden" name="nodeId" value="" /> <input type="hidden" name="nodeNm" value="" /> <input type="hidden" name="gpsLati" value="" /> <input type="hidden" name="gpsLong" value="" /> <input
			type="hidden" name="collectdTime" value="" /> <input type="hidden" name="nodeMobileId" value="" /> <input type="hidden" name="cityCd" value="" /> <input type="hidden" name="cityName" value="" />
		<input type="hidden" name="adminNm" value="" /> <input type="hidden" name="tDate" value="" />
	</form>

	<div id="map" class="map">
		<select id="baseLayer"></select>
		<button onclick="mapDicOnOff()" id="mapDicOnOff" class="mapDicOnOff" title="행정경계 on/off">행정경계 끄기</button>
		<button onclick="move()" id="moveOnOff" class="moveOnOff" title="마커있는 곳으로 시점 이동">마커 위치로 시점 이동</button>
		<div  id="dragONOff" class="dragONOff" title="지도 클릭 - [마커 옮기지않기]모드 - 이동 위치 선택 - 수정하기">드래그 on</div>
		
		<div id="mapContent" title="지도 설명"></div>
		<div id="mapContent-text" style="display: none;">
			<p style="font-weight: 800;">지도를 클릭해보세요</p>
			[단일 클릭] 행정경계 별 버스정류장 위치 검색 <br/>
			[더블 클릭] 버스정류장 위치 등록 <br/>
			[마커 마우스오버] 버스정류장 위치  <br/> <br/>
			마커 옮기기모드<br/>
			[마커 단일 클릭]-[타 위치 클릭]-[수정하기 버튼] 버스정류장 위치 수정<br/><br/>
			[마커 더블 클릭] 버스정류장 위치 수정 <br/>
		</div>
		<button onclick="markerON()" id="markerONOff" class="markerONOff" title="지도 클릭 - [마커 옮기지않기]모드 - 이동 위치 선택 - 수정하기">마커 옮기기</button>
		<br/><span style="font-size:11px;">지도 클릭(이동 할 마커) - [마커 옮기지않기]모드 - 마커 단일클릭 - 타 위치 단일클릭- 수정하기</span>
	</div>
	<div id="popup" class="ol-popup">
		<div id="popup-content"></div>
	</div>
	
	<div id="geoCoding">
		행정경계 별 클릭 위치 주소 : <span id="geoCoding-content"></span>
		</div>
		<div id="geoCoding">
			버스정류장 위치 :
			<span id="popup-Hover-content"></span>
		</div>
		<div id="main-modifyBtnBox" style="display:none;">
			<a id="modifyBtn" href="javascript:busstop_edit_btn();">수정하기</a> <a id="deleteBtn" href="javascript:busstop_delete();">삭제하기</a>
		</div>
	</section> 
	
	</main>
	
</body>

</html>