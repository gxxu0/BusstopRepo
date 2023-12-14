<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<c:set var="registerFlag" value="${empty busVO.nodeId ? 'create' : 'modify'}" />
<title>Bus <c:if test="${registerFlag == 'create'}">
<spring:message code="button.create" />
	</c:if> <c:if test="${registerFlag == 'modify'}">
		<spring:message code="button.modify" />
	</c:if>
</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>" />

<script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
<validator:javascript formName="busVO" staticJavascript="false" xhtml="true" cdata="false" />
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
        /*글 목록*/
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/BusStopList.do'/>";
           	document.detailForm.submit();
        }
        
        /*글 삭제 */
        function fn_egov_delete() {
           	document.detailForm.action = "<c:url value='/deleteBusStop.do'/>";
           	document.detailForm.submit();
        }
        
        /*글 등록*/
        function fn_egov_save() {
        	frm = document.detailForm;
        	console.log(document.detailForm);
        	if(!validateBusVO(frm)){
                return;
            }else{
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addBusStopList.do' : '/BusStopList.do'}"/>";
                frm.submit();
            }
        }
    </script>
</head>

<body style=" margin: 20px auto; display: inline; padding-top: 100px;">
	<ul>
		<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt="" /> <a href="<c:url value='/BusStopList.do'/>"><spring:message code="title.busstop.header" /></a></li>
	</ul>
	<form:form commandName="busVO" id="detailForm" name="detailForm">
		<div id="content_pop">
			<!-- 타이틀 -->
			<div id="title">
				<ul>
					<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt="" /> <c:if test="${registerFlag == 'create'}">
							<spring:message code="button.create" />
						</c:if> <c:if test="${registerFlag == 'modify'}">
							<spring:message code="button.modify" />
						</c:if></li>
				</ul>
			</div>
			<!-- // 타이틀 -->
			<div id="table">
				<table width="100%" border="1" cellpadding="0" cellspacing="0"
					style="bordercolor: #D3E2EC; bordercolordark: #FFFFFF; BORDER-TOP: #C2D0DB 2px solid; BORDER-LEFT: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; BORDER-BOTTOM: #C2D0DB 1px solid; border-collapse: collapse;">
					<colgroup>
						<col width="150" />
						<col width="?" />
					</colgroup>
					<c:if test="${registerFlag == 'modify'}">
						
					</c:if>
					<tr>
    			<td class="tbtd_caption"><label for="nodeId"><spring:message code="title.busstop.nodeId" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="nodeId" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="nodeId" />
    			</td>
    		</tr>  
					<tr>
						<td class="tbtd_caption"><label for="nodeNm"><spring:message code="title.busstop.nodeNm" /></label></td>
						<td class="tbtd_content"><form:input path="nodeNm" maxlength="30" cssClass="txt" /> &nbsp;<form:errors path="nodeNm" /></td>
					</tr>
					<tr>
						<td class="tbtd_caption"><label for="gpsLati"><spring:message code="title.busstop.gpsLati" /></label></td>
						<td class="tbtd_content"><form:input path="gpsLati" maxlength="30" cssClass="txt" /> &nbsp;<form:errors path="gpsLati" /></td>
					</tr>
					<tr>
						<td class="tbtd_caption"><label for="gpsLong"><spring:message code="title.busstop.gpsLong" /></label></td>
						<td class="tbtd_content"><form:input path="gpsLong" maxlength="30" cssClass="txt" /> &nbsp;<form:errors path="gpsLong" /></td>
					</tr>
					<tr>
						<td class="tbtd_caption"><label for="collectdTime"><spring:message code="title.busstop.collectdTime" /></label></td>
						<td class="tbtd_content"><form:input path="collectdTime" maxlength="30" cssClass="txt" /> &nbsp;<form:errors path="collectdTime" /></td>
					</tr>
					<tr>
						<td class="tbtd_caption"><label for="nodeMobileId"><spring:message code="title.busstop.nodeMobileId" /></label></td>
						<td class="tbtd_content"><form:input path="nodeMobileId" maxlength="30" cssClass="txt" /> &nbsp;<form:errors path="nodeMobileId" /></td>
					</tr>
					<tr>
						<td class="tbtd_caption"><label for="cityCd"><spring:message code="title.busstop.cityCd" /></label></td>
						<td class="tbtd_content"><form:input path="cityCd" maxlength="30" cssClass="txt" /> &nbsp;<form:errors path="cityCd" /></td>
					</tr>
					<tr>
						<td class="tbtd_caption"><label for="adminNm"><spring:message code="title.busstop.adminNm" /></label></td>
						<td class="tbtd_content"><form:select path="adminNm" cssClass="use">
								<form:option value="아산" label="아산" />
								<form:option value="경주" label="경주" />
								<form:option value="거제" label="거제" />
								<form:option value="울산" label="울산" />
								<form:option value="서산" label="서산" />
								<form:option value="영덕" label="영덕" />
								<form:option value="세종" label="세종" />
								<form:option value="구미" label="구미" />
								<form:option value="여수" label="여수" />
								<form:option value="대전" label="대전" />
								<form:option value="목포" label="목포" />
								<form:option value="서울" label="서울" />
								<form:option value="사천" label="사천" />
								<form:option value="영천" label="영천" />
								<form:option value="공단광역" label="공단광역" />
								<form:option value="함평" label="함평" />
								<form:option value="계룡" label="계룡" />
								<form:option value="진주" label="진주" />
								<form:option value="김천" label="김천" />
								<form:option value="경산" label="경산" />
								<form:option value="제주" label="제주" />
								<form:option value="충주" label="충주" />
								<form:option value="군산" label="군산" />
								<form:option value="옥천" label="옥천" />
								<form:option value="공주" label="공주" />
								<form:option value="춘천" label="춘천" />
								<form:option value="칠곡" label="칠곡" />
								<form:option value="천안" label="안" />
								<form:option value="김해" label="김해" />
								<form:option value="양산" label="양산" />
								<form:option value="인천" label="인천" />
								<form:option value="대구" label="대구" />
								<form:option value="청주" label="청주" />
								<form:option value="창원" label="창원" />
								<form:option value="제천" label="제천" />
								<form:option value="광양" label="광양" />
								<form:option value="순천" label="순천" />
								<form:option value="전주" label="전주" />
								<form:option value="경기도" label="경기도" />
								<form:option value="원주" label="원주" />
								<form:option value="남원" label="남원" />
								<form:option value="포항" label="포항" />
								<form:option value="밀양" label="밀양" />
								<form:option value="보은" label="보은" />
								<form:option value="광주" label="광주" />
							</form:select>&nbsp;<form:errors path="adminNm" /></td>
					</tr>

					<tr>
						<td class="tbtd_caption"><label for="cityName"><spring:message code="title.busstop.cityName" /></label></td>
						<td class="tbtd_content"><form:input path="cityName" maxlength="30" cssClass="txt" /> &nbsp;<form:errors path="cityName" /></td>
					</tr>
					<tr>
						<td class="tbtd_caption"><label for="tDate"><spring:message code="title.busstop.tDate" /></label></td>
						<td class="tbtd_content" style="font-weight: bold;">
						<c:set var="tDate" value="<%=new java.util.Date()%>"/>
    					<fmt:formatDate value="${tDate}" pattern="yyyy-MM-dd" var="tDate"/>
    					<form:input path="tDate" value="${tDate}" readonly="true" />
						</td>
					</tr>
				</table>
			</div>
			<div id="sysbtn">
				<ul>
					<li><span class="btn_blue_l"> <a href="javascript:fn_egov_selectList();"><spring:message code="button.list" /></a> <img
							src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left: 6px;" alt="" />
					</span></li>
					<li><span class="btn_blue_l"> <a href="javascript:fn_egov_save();"> <c:if test="${registerFlag == 'create'}">
									<spring:message code="button.create" />
								</c:if> <c:if test="${registerFlag == 'modify'}">
									<spring:message code="button.modify" />
								</c:if>
						</a> <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left: 6px;" alt="" />
					</span></li>
					<c:if test="${registerFlag == 'modify'}">
						<li><span class="btn_blue_l"> <a href="javascript:fn_egov_delete();"><spring:message code="button.delete" /></a> <img
								src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left: 6px;" alt="" />
						</span></li>
					</c:if>
					<li><span class="btn_blue_l"> <a href="javascript:document.detailForm.reset();"><spring:message code="button.reset" /></a> <img
							src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left: 6px;" alt="" />
					</span></li>
				</ul>
			</div>
		</div>
		<input type="hidden" name="searchCondition" value="<c:out value='${busSearchVO.searchCondition}'/>" />
		<input type="hidden" name="searchKeyword" value="<c:out value='${busSearchVO.searchKeyword}'/>" />
		<input type="hidden" name="pageIndex" value="<c:out value='${busSearchVO.pageIndex}'/>" />
	</form:form>
</body>
</html>