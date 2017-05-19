package org.ldd.ssm.crm.domain;
/**
 * 机场详细信息实体类
 * @Title:AirportDetailInfo 
 * @Description:
 * @author taimei-gds 
 * @date 2017-2-28 上午11:01:08
 */
public class AirportDetailInfo {
	private String id;                                 //
	private String airln_Cd;                           //   机场名字
	private String iATA;                               //   机场三字码
	private String iCAO;                               //   机场四字码
	private String cts_Cha_Nm;                         //   所在国家
	private String city_coordinate_j;                  //   经度
	private String city_coordinate_w;                  //   纬度
	private String city_name;                          //   位置                     
	private String air_state;                          //   机场状态           (0:启用,1:在建,2:筹备)        
	private String air_type;                           //   机场类型           (0:民用,1:军用)        
	private String air_port;                           //   航空口岸           (0:正式,1:临时,2:非航空口岸)       
	private String air_lvl;                            //   机场等级                  
	private String flg_type;                           //   可停降机型                  
	private String air_conditions;                     //   起降条件            (0:目视进近程序飞行,1:非精密进近跑道,2:Ⅰ类,3:Ⅱ类,4:Ⅲ类)    
	private String fire_lvl;                           //   消防等级                   
	private String air_ele;                            //   机场标高                   
	private String avg_tem;                            //   全年平均温度                 
	private String airline_data_state;                 //   航线数据库状态  (0:未发布,1:发布未生效,2:生效)              
	private String terrain_data_state;                 //   地形数据库状态  (0:未发布,1:发布未生效,2:生效)              
	private String air_subway;                         //   市内到机场地铁/轻轨             
	private String air_bus;                            //   市内到机场巴士                
	private String air_distance;                       //   市内到机场距离                
	private String air_covers;                         //   占地面积                   
	private String air_terminal;                       //   航站楼                    
	private String slots_total;                        //   机位总数                   
	private String terminal;                           //   候机楼                    
	private String air_runway;                         //   跑道                     
	private String air_runway_long;                    //   长                      
	private String air_runway_wide;                    //   宽                      
	private String air_apron;                          //   停机坪                    
	private String air_boarding_bridge;                //   登机桥                    
	private String air_capacity;                       //   高峰小时容量(针对协调机场) 
	private String yeah;               				   //   年份  
	private String yeah_air;               				   //   年份  
	private String air_complete;                       //   起降架次                  
	private String air_Passenger_throughput;           //   旅客吞吐量                            
	private String air_Goods_throughput;               //   货邮吞吐量                            
	private String air_line;                           //   在飞航线                             
	private String air_line_domestic;                  //   国内                               
	private String air_line_inter;                     //   国际                               
	private String air_early_date;                     //   初建日期                             
	private String air_acceptance_date;                //   验收日期                             
	private String air_school_fly_date;                //   校飞日期                             
	private String air_flight_date;                    //   试飞日期                             
	private String air_Planned_shipping_time;          //   计划通航时间                           
	private String air_target_throughput;              //   目标吞吐量                            
	private String air_Preliminary_planning_and_city;  //   初步规划城市                           
	private String air_Reward_policy;                  //   奖励政策      
	private long   employee_id;						   //	用户id
	private String employee;						   //	用户名
	private String date;							   // 	修改时间
	
	public AirportDetailInfo() {
		super();
		// TODO Auto-generated constructor stub
	}


