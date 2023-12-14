package busstop.example.sample.service.impl;

import java.util.List;

import busstop.example.sample.service.BusVO;
import busstop.example.sample.service.PageVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface BusMapper {

	void insertBusstop(BusVO vo) throws Exception;

	void updateBusstop(BusVO vo) throws Exception;

	void deleteBusstop(BusVO vo) throws Exception;

	BusVO selectBusstop(BusVO vo) throws Exception;

	
	List<?> selectBusstopList(PageVO pageVO) throws Exception;

	int selectBusstopListTotCnt(PageVO pageVO);
	
	List<?> selectBusstopCityList(PageVO pageVO) throws Exception;

}
