<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title.busstop" /></title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/busstop.css'/>" />
<script type="text/javaScript" language="javascript" defer="defer">
	/* 글 수정 화면 function */
	function fn_egov_select(id) {
		document.listForm.selectedId.value = id;
		document.listForm.action = "<c:url value='/updateBusView.do'/>";
		document.listForm.submit();
	}

	/* 글 등록 화면 function */
	function fn_egov_addView() {
		document.listForm.action = "<c:url value='/addBusStopList.do'/>";
		document.listForm.submit();
	}

	/* 글 목록 화면 function */
	function fn_egov_selectList() {
		document.listForm.action = "<c:url value='/BusStopList.do'/>";
		document.listForm.submit();
	}

	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/BusStopList.do'/>";
		document.listForm.submit();
	}
</script>
</head>

<body style="text-align: center; margin: 0 auto; display: inline; padding-top: 100px;">
	<form:form commandName="busSearchVO" id="listForm" name="listForm" >
		<input type="hidden" name="selectedId" />
		<div id="content_pop">
			<!-- 타이틀 -->
			<div id="title">
				<ul>
					<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt="" /> <spring:message code="title.busstop.header" /></li>
				</ul>
			</div>
			<!-- // 타이틀 -->
			<div id="search">
				<ul>
					<li><label for="searchCondition" style="visibility: hidden;"><spring:message code="search.choose" /></label> <form:select path="searchCondition" cssClass="use" id='select'>
							<form:option value="0" label="정류장 명칭" id="node_nm" />
							<form:option value="1" label="도시명" id="city_name" />
						</form:select></li>
					<script type="text/javaScript" language="javascript" defer="defer">
						console.log(document.getElementById('select').value);
					</script>
					<li><label for="searchKeyword" style="visibility: hidden; display: none;"><spring:message code="search.keyword" /></label> <form:input path="searchKeyword" cssClass="txt" /></li>
					<li><span class="btn_blue_l"> <a href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a> <img
							src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left: 6px;" alt="" />
					</span></li>
				</ul>
			</div>
			<!-- List -->
			<div id="table">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="정류장 ID, 정류장 명칭, GPS 위도, GPS 경도, 정보 수집 일시, 모바일/단축ID, 도시코드, 도시명, 관리도시명, 등록일">
					<caption style="visibility: hidden">정류장 ID, 정류장 명칭, GPS 위도, GPS 경도, 정보 수집 일시, 모바일/단축ID, 도시코드, 도시명, 관리도시명, 등록일</caption>
					<colgroup>
						<col width="50" />
						<col width="100" />
						<col width="130" />
						<col width="130" />
						<col width="130" />
						<col width="130" />
						<col width="70" />
						<col width="70" />
						<col width="50" />
						<col width="50" />
						<col width="70" />
					</colgroup>
					<tr>
						<th align="center">No</th>
						<th align="center"><spring:message code="title.busstop.nodeId" /></th>
						<th align="center"><spring:message code="title.busstop.nodeNm" /></th>
						<th align="center"><spring:message code="title.busstop.gpsLati" /></th>
						<th align="center"><spring:message code="title.busstop.gpsLong" /></th>
						<th align="center"><spring:message code="title.busstop.collectdTime" /></th>
						<th align="center"><spring:message code="title.busstop.nodeMobileId" /></th>
						<th align="center"><spring:message code="title.busstop.cityCd" /></th>
						<th align="center"><spring:message code="title.busstop.cityName" /></th>
						<th align="center"><spring:message code="title.busstop.adminNm" /></th>
						<th align="center"><spring:message code="title.busstop.tDate" /></th>
					</tr>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr class="memList">
							<td align="center" class="listtd"><c:out value="${((busSearchVO.pageIndex-1) * busSearchVO.pageSize + status.count)}" /></td>
							<td align="center" class="listtd"><a href="javascript:fn_egov_select(<c:out value="${result.nodeId}"/>)"><c:out value="${result.nodeId}" /></a></td>
							<td align="center" class="listtd"><c:out value="${result.nodeNm}" /></td>
							<td align="center" class="listtd"><c:out value="${result.gpsLati}" /></td>
							<td align="center" class="listtd"><c:out value="${result.gpsLong}" /></td>
							<td align="center" class="listtd"><c:out value="${result.collectdTime}" /></td>
							<td align="center" class="listtd"><c:out value="${result.nodeMobileId}" /></td>
							<td align="center" class="listtd"><c:out value="${result.cityCd}" /></td>
							<td align="center" class="listtd"><c:out value="${result.cityName}" /></td>
							<td align="center" class="listtd"><c:out value="${result.adminNm}" /></td>
							<td align="center" class="listtd"><c:out value="${result.tdate}" /></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<!-- /List -->
			<div id="paging">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
				<form:hidden path="pageIndex" />
			</div>
			<div id="sysbtn">
				<ul>
					<li><span class="btn_blue_l"> <a href="javascript:fn_egov_addView();"><spring:message code="button.create" /></a> <img
							src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left: 6px;" alt="" />
					</span></li>
				</ul>
			</div>
		</div>
	</form:form>
</body>
</html>
