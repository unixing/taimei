DROP TABLE IF EXISTS t_divide_season;
CREATE TABLE t_divide_season (
Divide_Id  int(10) NOT NULL AUTO_INCREMENT ,
Divide_Month  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Dpt_AirPt_Cd  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Arrv_Airpt_Cd  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Flt_Nbr  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Flt_Rte_Cd  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Days  int(11) NULL DEFAULT 0 ,
Yoy_Trans  decimal(10,0) NULL DEFAULT 0 ,
Qoq_Trans  decimal(10,0) NULL DEFAULT 0 ,
Curr_Trans  decimal(10,0) NULL DEFAULT 0 ,
Avg_GO_Cust  int(11) NULL DEFAULT 0 ,
Avg_Return_Cust  int(11) NULL DEFAULT 0 ,
Avg_Go_Dis  decimal(10,0) NULL DEFAULT 0 ,
Avg_Return_Dis  decimal(10,0) NULL DEFAULT 0 ,
Description  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (Divide_Id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_divide_time;
CREATE TABLE t_divide_time (
Divide_Id  int(10) NOT NULL AUTO_INCREMENT ,
Season_Id  int(10) NULL DEFAULT 0 ,
Flt_Direct  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Start_Date  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
End_Date  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Ref_Sale_Start_Date  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Ref_Sale_End_Date  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Nature  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (Divide_Id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_monthsaleplan;
CREATE TABLE t_monthsaleplan (
id  int(10) NOT NULL AUTO_INCREMENT ,
Time_Id  int(10) NULL DEFAULT 0 ,
Agreement  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
FIT_Nbr  int(10) NULL DEFAULT 0 ,
All_Fold  decimal(10,2) NULL DEFAULT 0.00 ,
Lowest_Sale  decimal(10,2) NULL DEFAULT 0.00 ,
Group_Nbr  int(10) NULL DEFAULT 0 ,
FIT_Sale_Cycle  int(10) NULL DEFAULT 0 ,
Discount_Return  decimal(10,2) NULL DEFAULT 0.00 ,
Group_Sale_Cycle  int(10) NULL DEFAULT 0 ,
Est_Posi_Nbr  int(10) NULL DEFAULT 0 ,
Est_Dispose_Plan  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
Frequency  int(10) NULL DEFAULT 0 ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_cabinseatset;
CREATE TABLE t_cabinseatset (
id  int(10) NOT NULL AUTO_INCREMENT ,
Time_Id  int(10) NULL DEFAULT 0 ,
Grp_Prc  decimal(10,2) NULL DEFAULT 0.00 ,
Two_Tak_Ppt  int(10) NULL DEFAULT 0 ,
Ful_Pce_Ppt  int(10) NULL DEFAULT 0 ,
Nne_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Eht_Five_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Eht_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Sen_Five_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Sen_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Six_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Fve_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Fur_Fve_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Fur_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Thr_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Two_Dnt_Ppt  int(10) NULL DEFAULT 0 ,
Grp_Nbr  int(10) NULL DEFAULT 0 ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_cityinfo;
CREATE TABLE t_cityinfo (
id  int(10) NOT NULL AUTO_INCREMENT ,
cityname varchar(20) NULL DEFAULT NULL,
economy  bigint(18) NULL DEFAULT 0 ,
population  int(10) NULL DEFAULT 0 ,
percapita  decimal(10,2) NULL DEFAULT 0.00 ,
structure  varchar(50) NULL DEFAULT null ,
traffic  varchar(50) NULL DEFAULT null ,
area  decimal(10,2) NULL DEFAULT 0.00 ,
popedom  varchar(100) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_buidschedule;
CREATE TABLE t_buidschedule (
id  int(10) NOT NULL AUTO_INCREMENT ,
airport_name  varchar(20) NULL DEFAULT null ,
init_buid_date  varchar(20) NULL DEFAULT null ,
accept_date  varchar(20) NULL DEFAULT null ,
revised_date  varchar(20) NULL DEFAULT null ,
test_flight_date  varchar(20) NULL DEFAULT null ,
planed_ship_date  varchar(20) NULL DEFAULT null ,
destination  varchar(50) NULL DEFAULT null ,
target_throughput  int(10) NULL DEFAULT 0 ,
awarding_policy  varchar(100) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_airpotinfo;
CREATE TABLE t_airportinfo (
id  int(10) NOT NULL AUTO_INCREMENT ,
airport_name  varchar(20) NULL DEFAULT null ,
runway_length  int(5) NULL DEFAULT 0 ,
runway_width  int(3) NULL DEFAULT 0 ,
airport_level  varchar(10) NULL DEFAULT null ,
fire_rating varchar(10) NULL DEFAULT null ,
can_stop_type  varchar(50) NULL DEFAULT null ,
airport_type  varchar(20) NULL DEFAULT null ,
climatic_changes  varchar(50) NULL DEFAULT null ,
clearance_condition  varchar(50) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_base;
CREATE TABLE t_base (
id  int(10) NOT NULL AUTO_INCREMENT ,
base_name  varchar(10) NULL DEFAULT null ,
plane_stop_position  varchar(30) NULL DEFAULT null ,
cityname  varchar(20) NULL DEFAULT null ,
plane_count  int(10) NULL DEFAULT 0 ,
plane_type  varchar(20) NULL DEFAULT null ,
flying_routes  varchar(20) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_saledptinfo;
CREATE TABLE t_saledptinfo (
id  int(10) NOT NULL AUTO_INCREMENT ,
dpt_name  varchar(20) NULL DEFAULT null ,
address  varchar(50) NULL DEFAULT null ,
linkman  varchar(20) NULL DEFAULT null ,
contact_way  varchar(20) NULL DEFAULT null ,
whether_local_base  varchar(10) NULL DEFAULT 'ÊÇ' ,
map_display  varchar(10) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_planeteam;
CREATE TABLE t_planeteam (
id  int(10) NOT NULL AUTO_INCREMENT ,
team_name  varchar(20) NULL DEFAULT null ,
plane_count  int(10) NULL DEFAULT 0 ,
plane_type  varchar(20) NULL DEFAULT null ,
plane_age  int(10) NULL DEFAULT 0 ,
flyer_count  int(10) NULL DEFAULT 0 ,
team_level  varchar(20) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_time_resource;
CREATE TABLE t_time_resource (
id  int(10) NOT NULL AUTO_INCREMENT ,
terminal  varchar(20) NULL DEFAULT null ,
proofread_airline  varchar(20) NULL DEFAULT null ,
flight_nbr  varchar(20) NULL DEFAULT null ,
air_route  varchar(20) NULL DEFAULT null ,
plane_type  varchar(20) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_flying_airroute;
CREATE TABLE t_flying_airroute (
id  int(10) NOT NULL AUTO_INCREMENT ,
air_route  varchar(20) NULL DEFAULT null ,
air_route_type  varchar(20) NULL DEFAULT null ,
schedule  varchar(20) NULL DEFAULT null ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;
DROP TABLE IF EXISTS t_transportinfo;
CREATE TABLE t_transportinfo (
id  int(10) NOT NULL AUTO_INCREMENT ,
transport_name  varchar(20) NULL DEFAULT null ,
transport_type  varchar(50) NULL DEFAULT null ,
airport_name varchar(20) NULL DEFAULT null,
hyperbolic  varchar(20) NULL DEFAULT null ,
running_time  varchar(20) NULL DEFAULT null ,
off_running_time  varchar(10) NULL DEFAULT null ,
sigle_trip_time  int(10) NULL DEFAULT 0 ,
interval_time  int(10) NULL DEFAULT 0 ,
PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=COMPACT;