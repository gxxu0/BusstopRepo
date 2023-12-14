package busstop.example.sample.service;

public class MapVO {
	private Integer id;

	private String geom;

	private String sigCd;

	private String sigEngNm;

	private String sigKorNm;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public String getSigCd() {
		return sigCd;
	}

	public void setSigCd(String sigCd) {
		this.sigCd = sigCd;
	}

	public String getSigEngNm() {
		return sigEngNm;
	}

	public void setSigEngNm(String sigEngNm) {
		this.sigEngNm = sigEngNm;
	}

	public String getSigKorNm() {
		return sigKorNm;
	}

	public void setSigKorNm(String sigKorNm) {
		this.sigKorNm = sigKorNm;
	}
	@Override
	public String toString() {
		return "MapVO [sigKorNm=" + sigKorNm + ", sigEngNm=" + sigEngNm + ", sigCd" + sigCd + ", id " + id + ", geom " + geom + "]";
	}

	public String getGeom() {
		return geom;
	}

	public void setGeom(String geom) {
		this.geom = geom;
	}
}
