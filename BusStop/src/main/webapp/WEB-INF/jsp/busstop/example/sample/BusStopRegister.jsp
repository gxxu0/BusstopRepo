<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	Date now = new Date();
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bus <spring:message code="button.create" /></title>
<link rel="icon" href="#?ver=1"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/busstop.css'/>" />

<script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
<validator:javascript formName="busVO" staticJavascript="false" xhtml="true" cdata="false" />
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/busstop.css?ver=1'/>" />

<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/ol.css?ver=1'/>" />
<script src="<c:url value='/css/busstop/ol.js?ver=1'/>"></script>
<script src="<c:url value='/css/busstop/proj4.js?ver=1'/>"></script>
<script defer="defer" src="/js/busstop/busstop.js?ver=1"></script>
<script type="text/javaScript" defer="defer">

//시군구 API
var dataObj = [];
var sidoM2 = [{sidoMDataNm: '시/도 선택', sidoMDataCd: '0'}]; //소상공인시장진흥공단 상권정보 시도 코드
var siGGM2 = []; //소상공인시장진흥공단 상권정보 시도 코드
var siBGDM2 = []; //소상공인시장진흥공단 상권정보 법정동 코드
var kSido;
var kSggCd;
var kUmdCd;
var combinedObject;
var combinedObject2;

//소상공인시장진흥공단 상권정보 시도 코드
function sidoMF() {

  var xhr = new XMLHttpRequest();
  var url = 'https://apis.data.go.kr/B553077/api/open/sdsc2/baroApi';
  var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'TVFo1GZot0KSCrEPGFWQUBefAD7Iq231jlkHSxDP26gpdn09b%2FHWx63ylTZmwquz6h6lHHYRH9nTwNEhFcJxag%3D%3D';
  queryParams += '&' + encodeURIComponent('resId') + '=' + encodeURIComponent('dong');
  queryParams += '&' + encodeURIComponent('catId') + '=' + encodeURIComponent('mega');
  queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
  xhr.open('POST', url + queryParams);

  var sidoMData;
  var sidoMDataNm;
  var sidoMDataCd;
  xhr.onreadystatechange = function () {
      if (this.readyState == 4 && this.status == 200) {
          var response = JSON.parse(this.responseText);
          sidoMData = response;
          sidoMData = sidoMData.body.items;
          for (var i = 0; i < sidoMData.length; i++) {
              sidoMDataNm = sidoMData[i].ctprvnNm;
              sidoMDataCd = sidoMData[i].ctprvnCd;
              sidoM2.push({sidoMDataNm, sidoMDataCd});
          }
          console.log("sidoM2", sidoM2);
          siGGMF();
          siBSDMF();
          fetchDataFromAPI();
      }
  };
  xhr.send('');

}



