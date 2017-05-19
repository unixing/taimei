package org.ldd.ssm.crm.domain;
/**
 * 航路实体类
 * @Title:FlightAirline 
 * @Description:
 * @author taimei-gds 
 * @date 2017-3-31 上午11:43:41
 */
public class FlightAirline implements Cloneable{
	private String stratCity;//起始地
	private String endCity;//到达地
	private String stratCityPoit1;//起始地坐标1
	private String stratCityPoit2;//起始地坐标2
	private String endCityCityPoit1;//到达地坐标1
	private String endCityCityPoit2;//到达地坐标2
	private String indexx;//顺序
	private String flightAirlineId;//航线的ID
	private String pointId;//点1的ID
	private String pointId2;//点2的ID
	private String pointName;//点的名字
	private String airLineDistance;//航距
	private String startType;//起始地类型（机场、航路点）
	private String endType;//到达地类型（机场、航路点）
	public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
	
	/**
	 * @return the stratCity
	 */
	public String getStratCity() {
		return stratCity;
	}
	/**
	 * @param stratCity the stratCity to set
	 */
	public void setStratCity(String stratCity) {
		this.stratCity = stratCity;
	}
	/**
	 * @return the endCity
	 */
	public String getEndCity() {
		return endCity;
	}
	/**
	 * @param endCity the endCity to set
	 */
	public void setEndCity(String endCity) {
		this.endCity = endCity;
	}
	/**
	 * @return the stratCityPoit1
	 */
	public String getStratCityPoit1() {
		return stratCityPoit1;
	}
	/**
	 * @param stratCityPoit1 the stratCityPoit1 to set
	 */
	public void setStratCityPoit1(String stratCityPoit1) {
		this.stratCityPoit1 = stratCityPoit1;
	}
	/**
	 * @return the stratCityPoit2
	 */
	public String getStratCityPoit2() {
		return stratCityPoit2;
	}
	/**
	 * @param stratCityPoit2 the stratCityPoit2 to set
	 */
	public void setStratCityPoit2(String stratCityPoit2) {
		this.stratCityPoit2 = stratCityPoit2;
	}
	/**
	 * @return the endCityCityPoit1
	 */
	public String getEndCityCityPoit1() {
		return endCityCityPoit1;
	}
	/**
	 * @param endCityCityPoit1 the endCityCityPoit1 to set
	 */
	public void setEndCityCityPoit1(String endCityCityPoit1) {
		this.endCityCityPoit1 = endCityCityPoit1;
	}
	/**
	 * @return the endCityCityPoit2
	 */
	public String getEndCityCityPoit2() {
		return endCityCityPoit2;
	}
	/**
	 * @param endCityCityPoit2 the endCityCityPoit2 to set
	 */
	public void setEndCityCityPoit2(String endCityCityPoit2) {
		this.endCityCityPoit2 = endCityCityPoit2;
	}
	/**
	 * @return the indexx
	 */
	public String getIndexx() {
		return indexx;
	}
	/**
	 * @param indexx the indexx to set
	 */
	public void setIndexx(String indexx) {
		this.indexx = indexx;
	}
	/**
	 * @return the flightAirlineId
	 */
	public String getFlightAirlineId() {
		return flightAirlineId;
	}
	/**
	 * @param flightAirlineId the flightAirlineId to set
	 */
	public void setFlightAirlineId(String flightAirlineId) {
		this.flightAirlineId = flightAirlineId;
	}
	/**
	 * @return the pointId
	 */
	public String getPointId() {
		return pointId;
	}
	/**
	 * @param pointId the pointId to set
	 */
	public void setPointId(String pointId) {
		this.pointId = pointId;
	}
	/**
	 * @return the pointName
	 */
	public String getPointName() {
		return pointName;
	}
	/**
	 * @param pointName the pointName to set
	 */
	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	/**
	 * @return the pointId2
	 */
	public String getPointId2() {
		return pointId2;
	}

	/**
	 * @param pointId2 the pointId2 to set
	 */
	public void setPointId2(String pointId2) {
		this.pointId2 = pointId2;
	}

	/**
	 * @return the airLineDistance
	 */
	public String getAirLineDistance() {
		return airLineDistance;
	}

	/**
	 * @param airLineDistance the airLineDistance to set
	 */
	public void setAirLineDistance(String airLineDistance) {
		this.airLineDistance = airLineDistance;
	}

	/**
	 * @return the startType
	 */
	public String getStartType() {
		return startType;
	}

	/**
	 * @param startType the startType to set
	 */
	public void setStartType(String startType) {
		this.startType = startType;
	}

	/**
	 * @return the endType
	 */
	public String getEndType() {
		return endType;
	}

	/**
	 * @param endType the endType to set
	 */
	public void setEndType(String endType) {
		this.endType = endType;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "FlightAirline [stratCity=" + stratCity + ", endCity=" + endCity
				+ ", stratCityPoit1=" + stratCityPoit1 + ", stratCityPoit2="
				+ stratCityPoit2 + ", endCityCityPoit1=" + endCityCityPoit1
				+ ", endCityCityPoit2=" + endCityCityPoit2 + ", indexx="
				+ indexx + ", flightAirlineId=" + flightAirlineId
				+ ", pointId=" + pointId + ", pointId2=" + pointId2
				+ ", pointName=" + pointName + ", airLineDistance="
				+ airLineDistance + ", startType=" + startType + ", endType="
				+ endType + "]";
	}
}
