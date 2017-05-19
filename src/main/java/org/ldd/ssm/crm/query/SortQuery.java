package org.ldd.ssm.crm.query;

public class SortQuery {
	private String itia;
	private String date;
	private String field;
	private String sortWay;
	public String getItia() {
		return itia;
	}
	public void setItia(String itia) {
		this.itia = itia;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getSortWay() {
		return sortWay;
	}
	public void setSortWay(String sortWay) {
		this.sortWay = sortWay;
	}
	@Override
	public String toString() {
		return "SortQuery [itia=" + itia + ", date=" + date + ", field="
				+ field + ", sortWay=" + sortWay + "]";
	}
	
}
