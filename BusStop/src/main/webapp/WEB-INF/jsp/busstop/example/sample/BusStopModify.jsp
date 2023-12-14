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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bus <spring:message code="button.modify" /></title>
<link rel="icon" href="#?ver=1"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/busstop.css'/>" />

<script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
<validator:javascript formName="busVO" staticJavascript="false" xhtml="true" cdata="false" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/busstop.css?ver=1'/>" />
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<link type="text/css" rel="stylesheet" href="<c:url value='/css/busstop/ol.css?ver=1'/>" />
<script src="<c:url value='/css/busstop/ol.js?ver=1'/>"></script>
<script src="<c:url value='/css/busstop/proj4.js?ver=1'/>"></script>
<script defer="defer" src="/js/busstop/busstop.js?ver=1"></script>
<script type="text/javaScript" defer="defer">


// 검색 결과를 저장할 배열
const foundItems = [];
document.addEventListener('DOMContentLoaded', function () {

    var siBGDM2 = [];
    var checkString = document.getElementById('mmadminNm');
    var checkTag = document.getElementById('mAdminNm');
    var checkString2 = document.getElementById('mmCityCd');
    
    function hasNumber(str) {
        return /\d/.test(str);
    }

    function siBSDMF() {
        var xhr = new XMLHttpRequest();
        var url = 'https://apis.data.go.kr/B553077/api/open/sdsc2/baroApi';
        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'TVFo1GZot0KSCrEPGFWQUBefAD7Iq231jlkHSxDP26gpdn09b%2FHWx63ylTZmwquz6h6lHHYRH9nTwNEhFcJxag%3D%3D';
        queryParams += '&' + encodeURIComponent('resId') + '=' + encodeURIComponent('dong');
        queryParams += '&' + encodeURIComponent('catId') + '=' + encodeURIComponent('zone');
        queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
        xhr.open('POST', url + queryParams);

        xhr.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var response = JSON.parse(this.responseText);
                siBGDM2 = response.body.items;

                performStringCheck();
            }
        };
        xhr.send('');
    }

    function performStringCheck() {
    	checkString = checkString.value;
    	console.log(checkString);
    	console.log(checkString.slice(7,10));
        if (hasNumber(checkString) && checkString.slice(7,10)!='000') {
            console.log("문자열에 숫자가 포함되어 있습니다.");
            const stringWithoutComma = checkString.replace(/,/g, '');
          

            // siBGDM2 배열을 순회하며 검색
            for (let i = 0; i < siBGDM2.length; i++) {
                const ldongCdValue = siBGDM2[i].ldongCd.slice(0, 8);

                // ldongCd 값이 targetLdongCdValues 배열에 포함되어 있는지 확인
                if (stringWithoutComma.includes(ldongCdValue)) {
                	 foundItems.push({
                         ctprvnNm: siBGDM2[i].ctprvnNm,
                         signguNm: siBGDM2[i].signguNm,
                         ldongNm: siBGDM2[i].ldongNm
                     });
                	checkString = siBGDM2[i].ctprvnNm + ' ' + siBGDM2[i].signguNm + ' ' + siBGDM2[i].ldongNm;

                	console.log(checkString);
                	
                    break;
                }
            }
            console.log(foundItems);
            console.log(checkString);
            
        } else {
            console.log("문자열에 숫자가 포함되어 있지 않습니다.");
            document.getElementById('mAdminNm').style.display = 'block';
            if(checkString.slice(7,10)=='000'){
            	foundItems.push({
                    ctprvnNm: '',
                    signguNm: '',
                    ldongNm: ''
                });
            }else{
            	foundItems.push({
                    ctprvnNm: checkString,
                    signguNm: '',
                    ldongNm: ''
                });
            }
            
        }
    }
    siBSDMF();

});
//시군구 API
var dataObj = [];
var sidoM2 = []; //소상공인시장진흥공단 상권정보 시도 코드
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
          //dropdownOptions();
          fetchDataFromAPI();
      }
  };
  xhr.send('');

}

