package org.ldd.ssm.crm.query;

import java.util.List;

/**
 * 高级查询加分页的封装对象
 */
public class SourceDistriDataQuery {
	private String lcl_Dpt_Tm;
	private String lcl_Arrv_Tm;
	private String dpt_AirPt_Cd;
	private String pas_stp;
	private String arrv_Airpt_Cd;
	private String flt_nbr;
	private String name;
	
	private String itia;
	private String isIncludePasDpt;//是否包含经停
	private List<String> fltnbrs;//所有的航班号以逗号分隔
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getItia() {
		return itia;
	}
	public void setItia(String itia) {
		this.itia = itia;
	}
	public String getLcl_Dpt_Tm() {
		return lcl_Dpt_Tm;
	}
	public void setLcl_Dpt_Tm(String lcl_Dpt_Tm) {
		this.lcl_Dpt_Tm = lcl_Dpt_Tm;
	}
	public String getLcl_Arrv_Tm() {
		return lcl_Arrv_Tm;
	}
	public void setLcl_Arrv_Tm(String lcl_Arrv_Tm) {
		this.lcl_Arrv_Tm = lcl_Arrv_Tm;
	}
	public String getDpt_AirPt_Cd() {
		return dpt_AirPt_Cd;
	}
	public void setDpt_AirPt_Cd(String dpt_AirPt_Cd) {
		this.dpt_AirPt_Cd = dpt_AirPt_Cd;
	}
	public String getPas_stp() {
		return pas_stp;
	}
	public void setPas_stp(String pas_stp) {
		this.pas_stp = pas_stp;
	}
	public String getArrv_Airpt_Cd() {
		return arrv_Airpt_Cd;
	}
	public void setArrv_Airpt_Cd(String arrv_Airpt_Cd) {
		this.arrv_Airpt_Cd = arrv_Airpt_Cd;
	}
	public String getFlt_nbr() {
		return flt_nbr;
	}
	public void setFlt_nbr(String flt_nbr) {
		this.flt_nbr = flt_nbr;
	}
	/**
	 * @return the isIncludePasDpt
	 */
	public String getIsIncludePasDpt() {
		return isIncludePasDpt;
	}
	/**
	 * @param isIncludePasDpt the isIncludePasDpt to set
	 */
	public void setIsIncludePasDpt(String isIncludePasDpt) {
		this.isIncludePasDpt = isIncludePasDpt;
	}
	
	
	/**
	 * @return the fltnbrs
	 */
	public List<String> getFltnbrs() {
		return fltnbrs;
	}
	/**
	 * @param fltnbrs the fltnbrs to set
	 */
	public void setFltnbrs(List<String> fltnbrs) {
		this.fltnbrs = fltnbrs;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SourceDistriDataQuery [lcl_Dpt_Tm=" + lcl_Dpt_Tm
				+ ", lcl_Arrv_Tm=" + lcl_Arrv_Tm + ", dpt_AirPt_Cd="
				+ dpt_AirPt_Cd + ", pas_stp=" + pas_stp + ", arrv_Airpt_Cd="
				+ arrv_Airpt_Cd + ", flt_nbr=" + flt_nbr + ", name=" + name
				+ ", itia=" + itia + ", isIncludePasDpt=" + isIncludePasDpt
				+ ", fltnbrs=" + fltnbrs + "]";
	}
	
}