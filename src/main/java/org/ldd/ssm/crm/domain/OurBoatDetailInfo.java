package org.ldd.ssm.crm.domain;

/**
 * 航司详细信息实体类
 * @Title:OurBoatDetailInfo 
 * @Description:
 * @author taimei-gds 
 * @date 2017-2-28 上午11:03:31
 */
public class OurBoatDetailInfo {
	private String id;
	private String airln_Cd;			// 航司名字
	private String iATA;				// IATA代码
	private String iCAO;				// ICAO代码
	private String head_Loca;			// 总部位置
	private String the_History_Of;		// 发展史
	private String platformPositioning;	// 平台定位
	private String airln_number;		// 飞机数量
	private String airCrft_Typ;			// 机型
	private String number;				// 数量
	private String avg_age;				// 平均年龄
	private String man_Count;			// 飞行员总数
	private String airline_true;		// 在飞航线
	private String airline_CH;			// 国内
	private String airline_inter;		// 国际
	private String base_Name;			// 基地名
	private String base_city;			// 基地所在城市
	private String air_number;			// 飞机数量
	private String air_type;			// 机型
	private String air_location;		// 过夜基地位置
	private long employee_id;//用户id
	private String employee;
	private String date;//修改时间

	public OurBoatDetailInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OurBoatDetailInfo(String id, String airln_Cd, String iATA, String iCAO,
			String head_Loca, String the_History_Of,
			String platformPositioning, String airln_number,
			String airCrft_Typ, String number, String avg_age,
			String man_Count, String airline_true, String airline_CH,
			String airline_inter, String base_Name, String base_city,
			String air_number, String air_type, String air_location
			) {
		super();
		this.id = id;
		this.airln_Cd = airln_Cd;
		this.iATA = iATA;
		this.iCAO = iCAO;
		this.head_Loca = head_Loca;
		this.the_History_Of = the_History_Of;
		this.platformPositioning = platformPositioning;
		this.airln_number = airln_number;
		this.airCrft_Typ = airCrft_Typ;
		this.number = number;
		this.avg_age = avg_age;
		this.man_Count = man_Count;
		this.airline_true = airline_true;
		this.airline_CH = airline_CH;
		this.airline_inter = airline_inter;
		this.base_Name = base_Name;
		this.base_city = base_city;
		this.air_number = air_number;
		this.air_type = air_type;
		this.air_location = air_location;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEmployee() {
		return employee;
	}

	public void setEmployee(String employee) {
		this.employee = employee;
	}

	public long getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(long employee_id) {
		this.employee_id = employee_id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getMan_Count() {
		return man_Count;
	}

	public void setMan_Count(String man_Count) {
		this.man_Count = man_Count;
	}

	public String getAirCrft_Typ() {
		return airCrft_Typ;
	}

	public void setAirCrft_Typ(String airCrft_Typ) {
		this.airCrft_Typ = airCrft_Typ;
	}

	public String getAir_location() {
		return air_location;
	}

	public void setAir_location(String air_location) {
		this.air_location = air_location;
	}

	public String getAir_number() {
		return air_number;
	}

	public void setAir_number(String air_number) {
		this.air_number = air_number;
	}

	public String getAir_type() {
		return air_type;
	}

	public void setAir_type(String air_type) {
		this.air_type = air_type;
	}

	public String getAirline_CH() {
		return airline_CH;
	}

	public void setAirline_CH(String airline_CH) {
		this.airline_CH = airline_CH;
	}

	public String getAirline_inter() {
		return airline_inter;
	}

	public void setAirline_inter(String airline_inter) {
		this.airline_inter = airline_inter;
	}

	public String getAirline_true() {
		return airline_true;
	}

	public void setAirline_true(String airline_true) {
		this.airline_true = airline_true;
	}

	public String getAirln_Cd() {
		return airln_Cd;
	}

	public void setAirln_Cd(String airln_Cd) {
		this.airln_Cd = airln_Cd;
	}

	public String getAirln_number() {
		return airln_number;
	}

	public void setAirln_number(String airln_number) {
		this.airln_number = airln_number;
	}

	public String getAvg_age() {
		return avg_age;
	}

	public void setAvg_age(String avg_age) {
		this.avg_age = avg_age;
	}

	public String getBase_Name() {
		return base_Name;
	}

	public void setBase_Name(String base_Name) {
		this.base_Name = base_Name;
	}

	public String getBase_city() {
		return base_city;
	}

	public void setBase_city(String base_city) {
		this.base_city = base_city;
	}

	public String getHead_Loca() {
		return head_Loca;
	}

	public void setHead_Loca(String head_Loca) {
		this.head_Loca = head_Loca;
	}

	public String getiATA() {
		return iATA;
	}

	public void setiATA(String iATA) {
		this.iATA = iATA;
	}

	public String getiCAO() {
		return iCAO;
	}

	public void setiCAO(String iCAO) {
		this.iCAO = iCAO;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getPlatformPositioning() {
		return platformPositioning;
	}

	public void setPlatformPositioning(String platformPositioning) {
		this.platformPositioning = platformPositioning;
	}

	public String getThe_History_Of() {
		return the_History_Of;
	}

	public void setThe_History_Of(String the_History_Of) {
		this.the_History_Of = the_History_Of;
	}

	@Override
	public String toString() {
		return "Base [id=" + id + ", airln_Cd=" + airln_Cd + ", iATA=" + iATA
				+ ", iCAO=" + iCAO + ", head_Loca=" + head_Loca
				+ ", the_History_Of=" + the_History_Of
				+ ", platformPositioning=" + platformPositioning
				+ ", airln_number=" + airln_number + ", airCrft_Typ="
				+ airCrft_Typ + ", number=" + number + ", avg_age=" + avg_age
				+ ", man_Count=" + man_Count + ", airline_true=" + airline_true
				+ ", airline_CH=" + airline_CH + ", airline_inter="
				+ airline_inter + ", base_Name=" + base_Name + ", base_city="
				+ base_city + ", air_number=" + air_number + ", air_type="
				+ air_type + ", air_location=" + air_location
				+ ", employee_id=" + employee_id + ", employee=" + employee
				+ ", date=" + date + "]";
	}
}
