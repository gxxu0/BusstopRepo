package busstop.example.sample.service;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.format.annotation.DateTimeFormat;

public class BusVO extends PageVO{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,
            generator = "MEMBER_SEQ_GENERATOR")
	
	
	private String nodeId;
	
	private String nodeNm;
	
	private Double gpsLati;
	
	private Double gpsLong;
	
	private String collectdTime;
	
	private String nodeMobileId;
	
	private String cityCd;
	
	private String cityName;
	
	private String adminNm;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private String tDate;

	
	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeNm() {
		return nodeNm;
	}

	public void setNodeNm(String nodeNm) {
		this.nodeNm = nodeNm;
	}

	public Double getGpsLati() {
		return gpsLati;
	}

	public void setGpsLati(Double gpsLati) {
		this.gpsLati = gpsLati;
	}

	public Double getGpsLong() {
		return gpsLong;
	}

	public void setGpsLong(Double gpsLong) {
		this.gpsLong = gpsLong;
	}

	public String getCollectdTime() {
	    return collectdTime;
	}

	public void setCollectdTime(String collectdTime) {
	    this.collectdTime = collectdTime;
	}


	public String getNodeMobileId() {
		return nodeMobileId;
	}

	public void setNodeMobileId(String nodeMobileId) {
		this.nodeMobileId = nodeMobileId;
	}

	public String getCityCd() {
		return cityCd;
	}

	public void setCityCd(String cityCd) {
		this.cityCd = cityCd;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getAdminNm() {
		return adminNm;
	}

	public void setAdminNm(String adminNm) {
		this.adminNm = adminNm;
	}

	public String gettDate() {
		return tDate;
	}

	public void settDate(String tDate) {
		this.tDate = tDate;
	}

}
