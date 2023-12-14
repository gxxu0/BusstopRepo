package busstop.example.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import busstop.example.sample.service.BusVO;
import busstop.example.sample.service.PageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("busDAO")
public class BusDAO extends EgovAbstractDAO {

	public String insertBusstop(BusVO vo) throws Exception {
		return  (String) insert("busDAO.insertBusstop", vo);
	}

	public void updateBusstop(BusVO vo) throws Exception {
		update("busDAO.updateBusstop", vo);
	}

	public void deleteBusstop(BusVO vo) throws Exception {
		delete("busDAO.deleteBusstop", vo);
	}

	public BusVO selectBusstop(BusVO vo) throws Exception {
		return (BusVO) select("busDAO.selectBusstop", vo);
	}
	

	public List<?> selectBusstopList(PageVO pageVO) throws Exception {
		return list("busDAO.selectBusstopList", pageVO);
	}

	public int selectBusstopListTotCnt(PageVO pageVO) throws Exception  {
		return (Integer) select("busDAO.selectBusstopListTotCnt", pageVO);
	}

	public List<?> selectBusstopCityList(PageVO pageVO) throws Exception {
		return list("busDAO.selectBusstopCityList", pageVO);
	}
	


}
