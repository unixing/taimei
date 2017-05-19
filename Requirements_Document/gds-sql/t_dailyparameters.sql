/*
Navicat MySQL Data Transfer

Source Server         : taimei
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : springmvc

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2016-05-30 10:16:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_dailyparameters`
-- ----------------------------
DROP TABLE IF EXISTS `t_dailyparameters`;
CREATE TABLE `t_dailyparameters` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `start_time` date DEFAULT NULL COMMENT '开始时间',
  `end_time` date DEFAULT NULL COMMENT '结束时间',
  `fly_site_min` int(10) DEFAULT NULL,
  `fly_site` int(10) DEFAULT NULL COMMENT '座位数',
  `hour_price` decimal(20,2) DEFAULT NULL COMMENT '小时成本',
  `agence_price` decimal(10,2) DEFAULT NULL COMMENT '代理费',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dailyparameters
-- ----------------------------
INSERT INTO `t_dailyparameters` VALUES ('10', '2013-05-01', '2016-05-28', '150', '202', '51000.00', '0.01', '12');
