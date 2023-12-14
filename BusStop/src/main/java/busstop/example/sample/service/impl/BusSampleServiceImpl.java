package busstop.example.sample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import busstop.example.sample.service.BusSampleService;
import busstop.example.sample.service.BusVO;
import busstop.example.sample.service.PageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("busSampleService")
public class BusSampleServiceImpl extends EgovAbstractServiceImpl implements BusSampleService{
	@Autowired
	private static final Logger LOGGER = LoggerFactory.getLogger(BusSampleServiceImpl.class);
	
	@Resource(name = "busDAO")
	private BusDAO busDAO;
	
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
	@Override
	public String insertBusstop(BusVO vo) throws Exception {
		LOGGER.debug(vo.toString());

		String id = egovIdGnrService.getNextStringId();
		vo.setNodeId(id);
		LOGGER.debug(vo.toString());

		busDAO.insertBusstop(vo);
		return id;
	}
	
	@Override
	public void updateBusstop(BusVO vo) throws Exception {
		// TODO Auto-generated method stub
		busDAO.updateBusstop(vo);
		
	}

	@Override
	public void deleteBusstop(BusVO vo) throws Exception {
		// TODO Auto-generated method stub
		busDAO.deleteBusstop(vo);
	}

	@Override
	public BusVO selectBusstop(BusVO vo) throws Exception {
		// TODO Auto-generated method stub
		BusVO resultVO = busDAO.selectBusstop(vo);
		if(resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}
	
	@Override
	public List<?> selectBusstopList(PageVO pageVO) throws Exception {
		return busDAO.selectBusstopList(pageVO);
	}

	@Override
	public int selectBusstopListTotCnt(PageVO pageVO) throws Exception {
		// TODO Auto-generated method stub
		return busDAO.selectBusstopListTotCnt(pageVO);
	}

	@Override
	public List<?> selectBusstopCityList(PageVO pageVO) throws Exception {
		return busDAO.selectBusstopCityList(pageVO);
	}
	
}
