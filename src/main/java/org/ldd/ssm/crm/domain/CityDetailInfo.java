package org.ldd.ssm.crm.domain;
/**
 * 机场详细信息实体类
 * @Title:CityDetailInfo 
 * @Description:
 * @author taimei-gds 
 * @date 2017-2-28 上午11:05:22
 */
public class CityDetailInfo {
	private String id;        
	private String iATA;					  //四字码
	private String city_Name;                 //城市名字         
	private String city_Countries;            //所在国家         
	private String city_Aea;                  //总面积          
	private String city_Center_Aea;           //市区面积         
	private String city_Type;                 //行政区类别        
	private String city_Loaclhost;            //位置           
	private String city_Terrain;              //地形           
	private String city_Climate;              //气候特点         
	private String city_Railway;              //铁路干线         
	private String city_rail;                 //高铁           
	private String city_pge_Count;            //总量           
	private String city_pge_number;           //城镇人口         
	private String city_rural_number;         //乡村人口         
	private String city_resident_number;      //常驻人口         
	private String pge_income;                //人均收入         
	private String city_pge_income;           //城镇人均收入       
	private String rural_income;              //乡村人均收入       
	private String important_Economic_Support;//重要经济支撑       
	private long employee_id;//用户id
	private String employee;
	private String date;//修改时间
	public CityDetailInfo() {
		super();
	}
	public CityDetailInfo(String id, String iATA,String city_Name, String city_Countries,
			String city_Aea, String city_Center_Aea, String city_Type,
			String city_Loaclhost, String city_Terrain, String city_Climate,
			String city_Railway, String city_rail, String city_pge_Count,
			String city_pge_number, String city_rural_number,
			String city_resident_number, String pge_income,
			String city_pge_income, String rural_income,
			String important_Economic_Support
			) {
		super();
		this.id = id;
		this.iATA = iATA;
		this.city_Name = city_Name;
		this.city_Countries = city_Countries;
		this.city_Aea = city_Aea;
		this.city_Center_Aea = city_Center_Aea;
		this.city_Type = city_Type;
		this.city_Loaclhost = city_Loaclhost;
		this.city_Terrain = city_Terrain;
		this.city_Climate = city_Climate;
		this.city_Railway = city_Railway;
		this.city_rail = city_rail;
		this.city_pge_Count = city_pge_Count;
		this.city_pge_number = city_pge_number;
		this.city_rural_number = city_rural_number;
		this.city_resident_number = city_resident_number;
		this.pge_income = pge_income;
		this.city_pge_income = city_pge_income;
		this.rural_income = rural_income;
		this.important_Economic_Support = important_Economic_Support;
	}
	public long getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(long employee_id) {
		this.employee_id = employee_id;
	}
	public String getEmployee() {
		return employee;
	}
	public void setEmployee(String employee) {
		this.employee = employee;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCity_Name() {
		return city_Name;
	}
	public void setCity_Name(String city_Name) {
		this.city_Name = city_Name;
	}
	public String getCity_Countries() {
		return city_Countries;
	}
	public void setCity_Countries(String city_Countries) {
		this.city_Countries = city_Countries;
	}
	public String getCity_Aea() {
		return city_Aea;
	}
	public void setCity_Aea(String city_Aea) {
		this.city_Aea = city_Aea;
	}
	public String getCity_Center_Aea() {
		return city_Center_Aea;
	}
	public void setCity_Center_Aea(String city_Center_Aea) {
		this.city_Center_Aea = city_Center_Aea;
	}
	public String getCity_Type() {
		return city_Type;
	}
	public void setCity_Type(String city_Type) {
		this.city_Type = city_Type;
	}
	public String getCity_Loaclhost() {
		return city_Loaclhost;
	}
	public void setCity_Loaclhost(String city_Loaclhost) {
		this.city_Loaclhost = city_Loaclhost;
	}
	public String getCity_Terrain() {
		return city_Terrain;
	}
	public void setCity_Terrain(String city_Terrain) {
		this.city_Terrain = city_Terrain;
	}
	public String getCity_Climate() {
		return city_Climate;
	}
	public void setCity_Climate(String city_Climate) {
		this.city_Climate = city_Climate;
	}
	public String getCity_Railway() {
		return city_Railway;
	}
	public void setCity_Railway(String city_Railway) {
		this.city_Railway = city_Railway;
	}
	public String getCity_rail() {
		return city_rail;
	}
	public void setCity_rail(String city_rail) {
		this.city_rail = city_rail;
	}
	public String getCity_pge_Count() {
		return city_pge_Count;
	}
	public void setCity_pge_Count(String city_pge_Count) {
		this.city_pge_Count = city_pge_Count;
	}
	public String getCity_pge_number() {
		return city_pge_number;
	}
	public void setCity_pge_number(String city_pge_number) {
		this.city_pge_number = city_pge_number;
	}
	public String getCity_rural_number() {
		return city_rural_number;
	}
	public void setCity_rural_number(String city_rural_number) {
		this.city_rural_number = city_rural_number;
	}
	public String getCity_resident_number() {
		return city_resident_number;
	}
	public void setCity_resident_number(String city_resident_number) {
		this.city_resident_number = city_resident_number;
	}
	public String getPge_income() {
		return pge_income;
	}
	public void setPge_income(String pge_income) {
		this.pge_income = pge_income;
	}
	public String getCity_pge_income() {
		return city_pge_income;
	}
	public void setCity_pge_income(String city_pge_income) {
		this.city_pge_income = city_pge_income;
	}
	public String getRural_income() {
		return rural_income;
	}
	public void setRural_income(String rural_income) {
		this.rural_income = rural_income;
	}
	
	public String getImportant_Economic_Support() {
		return important_Economic_Support;
	}
	public void setImportant_Economic_Support(String important_Economic_Support) {
		this.important_Economic_Support = important_Economic_Support;
	}
	/**
	 * @return the iATA
	 */
	public String getiATA() {
		return iATA;
	}
	/**
	 * @param iATA the iATA to set
	 */
	public void setiATA(String iATA) {
		this.iATA = iATA;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CityDetailInfo [id=" + id + ", iATA=" + iATA + ", city_Name="
				+ city_Name + ", city_Countries=" + city_Countries
				+ ", city_Aea=" + city_Aea + ", city_Center_Aea="
				+ city_Center_Aea + ", city_Type=" + city_Type
				+ ", city_Loaclhost=" + city_Loaclhost + ", city_Terrain="
				+ city_Terrain + ", city_Climate=" + city_Climate
				+ ", city_Railway=" + city_Railway + ", city_rail=" + city_rail
				+ ", city_pge_Count=" + city_pge_Count + ", city_pge_number="
				+ city_pge_number + ", city_rural_number=" + city_rural_number
				+ ", city_resident_number=" + city_resident_number
				+ ", pge_income=" + pge_income + ", city_pge_income="
				+ city_pge_income + ", rural_income=" + rural_income
				+ ", important_Economic_Support=" + important_Economic_Support
				+ ", employee_id=" + employee_id + ", employee=" + employee
				+ ", date=" + date + "]";
	}
	
}