	public AirportDetailInfo(String id, String airln_Cd, String iATA, String iCAO,
			String cts_Cha_Nm, String city_coordinate_j,
			String city_coordinate_w, String city_name, String air_state,
			String air_type, String air_port, String air_lvl, String flg_type,
			String air_conditions, String fire_lvl, String air_ele,
			String avg_tem, String airline_data_state,
			String terrain_data_state, String air_subway, String air_bus,
			String air_distance, String air_covers, String air_terminal,
			String slots_total, String terminal, String air_runway,
			String air_runway_long, String air_runway_wide, String air_apron,
			String air_boarding_bridge, String air_capacity, String yeah,
			String yeah_air, String air_complete,
			String air_Passenger_throughput, String air_Goods_throughput,
			String air_line, String air_line_domestic, String air_line_inter,
			String air_early_date, String air_acceptance_date,
			String air_school_fly_date, String air_flight_date,
			String air_Planned_shipping_time, String air_target_throughput,
			String air_Preliminary_planning_and_city, String air_Reward_policy) {
		super();
		this.id = id;
		this.airln_Cd = airln_Cd;
		this.iATA = iATA;
		this.iCAO = iCAO;
		this.cts_Cha_Nm = cts_Cha_Nm;
		this.city_coordinate_j = city_coordinate_j;
		this.city_coordinate_w = city_coordinate_w;
		this.city_name = city_name;
		this.air_state = air_state;
		this.air_type = air_type;
		this.air_port = air_port;
		this.air_lvl = air_lvl;
		this.flg_type = flg_type;
		this.air_conditions = air_conditions;
		this.fire_lvl = fire_lvl;
		this.air_ele = air_ele;
		this.avg_tem = avg_tem;
		this.airline_data_state = airline_data_state;
		this.terrain_data_state = terrain_data_state;
		this.air_subway = air_subway;
		this.air_bus = air_bus;
		this.air_distance = air_distance;
		this.air_covers = air_covers;
		this.air_terminal = air_terminal;
		this.slots_total = slots_total;
		this.terminal = terminal;
		this.air_runway = air_runway;
		this.air_runway_long = air_runway_long;
		this.air_runway_wide = air_runway_wide;
		this.air_apron = air_apron;
		this.air_boarding_bridge = air_boarding_bridge;
		this.air_capacity = air_capacity;
		this.yeah = yeah;
		this.yeah_air = yeah_air;
		this.air_complete = air_complete;
		this.air_Passenger_throughput = air_Passenger_throughput;
		this.air_Goods_throughput = air_Goods_throughput;
		this.air_line = air_line;
		this.air_line_domestic = air_line_domestic;
		this.air_line_inter = air_line_inter;
		this.air_early_date = air_early_date;
		this.air_acceptance_date = air_acceptance_date;
		this.air_school_fly_date = air_school_fly_date;
		this.air_flight_date = air_flight_date;
		this.air_Planned_shipping_time = air_Planned_shipping_time;
		this.air_target_throughput = air_target_throughput;
		this.air_Preliminary_planning_and_city = air_Preliminary_planning_and_city;
		this.air_Reward_policy = air_Reward_policy;
	}



	public String getYeah_air() {
		return yeah_air;
	}

	public void setYeah_air(String yeah_air) {
		this.yeah_air = yeah_air;
	}

	public String getYeah() {
		return yeah;
	}

