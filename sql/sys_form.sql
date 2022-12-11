/*
 Navicat Premium Data Transfer

 Source Server         : tony
 Source Server Type    : MySQL
 Source Server Version : 50737 (5.7.37-log)
 Source Host           : 43.142.119.38:3306
 Source Schema         : flowable

 Target Server Type    : MySQL
 Target Server Version : 50737 (5.7.37-log)
 File Encoding         : 65001

 Date: 11/12/2022 17:36:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_form
-- ----------------------------
DROP TABLE IF EXISTS `sys_form`;
CREATE TABLE `sys_form` (
  `form_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表单主键',
  `form_name` varchar(50) DEFAULT NULL COMMENT '表单名称',
  `form_content` longtext COMMENT '表单内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人员',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人员',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`form_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3170 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='流程表单';

SET FOREIGN_KEY_CHECKS = 1;
