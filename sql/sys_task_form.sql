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

 Date: 11/12/2022 17:37:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_task_form
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_form`;
CREATE TABLE `sys_task_form` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `form_id` bigint(20) DEFAULT NULL COMMENT '表单主键',
  `task_id` varchar(50) DEFAULT NULL COMMENT '所属任务',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='流程任务关联表单';

SET FOREIGN_KEY_CHECKS = 1;
