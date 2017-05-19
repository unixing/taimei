package org.ldd.ssm.crm.domain;
/**
 * 机场位置
 * @author wxm
 *
 * @date 2017-3-30
 */
public class AirportLocation{
	private String airlnCd;//机场名字
	private String cityCoordinateJ;//经度
	private String cityCoordinateW;//纬度
	public String getAirlnCd() {
		return airlnCd;
	}
	public void setAirlnCd(String airlnCd) {
		this.airlnCd = airlnCd;
	}
	public String getCityCoordinateJ() {
		return cityCoordinateJ;
	}
	public void setCityCoordinateJ(String cityCoordinateJ) {
		this.cityCoordinateJ = cityCoordinateJ;
	}
	public String getCityCoordinateW() {
		return cityCoordinateW;
	}
	public void setCityCoordinateW(String cityCoordinateW) {
		this.cityCoordinateW = cityCoordinateW;
	}
	
	
}