var sidoM = sidoM2;



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
          if (currentIndex <= sidoM2.length) {

              fetchDataForLocation(sidoM2[currentIndex-1].sidoMDataNm, 1, function (error, data) {
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
          } else{

        	//소상공인시장진흥공단 상권정보 시도 코드 호출 후 Op1에 넣기
        		alert('api요청 완료');
        		  console.log('sidoM', sidoM);
        		    document.getElementById('adminModify').style.display = 'block';
        		    var text = document.getElementById('mmadminNm');
        		    var text2 = document.getElementById('mmCityCd');
        		    console.log(text);
        		    text.remove();
        		    text2.remove();
        		  updateData();
        		  var selectOption = '';
        		  var selectOption2 = '';
        		  var selectOption3 = '';
        		  selectOption = '<option>*' + foundItems[0].ctprvnNm + '</option>';
        		  selectOption2 = '<option>' + foundItems[0].signguNm + '</option>';
        		  selectOption3 = '<option>' + foundItems[0].ldongNm + '</option>';
        		  for (var i = 0; i < sidoM2.length; i++) {
        		      selectOption += '<option value="' + sidoM2[i].sidoMDataCd + '">' + sidoM2[i].sidoMDataNm + '</option>';
        		  }
        		  document.getElementById("sidoOp1").innerHTML = selectOption;
        		  document.getElementById("sidoOp2").innerHTML = selectOption2;
        		  document.getElementById("sidoOp3").innerHTML = selectOption3;
        		  
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
  const selectedDataObj = dataObj.find((obj) => obj.kSido === optionSelect_1); //선택 한 시/도와 같은 시도코드 find하기
  if (selectedDataObj) {
      console.log('selectedDataObj', selectedDataObj);
      //  시/도 후 나타나는 시군구
      const after_optionSelect_1 = selectedDataObj.kValue; //op1
      const after_optionSelect_2 = selectedDataObj.kValue; //op2
      const after_optionSelect_3 = selectedDataObj.kValue; //op3
      const after_optionSelect_4 = selectedDataObj.kValue; //op4

      console.log('after_optionSelect_1', after_optionSelect_1);
      console.log('after_optionSelect_2', after_optionSelect_2);

      function groupBySggCd(data) {
          //console.log('data', data);
          data = data.row;
          return data.reduce((result, current) => {
        	  console.log('current',current);
              const sggCd = current.sgg_cd; // 시군구 코드
              const umdCd = current.umd_cd; // 읍면동 코드
              const plusCd = current.sido_cd+''+current.sgg_cd; // 시도+시군구
              const plusCd_umd = current.sido_cd+''+current.sgg_cd+''+current.umd_cd; // 시도+시군구+읍면동
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
                  result[sggCd][key].push({value,umdCd,plusCd,plusCd_umd});
              }

              return result;
          }, {});
      }

      const groupedJson = groupBySggCd(after_optionSelect_1);
      console.log('groupedJson', groupedJson);

      var values = Object.values(groupedJson);
      console.log(values);

      const op2Cd = Object.keys(groupedJson); //시군구
      //        console.log(op2Cd);
      const op2 = [...new Set(Object.values(groupedJson).map(entry => Object.keys(entry)[0]))]; //시군구
      var op3 = values.map(entry => entry[Object.keys(entry)[0]]); //읍면동리
      //시군구
      var option2 = '' ;
      for (let i = 0; i < op2.length; i++) {
    	  option2 = document.createElement("option");
          option2.value = op2Cd[i];
          option2.text = op2[i];
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
  }

}

sidoMF();




</script>


</head>
<body id="modifyBody">
	<form:form commandName="busVO" id="modifyForm" name="modifyForm">

			<h3>
				<spring:message code="button.modify" />
			</h3>
		<div style="display: flex; justify-content: center; margin: 10px 0; font-weight: bold;">
			선택위치 :
			<div id="click-Vworld"></div>
		</div>
		<div id="content_pop">
			<div id="modifyTable">
				<%
					String nodeId = request.getParameter("nodeId");
						String nodeNm = request.getParameter("nodeNm");
						String gpsLati = request.getParameter("gpsLati");
						String gpsLong = request.getParameter("gpsLong");
						String collectdTime = request.getParameter("collectdTime");
						String nodeMobileId = request.getParameter("nodeMobileId");
						String cityCd = request.getParameter("c");
						String adminNm = request.getParameter("adminNm");
						String cityName = request.getParameter("cityName");
						String tDate = request.getParameter("tDate");
				%>
				<div id="mNodeId">
					정류장 ID
					<form:input name="nodeId" path="nodeId" value="<%=nodeId%>" readonly="true" />
				</div>
				<div id="mNodeNm">
					정류장 명칭
					<form:input name="nodeNm" path="nodeNm" value="<%=nodeNm%>" />
				</div>
				<div id="mGpsLati">
					위도
					<form:input class="mGpsLati" path="gpsLati" name="gpsLati" maxlength="30" value="<%=gpsLati%>" />
				</div>
				<div id="mGpsLong">
					경도
					<form:input class="mGpsLong" path="gpsLong" name="gpsLong" maxlength="30" value="<%=gpsLong%>" />
				</div>
				
<%
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		String today = sf.format(now);
%>
				<div id="mCollectdTime">
					정보 수집 일시
					<form:input class="mCollectdTime" path="collectdTime" name="collectdTime" value="<%=today%>" readonly="true" />
				</div>
				<div id="mNodeMobileId">
					모바일/단축ID
					<form:input class="mNodeMobileId" path="nodeMobileId" maxlength="30" value="<%=nodeMobileId%>" />
				</div>
				<div id="mAdminNm">
					관리도시명
					<form:input class="mAdminNm" id="mmadminNm" path="adminNm" name="adminNm" value="<%=adminNm%>" readonly="true" style="opacity:0; height:1px;"/>
						
					<div id="adminModify" style="display:none;">
						<form:select path="adminNm" cssClass="use" id="sidoOp1" onchange="updateData()">
							<c:forEach items="${sidoM1}" var="sidoM1">
								<form:option name="${sidoOp1}" id="${sidoOp1}" value="<%=adminNm%>" label="${sidoOp1}" />
							</c:forEach>
						</form:select>
						<form:select path="adminNm" id="sidoOp2" cssClass="use">
							<c:forEach items="${sidoM2}" var="sidoM2">
								<form:option name="${sidoOp2}" id="${sidoOp2}" value="<%=adminNm%>" label="${sidoOp2}" />
							</c:forEach>
						</form:select>
						<form:select path="adminNm" id="sidoOp3" value="<%=adminNm%>" style="width:120px;height:20px;">
							<option name="${sidoOp3}" />
						</form:select>
					
					</div>
				</div>
				
				<div id="mTDate">
					등록일
					<c:set var="tDate" value="<%=new java.util.Date()%>" />
					<fmt:formatDate value="${tDate}" pattern="yyyy-MM-dd" var="tDate" />
					<form:input path="tDate" value="<%=tDate%>" readonly="true" />
				</div>
				<div id="mCityCd" style="opacity:0; height:1px;">
					도시코드
					<form:input style="height: 1px;" class="mCityCd"  id="mmCityCd" path="cityCd" name="cityCd" value="<%=cityCd%>" readonly="true"/>
					<div id="cityCdModify" style="display:none;">
						<form:select type="hidden" path="cityCd" id="sidoOp4" cssClass="use">
							<c:forEach items="${sidoM4}" var="sidoM4">
								<form:option type="hidden" name="${sidoOp4}" id="${sidoOp4}" value="${sidoOp4}" label="${sidoOp4}" />
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div id="mCityName" style="opacity:0; height:1px;">
					도시명
					<form:input type="hidden"  path="cityName" maxlength="30" cssClass="txt" value="<%=cityName%>" />
				</div>
			</div>
		</div>
		<div id="modifyBtnBox">
			<a id="modifyBtn" href="javascript:busstop_edit_btn();">수정하기</a> <a id="deleteBtn" href="javascript:busstop_delete();">삭제하기</a>

		</div>
	</form:form>

</body>
</html>