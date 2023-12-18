package busstop.example.sample.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import busstop.example.sample.service.BusSampleService;
import busstop.example.sample.service.BusVO;
import busstop.example.sample.service.MapVO;
import busstop.example.sample.service.PageVO;
import busstop.example.sample.service.Pagination;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class BusSampleController {

	@Resource(name = "busSampleService")
	private BusSampleService busSampleService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	private static final Logger LOGGER = LoggerFactory.getLogger(BusSampleController.class);

	// 글 목록 화면 조회
	@RequestMapping(value = "/BusStopList.do", method = RequestMethod.GET)
	public String selectBusstopListMain(@ModelAttribute("pageVO") PageVO pageVO, Model model) throws Exception {
//		System.out.println("글 목록 화면 조회");

		Pagination pagination = new Pagination();

		pagination.setCurrentPageNo(pageVO.getPageIndex()); // 현재 페이지 번호
		pagination.setRecordCountPerPage(pageVO.getRecordCountPerPage()); // 한 페이지에 게시되는 게시물 수
		pagination.setPageSize(pageVO.getPageSize()); // 페이징 리스트의 사이즈

		int totCnt = busSampleService.selectBusstopListTotCnt(pageVO);
		pagination.setTotalRecordCount(totCnt);
		pageVO.setFirstIndex(pagination.getFirstRecordIndex());
		pageVO.setEndDate(pagination.getLastPageNoOnPageList());
		pageVO.setStartDate(pagination.getFirstPageNoOnPageList());
		pageVO.setTotCnt(pagination.getTotalRecordCount());
		pageVO.setRecordCountPerPage(10); // 한 페이지 당

		List<?> busList = busSampleService.selectBusstopList(pageVO);

		model.addAttribute("busList", busList);
		model.addAttribute("pagination", pagination);

//		System.out.println(model);
		return "sample/BusStopList";
	}

	// 글 목록 비동기 페이지
	@RequestMapping(value = "/BusStopListAjax.do", produces = "text/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String selectBusstopList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("mapVO") MapVO mapVO, @ModelAttribute("vo") BusVO vo, @ModelAttribute("pageVO") PageVO pageVO) throws Exception {
		System.out.println("글 목록 비동기 페이지");
		ModelMap model = new ModelMap();

		//////////////////////////////////////////////////////////////////

		String keyword = pageVO.getSearchKeyword();
		String keywordCondition = pageVO.getSearchCondition();

		Pagination pagination = new Pagination();
		pagination.setCurrentPageNo(pageVO.getPageIndex()); // 현재 페이지 번호
		pagination.setRecordCountPerPage(pageVO.getPageUnit());
		pagination.setPageSize(pageVO.getPageSize()); // 페이징 리스트의 사이즈

		int totCnt = busSampleService.selectBusstopListTotCnt(pageVO);
		int defaultTotCnt = busSampleService.selectBusstopListTotCnt(vo);

		// System.out.println("defaultTotCnt : " + defaultTotCnt);
		pagination.setTotalRecordCount(totCnt);

		pageVO.setFirstIndex(pagination.getFirstRecordIndex());
		pageVO.setEndDate(pagination.getLastPageNoOnPageList());
		pageVO.setStartDate(pagination.getFirstPageNoOnPageList());
		pageVO.setPrev(pagination.getXprev());
		pageVO.setNext(pagination.getXnext());
		pageVO.setRealEnd(pagination.getRealEnd());
		pageVO.setTotCnt(pagination.getTotalRecordCount());
		pageVO.setSearchCondition(keywordCondition);
		pageVO.setSearchKeyword(keyword);

		Map<String, Object> map = new HashMap<>();

		pagination.setTotalRecordCount(totCnt);
		pageVO.setRecordCountPerPage(10); // 한 페이지 당

		// int totalPageCnt = (int) Math.ceil(totCnt / (double) pageVO.getPageUnit());
		int totalPageCnt = (int) Math.ceil((double) totCnt / pageVO.getPageUnit());

		// model에 map을 넣어서PreviousPreviousPrevious
		List<?> busList = busSampleService.selectBusstopList(pageVO);

		map.put("busList", busList);
		map.put("totalPageCnt", totalPageCnt);
		map.put("pageVO", pageVO);
		map.put("pagination", pagination);
		map.put("totcnt", totCnt);

		JSONObject json = new JSONObject(map);
		model.addAttribute("map", json);

		JSONArray jsonArray = new JSONArray();
		jsonArray.put(json);


		return jsonArray.toString();
	}
	
	// 글 목록 전체 가져오기
		@RequestMapping(value = "/entireBusStopListAjax.do", produces = "text/json; charset=utf-8", method = RequestMethod.POST)
		@ResponseBody
		public String selectBusstopListEntire(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("mapVO") MapVO mapVO, @ModelAttribute("vo") BusVO vo, @ModelAttribute("pageVO") PageVO pageVO) throws Exception {

			ModelMap model = new ModelMap();
			//////////////////////////////////////////////////////////////////

			String keyword = pageVO.getSearchKeyword();
			String keywordCondition = pageVO.getSearchCondition();

			Pagination pagination = new Pagination();
			pagination.setCurrentPageNo(pageVO.getPageIndex()); // 현재 페이지 번호
			pagination.setRecordCountPerPage(pageVO.getPageUnit());
			pagination.setPageSize(pageVO.getPageSize()); // 페이징 리스트의 사이즈

			int totCntEntire = busSampleService.selectBusstopListTotCnt(pageVO);
			int defaultTotCnt = busSampleService.selectBusstopListTotCnt(vo);

			// System.out.println("defaultTotCnt : " + defaultTotCnt);
			pagination.setTotalRecordCount(totCntEntire);

			pageVO.setFirstIndex(pagination.getFirstRecordIndex());
			pageVO.setEndDate(pagination.getLastPageNoOnPageList());
			pageVO.setStartDate(pagination.getFirstPageNoOnPageList());
			pageVO.setPrev(pagination.getXprev());
			pageVO.setNext(pagination.getXnext());
			pageVO.setRealEnd(pagination.getRealEnd());
			pageVO.setTotCnt(pagination.getTotalRecordCount());
			pageVO.setSearchCondition(keywordCondition);
			pageVO.setSearchKeyword(keyword);

			Map<String, Object> map = new HashMap<>();

			pagination.setTotalRecordCount(totCntEntire);
			pageVO.setRecordCountPerPage(totCntEntire); // 한 페이지 당

			// int totalPageCnt = (int) Math.ceil(totCnt / (double) pageVO.getPageUnit());
			int totalPageCnt = (int) Math.ceil((double) totCntEntire / pageVO.getPageUnit());

			List<?> cityList = busSampleService.selectBusstopCityList(pageVO);

			map.put("totalPageCnt", totalPageCnt);
			map.put("pageVO", pageVO);
			map.put("pagination", pagination);
			map.put("totCntEntire", totCntEntire);
			map.put("cityList", cityList);
			JSONObject json = new JSONObject(map);
			model.addAttribute("map", json);

			JSONArray jsonArray = new JSONArray();
			jsonArray.put(json);
			System.out.println(jsonArray);

			return jsonArray.toString();
		}
	// 등록 화면 조회
	@RequestMapping(value = "/BusStopRegister.do", method = RequestMethod.GET)
	public String addBusstopView(@ModelAttribute("busVO") BusVO busVO, Model model) throws Exception {
		System.out.println("글 등록화면 조회");

		model.addAttribute("busVO", new BusVO());
		return "sample/BusStopRegister";
	}

	// 글 등록 insert
	@RequestMapping(value = "/insertBusstop.do")
	public ModelAndView insertBusstop(HttpServletRequest request, @ModelAttribute("busVO") BusVO busVO, Model model) throws Exception {

//		System.out.println("글 등록화면 조회");
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView();
		Enumeration<String> enumber = request.getParameterNames();
		while (enumber.hasMoreElements()) {
			String key = enumber.nextElement().toString();
			String value = request.getParameter(key).replaceAll("&", "");

//		System.out.println(key + " : " + value);
			map.put(key, value);
		}

		model.addAttribute("map", map);
		modelAndView.setViewName("sample/BusStopRegister");
		return modelAndView;

	}

	// 글 등록 insert
	@RequestMapping(value = "/insertBusstop2.do")
	public ModelAndView insertBusstop2(HttpServletRequest request, @ModelAttribute("busVO") BusVO busVO) throws Exception {
		System.out.println("비동기 후 insertBusstop2");

		HashMap<String, Object> map = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView();

		Enumeration<String> params = request.getParameterNames(); // HttpServletRequest 으로 넘어오는 모든 request값을 확인하는 방법
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = request.getParameter(name).replaceAll("&", "");
// 			System.out.print(name + " : " + request.getParameter(value) + "");
		}

		busSampleService.insertBusstop(busVO);
		// // DB에 값이 잘 들어가면
		// if (rst != null) {
		// modelAndView.addObject("rst", rst);
		// } else {
		// modelAndView.addObject("rst", "error");
		// }

		modelAndView.addObject("map", map);
		modelAndView.setViewName("forward:/BusStopList.do"); // 다음 이동할 URL로 요청정보를 그대로 전달
		return modelAndView;
	}

	// 글 조회
	public BusVO selectBusstop(BusVO busVO, @ModelAttribute("pageVO") PageVO pageVO) throws Exception {
		System.out.println("글 조회");
		return busSampleService.selectBusstop(busVO);
	}

	// 글 수정화면 조회
	@RequestMapping(value = "/updateBusView.do")
	public String updateBusstopView(@RequestParam("nodeId") String nodeId, @ModelAttribute("pageVO") PageVO pageVO, Model model) throws Exception {
		System.out.println("수정화면 조회");

		BusVO busVO = new BusVO();
		busVO.setNodeId(nodeId); // nodeId값 가져옴

		BusVO selectedBus = busSampleService.selectBusstop(busVO); // 조회
		model.addAttribute("busVO", selectedBus);

		return "sample/BusStopModify";
	}

	// 글 수정
	@RequestMapping(value = "/updateBusstop.do")
	public ModelAndView updateBusstop(HttpServletRequest request, @ModelAttribute("busVO") BusVO busVO, Model model) throws Exception {
		System.out.println("글 수정 하기");

		HashMap<String, Object> map = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView();
//		System.out.println(request);

		Enumeration<String> params = request.getParameterNames();
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = request.getParameter(name).replaceAll("&", "");
//			System.out.println(name + " : " + request.getParameter(value) + "");
		}

		busSampleService.updateBusstop(busVO);

		System.out.println("글 수정 하기 성공");
		modelAndView.addObject("map", map);
//		System.out.println(map);
		modelAndView.addObject("nodeId", busVO.getNodeId()); // nodeId값 업데이트 -> Required String parameter '인자' is not present
		modelAndView.setViewName("forward:/BusStopList.do");
		return modelAndView;
	}

	// 글 삭제
	@RequestMapping("/deleteBusStop.do")
	public ModelAndView deleteBusStop(@RequestParam(value = "nodeId") String nodeId, Model model) throws Exception {
		System.out.println("글 삭제하기");

		ModelAndView modelAndView = new ModelAndView();

		BusVO busVO = new BusVO();
		busVO.setNodeId(nodeId); // nodeId값 가져옴

		busSampleService.deleteBusstop(busVO);

		modelAndView.setViewName("forward:/BusStopList.do");

		return modelAndView;
	}


}