function siGGMF() {

	  var xhr = new XMLHttpRequest();
	  var url = 'https://apis.data.go.kr/B553077/api/open/sdsc2/baroApi';
	  var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'TVFo1GZot0KSCrEPGFWQUBefAD7Iq231jlkHSxDP26gpdn09b%2FHWx63ylTZmwquz6h6lHHYRH9nTwNEhFcJxag%3D%3D';
	  queryParams += '&' + encodeURIComponent('resId') + '=' + encodeURIComponent('dong');
	  queryParams += '&' + encodeURIComponent('catId') + '=' + encodeURIComponent('cty');
	  queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
	  xhr.open('POST', url + queryParams);

	  var sidoMData;
	  var sidoMDataNm;
	  var sidoMDataCd;
	  var siGnguNm;
	  xhr.onreadystatechange = function () {
	      if (this.readyState == 4 && this.status == 200) {
	          var response = JSON.parse(this.responseText);
	          sidoMData = response;
	          sidoMData = sidoMData.body.items;
	          for (var i = 0; i < sidoMData.length; i++) {
	              sidoMDataNm = sidoMData[i].ctprvnNm;
	              sidoMDataCd = sidoMData[i].signguCd;
	              siGnguNm = sidoMData[i].signguNm;
	              siGGM2.push({sidoMDataNm,sidoMDataCd,siGnguNm});
	          }
	          console.log("siGGM2", siGGM2);
	          
	      }
	  };
	  xhr.send('');

}
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
	          console.log('response',response);
	          sidoMData = sidoMData.body.items;
	          for (var i = 0; i < sidoMData.length; i++) {
	              sidoMDataNm = sidoMData[i].ctprvnNm;
	              sidoMDataCd = sidoMData[i].signguCd;
	              siGnguNm = sidoMData[i].signguNm;
	              lDongNm = sidoMData[i].ldongNm;
	              siBGDM2.push({
	                  sidoMDataNm,
	                  sidoMDataCd,
	                  siGnguNm,
	                  lDongNm
	              });
	          }
	          console.log("siBGDM2", siBGDM2);
	      }
	  };
	  xhr.send('');

}
function fetchDataFromAPI() {

  // 행정안전부_행정표준코드_법정동코드
  function fetchDataForLocation(location, page, callback) {
      var results = [];
      var kName;
      var kValue;

      function fetchData() {

          var xhr = new XMLHttpRequest();
          var url = 'http://apis.data.go.kr/1741000/StanReginCd/getStanReginCdList';
          var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'TVFo1GZot0KSCrEPGFWQUBefAD7Iq231jlkHSxDP26gpdn09b%2FHWx63ylTZmwquz6h6lHHYRH9nTwNEhFcJxag%3D%3D';
          queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent(page);
          queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent(1000);
          queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
          queryParams += '&' + encodeURIComponent('locatadd_nm') + '=' + encodeURIComponent(location);
          xhr.open('POST', url + queryParams);

          xhr.onreadystatechange = function () {
              if (this.readyState == 4 && this.status == 200) {
                  var response = JSON.parse(this.responseText);
                  var totalRecords = response.StanReginCd[0].head[0].totalCount;

                  results.push(response.StanReginCd[1]);

                  if (results.length < 1000 && (page * 1000) < totalRecords) {
                      page++;
                      fetchData();
                  } else {
                      callback(null, results);
                      kName = location;
                      kValue = combinedObject;
                      kSido = kValue.row[0].sido_cd;
                      kSggCd = kValue.row[0].sgg_cd;
                      dataObj.push({kName,kValue,kSido,kSggCd,});

                  }
              }
          };
          xhr.send('');
      }

      fetchData();
  }

  function fetchDataForAllLocations() {
      var currentIndex = 0;
      function fetchNextLocation() {
          currentIndex++;
          if (currentIndex < sidoM2.length) {

              fetchDataForLocation(sidoM2[currentIndex].sidoMDataNm, 1, function (error, data) {
                  if (error) {
                      console.error(error);
                  } else {
                      combinedObject = {
                          row: []
                      };
                      combinedObject2 = {
                          row: []
                      };
                      for (let i = 0; i < data.length; i++) {
                          combinedObject.row = combinedObject.row.concat(data[i].row);
                      }
                      fetchNextLocation();
                  }
              });
          }else{
        	  var sidoM = sidoM2;

        	//소상공인시장진흥공단 상권정보 시도 코드 호출 후 Op1에 넣기
        	alert('api요청 완료');
        	  console.log('sidoM', sidoM);

        	  var selectOption = '';
        	  for (var i = 0; i < sidoM2.length; i++) {
        	      selectOption += '<option value="' + sidoM2[i].sidoMDataCd + '">' + sidoM2[i].sidoMDataNm + '</option>';
        	  }

        	  document.getElementById("sidoOp1").innerHTML = selectOption;
        	  updateData();
          }
          
      }
      fetchNextLocation();
  }
  fetchDataForAllLocations();

  
  //선택 위치
  var geoContent = document.getElementById("click-Vworld"); // 팝업창 문구
  var rlati = document.getElementById('gpsLati').value;
  var rlong = document.getElementById('gpsLong').value;
  var point = rlong;
  point += ',';
  point += rlati;
  console.log(point);

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
      success: function (result) {
          console.log('result',result);
          geoContent.innerHTML = '<span>' + result.response.result[0].text + '</span>';
          //        console.log(result);
      },
      error: function (error) {
          console.log("error");
      }
  });

}
function updateData() {
  //option에 표시
  // 시/도 -> 시군구 -> 읍면동 -> 기타주소
  // 시/도 선택에 따라 뜨는 세부 시군구
  const optionSelect_1 = sidoOp1.value; // 시/도 optionSelect_1

  const optionSelect_2 = document.getElementById("sidoOp2"); // 구/군 optionSelect_2

  const optionSelect_3 = document.getElementById("sidoOp3"); // 읍/면/동/리 optionSelect_3

  const optionSelect_4 = document.getElementById("sidoOp4"); //도시코드 optionSelect_4

  const textInputBox_5 = document.getElementById("cityName"); //도시명 textInputBox_5
  
  //첨에 선택한 시/도 초기화
  // 구/군
  while (optionSelect_2.firstChild) {
      optionSelect_2.removeChild(optionSelect_2.firstChild);
  }
  // 읍/면/동/리
  while (optionSelect_3.firstChild) {
      optionSelect_3.removeChild(optionSelect_3.firstChild);
  }
  //도시코드
  while (optionSelect_4.firstChild) {
      optionSelect_4.removeChild(optionSelect_4.firstChild);
  }

  if (optionSelect_1 != 0) { // 시/도 선택이 아니면 (== 사용자가 시/도를 선택하면)
      const selectedDataObj = dataObj.find((obj) => obj.kSido === optionSelect_1); //선택 한 시/도와 같은 시도코드 find하기
      if (selectedDataObj) {
          console.log('selectedDataObj', selectedDataObj);
          //  시/도 후 나타나는 시군구
          const after_optionSelect_1 = selectedDataObj.kValue; //op1
          const after_optionSelect_2 = selectedDataObj.kValue; //op2
          const after_optionSelect_3 = selectedDataObj.kValue; //op3
          const after_optionSelect_4 = selectedDataObj.kValue; //op4

          console.log('after_optionSelect_1', after_optionSelect_1);

          function groupBySggCd(data) {
             console.log('data', data);
              data = data.row;
              return data.reduce((result, current) => {
            	  console.log('current',current);
                  const sggCd = current.sgg_cd; // 시군구 코드
                  const umdCd = current.umd_cd; // 읍면동 코드
                  const plusCd = current.sido_cd+''+current.sgg_cd; // 시도+시군구
                  const plusCd_umd = current.sido_cd+''+current.sgg_cd+''+current.umd_cd; // 시도+시군구+읍면동
                  const locatjijuk_cd = current.locatjijuk_cd //지역코드_지적
                  const districtName = current.locallow_nm; // 최하위지역명
                  //console.log(sggCd, districtName);
                  const locataddArray = current.locatadd_nm.split(" "); // 지역주소명 split

                  //console.log('locataddArray',locataddArray);
                  if (locataddArray.length >= 3) {
                      const key = locataddArray[1];
                      var value;

                      if (locataddArray[3] == undefined) {
                          value = locataddArray[2];
                      } else if (locataddArray.length == 4) {
                          value = locataddArray[2] + " " + locataddArray[3];
                      } else if (locataddArray.length == 5) {
                          value = locataddArray[2] + " " + locataddArray[3] + " " + locataddArray[4];
                      } else if (locataddArray.length == 6) {
                          value = locataddArray[2] + " " + locataddArray[3] + " " + locataddArray[4] + " " + locataddArray[5];
                      }

                      if (!result[sggCd]) {
                          result[sggCd] = {};
                      }

                      if (!result[sggCd][key]) {
                          result[sggCd][key] = [];
                      }
                      result[sggCd][key].push({value,umdCd,plusCd,plusCd_umd,locatjijuk_cd});
                  }

                  return result;
              }, {});
          }

          const groupedJson = groupBySggCd(after_optionSelect_1);
          console.log('groupedJson', groupedJson);

          var values = Object.values(groupedJson);
          console.log(values);

          const op2Cd = Object.keys(groupedJson); //시군구
          const op2 = [...new Set(Object.values(groupedJson).map(entry => Object.keys(entry)[0]))]; //시군구
          console.log(op2);
          var op3 = values.map(entry => entry[Object.keys(entry)[0]]); //읍면동리

          var sidoName;
          //시군구
          for (let i = 0; i < op2.length; i++) {
              const option2 = document.createElement("option");
              option2.value = op2Cd[i];
              option2.text = op2[i];
              sidoName = op2Cd[i];
              optionSelect_2.appendChild(option2);

          }

          const selectedKey = document.getElementById("sidoOp2");
          if (selectedKey) {
              const selectedValues = op3[selectedKey.selectedIndex];
              //읍면동리
              for (let i = 0; i < selectedValues.length; i++) {
                  const option3 = document.createElement("option");
                  option3.value = selectedValues[i].umdCd;
                  option3.text = selectedValues[i].value;
                  optionSelect_3.appendChild(option3);
              }
              //도시코드
              for (let i = 0; i < 1; i++) {
                  const option4 = document.createElement("option");
                  option4.text = selectedValues[i].plusCd;
                  option4.value = selectedValues[i].plusCd;
                  optionSelect_4.appendChild(option4);
              }

              textInputBox_5.value = document.getElementById('sidoOp2').value;
          }
          var selectedValues;
          optionSelect_2.addEventListener("change", function () {
              const selectedKey = document.getElementById("sidoOp2");
              optionSelect_3.innerHTML = "";
              optionSelect_4.innerHTML = "";

              if (selectedKey !== "") {
            	  selectedValues = op3[selectedKey.selectedIndex];
                  if (selectedValues) {

                      //읍면동리
                      for (let i = 0; i < selectedValues.length; i++) {
                          const option3 = document.createElement("option");
                          console.log('selectedValues[i]',selectedValues[i]);
                          option3.value = selectedValues[i].umdCd;
                          option3.text = selectedValues[i].value;
                          optionSelect_3.appendChild(option3);
                      }

                      //도시코드
                      for (let i = 0; i < 1; i++) {
                          const option4 = document.createElement("option");
                          option4.text = selectedValues[i].plusCd;
                          option4.value = selectedValues[i].plusCd;
                          optionSelect_4.appendChild(option4);
                      }

                      textInputBox_5.value = document.getElementById('sidoOp2').value;
                  }
              }
          });
          
      } else {
          // 시/도 선택 X
          const option = document.createElement("option");

          option.value = 0;
          option.text = "시/도를 선택하세요";

          dataSelectCityCode.appendChild(option);
      }

  }
}

