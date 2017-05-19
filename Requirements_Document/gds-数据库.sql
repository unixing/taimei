/*
Navicat MySQL Data Transfer

Source Server         : taimei
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : springmvc

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2016-04-06 10:39:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `z_airlineforecast`
-- ----------------------------
DROP TABLE IF EXISTS `z_airlineforecast`;
CREATE TABLE `z_airlineforecast` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `startDate` date DEFAULT NULL COMMENT '开始时间',
  `endDate` date DEFAULT NULL COMMENT '结束时间',
  `dpt_AirPt_Cd` varchar(10) DEFAULT NULL COMMENT '始发地',
  `arrv_Airpt_Cd` varchar(10) DEFAULT NULL COMMENT '目的地',
  `pas_stp` varchar(10) DEFAULT NULL COMMENT '经停地',
  `fly_time` decimal(10,5) DEFAULT NULL COMMENT '飞行小时',
  `fly_price` decimal(20,2) DEFAULT NULL COMMENT '小时成本',
  `fly_type` varchar(20) DEFAULT NULL COMMENT '机型',
  `fly_site` int(5) DEFAULT NULL COMMENT '座位数',
  `fly_banqi` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '执行班期',
  `bp_time` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '预编排时刻',
  `bark` varchar(2000) DEFAULT NULL COMMENT '参考',
  `dta_Sce` varchar(100) DEFAULT NULL COMMENT '数据来源',
  `Dta_Dte` date DEFAULT NULL COMMENT '数据写入日期',
  `daili_price` decimal(10,4) DEFAULT NULL COMMENT '代理费',
  `fly_banci` varchar(10) DEFAULT NULL COMMENT '班次',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1163 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of z_airlineforecast



/*
Navicat MySQL Data Transfer

Source Server         : taimei
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : springmvc

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2016-04-05 14:04:03
*/

SET FOREIGN_KEY_CHECKS=0;

/*
Navicat MySQL Data Transfer

Source Server         : taimei
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : springmvc

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2016-04-05 14:04:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_airlineforecastdetail`
-- ----------------------------
DROP TABLE IF EXISTS `t_airlineforecastdetail`;
CREATE TABLE `t_airlineforecastdetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `airLineForecastId` bigint(20) NOT NULL COMMENT '外键',
  `dpt_AirPt_Cd` varchar(10) DEFAULT NULL COMMENT '出发地',
  `arrv_Airpt_Cd` varchar(10) DEFAULT NULL COMMENT '目的地',
  `pas_stp` varchar(10) DEFAULT NULL COMMENT '经停地',
  `hangju` int(3) DEFAULT NULL COMMENT '航距',
  `y_price` int(3) DEFAULT NULL COMMENT 'Y舱价格',
  `qie_team_price` int(3) unsigned zerofill DEFAULT NULL COMMENT '切位团队价',
  `f_flag` int(3) DEFAULT NULL,
  `y_flag` int(3) DEFAULT NULL,
  `b_flag` int(3) DEFAULT NULL,
  `h_flag` int(3) DEFAULT NULL,
  `k_flag` int(3) DEFAULT NULL,
  `l_flag` int(3) DEFAULT NULL,
  `m_flag` int(3) DEFAULT NULL,
  `q_flag` int(3) DEFAULT NULL,
  `x_flag` int(3) DEFAULT NULL,
  `u_flag` int(3) DEFAULT NULL,
  `e_flag` int(3) DEFAULT NULL,
  `z_flag` int(3) DEFAULT NULL,
  `t_flag` int(3) DEFAULT NULL,
  `v_flag` int(3) DEFAULT NULL,
  `g_flag` int(3) DEFAULT NULL,
  `o_flag` int(3) DEFAULT NULL,
  `s_flag` int(3) DEFAULT NULL,
  `qp_flag` int(3) DEFAULT NULL,
  `qt_flag` int(3) DEFAULT NULL,
  `dta_Sce` varchar(100) DEFAULT NULL COMMENT '数据来源',
  `Dta_Dte` date DEFAULT NULL COMMENT '数据写入日期',
  PRIMARY KEY (`id`),
  KEY `airLineForecastId` (`airLineForecastId`),
  CONSTRAINT `airLineForecastId` FOREIGN KEY (`airLineForecastId`) REFERENCES `z_airlineforecast` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_airlineforecastdetail
-- ----------------------------
