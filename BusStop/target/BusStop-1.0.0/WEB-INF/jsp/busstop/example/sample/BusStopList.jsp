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
</style>

</head>

<body>
	<div id="title">
		<h2>
			<a href="/BusStopList.do"> <spring:message code="title.busstop.header" /></a>
		</h2>
	</div>
	<main id="section-Box"> <section id="section-table"> <c:out value="${mapList}" /> <form:form commandName="pageVO" id="listForm2" name="listForm2">
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
				검색 건 수 : <span id="info"><c:out value="${pageVO.totCnt}" /></span>
			</div>
			
		</div>
		<div id="table-Box">
			<table id="table">
				<colgroup>
					<col width="50" />
					<col width="150" />
					<col width="200" />
					<col width="100" />
					<col width="120" />
					<col width="80" />
					<col width="80" />
					<col width="70" />
					<col width="100" />
					<col width="200" />
					<col width="110" />
				</colgroup>
				<thead>
					<tr>
						<th style="border-radius: 20px 0 0 0;">No</th>
						<th><spring:message code="title.busstop.nodeId" /></th>
						<th><spring:message code="title.busstop.nodeNm" /></th>
						<th><spring:message code="title.busstop.gpsLati" /></th>
						<th><spring:message code="title.busstop.gpsLong" /></th>
						<th><spring:message code="title.busstop.collectdTime" /></th>
						<th><spring:message code="title.busstop.nodeMobileId" /></th>
						<th><spring:message code="title.busstop.cityCd" /></th>
						<th><spring:message code="title.busstop.cityName" /></th>
						<th><spring:message code="title.busstop.adminNm" /></th>
						<th style="border-radius: 0 20px 0 0;"><spring:message code="title.busstop.tDate" /></th>
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
							<td align="center" class="collectdTime listtd" id="collectdTime"><c:out value="${busList.collectd_time}" /></td>
							<td align="center" class="nodeMobileId listtd" id="nodeMobileId"><c:out value="${busList.node_mobile_id}" /></td>
							<td align="center" class="cityCd listtd" id="cityCd"><c:out value="${busList.city_cd}" /></td>
							<td align="center" class="cityName listtd" id="cityName"><c:out value="${busList.city_name}" /></td>
							<td align="center" class="adminNm listtd" id="adminNm"><c:out value="${busList.admin_nm}" /></td>
							<td align="center" class="tDate listtd" id="tDate"><c:out value="${busList.tdate}" /></td>
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
	</form:form> </section>
	<section></section> <section id="section-map">
	<form name="frmPopup" method="post">
		<input type="hidden" name="nodeId" value="" /> <input type="hidden" name="nodeNm" value="" /> <input type="hidden" name="gpsLati" value="" /> <input type="hidden" name="gpsLong" value="" /> <input
			type="hidden" name="collectdTime" value="" /> <input type="hidden" name="nodeMobileId" value="" /> <input type="hidden" name="cityCd" value="" /> <input type="hidden" name="cityName" value="" />
		<input type="hidden" name="adminNm" value="" /> <input type="hidden" name="tDate" value="" />
	</form>

	<div id="map" class="map">
		<select id="baseLayer"></select>
		<button onclick="mapDicOnOff()" id="mapDicOnOff" class="mapDicOnOff">행정경계 끄기</button>
		<div id="mapContent">
			행정경계 별 버스정류장 위치 검색은 단일 클릭, 버스정류장 위치 등록은 더블클릭을 하세요.<br />단일 클릭 시, 클릭 위치의 지번주소가 표시됩니다.
		</div>
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
	</section> </main>
</body>

</html>