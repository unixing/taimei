package org.ldd.ssm.crm.query;
/**
 * 机场历史运营 查询条件类
 * @author Taimei
 *
 */
public class AirportOperatingHistoryQuery {
	private String dpt_AirPt_Cd;
	private String startTime;
	private String endTime;
	private String cpy_Nm;
	
	public String getCpy_Nm() {
		return cpy_Nm;
	}
	public void setCpy_Nm(String cpy_Nm) {
		this.cpy_Nm = cpy_Nm;
	}
	public String getDpt_AirPt_Cd() {
		return dpt_AirPt_Cd;
	}
	public void setDpt_AirPt_Cd(String dpt_AirPt_Cd) {
		this.dpt_AirPt_Cd = dpt_AirPt_Cd;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	@Override
	public String toString() {
		return "AirportOperatingHistoryQuery [dpt_AirPt_Cd=" + dpt_AirPt_Cd
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", cpy_Nm=" + cpy_Nm + "]";
	}
}