sidoMF();


</script>
</head>
<body id="registerBody">
	<form:form commandName="busVO" id="detailForm" name="detailForm">
		
			<h3>버스정류장 위치 등록</h3>
		

		<div style="display: flex; justify-content: center; margin: 10px 0; font-weight: bold;">
			선택위치 :
			<div id="click-Vworld"></div>
		</div>
		<div id="content_pop">
			<div id="registerTable">
<%
	String gpsLati = request.getParameter("gpsLati");
		String gpsLong = request.getParameter("gpsLong");
%>
<%
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		String today = sf.format(now);
%>

				<div id="rNodeNm">
					<form:input path="nodeNm" id="nodeNm" placeholder="정류장 명칭" />
				</div>
				<div id="rGpsLati">
					위도
					<form:input class="mGpsLati" path="gpsLati" id="gpsLati" value="<%=gpsLati%>" name="gpsLati" maxlength="30" readonly="true" />

				</div>
				<div id="rGpsLong">
					경도
					<form:input class="mGpsLong" path="gpsLong" id="gpsLong" name="gpsLong" value="<%=gpsLong%>" maxlength="30" readonly="true" />

				</div>


				<form:input type="hidden" path="collectdTime" maxlength="30" cssClass="txt" value="<%=today%>" readonly="readonly" />

				<div id="rNodeMobileId">
					<form:input path="nodeMobileId" maxlength="30" cssClass="txt" placeholder="모바일/단축ID" />
				</div>
				<div id="rAdminNm">
					관리도시명
					<div id="rAdminNm-Content">
						<form:select path="adminNm" cssClass="use" id="sidoOp1" onchange="updateData()">
							<c:forEach items="${sidoM1}" var="sidoM1">
								<form:option name="${sidoOp1}" id="${sidoOp1}" value="" label="${sidoOp1}" />
							</c:forEach>
						</form:select>
						<form:select path="adminNm" id="sidoOp2" cssClass="use">
							<c:forEach items="${sidoM2}" var="sidoM2">
								<form:option name="${sidoOp2}" id="${sidoOp2}" value="" label="${sidoOp2}" />
							</c:forEach>
						</form:select>
						<form:select path="adminNm" id="sidoOp3" cssClass="use" style="width:120px;height:20px;">
							<option name="${sidoOp3}" />
						</form:select>
					</div>
				</div>

				<span id="rCityCd" style="height: 40px;"> 도시코드 <span id="rCityCd-Content"> <form:select path="cityCd" id="sidoOp4" cssClass="use">
							<c:forEach items="${sidoM4}" var="sidoM4">
								<form:option name="${sidoOp4}" id="${sidoOp4}" value="${sidoOp4}" label="${sidoOp4}" />
							</c:forEach>
						</form:select>
				</span>
				</span>
				<form:input type="hidden" path="cityName" maxlength="30" value="" cssClass="txt" placeholder="도시명" />

				<div id="rTDate">
					등록일
					<c:set var="tDate" value="<%=new java.util.Date()%>" />
					<fmt:formatDate value="${tDate}" pattern="yyyy-MM-dd" var="tDate" />
					<form:input class="mtDate" path="tDate" value="${tDate}" readonly="true" />
				</div>
			</div>
		</div>

		<div id="registerBtnBox">
			<a id="registerBtn" href="javascript:busstop_register();"><spring:message code="button.create" /></a> <a id="resetBtn" href="javascript:document.detailForm.reset();"><spring:message
					code="button.reset" /></a>
		</div>
		</div>
	</form:form>
</body>
</html>