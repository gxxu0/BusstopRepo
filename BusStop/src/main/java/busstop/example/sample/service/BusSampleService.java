package busstop.example.sample.service;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface BusSampleService {

	String insertBusstop(BusVO vo) throws Exception;

	void updateBusstop(BusVO vo) throws Exception;

	void deleteBusstop(BusVO vo) throws Exception;

	BusVO selectBusstop(BusVO vo) throws Exception;

	
	List<?> selectBusstopList(PageVO pageVO) throws Exception;
	
	int selectBusstopListTotCnt(PageVO pageVO) throws Exception;

	List<?> selectBusstopCityList(PageVO pageVO) throws Exception;
	

}