	public void setYeah(String yeah) {
		this.yeah = yeah;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAirln_Cd() {
		return airln_Cd;
	}
	public void setAirln_Cd(String airln_Cd) {
		this.airln_Cd = airln_Cd;
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
	public String getCts_Cha_Nm() {
		return cts_Cha_Nm;
	}
	public void setCts_Cha_Nm(String cts_Cha_Nm) {
		this.cts_Cha_Nm = cts_Cha_Nm;
	}
	public String getCity_coordinate_j() {
		return city_coordinate_j;
	}
	public void setCity_coordinate_j(String city_coordinate_j) {
		this.city_coordinate_j = city_coordinate_j;
	}
	public String getCity_coordinate_w() {
		return city_coordinate_w;
	}
	public void setCity_coordinate_w(String city_coordinate_w) {
		this.city_coordinate_w = city_coordinate_w;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	public String getAir_state() {
		return air_state;
	}
	public void setAir_state(String air_state) {
		this.air_state = air_state;
	}
	public String getAir_type() {
		return air_type;
	}
	public void setAir_type(String air_type) {
		this.air_type = air_type;
	}
	public String getAir_port() {
		return air_port;
	}
	public void setAir_port(String air_port) {
		this.air_port = air_port;
	}
	public String getAir_lvl() {
		return air_lvl;
	}
	public void setAir_lvl(String air_lvl) {
		this.air_lvl = air_lvl;
	}
	public String getFlg_type() {
		return flg_type;
	}
	public void setFlg_type(String flg_type) {
		this.flg_type = flg_type;
	}
	public String getAir_conditions() {
		return air_conditions;
	}
	public void setAir_conditions(String air_conditions) {
		this.air_conditions = air_conditions;
	}
	public String getFire_lvl() {
		return fire_lvl;
	}
	public void setFire_lvl(String fire_lvl) {
		this.fire_lvl = fire_lvl;
	}
	public String getAir_ele() {
		return air_ele;
	}
	public void setAir_ele(String air_ele) {
		this.air_ele = air_ele;
	}
	public String getAvg_tem() {
		return avg_tem;
	}
	public void setAvg_tem(String avg_tem) {
		this.avg_tem = avg_tem;
	}
	public String getAirline_data_state() {
		return airline_data_state;
	}
	public void setAirline_data_state(String airline_data_state) {
		this.airline_data_state = airline_data_state;
	}
	public String getTerrain_data_state() {
		return terrain_data_state;
	}
	public void setTerrain_data_state(String terrain_data_state) {
		this.terrain_data_state = terrain_data_state;
	}
	public String getAir_subway() {
		return air_subway;
	}
	public void setAir_subway(String air_subway) {
		this.air_subway = air_subway;
	}
	public String getAir_bus() {
		return air_bus;
	}
	public void setAir_bus(String air_bus) {
		this.air_bus = air_bus;
	}
	public String getAir_distance() {
		return air_distance;
	}
	public void setAir_distance(String air_distance) {
		this.air_distance = air_distance;
	}
	public String getAir_covers() {
		return air_covers;
	}
	public void setAir_covers(String air_covers) {
		this.air_covers = air_covers;
	}
	public String getAir_terminal() {
		return air_terminal;
	}
	public void setAir_terminal(String air_terminal) {
		this.air_terminal = air_terminal;
	}
	public String getSlots_total() {
		return slots_total;
	}
	public void setSlots_total(String slots_total) {
		this.slots_total = slots_total;
	}
	public String getTerminal() {
		return terminal;
	}
	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}
	public String getAir_runway() {
		return air_runway;
	}
	public void setAir_runway(String air_runway) {
		this.air_runway = air_runway;
	}
	public String getAir_runway_long() {
		return air_runway_long;
	}
	public void setAir_runway_long(String air_runway_long) {
		this.air_runway_long = air_runway_long;
	}
	public String getAir_runway_wide() {
		return air_runway_wide;
	}
	public void setAir_runway_wide(String air_runway_wide) {
		this.air_runway_wide = air_runway_wide;
	}
	public String getAir_apron() {
		return air_apron;
	}
	public void setAir_apron(String air_apron) {
		this.air_apron = air_apron;
	}
	public String getAir_boarding_bridge() {
		return air_boarding_bridge;
	}
	public void setAir_boarding_bridge(String air_boarding_bridge) {
		this.air_boarding_bridge = air_boarding_bridge;
	}
	public String getAir_capacity() {
		return air_capacity;
	}
	public void setAir_capacity(String air_capacity) {
		this.air_capacity = air_capacity;
	}
	public String getAir_complete() {
		return air_complete;
	}
	public void setAir_complete(String air_complete) {
		this.air_complete = air_complete;
	}
	public String getAir_Passenger_throughput() {
		return air_Passenger_throughput;
	}
	public void setAir_Passenger_throughput(String air_Passenger_throughput) {
		this.air_Passenger_throughput = air_Passenger_throughput;
	}
	public String getAir_Goods_throughput() {
		return air_Goods_throughput;
	}
	public void setAir_Goods_throughput(String air_Goods_throughput) {
		this.air_Goods_throughput = air_Goods_throughput;
	}
	public String getAir_line() {
		return air_line;
	}
	public void setAir_line(String air_line) {
		this.air_line = air_line;
	}
	public String getAir_line_domestic() {
		return air_line_domestic;
	}
	public void setAir_line_domestic(String air_line_domestic) {
		this.air_line_domestic = air_line_domestic;
	}
	public String getAir_line_inter() {
		return air_line_inter;
	}
	public void setAir_line_inter(String air_line_inter) {
		this.air_line_inter = air_line_inter;
	}
	public String getAir_early_date() {
		return air_early_date;
	}
	public void setAir_early_date(String air_early_date) {
		this.air_early_date = air_early_date;
	}
	public String getAir_acceptance_date() {
		return air_acceptance_date;
	}
	public void setAir_acceptance_date(String air_acceptance_date) {
		this.air_acceptance_date = air_acceptance_date;
	}
	public String getAir_school_fly_date() {
		return air_school_fly_date;
	}
	public void setAir_school_fly_date(String air_school_fly_date) {
		this.air_school_fly_date = air_school_fly_date;
	}
	public String getAir_flight_date() {
		return air_flight_date;
	}
	public void setAir_flight_date(String air_flight_date) {
		this.air_flight_date = air_flight_date;
	}
	public String getAir_Planned_shipping_time() {
		return air_Planned_shipping_time;
	}
	public void setAir_Planned_shipping_time(String air_Planned_shipping_time) {
		this.air_Planned_shipping_time = air_Planned_shipping_time;
	}
	public String getAir_target_throughput() {
		return air_target_throughput;
	}
	public void setAir_target_throughput(String air_target_throughput) {
		this.air_target_throughput = air_target_throughput;
	}
	public String getAir_Preliminary_planning_and_city() {
		return air_Preliminary_planning_and_city;
	}
	public void setAir_Preliminary_planning_and_city(
			String air_Preliminary_planning_and_city) {
		this.air_Preliminary_planning_and_city = air_Preliminary_planning_and_city;
	}
	public String getAir_Reward_policy() {
		return air_Reward_policy;
	}
	public void setAir_Reward_policy(String air_Reward_policy) {
		this.air_Reward_policy = air_Reward_policy;
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
	@Override
	public String toString() {
		return "AirportInfo [id=" + id + ", airln_Cd=" + airln_Cd + ", iATA="
				+ iATA + ", iCAO=" + iCAO + ", cts_Cha_Nm=" + cts_Cha_Nm
				+ ", city_coordinate_j=" + city_coordinate_j
				+ ", city_coordinate_w=" + city_coordinate_w + ", city_name="
				+ city_name + ", air_state=" + air_state + ", air_type="
				+ air_type + ", air_port=" + air_port + ", air_lvl=" + air_lvl
				+ ", flg_type=" + flg_type + ", air_conditions="
				+ air_conditions + ", fire_lvl=" + fire_lvl + ", air_ele="
				+ air_ele + ", avg_tem=" + avg_tem + ", airline_data_state="
				+ airline_data_state + ", terrain_data_state="
				+ terrain_data_state + ", air_subway=" + air_subway
				+ ", air_bus=" + air_bus + ", air_distance=" + air_distance
				+ ", air_covers=" + air_covers + ", air_terminal="
				+ air_terminal + ", slots_total=" + slots_total + ", terminal="
				+ terminal + ", air_runway=" + air_runway
				+ ", air_runway_long=" + air_runway_long + ", air_runway_wide="
				+ air_runway_wide + ", air_apron=" + air_apron
				+ ", air_boarding_bridge=" + air_boarding_bridge
				+ ", air_capacity=" + air_capacity + ", yeah=" + yeah
				+ ", yeah_air=" + yeah_air + ", air_complete=" + air_complete
				+ ", air_Passenger_throughput=" + air_Passenger_throughput
				+ ", air_Goods_throughput=" + air_Goods_throughput
				+ ", air_line=" + air_line + ", air_line_domestic="
				+ air_line_domestic + ", air_line_inter=" + air_line_inter
				+ ", air_early_date=" + air_early_date
				+ ", air_acceptance_date=" + air_acceptance_date
				+ ", air_school_fly_date=" + air_school_fly_date
				+ ", air_flight_date=" + air_flight_date
				+ ", air_Planned_shipping_time=" + air_Planned_shipping_time
				+ ", air_target_throughput=" + air_target_throughput
				+ ", air_Preliminary_planning_and_city="
				+ air_Preliminary_planning_and_city + ", air_Reward_policy="
				+ air_Reward_policy + ", employee_id=" + employee_id
				+ ", employee=" + employee + ", date=" + date + "]";
	}
}