/*
Navicat MySQL Data Transfer

Source Server         : taimei
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : springmvc

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2016-05-30 10:17:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `z_digit`
-- ----------------------------
DROP TABLE IF EXISTS `z_digit`;
CREATE TABLE `z_digit` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `digit` int(4) DEFAULT '2' COMMENT '小数点位数',
  `expression` varchar(10) DEFAULT '0.00' COMMENT '位数对应的表达式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of z_digit
-- ----------------------------
INSERT INTO `z_digit` VALUES ('1', '4', '0.0000');
