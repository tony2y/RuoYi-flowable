/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50731 (5.7.31)
 Source Host           : localhost:3306
 Source Schema         : tony-flowable

 Target Server Type    : MySQL
 Target Server Version : 50731 (5.7.31)
 File Encoding         : 65001

 Date: 28/12/2022 16:39:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ACT_APP_APPDEF
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_APPDEF`;
CREATE TABLE `ACT_APP_APPDEF` (
                                  `ID_` varchar(255) NOT NULL,
                                  `REV_` int(11) NOT NULL,
                                  `NAME_` varchar(255) DEFAULT NULL,
                                  `KEY_` varchar(255) NOT NULL,
                                  `VERSION_` int(11) NOT NULL,
                                  `CATEGORY_` varchar(255) DEFAULT NULL,
                                  `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                  `RESOURCE_NAME_` varchar(4000) DEFAULT NULL,
                                  `DESCRIPTION_` varchar(4000) DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) DEFAULT '',
                                  PRIMARY KEY (`ID_`),
                                  UNIQUE KEY `ACT_IDX_APP_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`),
                                  KEY `ACT_IDX_APP_DEF_DPLY` (`DEPLOYMENT_ID_`),
                                  CONSTRAINT `ACT_FK_APP_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_APP_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_APP_APPDEF
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_APP_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DATABASECHANGELOG`;
CREATE TABLE `ACT_APP_DATABASECHANGELOG` (
                                             `ID` varchar(255) NOT NULL,
                                             `AUTHOR` varchar(255) NOT NULL,
                                             `FILENAME` varchar(255) NOT NULL,
                                             `DATEEXECUTED` datetime NOT NULL,
                                             `ORDEREXECUTED` int(11) NOT NULL,
                                             `EXECTYPE` varchar(10) NOT NULL,
                                             `MD5SUM` varchar(35) DEFAULT NULL,
                                             `DESCRIPTION` varchar(255) DEFAULT NULL,
                                             `COMMENTS` varchar(255) DEFAULT NULL,
                                             `TAG` varchar(255) DEFAULT NULL,
                                             `LIQUIBASE` varchar(20) DEFAULT NULL,
                                             `CONTEXTS` varchar(255) DEFAULT NULL,
                                             `LABELS` varchar(255) DEFAULT NULL,
                                             `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_APP_DATABASECHANGELOG
-- ----------------------------
BEGIN;
INSERT INTO `ACT_APP_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-09-14 11:05:29', 1, 'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', NULL, '4.3.5', NULL, NULL, '4660729443');
INSERT INTO `ACT_APP_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-09-14 11:05:29', 2, 'EXECUTED', '8:ccea9ebfb6c1f8367ca4dd473fcbb7db', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_APP_DEPLOYMENT', '', NULL, '4.3.5', NULL, NULL, '4660729443');
INSERT INTO `ACT_APP_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-09-14 11:05:29', 3, 'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '4.3.5', NULL, NULL, '4660729443');
COMMIT;

-- ----------------------------
-- Table structure for ACT_APP_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_APP_DATABASECHANGELOGLOCK` (
                                                 `ID` int(11) NOT NULL,
                                                 `LOCKED` bit(1) NOT NULL,
                                                 `LOCKGRANTED` datetime DEFAULT NULL,
                                                 `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                 PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_APP_DATABASECHANGELOGLOCK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_APP_DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_APP_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DEPLOYMENT`;
CREATE TABLE `ACT_APP_DEPLOYMENT` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `CATEGORY_` varchar(255) DEFAULT NULL,
                                      `KEY_` varchar(255) DEFAULT NULL,
                                      `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) DEFAULT '',
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_APP_DEPLOYMENT
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_APP_DEPLOYMENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DEPLOYMENT_RESOURCE`;
CREATE TABLE `ACT_APP_DEPLOYMENT_RESOURCE` (
                                               `ID_` varchar(255) NOT NULL,
                                               `NAME_` varchar(255) DEFAULT NULL,
                                               `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                               `RESOURCE_BYTES_` longblob,
                                               PRIMARY KEY (`ID_`),
                                               KEY `ACT_IDX_APP_RSRC_DPL` (`DEPLOYMENT_ID_`),
                                               CONSTRAINT `ACT_FK_APP_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_APP_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_APP_DEPLOYMENT_RESOURCE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_CASEDEF
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_CASEDEF`;
CREATE TABLE `ACT_CMMN_CASEDEF` (
                                    `ID_` varchar(255) NOT NULL,
                                    `REV_` int(11) NOT NULL,
                                    `NAME_` varchar(255) DEFAULT NULL,
                                    `KEY_` varchar(255) NOT NULL,
                                    `VERSION_` int(11) NOT NULL,
                                    `CATEGORY_` varchar(255) DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                    `RESOURCE_NAME_` varchar(4000) DEFAULT NULL,
                                    `DESCRIPTION_` varchar(4000) DEFAULT NULL,
                                    `HAS_GRAPHICAL_NOTATION_` bit(1) DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) DEFAULT '',
                                    `DGRM_RESOURCE_NAME_` varchar(4000) DEFAULT NULL,
                                    `HAS_START_FORM_KEY_` bit(1) DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    UNIQUE KEY `ACT_IDX_CASE_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`),
                                    KEY `ACT_IDX_CASE_DEF_DPLY` (`DEPLOYMENT_ID_`),
                                    CONSTRAINT `ACT_FK_CASE_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_CMMN_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_CASEDEF
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DATABASECHANGELOG`;
CREATE TABLE `ACT_CMMN_DATABASECHANGELOG` (
                                              `ID` varchar(255) NOT NULL,
                                              `AUTHOR` varchar(255) NOT NULL,
                                              `FILENAME` varchar(255) NOT NULL,
                                              `DATEEXECUTED` datetime NOT NULL,
                                              `ORDEREXECUTED` int(11) NOT NULL,
                                              `EXECTYPE` varchar(10) NOT NULL,
                                              `MD5SUM` varchar(35) DEFAULT NULL,
                                              `DESCRIPTION` varchar(255) DEFAULT NULL,
                                              `COMMENTS` varchar(255) DEFAULT NULL,
                                              `TAG` varchar(255) DEFAULT NULL,
                                              `LIQUIBASE` varchar(20) DEFAULT NULL,
                                              `CONTEXTS` varchar(255) DEFAULT NULL,
                                              `LABELS` varchar(255) DEFAULT NULL,
                                              `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_DATABASECHANGELOG
-- ----------------------------
BEGIN;
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:27', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('5', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 5, 'EXECUTED', '8:70349de472f87368dcdec971a10311a0', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_CMMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_CASE_INST; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; modifyDataType columnName=T...', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 6, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 7, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 8, 'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 9, 'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 10, 'EXECUTED', '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 11, 'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 12, 'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 13, 'EXECUTED', '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('14', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 14, 'EXECUTED', '8:086b40b3a05596dcc8a8d7479922d494', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('16', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 15, 'EXECUTED', '8:a697a222ddd99dd15b36516a252f1c63', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('17', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-14 11:05:28', 16, 'EXECUTED', '8:d3706c5813a9b97fd2a59d12a9523946', 'createIndex indexName=ACT_IDX_HI_CASE_INST_END, tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.3.5', NULL, NULL, '4660727511');
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_CMMN_DATABASECHANGELOGLOCK` (
                                                  `ID` int(11) NOT NULL,
                                                  `LOCKED` bit(1) NOT NULL,
                                                  `LOCKGRANTED` datetime DEFAULT NULL,
                                                  `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_DATABASECHANGELOGLOCK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_CMMN_DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DEPLOYMENT`;
CREATE TABLE `ACT_CMMN_DEPLOYMENT` (
                                       `ID_` varchar(255) NOT NULL,
                                       `NAME_` varchar(255) DEFAULT NULL,
                                       `CATEGORY_` varchar(255) DEFAULT NULL,
                                       `KEY_` varchar(255) DEFAULT NULL,
                                       `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                       `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) DEFAULT '',
                                       PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_DEPLOYMENT
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_DEPLOYMENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DEPLOYMENT_RESOURCE`;
CREATE TABLE `ACT_CMMN_DEPLOYMENT_RESOURCE` (
                                                `ID_` varchar(255) NOT NULL,
                                                `NAME_` varchar(255) DEFAULT NULL,
                                                `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                                `RESOURCE_BYTES_` longblob,
                                                `GENERATED_` bit(1) DEFAULT NULL,
                                                PRIMARY KEY (`ID_`),
                                                KEY `ACT_IDX_CMMN_RSRC_DPL` (`DEPLOYMENT_ID_`),
                                                CONSTRAINT `ACT_FK_CMMN_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_CMMN_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_DEPLOYMENT_RESOURCE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_HI_CASE_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_HI_CASE_INST`;
CREATE TABLE `ACT_CMMN_HI_CASE_INST` (
                                         `ID_` varchar(255) NOT NULL,
                                         `REV_` int(11) NOT NULL,
                                         `BUSINESS_KEY_` varchar(255) DEFAULT NULL,
                                         `NAME_` varchar(255) DEFAULT NULL,
                                         `PARENT_ID_` varchar(255) DEFAULT NULL,
                                         `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                         `STATE_` varchar(255) DEFAULT NULL,
                                         `START_TIME_` datetime(3) DEFAULT NULL,
                                         `END_TIME_` datetime(3) DEFAULT NULL,
                                         `START_USER_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_TYPE_` varchar(255) DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) DEFAULT '',
                                         `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                         `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                         `LAST_REACTIVATION_TIME_` datetime(3) DEFAULT NULL,
                                         `LAST_REACTIVATION_USER_ID_` varchar(255) DEFAULT NULL,
                                         `BUSINESS_STATUS_` varchar(255) DEFAULT NULL,
                                         PRIMARY KEY (`ID_`),
                                         KEY `ACT_IDX_HI_CASE_INST_END` (`END_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_HI_CASE_INST
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_HI_MIL_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_HI_MIL_INST`;
CREATE TABLE `ACT_CMMN_HI_MIL_INST` (
                                        `ID_` varchar(255) NOT NULL,
                                        `REV_` int(11) NOT NULL,
                                        `NAME_` varchar(255) NOT NULL,
                                        `TIME_STAMP_` datetime(3) DEFAULT NULL,
                                        `CASE_INST_ID_` varchar(255) NOT NULL,
                                        `CASE_DEF_ID_` varchar(255) NOT NULL,
                                        `ELEMENT_ID_` varchar(255) NOT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT '',
                                        PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_HI_MIL_INST
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_HI_PLAN_ITEM_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_HI_PLAN_ITEM_INST`;
CREATE TABLE `ACT_CMMN_HI_PLAN_ITEM_INST` (
                                              `ID_` varchar(255) NOT NULL,
                                              `REV_` int(11) NOT NULL,
                                              `NAME_` varchar(255) DEFAULT NULL,
                                              `STATE_` varchar(255) DEFAULT NULL,
                                              `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `CASE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `STAGE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `IS_STAGE_` bit(1) DEFAULT NULL,
                                              `ELEMENT_ID_` varchar(255) DEFAULT NULL,
                                              `ITEM_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                              `ITEM_DEFINITION_TYPE_` varchar(255) DEFAULT NULL,
                                              `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_AVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_ENABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_DISABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_STARTED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_SUSPENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `COMPLETED_TIME_` datetime(3) DEFAULT NULL,
                                              `OCCURRED_TIME_` datetime(3) DEFAULT NULL,
                                              `TERMINATED_TIME_` datetime(3) DEFAULT NULL,
                                              `EXIT_TIME_` datetime(3) DEFAULT NULL,
                                              `ENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                              `START_USER_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                              `TENANT_ID_` varchar(255) DEFAULT '',
                                              `ENTRY_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `EXIT_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `SHOW_IN_OVERVIEW_` bit(1) DEFAULT NULL,
                                              `EXTRA_VALUE_` varchar(255) DEFAULT NULL,
                                              `DERIVED_CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `LAST_UNAVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_HI_PLAN_ITEM_INST
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_RU_CASE_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_CASE_INST`;
CREATE TABLE `ACT_CMMN_RU_CASE_INST` (
                                         `ID_` varchar(255) NOT NULL,
                                         `REV_` int(11) NOT NULL,
                                         `BUSINESS_KEY_` varchar(255) DEFAULT NULL,
                                         `NAME_` varchar(255) DEFAULT NULL,
                                         `PARENT_ID_` varchar(255) DEFAULT NULL,
                                         `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                         `STATE_` varchar(255) DEFAULT NULL,
                                         `START_TIME_` datetime(3) DEFAULT NULL,
                                         `START_USER_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_TYPE_` varchar(255) DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) DEFAULT '',
                                         `LOCK_TIME_` datetime(3) DEFAULT NULL,
                                         `IS_COMPLETEABLE_` bit(1) DEFAULT NULL,
                                         `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                         `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                         `LOCK_OWNER_` varchar(255) DEFAULT NULL,
                                         `LAST_REACTIVATION_TIME_` datetime(3) DEFAULT NULL,
                                         `LAST_REACTIVATION_USER_ID_` varchar(255) DEFAULT NULL,
                                         `BUSINESS_STATUS_` varchar(255) DEFAULT NULL,
                                         PRIMARY KEY (`ID_`),
                                         KEY `ACT_IDX_CASE_INST_CASE_DEF` (`CASE_DEF_ID_`),
                                         KEY `ACT_IDX_CASE_INST_PARENT` (`PARENT_ID_`),
                                         KEY `ACT_IDX_CASE_INST_REF_ID_` (`REFERENCE_ID_`),
                                         CONSTRAINT `ACT_FK_CASE_INST_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_RU_CASE_INST
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_RU_MIL_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_MIL_INST`;
CREATE TABLE `ACT_CMMN_RU_MIL_INST` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) NOT NULL,
                                        `TIME_STAMP_` datetime(3) DEFAULT NULL,
                                        `CASE_INST_ID_` varchar(255) NOT NULL,
                                        `CASE_DEF_ID_` varchar(255) NOT NULL,
                                        `ELEMENT_ID_` varchar(255) NOT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT '',
                                        PRIMARY KEY (`ID_`),
                                        KEY `ACT_IDX_MIL_CASE_DEF` (`CASE_DEF_ID_`),
                                        KEY `ACT_IDX_MIL_CASE_INST` (`CASE_INST_ID_`),
                                        CONSTRAINT `ACT_FK_MIL_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`),
                                        CONSTRAINT `ACT_FK_MIL_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_CMMN_RU_CASE_INST` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_RU_MIL_INST
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_RU_PLAN_ITEM_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_PLAN_ITEM_INST`;
CREATE TABLE `ACT_CMMN_RU_PLAN_ITEM_INST` (
                                              `ID_` varchar(255) NOT NULL,
                                              `REV_` int(11) NOT NULL,
                                              `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `CASE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `STAGE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `IS_STAGE_` bit(1) DEFAULT NULL,
                                              `ELEMENT_ID_` varchar(255) DEFAULT NULL,
                                              `NAME_` varchar(255) DEFAULT NULL,
                                              `STATE_` varchar(255) DEFAULT NULL,
                                              `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                              `START_USER_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                              `TENANT_ID_` varchar(255) DEFAULT '',
                                              `ITEM_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                              `ITEM_DEFINITION_TYPE_` varchar(255) DEFAULT NULL,
                                              `IS_COMPLETEABLE_` bit(1) DEFAULT NULL,
                                              `IS_COUNT_ENABLED_` bit(1) DEFAULT NULL,
                                              `VAR_COUNT_` int(11) DEFAULT NULL,
                                              `SENTRY_PART_INST_COUNT_` int(11) DEFAULT NULL,
                                              `LAST_AVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_ENABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_DISABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_STARTED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_SUSPENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `COMPLETED_TIME_` datetime(3) DEFAULT NULL,
                                              `OCCURRED_TIME_` datetime(3) DEFAULT NULL,
                                              `TERMINATED_TIME_` datetime(3) DEFAULT NULL,
                                              `EXIT_TIME_` datetime(3) DEFAULT NULL,
                                              `ENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `ENTRY_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `EXIT_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `EXTRA_VALUE_` varchar(255) DEFAULT NULL,
                                              `DERIVED_CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `LAST_UNAVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              PRIMARY KEY (`ID_`),
                                              KEY `ACT_IDX_PLAN_ITEM_CASE_DEF` (`CASE_DEF_ID_`),
                                              KEY `ACT_IDX_PLAN_ITEM_CASE_INST` (`CASE_INST_ID_`),
                                              KEY `ACT_IDX_PLAN_ITEM_STAGE_INST` (`STAGE_INST_ID_`),
                                              CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`),
                                              CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_CMMN_RU_CASE_INST` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_RU_PLAN_ITEM_INST
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CMMN_RU_SENTRY_PART_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_SENTRY_PART_INST`;
CREATE TABLE `ACT_CMMN_RU_SENTRY_PART_INST` (
                                                `ID_` varchar(255) NOT NULL,
                                                `REV_` int(11) NOT NULL,
                                                `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                                `CASE_INST_ID_` varchar(255) DEFAULT NULL,
                                                `PLAN_ITEM_INST_ID_` varchar(255) DEFAULT NULL,
                                                `ON_PART_ID_` varchar(255) DEFAULT NULL,
                                                `IF_PART_ID_` varchar(255) DEFAULT NULL,
                                                `TIME_STAMP_` datetime(3) DEFAULT NULL,
                                                PRIMARY KEY (`ID_`),
                                                KEY `ACT_IDX_SENTRY_CASE_DEF` (`CASE_DEF_ID_`),
                                                KEY `ACT_IDX_SENTRY_CASE_INST` (`CASE_INST_ID_`),
                                                KEY `ACT_IDX_SENTRY_PLAN_ITEM` (`PLAN_ITEM_INST_ID_`),
                                                CONSTRAINT `ACT_FK_SENTRY_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`),
                                                CONSTRAINT `ACT_FK_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_CMMN_RU_CASE_INST` (`ID_`),
                                                CONSTRAINT `ACT_FK_SENTRY_PLAN_ITEM` FOREIGN KEY (`PLAN_ITEM_INST_ID_`) REFERENCES `ACT_CMMN_RU_PLAN_ITEM_INST` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CMMN_RU_SENTRY_PART_INST
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CO_CONTENT_ITEM
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CO_CONTENT_ITEM`;
CREATE TABLE `ACT_CO_CONTENT_ITEM` (
                                       `ID_` varchar(255) NOT NULL,
                                       `NAME_` varchar(255) NOT NULL,
                                       `MIME_TYPE_` varchar(255) DEFAULT NULL,
                                       `TASK_ID_` varchar(255) DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(255) DEFAULT NULL,
                                       `CONTENT_STORE_ID_` varchar(255) DEFAULT NULL,
                                       `CONTENT_STORE_NAME_` varchar(255) DEFAULT NULL,
                                       `FIELD_` varchar(400) DEFAULT NULL,
                                       `CONTENT_AVAILABLE_` bit(1) DEFAULT b'0',
                                       `CREATED_` timestamp(6) NULL DEFAULT NULL,
                                       `CREATED_BY_` varchar(255) DEFAULT NULL,
                                       `LAST_MODIFIED_` timestamp(6) NULL DEFAULT NULL,
                                       `LAST_MODIFIED_BY_` varchar(255) DEFAULT NULL,
                                       `CONTENT_SIZE_` bigint(20) DEFAULT '0',
                                       `TENANT_ID_` varchar(255) DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `idx_contitem_taskid` (`TASK_ID_`),
                                       KEY `idx_contitem_procid` (`PROC_INST_ID_`),
                                       KEY `idx_contitem_scope` (`SCOPE_ID_`,`SCOPE_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CO_CONTENT_ITEM
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_CO_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CO_DATABASECHANGELOG`;
CREATE TABLE `ACT_CO_DATABASECHANGELOG` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int(11) NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CO_DATABASECHANGELOG
-- ----------------------------
BEGIN;
INSERT INTO `ACT_CO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-09-14 11:05:26', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.3.5', NULL, NULL, '4660726300');
INSERT INTO `ACT_CO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-09-14 11:05:26', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.3.5', NULL, NULL, '4660726300');
COMMIT;

-- ----------------------------
-- Table structure for ACT_CO_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CO_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_CO_DATABASECHANGELOGLOCK` (
                                                `ID` int(11) NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_CO_DATABASECHANGELOGLOCK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_CO_DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_DMN_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DATABASECHANGELOG`;
CREATE TABLE `ACT_DMN_DATABASECHANGELOG` (
                                             `ID` varchar(255) NOT NULL,
                                             `AUTHOR` varchar(255) NOT NULL,
                                             `FILENAME` varchar(255) NOT NULL,
                                             `DATEEXECUTED` datetime NOT NULL,
                                             `ORDEREXECUTED` int(11) NOT NULL,
                                             `EXECTYPE` varchar(10) NOT NULL,
                                             `MD5SUM` varchar(35) DEFAULT NULL,
                                             `DESCRIPTION` varchar(255) DEFAULT NULL,
                                             `COMMENTS` varchar(255) DEFAULT NULL,
                                             `TAG` varchar(255) DEFAULT NULL,
                                             `LIQUIBASE` varchar(20) DEFAULT NULL,
                                             `CONTEXTS` varchar(255) DEFAULT NULL,
                                             `LABELS` varchar(255) DEFAULT NULL,
                                             `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_DMN_DATABASECHANGELOG
-- ----------------------------
BEGIN;
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('5', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 5, 'EXECUTED', '8:3e03528582dd4eeb4eb41f9b9539140d', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_DMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION; modifyDataType columnName=END_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 6, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 7, 'EXECUTED', '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 8, 'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '4.3.5', NULL, NULL, '4660725322');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('9', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-14 11:05:25', 9, 'EXECUTED', '8:0fe82086431b1953d293f0199f805876', 'createIndex indexName=ACT_IDX_DMN_INSTANCE_ID, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.3.5', NULL, NULL, '4660725322');
COMMIT;

-- ----------------------------
-- Table structure for ACT_DMN_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_DMN_DATABASECHANGELOGLOCK` (
                                                 `ID` int(11) NOT NULL,
                                                 `LOCKED` bit(1) NOT NULL,
                                                 `LOCKGRANTED` datetime DEFAULT NULL,
                                                 `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                 PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_DMN_DATABASECHANGELOGLOCK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_DMN_DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_DMN_DECISION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DECISION`;
CREATE TABLE `ACT_DMN_DECISION` (
                                    `ID_` varchar(255) NOT NULL,
                                    `NAME_` varchar(255) DEFAULT NULL,
                                    `VERSION_` int(11) DEFAULT NULL,
                                    `KEY_` varchar(255) DEFAULT NULL,
                                    `CATEGORY_` varchar(255) DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) DEFAULT NULL,
                                    `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                    `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                    `DECISION_TYPE_` varchar(255) DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    UNIQUE KEY `ACT_IDX_DMN_DEC_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_DMN_DECISION
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_DMN_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DEPLOYMENT`;
CREATE TABLE `ACT_DMN_DEPLOYMENT` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `CATEGORY_` varchar(255) DEFAULT NULL,
                                      `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) DEFAULT NULL,
                                      `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_DMN_DEPLOYMENT
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_DMN_DEPLOYMENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DEPLOYMENT_RESOURCE`;
CREATE TABLE `ACT_DMN_DEPLOYMENT_RESOURCE` (
                                               `ID_` varchar(255) NOT NULL,
                                               `NAME_` varchar(255) DEFAULT NULL,
                                               `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                               `RESOURCE_BYTES_` longblob,
                                               PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_DMN_DEPLOYMENT_RESOURCE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_DMN_HI_DECISION_EXECUTION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_HI_DECISION_EXECUTION`;
CREATE TABLE `ACT_DMN_HI_DECISION_EXECUTION` (
                                                 `ID_` varchar(255) NOT NULL,
                                                 `DECISION_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                                 `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                                 `START_TIME_` datetime(3) DEFAULT NULL,
                                                 `END_TIME_` datetime(3) DEFAULT NULL,
                                                 `INSTANCE_ID_` varchar(255) DEFAULT NULL,
                                                 `EXECUTION_ID_` varchar(255) DEFAULT NULL,
                                                 `ACTIVITY_ID_` varchar(255) DEFAULT NULL,
                                                 `FAILED_` bit(1) DEFAULT b'0',
                                                 `TENANT_ID_` varchar(255) DEFAULT NULL,
                                                 `EXECUTION_JSON_` longtext,
                                                 `SCOPE_TYPE_` varchar(255) DEFAULT NULL,
                                                 PRIMARY KEY (`ID_`),
                                                 KEY `ACT_IDX_DMN_INSTANCE_ID` (`INSTANCE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_DMN_HI_DECISION_EXECUTION
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_EVT_LOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_EVT_LOG`;
CREATE TABLE `ACT_EVT_LOG` (
                               `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
                               `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                               `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DATA_` longblob,
                               `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `IS_PROCESSED_` tinyint(4) DEFAULT '0',
                               PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_EVT_LOG
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_FO_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_DATABASECHANGELOG`;
CREATE TABLE `ACT_FO_DATABASECHANGELOG` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int(11) NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_FO_DATABASECHANGELOG
-- ----------------------------
BEGIN;
INSERT INTO `ACT_FO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-09-14 11:05:25', 1, 'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.3.5', NULL, NULL, '4660725875');
INSERT INTO `ACT_FO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-09-14 11:05:25', 2, 'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.3.5', NULL, NULL, '4660725875');
INSERT INTO `ACT_FO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-09-14 11:05:25', 3, 'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.3.5', NULL, NULL, '4660725875');
INSERT INTO `ACT_FO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('4', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-09-14 11:05:26', 4, 'EXECUTED', '8:2087829f22a4b2298dbf530681c74854', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_FO_FORM_DEPLOYMENT; modifyDataType columnName=SUBMITTED_DATE_, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.3.5', NULL, NULL, '4660725875');
INSERT INTO `ACT_FO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-09-14 11:05:26', 5, 'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446', 'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.3.5', NULL, NULL, '4660725875');
INSERT INTO `ACT_FO_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('6', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-09-14 11:05:26', 6, 'EXECUTED', '8:384bbd364a649b67c3ca1bcb72fe537f', 'createIndex indexName=ACT_IDX_FORM_TASK, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_PROC, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_SCOPE, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.3.5', NULL, NULL, '4660725875');
COMMIT;

-- ----------------------------
-- Table structure for ACT_FO_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_FO_DATABASECHANGELOGLOCK` (
                                                `ID` int(11) NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_FO_DATABASECHANGELOGLOCK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_FO_DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_FO_FORM_DEFINITION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_DEFINITION`;
CREATE TABLE `ACT_FO_FORM_DEFINITION` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `VERSION_` int(11) DEFAULT NULL,
                                          `KEY_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                          `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`),
                                          UNIQUE KEY `ACT_IDX_FORM_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_FO_FORM_DEFINITION
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_FO_FORM_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_DEPLOYMENT`;
CREATE TABLE `ACT_FO_FORM_DEPLOYMENT` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_FO_FORM_DEPLOYMENT
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_FO_FORM_INSTANCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_INSTANCE`;
CREATE TABLE `ACT_FO_FORM_INSTANCE` (
                                        `ID_` varchar(255) NOT NULL,
                                        `FORM_DEFINITION_ID_` varchar(255) NOT NULL,
                                        `TASK_ID_` varchar(255) DEFAULT NULL,
                                        `PROC_INST_ID_` varchar(255) DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(255) DEFAULT NULL,
                                        `SUBMITTED_DATE_` datetime(3) DEFAULT NULL,
                                        `SUBMITTED_BY_` varchar(255) DEFAULT NULL,
                                        `FORM_VALUES_ID_` varchar(255) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`),
                                        KEY `ACT_IDX_FORM_TASK` (`TASK_ID_`),
                                        KEY `ACT_IDX_FORM_PROC` (`PROC_INST_ID_`),
                                        KEY `ACT_IDX_FORM_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_FO_FORM_INSTANCE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_FO_FORM_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_RESOURCE`;
CREATE TABLE `ACT_FO_FORM_RESOURCE` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        `RESOURCE_BYTES_` longblob,
                                        PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ACT_FO_FORM_RESOURCE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_GE_BYTEARRAY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;
CREATE TABLE `ACT_GE_BYTEARRAY` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    `GENERATED_` tinyint(4) DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
                                    CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_GE_BYTEARRAY
-- ----------------------------
BEGIN;
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2520', 1, 'flow_a9z4w99d.bpmn', '2519', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A62696F633D22687474703A2F2F62706D6E2E696F2F736368656D612F62706D6E2F62696F636F6C6F722F312E302220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D6122207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D22666C6F775F6B73326C797A346322206E616D653D22666C6F775F61397A34773939642220666C6F7761626C653A70726F6365737343617465676F72793D226F61223E0A202020203C73746172744576656E742069643D2273746172745F6576656E7422206E616D653D22E5BC80E5A78B223E0A2020202020203C6F7574676F696E673E466C6F775F3174756D6E74363C2F6F7574676F696E673E0A202020203C2F73746172744576656E743E0A202020203C757365725461736B2069643D2241637469766974795F317167396F676122206E616D653D22E8A18CE694BF2220666C6F7761626C653A75736572547970653D2263616E64696461746555736572732220666C6F7761626C653A64617461547970653D2266697865642220666C6F7761626C653A63616E64696461746555736572733D22312C32223E0A2020202020203C696E636F6D696E673E466C6F775F3174756D6E74363C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F31787A736963673C2F6F7574676F696E673E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3174756D6E74362220736F757263655265663D2273746172745F6576656E7422207461726765745265663D2241637469766974795F317167396F676122202F3E0A202020203C757365725461736B2069643D2241637469766974795F316D3962386D7522206E616D653D22E88081E69DBF2220666C6F7761626C653A63616E64696461746547726F7570733D22237B617070726F76616C7D2220666C6F7761626C653A75736572547970653D2263616E64696461746547726F7570732220666C6F7761626C653A64617461547970653D2264796E616D6963223E0A2020202020203C696E636F6D696E673E466C6F775F31787A736963673C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F313668696430713C2F6F7574676F696E673E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31787A736963672220736F757263655265663D2241637469766974795F317167396F676122207461726765745265663D2241637469766974795F316D3962386D7522202F3E0A202020203C656E644576656E742069643D224576656E745F3070756375313722206E616D653D22223E0A2020202020203C696E636F6D696E673E466C6F775F313668696430713C2F696E636F6D696E673E0A202020203C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F313668696430712220736F757263655265663D2241637469766974795F316D3962386D7522207461726765745265663D224576656E745F3070756375313722202F3E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F666C6F77223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242504D4E506C616E655F666C6F77222062706D6E456C656D656E743D22666C6F775F6B73326C797A3463223E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2242504D4E53686170655F73746172745F6576656E74222062706D6E456C656D656E743D2273746172745F6576656E74222062696F633A7374726F6B653D22223E0A20202020202020203C6F6D6764633A426F756E647320783D222D32352220793D22313235222077696474683D22333022206865696768743D22333022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D222D32322220793D22313632222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F317167396F67615F6469222062706D6E456C656D656E743D2241637469766974795F317167396F6761223E0A20202020202020203C6F6D6764633A426F756E647320783D2236302220793D22313030222077696474683D2231303022206865696768743D22383022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F316D3962386D755F6469222062706D6E456C656D656E743D2241637469766974795F316D3962386D75223E0A20202020202020203C6F6D6764633A426F756E647320783D223232302220793D22313030222077696474683D2231303022206865696768743D22383022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F307075637531375F6469222062706D6E456C656D656E743D224576656E745F30707563753137223E0A20202020202020203C6F6D6764633A426F756E647320783D223338322220793D22313232222077696474683D22333622206865696768743D22333622202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3174756D6E74365F6469222062706D6E456C656D656E743D22466C6F775F3174756D6E7436223E0A20202020202020203C64693A776179706F696E7420783D22352220793D2231343022202F3E0A20202020202020203C64693A776179706F696E7420783D2236302220793D2231343022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F31787A736963675F6469222062706D6E456C656D656E743D22466C6F775F31787A73696367223E0A20202020202020203C64693A776179706F696E7420783D223136302220793D2231343022202F3E0A20202020202020203C64693A776179706F696E7420783D223232302220793D2231343022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F313668696430715F6469222062706D6E456C656D656E743D22466C6F775F31366869643071223E0A20202020202020203C64693A776179706F696E7420783D223332302220793D2231343022202F3E0A20202020202020203C64693A776179706F696E7420783D223338322220793D2231343022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E0A, 0);
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2521', 1, 'flow_a9z4w99d.flow_ks2lyz4c.png', '2519', 0x89504E470D0A1A0A0000000D49484452000001C5000000BE0806000000445314320000103B4944415478DAEDDD098C14E5BA06E0E34EDCA2718DC6DDE85163DCE3AED7B81D4563AE0147441474505071DF85086E5173347ADCAF7123A2B8218B17411D442E0272F4B8E2753902823022202AE88008FFADAF323DB71D416660A6677B9EE4CBD8DD35DDD5E3CBF7D75F5D55FD97BF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000544B29AD3D79F2E4E7C78F1FFF6B4545457AFDF5D755892BFBBB2F1D3366CCCC51A3469D227FF2207FD084B286F442F60F22CD9A352B555555A5458B16A91257FCDDE3EF3F7AF4E81FB326D55EFE94FC4113892DF4F807A139347D555656CEC99AD244F953F2074D247659D9426F3E5BEC59535A287F4AFEA089C4670A1A42F3A9F8FF217F4AFEA09937A5053F54A6C9FF7C224D7AE3A6BCE2BFE33E8D4453923FF98336D594E6CF9B913E19D9277DF8DF57FDAEE2BE784C33D194E44FFEA0CD34A5E99386FEA12115EA9B49C334134D49FEE40FDA4E53FADF37EF586E538AC734134D49FEE40FDA4C53FAE4F5BECB6D4AF19866A229C99FFC81A6A429694AF2277FD0D69A521CEDB7BCA6148F69269A92FCC91FB499A6F4E5DBF72FB729C5639A89A6247FF2076DA629CD9DF151FAE4B51BFFB8EB2ABB2F1ED34C3425F9933F68334D296ACABBFDFFD094E23E8D4453923FF983B6D594162E4C5F8E7BE88FBBAEB2FBE231CD4453923FF98336D194E28A215FBC7DDF723FD389C75C554453923FF983D6DD94B22DF0CA2F47A58F475CBFDC8654A8582696B5D5AE29C99FFC41AB6B4A2BDA3AB7D5AE29C99FFC419B694A75D93AFFB3AD76CD4553923FF98356D39456B621154A73D194E44FFEA0757DA6A33425F9933F96A96BD7AE1B9D7EFAE91DCACACAFE91FDACC86A4A56BF6495AA7FC6ED8AEAC73BC4F2FE6A9A92D294E44FFE5A954E9D3A1D9B0D7283B25A543D00D6B562F941F1FBFE8A9A92D294E44FFE5AFA60787036A84DA8E740B8BC9A10CFE7AFAA29294D49FEE4AFA5ED266D575656F64036902DAD3DB85D7AE9A569C08001E9BDF7DE4B5F7DF5559A3B776E0AF1336EC7FDF1782CB78C8171693C6F3C7FA3BF896C9D561F3F7EFCA9FDFBF77FAD5FBF7E73AEB9E69AAA9E3D7BE66FA8478F1E8BAFBCF2CA9FB2FBFE7DF3CD37FFBD5BB76EDB181435254D49FE9441B1B66CCCD8269BD17D583C989D71C619E991471E49DF7CF34DAA8F583E7E2F7EBFD6E0F841BC4E630D86ED468C18F15F7DFAF4F9B5BCBC3C3DF8E08369C28409CB1CC1E3FE78FCDC73CF5DD2AB57AFC9DDBB773FDEA0A83425F9933F8362F5EED2BF6635A37800BBE38E3BD2F4E9D3D3AA88DF8FE7A935304E8FD76BD037900D72176633BFAA98A666B3C4B464C9923AAD602C17CB5F7CF1C58B2FB8E0827F65D3D99D0C8A4A53923FF96BF333C419C5B3C3A14387A68614CF576BD638BD41668CD973AF3672E4C801E79F7F7E1A3E7C78FAEDB7DF566A05E3F7E2F7BB76EDBAA0AD1D1DA429694AF2A70C8AFFFF1962F12ED36EDDBAA5F7DF7F3F358678DE78FEE25DA9ABF419630C8883060D7AA767CF9EE9B3CF3E6B90958CE7292F2FFF251BC1CFD59494A6247FF2D7B6541F545333436CAC01B178602C9E31C6EBAFF4CAC70CB1478F1E69D6AC590DBA92F17CD9E83DFFB4D34E3B4653529A92FCC95F9BF91C314EBB585218A0860D1B964A215EA768B6B864A54ED718376EDC85312036D40C711933C6A5679D75D6BC8E1D3BEEAC29294D49FEE4AF4D7C9638A1F8A09A52AA75F0CD84FAEE366D77CB2DB754C567808D69C89021F3B269ED084D49694AF2277FAD5BEC192CDE6DBAAA4799AECC51A9C5BB51EBB5A7F2D5575F7D248E325DD9836AEA73F04D7979F9EC6CE58ED29494A6247FF2D7AA6789830A03529C4FD814E2758B668B83EA3A4B5CBD77EFDEBFC66914A53076ECD81FB295FB1F4D49694AF2277FAD533643DBB8F85AA6A59E2516CF168BAF951AEB5597CF12FFB37BF7EE753E0F7155C5EB74EEDCF9878E1D3B6EDD02B77CDECCEA3F34254D49FE545B1D14EB92C3F8168BE24BB735A55A9784EBB0C237F8D4534FBD1E57A229A57EFDFA7D525656D6B30586A1F087FDD350684A9A92FCA9563C28AE3087D9FDF715967BFAE9A79B74508CD72F5AE7FB56F8066FBEF9E6D9A5DA755AF0C61B6F4CAAF3FEDDE619863F0D85A6A429C99F6A0383E27273D8A953A75185C7DF7DF7DD261D14E3F50BEB12EBB5C23778F5D557574D9E3CB9A42BF9F9E79F4FCD56F09FAD200CCB0C85A6A429C99F6A4383E21F7298FD9C56B8BFD4E34B6DF1FA45EB386D856FB0478F1E4BBFFFFEFB92AEE4DCB973E7672B37A31585E177A1D0943425F9536D70502CCEE1CF85DBA51E5F6A8BD72F9A29FEB4C237D8A54B97B478F1E292AE64F67A3F35D0174B36CBD2949A57B5E6ACC99FFC35F72AF5F8B28CF1A6787D7E5BE1A078FEF9E72F2EF5483E7BF6EC7FB7B299628BDB7D15BB143EFAE8A395FADD418306A5679E79C696BAFCAD728D1C3932AFE53D1E5F4DF7F0C30FA71933669829B6A01CC68CACC5CE14AFB8E28A9F4ABDCFF7D34F3F7DB7957CA6D8220F74F8EEBBEFD241071D9476DE79E774CF3DF7A45D77DD35EDB9E79E3515F77FFCF1C7E995575E898BE9A633CF3C33AFB83AC4DD77DF9DFEF6B7BFA50E1D3A684AF2B7523573E6CCFC0B62BFFDF6DB74C20927A4638E3926BFEFEBAFBFCE07C0EBAFBF3ECD9F3F3F5F3696CBDE52FE7DAD8F3FFE78DA6AABADD276DB6D57535B6FBD75BAF6DA6BE5AF99E5B0457FA69805F08B521F7DFAF2CB2F0F6DE1479FB6D843E2DF7CF3CDB4C30E3BA4FDF7DF3F8D1B372EBDFDF6DBE9DE7BEF4D0F3CF0404DDD75D75DA9B2B232FFC77CC10517A4F6EDDBA735D658235D78E185F9B2EBAEBB6EDA7DF7DD63AB2B1F34E31A839A92FCD5B5AEBEFAEA3C833BEEB8635A6FBDF5F28AFFDE64934DD23AEBAC93E21ACC0B172E4CEFBCF34EBE111683629F3E7DF2C16FFDF5D74F8F3EFA684D3DF4D04369F4E8D1F2D7CC72D8A28F3EEDD7AFDFDF4B7D9EE245175D34BC859EA7D8E24F9E8E5D094F3EF964BAF5D65BF3C12D1A50349CBE7DFBD6D40D37DC909E78E289D8CD9D4E3DF5D4BC3145B38ADF8FFFDE60830DF22DFB5EBD7AA5238E3822CD9933475392BF3AD5871F7E989E7FFEF9F4D24B2FE575C82187A4030E38205D79E59569F5D5574FC71D775C7AF6D967F3463671E2C43C9F31284643BBFCF2CBD39A6BAE99F6D9679FBCF6DE7BEF74F8E187A779F3E6C95F33CB618B3E4FB15BB76EDB9497972F29E1156DBECD566C764BBCA24D5D35F72DF518F062E6976D10A53DF6D823DF6ADF69A79DF22DF5683AB15B2AAE7214836234A4DB6EBB2DFFB9D1461BA576EDDAA5B5D65A2B1F148F3FFEF814DFBD69F7A9FCD5B56EB9E5963C4B2BAA1B6FBC315FBE3028EEB6DB6EE9CE3BEFAC79FCBCF3CE4B871E7A683ECB2CEC6A95BF663570369B2BDA5C72C9254BEB75459B906DF14F29D52ED48103073EEDDAA74D57B1CBA9D0585E7BEDB5DF3D16BB41B7DD76DB9ADB31038CE56EBFFDF67CB0ECDDBB77DA6CB3CDD2C61B6F9C0F94317B8CDDAD0645F9AB6BC58133F1FDAA31BB8B8B354796B6DC72CB3C8B71304D454545CDE3B1ECA69B6E9A673006BF7DF7DD37EDB7DF7E79EE5E7CF1C57CB7FE29A79C227FCD508BBEF669C86605C75F7CF1C58B4BF02D19D3B315FBD2B764345D159A497D07C5C2EED308596CF9ADBDF6DAF9AC313E7BD494E4AFAE555555951FBD1CBB3D235B31DB8BF58DCF0B37DF7CF33C53B18B35968D8DB0D86B11CBDD74D34D355F4174F2C927A7BDF6DA2BDFDBD1BF7F7FF96BBEB3C596F92D1905175D74D1BF860F1FBEB411D76FE99D77DEF944B662C335A5A6AB38802106B6959929BEF0C20B69CC9831857FE4E9C4134F74F4A9FCD5ABE2B3C3C84EE42C36ACA2E2F6861B6E98CE3EFBECF4D8638FA51F7FFC315FF6B2CB2ECB77A3C6E3EFBDF75E7E70D875D75D179789CCEFDB7EFBEDD3CF3FFF2C7FCD5473F83EC54E9D3A2D5DA9EF530C1D3B76DCB95BB76EF33FFBECB34659C1B7DE7AEBA96CC52AE37534A5A6ADC261EECB1A1463CBBC703B8EFE8BE562B75561976B1C9413CD2806C9D5565B2DDD7FFFFD9A92FCD52B7BB1F51E9F03C6AEF8D8B08AF314172C58903F1E076F1D76D861F97F4F9B36AD66036EE8D0A179DE060F1E9C1F115DD8A5FA67E738CA5FB3982D4E280C4AD15F4A295EAF68963861A5DE4036AA1E7BCE39E7FC12FBF41BD2D4A95387652B35B3DE23B5A6D42815CD269ACA881123F2DBA3468DCA4FB7885D5ABBECB24BCD72716E621C5473F4D147E7A76274EEDC39BF1DE7314E9A3429DF8D1ACF1307E5684AF257DFDA628B2DF2537B624678D55557E5835D0C94599FA85926CE652C6C98C56CF2E0830FAED9383BF0C003F32356E3486AF96B9EB231E5E0ACF72F290C4EC3860D2BC98018AF5334202E89F558950F48CFCD668C3F35D48CB17A863823AB7334A5E6515F7CF1457E12F4F0E1C3F3DB71659B238F3C323F913A8E4C2D2C17198813FD0BB763D75634AFE243E0E3409B214386684AF257EF8A53C14E3AE9A474D45147E5F98B93F8BB76EDFABB2B2D4D9932259F11C639B171A1898E1D3BA6E79E7B2E7F2C72181B6471EEADFC355F6565650F14EF467DFFFDF71B75408CE72FDE6D1AAFDF20FB82BB74E9322F6B76F356F6E09B38A8A6FA33C46FDBCA0CB1A535251764963F257F8D2DDBD069978D031F1406A96CD2D56803633C6FF67A4B8A66891FC4EB37D4E8BE5336AA8F2C2F2F9F3D76ECD81FEA7A1E63B6DCAC8103070E88A34CB37A359EA7AD854053D294E44F19147FF7D9E236594D2F9E31C6E7C40D299EAF788658FD7ADB34C6114447654F3CA673E7CE3FF6EDDBF7E38A8A8A4F3EFFFCF36973E6CC5990ADC7FCEFBEFB6EF2A44993DE1D3C78F0905EBD7ABD9A2D3B27966FEDA75D684A9A92FC29F9ABD7E78B7F2D1E180B07DFACEA51A9F1FBB50EAAC907C478BD467D4371059AEC857A6433BFB86EE9C4A237173F2756DFDFA3355FA94653D294E44FC9DF2ACF183F281EC062D6184724C791C9F5513892B9D6EC30553FFF36FEDA9A92D294E44FFE5AC4678CD507DFD41ECCF223DA070C18909F97FAD5575FE55735AAFE62FAFC76DC1F8FD7BA745BA196C6F336D86788684A9A92FC29F92BE1EED4838BCF635CC59AB04AA75DA029694AF2A7E4AF990C8EC7565F126E513D07C2587E50FCBEBFA2A6A43425F993BFD6B65B75A3F8168BB2B2B27F643F2BB29A92D52FD503E02FD5B72BAA1FEF10CBFBAB694A4A53923FF9034D49694AF2277FA029294D49FEE40F3425A529C99FFC81A6A43425F9933FD09494A6247FF2079A92D294E44FFE4053529A92FCC91F684A4A53923FF9034D49694AF2277F6050549A92FCC91F181495A6247FF2070645A529C99F322882A6A429C99F322882A6A429C99F322882A6A429C99F923FD0943425F953F2077FA6A2A2626955559586D00C2AFBFF30336B4A0BE54FC91F34913163C6CC9C356B96A6D00CEAEBAFBF1E9835A589F2A7E40F9AC8A851A34E193D7AF48F959595736CB137D9167AE5D4A9539FC91AD2B4ACDACB9F923F68DACF75DAC71662568BE2330555F25A54FDF76F2F7FF2207F0000000000000000000000000000000025F27F960D66048BE0FA430000000049454E44AE426082, 1);
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2530', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C74000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E7400056C6162656C74000CE8AFB7E58187E6A087E9A29874000A6C6162656C57696474687074000973686F774C6162656C737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870017400096368616E676554616771007E000E740003746167740008656C2D696E70757474000774616749636F6E740005696E707574740008726571756972656471007E000E7400066C61796F757474000B636F6C466F726D4974656D7400047370616E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000018740008646F63756D656E7474003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E7075747400077265674C6973747371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E7400076D657373616765740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A29874000774726967676572740004626C7572780078740006666F726D49647371007E00180000006574000972656E6465724B65797400103130313136353035393234363637303374000C64656661756C7456616C7565740006E6B58BE8AF9578007400085F5F736C6F745F5F7371007E00003F400000000000037708000000040000000274000770726570656E64740000740006617070656E6471007E002D780074000B706C616365686F6C646572740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A2987400057374796C657371007E00003F40000000000001770800000002000000017400057769647468740004313030257800740009636C65617261626C6571007E000E74000B7072656669782D69636F6E71007E002D74000B7375666669782D69636F6E71007E002D7400096D61786C656E6774687074000F73686F772D776F72642D6C696D69747371007E000D00740008726561646F6E6C7971007E003A74000864697361626C656471007E003A74000A5F5F764D6F64656C5F5F7400086669656C6431303178007371007E00003F4000000000000C7708000000100000000C71007E00077371007E00003F400000000000187708000000200000000E71007E000974000CE8AFB7E58187E5A4A9E695B071007E000B7071007E000C71007E000E71007E000F71007E000E71007E0010740008656C2D696E70757471007E0012740005696E70757471007E001471007E000E71007E001574000B636F6C466F726D4974656D71007E001771007E001A71007E001B74003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E001D7371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E71007E0020740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E0022740004626C757278007871007E002471007E002571007E00267400103130313136343633363237353238353271007E002874000133780071007E002A7371007E00003F400000000000037708000000040000000271007E002C71007E002D71007E002E71007E002D780071007E002F740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E00317371007E00003F400000000000017708000000020000000171007E003374000431303025780071007E003571007E000E71007E003671007E002D71007E003771007E002D71007E00387071007E003971007E003A71007E003B71007E003A71007E003C71007E003A71007E003D74000364617978007371007E00003F4000000000000C7708000000100000000A71007E00077371007E00003F400000000000187708000000200000000E71007E000974000CE8AFB7E58187E5A487E6B3A871007E000B7071007E000C71007E000E71007E0010740008656C2D696E70757471007E0012740008746578746172656171007E001471007E000E71007E001574000B636F6C466F726D4974656D71007E001771007E001A71007E001D7371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E71007E0020740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A871007E0022740004626C757278007871007E000F71007E000E71007E001B74003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00247371007E00180000006671007E00267400103130323136353035393234363936393271007E002874000474657374780074000474797065740008746578746172656171007E002F740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A87400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0018000000047400076D6178526F777371007E0065780071007E00317371007E00003F400000000000017708000000020000000171007E003374000431303025780071007E00387071007E003971007E003A71007E003B71007E003A71007E003C71007E003A71007E003D7400086669656C64313032780078740007666F726D526566740006656C466F726D740009666F726D4D6F64656C740008666F726D4461746174000473697A657400066D656469756D74000D6C6162656C506F736974696F6E740005726967687471007E000B7371007E001800000064740009666F726D52756C657374000572756C65737400066775747465727371007E00180000000F71007E003C71007E000E71007E001771007E001A740008666F726D42746E7371007E003A7800, NULL);
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2546', 1, 'hist.var-fields', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000003770400000003737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000C74000A5F5F636F6E6669675F5F7371007E00023F400000000000187708000000200000000E7400056C6162656C74000CE8AFB7E58187E6A087E9A29874000A6C6162656C57696474687074000973686F774C6162656C737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870017400096368616E676554616771007E000C740003746167740008656C2D696E70757474000774616749636F6E740005696E707574740008726571756972656471007E000C7400066C61796F757474000B636F6C466F726D4974656D7400047370616E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000018740008646F63756D656E7474003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E7075747400077265674C6973747371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C7400076D657373616765740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A29874000774726967676572740004626C7572780078740006666F726D49647371007E00160000006574000972656E6465724B65797400103130313136353035393234363637303374000C64656661756C7456616C7565740006E6B58BE8AF9578007400085F5F736C6F745F5F7371007E00023F400000000000037708000000040000000274000770726570656E64740000740006617070656E6471007E002B780074000B706C616365686F6C646572740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A2987400057374796C657371007E00023F40000000000001770800000002000000017400057769647468740004313030257800740009636C65617261626C6571007E000C74000B7072656669782D69636F6E71007E002B74000B7375666669782D69636F6E71007E002B7400096D61786C656E6774687074000F73686F772D776F72642D6C696D69747371007E000B00740008726561646F6E6C7971007E003874000864697361626C656471007E003874000A5F5F764D6F64656C5F5F7400086669656C6431303178007371007E00023F4000000000000C7708000000100000000C71007E00057371007E00023F400000000000187708000000200000000E71007E000774000CE8AFB7E58187E5A4A9E695B071007E00097071007E000A71007E000C71007E000D71007E000C71007E000E740008656C2D696E70757471007E0010740005696E70757471007E001271007E000C71007E001374000B636F6C466F726D4974656D71007E001571007E001871007E001974003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E001B7371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C71007E001E740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E0020740004626C757278007871007E002271007E002371007E00247400103130313136343633363237353238353271007E002674000133780071007E00287371007E00023F400000000000037708000000040000000271007E002A71007E002B71007E002C71007E002B780071007E002D740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E002F7371007E00023F400000000000017708000000020000000171007E003174000431303025780071007E003371007E000C71007E003471007E002B71007E003571007E002B71007E00367071007E003771007E003871007E003971007E003871007E003A71007E003871007E003B74000364617978007371007E00023F4000000000000C7708000000100000000A71007E00057371007E00023F400000000000187708000000200000000E71007E000774000CE8AFB7E58187E5A487E6B3A871007E00097071007E000A71007E000C71007E000E740008656C2D696E70757471007E0010740008746578746172656171007E001271007E000C71007E001374000B636F6C466F726D4974656D71007E001571007E001871007E001B7371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C71007E001E740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A871007E0020740004626C757278007871007E000D71007E000C71007E001974003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00227371007E00160000006671007E00247400103130323136353035393234363936393271007E002674000474657374780074000474797065740008746578746172656171007E002D740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A87400086175746F73697A657371007E00023F40000000000003770800000004000000027400076D696E526F77737371007E0016000000047400076D6178526F777371007E0063780071007E002F7371007E00023F400000000000017708000000020000000171007E003174000431303025780071007E00367071007E003771007E003871007E003971007E003871007E003A71007E003871007E003B7400086669656C64313032780078, NULL);
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2568', 1, 'var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C74000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E7400056C6162656C74000CE8AFB7E58187E6A087E9A29874000A6C6162656C57696474687074000973686F774C6162656C737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870017400096368616E676554616771007E000E740003746167740008656C2D696E70757474000774616749636F6E740005696E707574740008726571756972656471007E000E7400066C61796F757474000B636F6C466F726D4974656D7400047370616E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000018740008646F63756D656E7474003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E7075747400077265674C6973747371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E7400076D657373616765740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A29874000774726967676572740004626C7572780078740006666F726D49647371007E00180000006574000972656E6465724B65797400103130313136353035393234363637303374000C64656661756C7456616C75657400066A696E74747478007400085F5F736C6F745F5F7371007E00003F400000000000037708000000040000000274000770726570656E64740000740006617070656E6471007E002D780074000B706C616365686F6C646572740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A2987400057374796C657371007E00003F40000000000001770800000002000000017400057769647468740004313030257800740009636C65617261626C6571007E000E74000B7072656669782D69636F6E71007E002D74000B7375666669782D69636F6E71007E002D7400096D61786C656E6774687074000F73686F772D776F72642D6C696D69747371007E000D00740008726561646F6E6C7971007E003A74000864697361626C656471007E003A74000A5F5F764D6F64656C5F5F7400086669656C6431303178007371007E00003F4000000000000C7708000000100000000C71007E00077371007E00003F400000000000187708000000200000000E71007E000974000CE8AFB7E58187E5A4A9E695B071007E000B7071007E000C71007E000E71007E000F71007E000E71007E0010740008656C2D696E70757471007E0012740005696E70757471007E001471007E000E71007E001574000B636F6C466F726D4974656D71007E001771007E001A71007E001B74003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E001D7371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E71007E0020740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E0022740004626C757278007871007E002471007E002571007E00267400103130313136343633363237353238353271007E002874000134780071007E002A7371007E00003F400000000000037708000000040000000271007E002C71007E002D71007E002E71007E002D780071007E002F740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E00317371007E00003F400000000000017708000000020000000171007E003374000431303025780071007E003571007E000E71007E003671007E002D71007E003771007E002D71007E00387071007E003971007E003A71007E003B71007E003A71007E003C71007E003A71007E003D74000364617978007371007E00003F4000000000000C7708000000100000000A71007E00077371007E00003F400000000000187708000000200000000E71007E000974000CE8AFB7E58187E5A487E6B3A871007E000B7071007E000C71007E000E71007E0010740008656C2D696E70757471007E0012740008746578746172656171007E001471007E000E71007E001574000B636F6C466F726D4974656D71007E001771007E001A71007E001D7371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E71007E0020740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A871007E0022740004626C757278007871007E000F71007E000E71007E001B74003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00247371007E00180000006671007E00267400103130323136353035393234363936393271007E0028740003747474780074000474797065740008746578746172656171007E002F740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A87400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0018000000047400076D6178526F777371007E0065780071007E00317371007E00003F400000000000017708000000020000000171007E003374000431303025780071007E00387071007E003971007E003A71007E003B71007E003A71007E003C71007E003A71007E003D7400086669656C64313032780078740007666F726D526566740006656C466F726D740009666F726D4D6F64656C740008666F726D4461746174000473697A657400066D656469756D74000D6C6162656C506F736974696F6E740005726967687471007E000B7371007E001800000064740009666F726D52756C657374000572756C65737400066775747465727371007E00180000000F71007E003C71007E000E71007E001771007E001A740008666F726D42746E7371007E003A7800, NULL);
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2570', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C74000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E7400056C6162656C74000CE8AFB7E58187E6A087E9A29874000A6C6162656C57696474687074000973686F774C6162656C737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870017400096368616E676554616771007E000E740003746167740008656C2D696E70757474000774616749636F6E740005696E707574740008726571756972656471007E000E7400066C61796F757474000B636F6C466F726D4974656D7400047370616E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000018740008646F63756D656E7474003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E7075747400077265674C6973747371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E7400076D657373616765740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A29874000774726967676572740004626C7572780078740006666F726D49647371007E00180000006574000972656E6465724B65797400103130313136353035393234363637303374000C64656661756C7456616C75657400066A696E74747478007400085F5F736C6F745F5F7371007E00003F400000000000037708000000040000000274000770726570656E64740000740006617070656E6471007E002D780074000B706C616365686F6C646572740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A2987400057374796C657371007E00003F40000000000001770800000002000000017400057769647468740004313030257800740009636C65617261626C6571007E000E74000B7072656669782D69636F6E71007E002D74000B7375666669782D69636F6E71007E002D7400096D61786C656E6774687074000F73686F772D776F72642D6C696D69747371007E000D00740008726561646F6E6C7971007E003A74000864697361626C656471007E003A74000A5F5F764D6F64656C5F5F7400086669656C6431303178007371007E00003F4000000000000C7708000000100000000C71007E00077371007E00003F400000000000187708000000200000000E71007E000974000CE8AFB7E58187E5A4A9E695B071007E000B7071007E000C71007E000E71007E000F71007E000E71007E0010740008656C2D696E70757471007E0012740005696E70757471007E001471007E000E71007E001574000B636F6C466F726D4974656D71007E001771007E001A71007E001B74003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E001D7371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E71007E0020740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E0022740004626C757278007871007E002471007E002571007E00267400103130313136343633363237353238353271007E002874000134780071007E002A7371007E00003F400000000000037708000000040000000271007E002C71007E002D71007E002E71007E002D780071007E002F740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E00317371007E00003F400000000000017708000000020000000171007E003374000431303025780071007E003571007E000E71007E003671007E002D71007E003771007E002D71007E00387071007E003971007E003A71007E003B71007E003A71007E003C71007E003A71007E003D74000364617978007371007E00003F4000000000000C7708000000100000000A71007E00077371007E00003F400000000000187708000000200000000E71007E000974000CE8AFB7E58187E5A487E6B3A871007E000B7071007E000C71007E000E71007E0010740008656C2D696E70757471007E0012740008746578746172656171007E001471007E000E71007E001574000B636F6C466F726D4974656D71007E001771007E001A71007E001D7371007E0004000000017704000000017371007E00003F4000000000000C7708000000100000000371007E001471007E000E71007E0020740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A871007E0022740004626C757278007871007E000F71007E000E71007E001B74003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00247371007E00180000006671007E00267400103130323136353035393234363936393271007E0028740003747474780074000474797065740008746578746172656171007E002F740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A87400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0018000000047400076D6178526F777371007E0065780071007E00317371007E00003F400000000000017708000000020000000171007E003374000431303025780071007E00387071007E003971007E003A71007E003B71007E003A71007E003C71007E003A71007E003D7400086669656C64313032780078740007666F726D526566740006656C466F726D740009666F726D4D6F64656C740008666F726D4461746174000473697A657400066D656469756D74000D6C6162656C506F736974696F6E740005726967687471007E000B7371007E001800000064740009666F726D52756C657374000572756C65737400066775747465727371007E00180000000F71007E003C71007E000E71007E001771007E001A740008666F726D42746E7371007E003A7800, NULL);
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2584', 1, 'var-fields', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000003770400000003737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000C74000A5F5F636F6E6669675F5F7371007E00023F400000000000187708000000200000000E7400056C6162656C74000CE8AFB7E58187E6A087E9A29874000A6C6162656C57696474687074000973686F774C6162656C737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870017400096368616E676554616771007E000C740003746167740008656C2D696E70757474000774616749636F6E740005696E707574740008726571756972656471007E000C7400066C61796F757474000B636F6C466F726D4974656D7400047370616E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000018740008646F63756D656E7474003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E7075747400077265674C6973747371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C7400076D657373616765740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A29874000774726967676572740004626C7572780078740006666F726D49647371007E00160000006574000972656E6465724B65797400103130313136353035393234363637303374000C64656661756C7456616C75657400066A696E74747478007400085F5F736C6F745F5F7371007E00023F400000000000037708000000040000000274000770726570656E64740000740006617070656E6471007E002B780074000B706C616365686F6C646572740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A2987400057374796C657371007E00023F40000000000001770800000002000000017400057769647468740004313030257800740009636C65617261626C6571007E000C74000B7072656669782D69636F6E71007E002B74000B7375666669782D69636F6E71007E002B7400096D61786C656E6774687074000F73686F772D776F72642D6C696D69747371007E000B00740008726561646F6E6C7971007E003874000864697361626C656471007E003874000A5F5F764D6F64656C5F5F7400086669656C6431303178007371007E00023F4000000000000C7708000000100000000C71007E00057371007E00023F400000000000187708000000200000000E71007E000774000CE8AFB7E58187E5A4A9E695B071007E00097071007E000A71007E000C71007E000D71007E000C71007E000E740008656C2D696E70757471007E0010740005696E70757471007E001271007E000C71007E001374000B636F6C466F726D4974656D71007E001571007E001871007E001974003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E001B7371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C71007E001E740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E0020740004626C757278007871007E002271007E002371007E00247400103130313136343633363237353238353271007E002674000134780071007E00287371007E00023F400000000000037708000000040000000271007E002A71007E002B71007E002C71007E002B780071007E002D740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E002F7371007E00023F400000000000017708000000020000000171007E003174000431303025780071007E003371007E000C71007E003471007E002B71007E003571007E002B71007E00367071007E003771007E003871007E003971007E003871007E003A71007E003871007E003B74000364617978007371007E00023F4000000000000C7708000000100000000A71007E00057371007E00023F400000000000187708000000200000000E71007E000774000CE8AFB7E58187E5A487E6B3A871007E00097071007E000A71007E000C71007E000E740008656C2D696E70757471007E0010740008746578746172656171007E001271007E000C71007E001374000B636F6C466F726D4974656D71007E001571007E001871007E001B7371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C71007E001E740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A871007E0020740004626C757278007871007E000D71007E000C71007E001974003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00227371007E00160000006671007E00247400103130323136353035393234363936393271007E0026740003747474780074000474797065740008746578746172656171007E002D740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A87400086175746F73697A657371007E00023F40000000000003770800000004000000027400076D696E526F77737371007E0016000000047400076D6178526F777371007E0063780071007E002F7371007E00023F400000000000017708000000020000000171007E003174000431303025780071007E00367071007E003771007E003871007E003971007E003871007E003A71007E003871007E003B7400086669656C64313032780078, NULL);
INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2586', 1, 'hist.var-fields', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000003770400000003737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000C74000A5F5F636F6E6669675F5F7371007E00023F400000000000187708000000200000000E7400056C6162656C74000CE8AFB7E58187E6A087E9A29874000A6C6162656C57696474687074000973686F774C6162656C737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870017400096368616E676554616771007E000C740003746167740008656C2D696E70757474000774616749636F6E740005696E707574740008726571756972656471007E000C7400066C61796F757474000B636F6C466F726D4974656D7400047370616E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000018740008646F63756D656E7474003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E7075747400077265674C6973747371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C7400076D657373616765740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A29874000774726967676572740004626C7572780078740006666F726D49647371007E00160000006574000972656E6465724B65797400103130313136353035393234363637303374000C64656661756C7456616C75657400066A696E74747478007400085F5F736C6F745F5F7371007E00023F400000000000037708000000040000000274000770726570656E64740000740006617070656E6471007E002B780074000B706C616365686F6C646572740015E8AFB7E8BE93E585A5E8AFB7E58187E6A087E9A2987400057374796C657371007E00023F40000000000001770800000002000000017400057769647468740004313030257800740009636C65617261626C6571007E000C74000B7072656669782D69636F6E71007E002B74000B7375666669782D69636F6E71007E002B7400096D61786C656E6774687074000F73686F772D776F72642D6C696D69747371007E000B00740008726561646F6E6C7971007E003874000864697361626C656471007E003874000A5F5F764D6F64656C5F5F7400086669656C6431303178007371007E00023F4000000000000C7708000000100000000C71007E00057371007E00023F400000000000187708000000200000000E71007E000774000CE8AFB7E58187E5A4A9E695B071007E00097071007E000A71007E000C71007E000D71007E000C71007E000E740008656C2D696E70757471007E0010740005696E70757471007E001271007E000C71007E001374000B636F6C466F726D4974656D71007E001571007E001871007E001974003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E001B7371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C71007E001E740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E0020740004626C757278007871007E002271007E002371007E00247400103130313136343633363237353238353271007E002674000134780071007E00287371007E00023F400000000000037708000000040000000271007E002A71007E002B71007E002C71007E002B780071007E002D740015E8AFB7E8BE93E585A5E8AFB7E58187E5A4A9E695B071007E002F7371007E00023F400000000000017708000000020000000171007E003174000431303025780071007E003371007E000C71007E003471007E002B71007E003571007E002B71007E00367071007E003771007E003871007E003971007E003871007E003A71007E003871007E003B74000364617978007371007E00023F4000000000000C7708000000100000000A71007E00057371007E00023F400000000000187708000000200000000E71007E000774000CE8AFB7E58187E5A487E6B3A871007E00097071007E000A71007E000C71007E000E740008656C2D696E70757471007E0010740008746578746172656171007E001271007E000C71007E001374000B636F6C466F726D4974656D71007E001571007E001871007E001B7371007E0000000000017704000000017371007E00023F4000000000000C7708000000100000000371007E001271007E000C71007E001E740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A871007E0020740004626C757278007871007E000D71007E000C71007E001974003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00227371007E00160000006671007E00247400103130323136353035393234363936393271007E0026740003747474780074000474797065740008746578746172656171007E002D740015E8AFB7E8BE93E585A5E8AFB7E58187E5A487E6B3A87400086175746F73697A657371007E00023F40000000000003770800000004000000027400076D696E526F77737371007E0016000000047400076D6178526F777371007E0063780071007E002F7371007E00023F400000000000017708000000020000000171007E003174000431303025780071007E00367071007E003771007E003871007E003971007E003871007E003A71007E003871007E003B7400086669656C64313032780078, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_GE_PROPERTY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;
CREATE TABLE `ACT_GE_PROPERTY` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_GE_PROPERTY
-- ----------------------------
BEGIN;
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('batch.schema.version', '6.7.2.3', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('common.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('entitylink.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('eventsubscription.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('identitylink.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('job.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('next.dbid', '7501', 4);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.history', 'upgrade(6.7.2.0->6.8.0.0)', 2);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.8.0.0', 2);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('task.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('variable.schema.version', '6.8.0.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_ACTINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ACTINST`;
CREATE TABLE `ACT_HI_ACTINST` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int(11) DEFAULT NULL,
                                  `DURATION_` bigint(20) DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`),
                                  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
                                  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
                                  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
                                  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_ACTINST
-- ----------------------------
BEGIN;
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2533', 1, 'flow_ks2lyz4c:2:2522', '2523', '2532', 'start_event', NULL, NULL, '开始', 'startEvent', NULL, '2022-12-26 11:28:09.659', '2022-12-26 11:28:09.659', 1, 0, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2534', 1, 'flow_ks2lyz4c:2:2522', '2523', '2532', 'Flow_1tumnt6', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-12-26 11:28:09.659', '2022-12-26 11:28:09.659', 2, 0, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2535', 3, 'flow_ks2lyz4c:2:2522', '2523', '2532', 'Activity_1qg9oga', '2536', NULL, '行政', 'userTask', '1', '2022-12-26 11:28:09.659', '2022-12-26 11:29:12.968', 3, 63309, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2558', 1, 'flow_ks2lyz4c:2:2522', '2523', '2532', 'Flow_1xzsicg', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-12-26 11:29:12.969', '2022-12-26 11:29:12.969', 1, 0, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2559', 3, 'flow_ks2lyz4c:2:2522', '2523', '2532', 'Activity_1m9b8mu', '2560', NULL, '老板', 'userTask', '1', '2022-12-26 11:29:12.969', '2022-12-26 18:54:38.684', 2, 26725715, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2573', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'start_event', NULL, NULL, '开始', 'startEvent', NULL, '2022-12-26 11:31:33.717', '2022-12-26 11:31:33.717', 1, 0, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2574', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Flow_1tumnt6', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-12-26 11:31:33.718', '2022-12-26 11:31:33.718', 2, 0, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2575', 3, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Activity_1qg9oga', '2576', NULL, '行政', 'userTask', '2', '2022-12-26 11:31:33.718', '2022-12-26 11:32:01.166', 3, 27448, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2598', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Flow_1xzsicg', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-12-26 11:32:01.166', '2022-12-26 11:32:01.166', 1, 0, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2599', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Activity_1m9b8mu', '2600', NULL, '老板', 'userTask', NULL, '2022-12-26 11:32:01.167', NULL, 2, NULL, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('5005', 1, 'flow_ks2lyz4c:2:2522', '2523', '2532', 'Flow_16hid0q', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-12-26 18:54:38.691', '2022-12-26 18:54:38.691', 1, 0, NULL, '');
INSERT INTO `ACT_HI_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('5006', 1, 'flow_ks2lyz4c:2:2522', '2523', '2532', 'Event_0pucu17', NULL, NULL, '', 'endEvent', NULL, '2022-12-26 18:54:38.692', '2022-12-26 18:54:38.693', 2, 1, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_ATTACHMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;
CREATE TABLE `ACT_HI_ATTACHMENT` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TIME_` datetime(3) DEFAULT NULL,
                                     PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_ATTACHMENT
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_COMMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_COMMENT`;
CREATE TABLE `ACT_HI_COMMENT` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TIME_` datetime(3) NOT NULL,
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `FULL_MSG_` longblob,
                                  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_COMMENT
-- ----------------------------
BEGIN;
INSERT INTO `ACT_HI_COMMENT` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('2541', '1', '2022-12-26 11:29:12.929', NULL, '2536', '2523', 'AddComment', 'ddd', 0x646464);
INSERT INTO `ACT_HI_COMMENT` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('2543', 'event', '2022-12-26 11:29:12.946', NULL, '2536', NULL, 'AddUserLink', '1_|_assignee', NULL);
INSERT INTO `ACT_HI_COMMENT` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('2581', '1', '2022-12-26 11:32:01.141', NULL, '2576', '2563', 'AddComment', 'rrrr', 0x72727272);
INSERT INTO `ACT_HI_COMMENT` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('2583', 'event', '2022-12-26 11:32:01.150', NULL, '2576', NULL, 'AddUserLink', '2_|_assignee', NULL);
INSERT INTO `ACT_HI_COMMENT` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('5001', '1', '2022-12-26 18:54:38.588', 'admin', '2560', '2523', 'AddComment', 'hhh', 0x686868);
INSERT INTO `ACT_HI_COMMENT` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('5003', 'event', '2022-12-26 18:54:38.622', 'admin', '2560', NULL, 'AddUserLink', '1_|_assignee', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_DETAIL
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_DETAIL`;
CREATE TABLE `ACT_HI_DETAIL` (
                                 `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                 `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                 `REV_` int(11) DEFAULT NULL,
                                 `TIME_` datetime(3) NOT NULL,
                                 `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `DOUBLE_` double DEFAULT NULL,
                                 `LONG_` bigint(20) DEFAULT NULL,
                                 `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 PRIMARY KEY (`ID_`),
                                 KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
                                 KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
                                 KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
                                 KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
                                 KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_DETAIL
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_ENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ENTITYLINK`;
CREATE TABLE `ACT_HI_ENTITYLINK` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_ENTITYLINK
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_IDENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_IDENTITYLINK`;
CREATE TABLE `ACT_HI_IDENTITYLINK` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_IDENTITYLINK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2524', NULL, 'starter', '1', NULL, '2022-12-26 11:28:09.658', '2523', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2537', NULL, 'candidate', '1', '2536', '2022-12-26 11:28:09.660', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2538', NULL, 'participant', '1', NULL, '2022-12-26 11:28:09.660', '2523', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2539', NULL, 'candidate', '2', '2536', '2022-12-26 11:28:09.660', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2540', NULL, 'participant', '2', NULL, '2022-12-26 11:28:09.660', '2523', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2542', NULL, 'assignee', '1', '2536', '2022-12-26 11:29:12.943', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2561', '1', 'candidate', NULL, '2560', '2022-12-26 11:29:12.973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2562', '2', 'candidate', NULL, '2560', '2022-12-26 11:29:12.973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2564', NULL, 'starter', '1', NULL, '2022-12-26 11:31:33.717', '2563', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2577', NULL, 'candidate', '1', '2576', '2022-12-26 11:31:33.718', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2578', NULL, 'participant', '1', NULL, '2022-12-26 11:31:33.718', '2563', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2579', NULL, 'candidate', '2', '2576', '2022-12-26 11:31:33.718', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2580', NULL, 'participant', '2', NULL, '2022-12-26 11:31:33.718', '2563', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2582', NULL, 'assignee', '2', '2576', '2022-12-26 11:32:01.148', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2601', '2', 'candidate', NULL, '2600', '2022-12-26 11:32:01.168', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('5002', NULL, 'assignee', '1', '2560', '2022-12-26 18:54:38.616', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_IDENTITYLINK` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('5004', NULL, 'participant', 'admin', NULL, '2022-12-26 18:54:38.671', '2523', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_PROCINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_PROCINST`;
CREATE TABLE `ACT_HI_PROCINST` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT '1',
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint(20) DEFAULT NULL,
                                   `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`),
                                   UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
                                   KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
                                   KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`),
                                   KEY `ACT_IDX_HI_PRO_SUPER_PROCINST` (`SUPER_PROCESS_INSTANCE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_PROCINST
-- ----------------------------
BEGIN;
INSERT INTO `ACT_HI_PROCINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('2523', 2, '2523', NULL, 'flow_ks2lyz4c:2:2522', '2022-12-26 11:28:09.658', '2022-12-26 18:54:38.715', 26789057, '1', 'start_event', 'Event_0pucu17', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_HI_PROCINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('2563', 1, '2563', NULL, 'flow_ks2lyz4c:2:2522', '2022-12-26 11:31:33.717', NULL, NULL, '1', 'start_event', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_TASKINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_TASKINST`;
CREATE TABLE `ACT_HI_TASKINST` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT '1',
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint(20) DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `PRIORITY_` int(11) DEFAULT NULL,
                                   `DUE_DATE_` datetime(3) DEFAULT NULL,
                                   `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                   PRIMARY KEY (`ID_`),
                                   KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_TASKINST
-- ----------------------------
BEGIN;
INSERT INTO `ACT_HI_TASKINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('2536', 3, 'flow_ks2lyz4c:2:2522', NULL, 'Activity_1qg9oga', '2523', '2532', NULL, NULL, NULL, NULL, NULL, '行政', NULL, NULL, NULL, '1', '2022-12-26 11:28:09.659', NULL, '2022-12-26 11:29:12.964', 63305, NULL, 50, NULL, NULL, NULL, '', '2022-12-26 11:29:12.964');
INSERT INTO `ACT_HI_TASKINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('2560', 3, 'flow_ks2lyz4c:2:2522', NULL, 'Activity_1m9b8mu', '2523', '2532', NULL, NULL, NULL, NULL, NULL, '老板', NULL, NULL, NULL, '1', '2022-12-26 11:29:12.969', NULL, '2022-12-26 18:54:38.676', 26725707, NULL, 50, NULL, NULL, NULL, '', '2022-12-26 18:54:38.676');
INSERT INTO `ACT_HI_TASKINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('2576', 3, 'flow_ks2lyz4c:2:2522', NULL, 'Activity_1qg9oga', '2563', '2572', NULL, NULL, NULL, NULL, NULL, '行政', NULL, NULL, NULL, '2', '2022-12-26 11:31:33.718', NULL, '2022-12-26 11:32:01.163', 27445, NULL, 50, NULL, NULL, NULL, '', '2022-12-26 11:32:01.163');
INSERT INTO `ACT_HI_TASKINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('2600', 1, 'flow_ks2lyz4c:2:2522', NULL, 'Activity_1m9b8mu', '2563', '2572', NULL, NULL, NULL, NULL, NULL, '老板', NULL, NULL, NULL, NULL, '2022-12-26 11:32:01.167', NULL, NULL, NULL, NULL, 50, NULL, NULL, NULL, '', '2022-12-26 11:32:01.167');
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_TSK_LOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_TSK_LOG`;
CREATE TABLE `ACT_HI_TSK_LOG` (
                                  `ID_` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DATA_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_TSK_LOG
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_HI_VARINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_VARINST`;
CREATE TABLE `ACT_HI_VARINST` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DOUBLE_` double DEFAULT NULL,
                                  `LONG_` bigint(20) DEFAULT NULL,
                                  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                  PRIMARY KEY (`ID_`),
                                  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
                                  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
                                  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`),
                                  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_HI_VARINST
-- ----------------------------
BEGIN;
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2525', 0, '2523', '2523', NULL, 'field101', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '测试', NULL, '2022-12-26 11:28:09.659', '2022-12-26 11:28:09.659');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2526', 0, '2523', '2523', NULL, 'day', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '2022-12-26 11:28:09.659', '2022-12-26 11:28:09.659');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2527', 0, '2523', '2523', NULL, 'field102', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'test', NULL, '2022-12-26 11:28:09.659', '2022-12-26 11:28:09.659');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2529', 0, '2523', '2523', NULL, 'variables', 'serializable', NULL, NULL, NULL, '2530', NULL, NULL, NULL, NULL, '2022-12-26 11:28:09.659', '2022-12-26 11:28:09.659');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2531', 0, '2523', '2523', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2022-12-26 11:28:09.659', '2022-12-26 11:28:09.659');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2545', 1, '2523', '2523', NULL, 'fields', 'serializable', NULL, NULL, NULL, '2546', NULL, NULL, NULL, NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.656');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2547', 1, '2523', '2523', NULL, 'formRef', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'elForm', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.659');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2548', 1, '2523', '2523', NULL, 'formModel', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'formData', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.661');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2549', 1, '2523', '2523', NULL, 'size', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'medium', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.662');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2550', 1, '2523', '2523', NULL, 'labelPosition', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'right', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.663');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2551', 1, '2523', '2523', NULL, 'labelWidth', 'integer', NULL, NULL, NULL, NULL, NULL, 100, '100', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.665');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2552', 1, '2523', '2523', NULL, 'formRules', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'rules', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.665');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2553', 1, '2523', '2523', NULL, 'gutter', 'integer', NULL, NULL, NULL, NULL, NULL, 15, '15', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.666');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2554', 1, '2523', '2523', NULL, 'disabled', 'boolean', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.667');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2555', 1, '2523', '2523', NULL, 'span', 'integer', NULL, NULL, NULL, NULL, NULL, 24, '24', NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.668');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2556', 1, '2523', '2523', NULL, 'formBtns', 'boolean', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2022-12-26 11:29:12.962', '2022-12-26 18:54:38.669');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2557', 0, '2523', '2523', NULL, 'approval', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1,2', NULL, '2022-12-26 11:29:12.963', '2022-12-26 11:29:12.963');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2565', 0, '2563', '2563', NULL, 'field101', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'jinttt', NULL, '2022-12-26 11:31:33.717', '2022-12-26 11:31:33.717');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2566', 0, '2563', '2563', NULL, 'day', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '4', NULL, '2022-12-26 11:31:33.717', '2022-12-26 11:31:33.717');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2567', 0, '2563', '2563', NULL, 'field102', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'ttt', NULL, '2022-12-26 11:31:33.717', '2022-12-26 11:31:33.717');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2569', 0, '2563', '2563', NULL, 'variables', 'serializable', NULL, NULL, NULL, '2570', NULL, NULL, NULL, NULL, '2022-12-26 11:31:33.717', '2022-12-26 11:31:33.717');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2571', 0, '2563', '2563', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2022-12-26 11:31:33.717', '2022-12-26 11:31:33.717');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2585', 0, '2563', '2563', NULL, 'fields', 'serializable', NULL, NULL, NULL, '2586', NULL, NULL, NULL, NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2587', 0, '2563', '2563', NULL, 'formRef', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'elForm', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2588', 0, '2563', '2563', NULL, 'formModel', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'formData', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2589', 0, '2563', '2563', NULL, 'size', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'medium', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2590', 0, '2563', '2563', NULL, 'labelPosition', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'right', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2591', 0, '2563', '2563', NULL, 'labelWidth', 'integer', NULL, NULL, NULL, NULL, NULL, 100, '100', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2592', 0, '2563', '2563', NULL, 'formRules', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'rules', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2593', 0, '2563', '2563', NULL, 'gutter', 'integer', NULL, NULL, NULL, NULL, NULL, 15, '15', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2594', 0, '2563', '2563', NULL, 'disabled', 'boolean', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2595', 0, '2563', '2563', NULL, 'span', 'integer', NULL, NULL, NULL, NULL, NULL, 24, '24', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2596', 0, '2563', '2563', NULL, 'formBtns', 'boolean', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
INSERT INTO `ACT_HI_VARINST` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2597', 0, '2563', '2563', NULL, 'approval', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2022-12-26 11:32:01.162', '2022-12-26 11:32:01.162');
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_BYTEARRAY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_BYTEARRAY`;
CREATE TABLE `ACT_ID_BYTEARRAY` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_BYTEARRAY
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_GROUP
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_GROUP`;
CREATE TABLE `ACT_ID_GROUP` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_GROUP
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_INFO
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_INFO`;
CREATE TABLE `ACT_ID_INFO` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int(11) DEFAULT NULL,
                               `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PASSWORD_` longblob,
                               `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_INFO
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_MEMBERSHIP
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;
CREATE TABLE `ACT_ID_MEMBERSHIP` (
                                     `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
                                     KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
                                     CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `ACT_ID_GROUP` (`ID_`),
                                     CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `ACT_ID_USER` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_MEMBERSHIP
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_PRIV
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_PRIV`;
CREATE TABLE `ACT_ID_PRIV` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                               PRIMARY KEY (`ID_`),
                               UNIQUE KEY `ACT_UNIQ_PRIV_NAME` (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_PRIV
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_PRIV_MAPPING
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_PRIV_MAPPING`;
CREATE TABLE `ACT_ID_PRIV_MAPPING` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `PRIV_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`),
                                       KEY `ACT_IDX_PRIV_USER` (`USER_ID_`),
                                       KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`),
                                       CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `ACT_ID_PRIV` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_PRIV_MAPPING
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_PROPERTY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_PROPERTY`;
CREATE TABLE `ACT_ID_PROPERTY` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_PROPERTY
-- ----------------------------
BEGIN;
INSERT INTO `ACT_ID_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.8.0.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_TOKEN
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_TOKEN`;
CREATE TABLE `ACT_ID_TOKEN` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `TOKEN_VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATE_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                `IP_ADDRESS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_AGENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATA_` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
                                PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_TOKEN
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_ID_USER
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_USER`;
CREATE TABLE `ACT_ID_USER` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int(11) DEFAULT NULL,
                               `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DISPLAY_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                               PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_ID_USER
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_PROCDEF_INFO
-- ----------------------------
DROP TABLE IF EXISTS `ACT_PROCDEF_INFO`;
CREATE TABLE `ACT_PROCDEF_INFO` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
                                    KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
                                    KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
                                    CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                    CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_PROCDEF_INFO
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RE_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;
CREATE TABLE `ACT_RE_DEPLOYMENT` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
                                     `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_DEPLOYMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RE_DEPLOYMENT
-- ----------------------------
BEGIN;
INSERT INTO `ACT_RE_DEPLOYMENT` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('2519', 'flow_a9z4w99d', 'oa', NULL, '', '2022-12-26 11:27:34.708', NULL, NULL, '2519', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_RE_MODEL
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_MODEL`;
CREATE TABLE `ACT_RE_MODEL` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `VERSION_` int(11) DEFAULT NULL,
                                `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`),
                                KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
                                KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
                                KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
                                CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RE_MODEL
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RE_PROCDEF
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;
CREATE TABLE `ACT_RE_PROCDEF` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT NULL,
                                  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VERSION_` int(11) NOT NULL,
                                  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
                                  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
                                  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_VERSION_` int(11) NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`ID_`),
                                  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`DERIVED_VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RE_PROCDEF
-- ----------------------------
BEGIN;
INSERT INTO `ACT_RE_PROCDEF` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('flow_ks2lyz4c:2:2522', 2, 'oa', 'flow_a9z4w99d', 'flow_ks2lyz4c', 2, '2519', 'flow_a9z4w99d.bpmn', 'flow_a9z4w99d.flow_ks2lyz4c.png', NULL, 0, 1, 1, '', NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_ACTINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_ACTINST`;
CREATE TABLE `ACT_RU_ACTINST` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `DURATION_` bigint(20) DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int(11) DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`),
                                  KEY `ACT_IDX_RU_ACTI_START` (`START_TIME_`),
                                  KEY `ACT_IDX_RU_ACTI_END` (`END_TIME_`),
                                  KEY `ACT_IDX_RU_ACTI_PROC` (`PROC_INST_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_PROC_ACT` (`PROC_INST_ID_`,`ACT_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_EXEC` (`EXECUTION_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_EXEC_ACT` (`EXECUTION_ID_`,`ACT_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_TASK` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_ACTINST
-- ----------------------------
BEGIN;
INSERT INTO `ACT_RU_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2573', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'start_event', NULL, NULL, '开始', 'startEvent', NULL, '2022-12-26 11:31:33.717', '2022-12-26 11:31:33.717', 0, 1, NULL, '');
INSERT INTO `ACT_RU_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2574', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Flow_1tumnt6', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-12-26 11:31:33.718', '2022-12-26 11:31:33.718', 0, 2, NULL, '');
INSERT INTO `ACT_RU_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2575', 3, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Activity_1qg9oga', '2576', NULL, '行政', 'userTask', '2', '2022-12-26 11:31:33.718', '2022-12-26 11:32:01.166', 27448, 3, NULL, '');
INSERT INTO `ACT_RU_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2598', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Flow_1xzsicg', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-12-26 11:32:01.166', '2022-12-26 11:32:01.166', 0, 1, NULL, '');
INSERT INTO `ACT_RU_ACTINST` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2599', 1, 'flow_ks2lyz4c:2:2522', '2563', '2572', 'Activity_1m9b8mu', '2600', NULL, '老板', 'userTask', NULL, '2022-12-26 11:32:01.167', NULL, NULL, 2, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_DEADLETTER_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_DEADLETTER_JOB`;
CREATE TABLE `ACT_RU_DEADLETTER_JOB` (
                                         `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                         `REV_` int(11) DEFAULT NULL,
                                         `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                         `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                         `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                         `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                         PRIMARY KEY (`ID_`),
                                         KEY `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                         KEY `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                         KEY `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                         KEY `ACT_IDX_DJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                         KEY `ACT_IDX_DJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                         KEY `ACT_IDX_DJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                         KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
                                         KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                                         KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_DEADLETTER_JOB
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_ENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_ENTITYLINK`;
CREATE TABLE `ACT_RU_ENTITYLINK` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`),
                                     KEY `ACT_IDX_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_ENTITYLINK
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_EVENT_SUBSCR
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;
CREATE TABLE `ACT_RU_EVENT_SUBSCR` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
                                       KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
                                       KEY `ACT_IDX_EVENT_SUBSCR_SCOPEREF_` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_EVENT_SUBSCR
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_EXECUTION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;
CREATE TABLE `ACT_RU_EXECUTION` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
                                    `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
                                    `IS_SCOPE_` tinyint(4) DEFAULT NULL,
                                    `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
                                    `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
                                    `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                                    `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_TIME_` datetime(3) DEFAULT NULL,
                                    `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
                                    `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
                                    `TASK_COUNT_` int(11) DEFAULT NULL,
                                    `JOB_COUNT_` int(11) DEFAULT NULL,
                                    `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `EXTERNAL_WORKER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `VAR_COUNT_` int(11) DEFAULT NULL,
                                    `ID_LINK_COUNT_` int(11) DEFAULT NULL,
                                    `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
                                    KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
                                    KEY `ACT_IDX_EXEC_REF_ID_` (`REFERENCE_ID_`),
                                    KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
                                    KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
                                    KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
                                    KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
                                    CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
                                    CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_EXECUTION
-- ----------------------------
BEGIN;
INSERT INTO `ACT_RU_EXECUTION` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('2563', 1, '2563', NULL, NULL, 'flow_ks2lyz4c:2:2522', NULL, '2563', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'start_event', '2022-12-26 11:31:33.717', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_RU_EXECUTION` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('2572', 2, '2563', NULL, '2563', 'flow_ks2lyz4c:2:2522', NULL, '2563', 'Activity_1m9b8mu', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2022-12-26 11:31:33.717', NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_EXTERNAL_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EXTERNAL_JOB`;
CREATE TABLE `ACT_RU_EXTERNAL_JOB` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `RETRIES_` int(11) DEFAULT NULL,
                                       `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                       `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                       KEY `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                       KEY `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                       KEY `ACT_IDX_EJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_EJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_EJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_EXTERNAL_JOB
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_HISTORY_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_HISTORY_JOB`;
CREATE TABLE `ACT_RU_HISTORY_JOB` (
                                      `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                      `REV_` int(11) DEFAULT NULL,
                                      `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `RETRIES_` int(11) DEFAULT NULL,
                                      `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `ADV_HANDLER_CFG_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_HISTORY_JOB
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_IDENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;
CREATE TABLE `ACT_RU_IDENTITYLINK` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
                                       KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
                                       KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
                                       KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
                                       CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
                                       CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                       CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `ACT_RU_TASK` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_IDENTITYLINK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_RU_IDENTITYLINK` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2564', 1, NULL, 'starter', '1', NULL, '2563', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_RU_IDENTITYLINK` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2578', 1, NULL, 'participant', '1', NULL, '2563', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_RU_IDENTITYLINK` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2580', 1, NULL, 'participant', '2', NULL, '2563', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ACT_RU_IDENTITYLINK` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('2601', 1, '2', 'candidate', NULL, '2600', NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_JOB`;
CREATE TABLE `ACT_RU_JOB` (
                              `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                              `REV_` int(11) DEFAULT NULL,
                              `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                              `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                              `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `RETRIES_` int(11) DEFAULT NULL,
                              `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                              `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                              PRIMARY KEY (`ID_`),
                              KEY `ACT_IDX_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                              KEY `ACT_IDX_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                              KEY `ACT_IDX_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                              KEY `ACT_IDX_JOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                              KEY `ACT_IDX_JOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                              KEY `ACT_IDX_JOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                              KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
                              KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                              KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                              CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_JOB
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_SUSPENDED_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_SUSPENDED_JOB`;
CREATE TABLE `ACT_RU_SUSPENDED_JOB` (
                                        `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                        `REV_` int(11) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                        `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                        `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `RETRIES_` int(11) DEFAULT NULL,
                                        `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                        `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                        PRIMARY KEY (`ID_`),
                                        KEY `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                        KEY `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                        KEY `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                        KEY `ACT_IDX_SJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                        KEY `ACT_IDX_SJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                        KEY `ACT_IDX_SJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                        KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
                                        KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                                        KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_SUSPENDED_JOB
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_TASK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_TASK`;
CREATE TABLE `ACT_RU_TASK` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int(11) DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PRIORITY_` int(11) DEFAULT NULL,
                               `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `DUE_DATE_` datetime(3) DEFAULT NULL,
                               `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                               `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                               `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                               `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
                               `VAR_COUNT_` int(11) DEFAULT NULL,
                               `ID_LINK_COUNT_` int(11) DEFAULT NULL,
                               `SUB_TASK_COUNT_` int(11) DEFAULT NULL,
                               PRIMARY KEY (`ID_`),
                               KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
                               KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                               KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                               KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                               KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
                               KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
                               KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
                               CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_TASK
-- ----------------------------
BEGIN;
INSERT INTO `ACT_RU_TASK` (`ID_`, `REV_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `TASK_DEF_KEY_`, `OWNER_`, `ASSIGNEE_`, `DELEGATION_`, `PRIORITY_`, `CREATE_TIME_`, `DUE_DATE_`, `CATEGORY_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `FORM_KEY_`, `CLAIM_TIME_`, `IS_COUNT_ENABLED_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `SUB_TASK_COUNT_`) VALUES ('2600', 1, '2572', '2563', 'flow_ks2lyz4c:2:2522', NULL, NULL, NULL, NULL, NULL, NULL, '老板', NULL, NULL, 'Activity_1m9b8mu', NULL, NULL, NULL, 50, '2022-12-26 11:32:01.167', NULL, NULL, 1, '', NULL, NULL, 1, 0, 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_TIMER_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_TIMER_JOB`;
CREATE TABLE `ACT_RU_TIMER_JOB` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                    `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                    `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `RETRIES_` int(11) DEFAULT NULL,
                                    `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                    `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    PRIMARY KEY (`ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_DUEDATE` (`DUEDATE_`),
                                    KEY `ACT_IDX_TJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                    KEY `ACT_IDX_TJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                    KEY `ACT_IDX_TJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                    KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
                                    KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                                    KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_TIMER_JOB
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ACT_RU_VARIABLE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;
CREATE TABLE `ACT_RU_VARIABLE` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DOUBLE_` double DEFAULT NULL,
                                   `LONG_` bigint(20) DEFAULT NULL,
                                   `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`),
                                   KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
                                   KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
                                   KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
                                   KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
                                   CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ACT_RU_VARIABLE
-- ----------------------------
BEGIN;
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2565', 1, 'string', 'field101', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'jinttt', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2566', 1, 'string', 'day', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2567', 1, 'string', 'field102', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ttt', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2569', 1, 'serializable', 'variables', '2563', '2563', NULL, NULL, NULL, NULL, '2568', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2571', 1, 'long', 'INITIATOR', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2585', 1, 'serializable', 'fields', '2563', '2563', NULL, NULL, NULL, NULL, '2584', NULL, NULL, NULL, NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2587', 1, 'string', 'formRef', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'elForm', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2588', 1, 'string', 'formModel', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'formData', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2589', 1, 'string', 'size', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'medium', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2590', 1, 'string', 'labelPosition', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'right', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2591', 1, 'integer', 'labelWidth', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, 100, '100', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2592', 1, 'string', 'formRules', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rules', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2593', 1, 'integer', 'gutter', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, 15, '15', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2594', 1, 'boolean', 'disabled', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2595', 1, 'integer', 'span', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, 24, '24', NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2596', 1, 'boolean', 'formBtns', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('2597', 1, 'string', 'approval', '2563', '2563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL);
COMMIT;

-- ----------------------------
-- Table structure for FLW_CHANNEL_DEFINITION
-- ----------------------------
DROP TABLE IF EXISTS `FLW_CHANNEL_DEFINITION`;
CREATE TABLE `FLW_CHANNEL_DEFINITION` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `VERSION_` int(11) DEFAULT NULL,
                                          `KEY_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                          `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                          `TYPE_` varchar(255) DEFAULT NULL,
                                          `IMPLEMENTATION_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`),
                                          UNIQUE KEY `ACT_IDX_CHANNEL_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of FLW_CHANNEL_DEFINITION
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for FLW_EVENT_DEFINITION
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EVENT_DEFINITION`;
CREATE TABLE `FLW_EVENT_DEFINITION` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `VERSION_` int(11) DEFAULT NULL,
                                        `KEY_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                        `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`),
                                        UNIQUE KEY `ACT_IDX_EVENT_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of FLW_EVENT_DEFINITION
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for FLW_EVENT_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EVENT_DEPLOYMENT`;
CREATE TABLE `FLW_EVENT_DEPLOYMENT` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of FLW_EVENT_DEPLOYMENT
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for FLW_EVENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EVENT_RESOURCE`;
CREATE TABLE `FLW_EVENT_RESOURCE` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                      `RESOURCE_BYTES_` longblob,
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of FLW_EVENT_RESOURCE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for FLW_EV_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EV_DATABASECHANGELOG`;
CREATE TABLE `FLW_EV_DATABASECHANGELOG` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int(11) NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of FLW_EV_DATABASECHANGELOG
-- ----------------------------
BEGIN;
INSERT INTO `FLW_EV_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2022-12-11 17:28:49', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.3.5', NULL, NULL, '0750929197');
INSERT INTO `FLW_EV_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2022-12-11 17:28:49', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.3.5', NULL, NULL, '0750929197');
INSERT INTO `FLW_EV_DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2022-12-11 17:28:49', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.3.5', NULL, NULL, '0750929197');
COMMIT;

-- ----------------------------
-- Table structure for FLW_EV_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EV_DATABASECHANGELOGLOCK`;
CREATE TABLE `FLW_EV_DATABASECHANGELOGLOCK` (
                                                `ID` int(11) NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of FLW_EV_DATABASECHANGELOGLOCK
-- ----------------------------
BEGIN;
INSERT INTO `FLW_EV_DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for FLW_RU_BATCH
-- ----------------------------
DROP TABLE IF EXISTS `FLW_RU_BATCH`;
CREATE TABLE `FLW_RU_BATCH` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` datetime(3) NOT NULL,
                                `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `BATCH_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of FLW_RU_BATCH
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for FLW_RU_BATCH_PART
-- ----------------------------
DROP TABLE IF EXISTS `FLW_RU_BATCH_PART`;
CREATE TABLE `FLW_RU_BATCH_PART` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `BATCH_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) NOT NULL,
                                     `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                     `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `RESULT_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     PRIMARY KEY (`ID_`),
                                     KEY `FLW_IDX_BATCH_PART` (`BATCH_ID_`),
                                     CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `FLW_RU_BATCH` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of FLW_RU_BATCH_PART
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
                                      `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                      `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                      `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                      `blob_data` blob COMMENT '存放持久化Trigger对象',
                                      PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                      CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Blob类型的触发器表';

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
                                  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
                                  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
                                  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日历信息表';

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
                                      `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                      `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                      `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                      `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
                                      `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
                                      PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                      CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cron类型的触发器表';

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
                                       `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                       `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
                                       `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                       `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                       `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
                                       `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
                                       `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
                                       `priority` int(11) NOT NULL COMMENT '优先级',
                                       `state` varchar(16) NOT NULL COMMENT '状态',
                                       `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
                                       `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
                                       `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
                                       `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
                                       PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='已触发的触发器表';

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
                                    `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                    `job_name` varchar(200) NOT NULL COMMENT '任务名称',
                                    `job_group` varchar(200) NOT NULL COMMENT '任务组名',
                                    `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
                                    `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
                                    `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
                                    `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
                                    `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
                                    `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
                                    `job_data` blob COMMENT '存放持久化job对象',
                                    PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务详细信息表';

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
                              `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                              `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
                              PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='存储的悲观锁信息表';

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
                                            `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                            `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                            PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='暂停的触发器表';

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
                                        `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                        `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
                                        `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
                                        `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
                                        PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调度器状态表';

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
                                        `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                        `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                        `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                        `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
                                        `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
                                        `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
                                        PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                        CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='简单触发器的信息表';

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
                                         `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                         `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                         `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                         `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
                                         `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
                                         `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
                                         `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
                                         `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
                                         `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
                                         `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
                                         `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
                                         `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
                                         `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
                                         `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
                                         PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                         CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同步机制的行锁表';

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
                                 `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                 `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
                                 `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
                                 `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
                                 `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
                                 `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
                                 `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
                                 `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
                                 `priority` int(11) DEFAULT NULL COMMENT '优先级',
                                 `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
                                 `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
                                 `start_time` bigint(13) NOT NULL COMMENT '开始时间',
                                 `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
                                 `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
                                 `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
                                 `job_data` blob COMMENT '存放持久化job对象',
                                 PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                 KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
                                 CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='触发器详细信息表';

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
                             `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                             `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
                             `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
                             `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
                             `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
                             `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
                             `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
                             `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
                             `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
                             `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
                             `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
                             `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
                             `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
                             `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
                             `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
                             `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                             `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                             `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
                                    `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                    `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
                                    `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
                                    `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
                                    `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
                                    `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
                                    `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
                                    `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
                                    `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
                                    `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
                                    `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
                                    `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
                                    `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
                                    `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
                                    `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
                                    `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
                                    `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
                                    `sort` int(11) DEFAULT NULL COMMENT '排序',
                                    `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                    `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                    PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
                              `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
                              `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
                              `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
                              `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
                              `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-12-11 16:51:52', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-12-11 16:51:52', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-12-11 16:51:52', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2022-12-11 16:51:52', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-12-11 16:51:52', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
COMMIT;

-- ----------------------------
-- Table structure for sys_deploy_form
-- ----------------------------
DROP TABLE IF EXISTS `sys_deploy_form`;
CREATE TABLE `sys_deploy_form` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `form_id` bigint(20) DEFAULT NULL COMMENT '表单主键',
                                   `deploy_id` varchar(50) DEFAULT NULL COMMENT '流程实例主键',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6201 DEFAULT CHARSET=utf8mb4 COMMENT='流程实例关联表单';

-- ----------------------------
-- Records of sys_deploy_form
-- ----------------------------
BEGIN;
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6180, 3170, '599f76eb-7954-11ed-b4f6-a6d273354027');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6181, 3170, '7626e55d-7af5-11ed-9d2c-aef9a5fa0bfa');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6182, 3170, '9fc55848-7b94-11ed-8d55-5ae1c970b0cc');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6183, 3170, '86d012f0-7b95-11ed-8d55-5ae1c970b0cc');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6184, 3170, '9324a1b5-7c2c-11ed-8695-924c6d734391');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6185, 3170, '18667e8e-7c88-11ed-a7de-e253d0217ba3');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6186, 3170, 'c2f37152-7cf1-11ed-948d-7226aba284c4');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6187, 3170, '3408e017-7cf2-11ed-948d-7226aba284c4');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6188, 3170, 'b69aadce-7cf7-11ed-bd4e-7226aba284c4');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6189, 3170, '9c3e92ed-7cfd-11ed-813e-621e497bd95c');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6190, 3170, '275bfcb5-7e95-11ed-b044-cacdb63dfd63');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6191, 3170, '42caede2-7eb1-11ed-8a7b-563e6b3c7d31');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6192, 3170, '4ff26436-7eb1-11ed-8a7b-563e6b3c7d31');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6193, 3170, '70c7041b-7eb3-11ed-b231-1a65000c45b2');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6194, 3170, 'ce79c9a0-7ebd-11ed-acae-6ec23aad2db1');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6195, 3170, '9233b1a6-7ecd-11ed-a1a8-767ed87bdd9a');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6196, 3170, '1b5733f0-7f59-11ed-9cbf-4a21df182334');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6197, 3170, '39b6f89f-7f5a-11ed-9cbf-4a21df182334');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6198, 3170, '0fad32e8-8437-11ed-8d46-7270fbe7c88b');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6199, 3170, 'c4b3b55c-8438-11ed-8d46-7270fbe7c88b');
INSERT INTO `sys_deploy_form` (`id`, `form_id`, `deploy_id`) VALUES (6200, 3170, '2519');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
                            `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
                            `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
                            `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
                            `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
                            `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
                            `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
                            `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
                            `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
                                 `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
                                 `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
                                 `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
                                 `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
                                 `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
                                 `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '性别男');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '性别女');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '通知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '公告');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 0, '请假流程', 'leave', 'sys_process_category', NULL, 'default', 'N', '0', 'admin', '2022-12-12 11:17:56', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, 0, 'OA流程', 'oa', 'sys_process_category', NULL, 'default', 'N', '0', 'admin', '2022-12-12 11:18:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, 0, '正常', '0', 'common_status', NULL, 'success', 'N', '0', 'admin', '2022-12-18 22:01:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, 1, '禁用', '1', 'common_status', NULL, 'danger', 'N', '0', 'admin', '2022-12-18 22:01:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, 0, '任务监听', '1', 'sys_listener_type', NULL, 'default', 'N', '0', 'admin', '2022-12-25 11:47:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, 2, '执行监听', '2', 'sys_listener_type', NULL, 'default', 'N', '0', 'admin', '2022-12-25 11:47:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, 0, 'JAVA类', '1', 'sys_listener_value_type', NULL, 'default', 'N', '0', 'admin', '2022-12-25 11:48:55', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, 0, '表达式', '2', 'sys_listener_value_type', NULL, 'default', 'N', '0', 'admin', '2022-12-25 11:49:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, 0, '代理表达式', '3', 'sys_listener_value_type', NULL, 'default', 'N', '0', 'admin', '2022-12-25 11:49:16', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
                                 `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
                                 `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_id`),
                                 UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '流程分类', 'sys_process_category', '0', 'admin', '2022-12-12 11:17:38', '', NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '通用状态', 'common_status', '0', 'admin', '2022-12-18 22:00:02', '', NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '监听类型', 'sys_listener_type', '0', 'admin', '2022-12-18 22:03:07', '', NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '监听值类型', 'sys_listener_value_type', '0', 'admin', '2022-12-18 22:03:39', '', NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '监听属性', 'sys_listener_event_type', '0', 'admin', '2022-12-18 22:04:29', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_expression
-- ----------------------------
DROP TABLE IF EXISTS `sys_expression`;
CREATE TABLE `sys_expression` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表单主键',
                                  `name` varchar(50) DEFAULT NULL COMMENT '表达式名称',
                                  `expression` varchar(255) DEFAULT NULL COMMENT '表达式内容',
                                  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人员',
                                  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人员',
                                  `status` tinyint(2) DEFAULT '0' COMMENT '状态',
                                  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='流程表达式';

-- ----------------------------
-- Records of sys_expression
-- ----------------------------
BEGIN;
INSERT INTO `sys_expression` (`id`, `name`, `expression`, `create_time`, `update_time`, `create_by`, `update_by`, `status`, `remark`) VALUES (1, '流程发起人', '${INITIATOR}', '2022-12-12 17:29:10', NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_expression` (`id`, `name`, `expression`, `create_time`, `update_time`, `create_by`, `update_by`, `status`, `remark`) VALUES (2, '审批流程指定接收人', '#{approval}', '2022-12-12 17:43:10', NULL, NULL, NULL, 0, NULL);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=3171 DEFAULT CHARSET=utf8mb4 COMMENT='流程表单';

-- ----------------------------
-- Records of sys_form
-- ----------------------------
BEGIN;
INSERT INTO `sys_form` (`form_id`, `form_name`, `form_content`, `create_time`, `update_time`, `create_by`, `update_by`, `remark`) VALUES (3170, '请假表单', '{\"fields\":[{\"__config__\":{\"label\":\"请假标题\",\"labelWidth\":null,\"showLabel\":true,\"changeTag\":true,\"tag\":\"el-input\",\"tagIcon\":\"input\",\"required\":true,\"layout\":\"colFormItem\",\"span\":24,\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"regList\":[],\"formId\":101,\"renderKey\":\"1011650592466703\"},\"__slot__\":{\"prepend\":\"\",\"append\":\"\"},\"placeholder\":\"请输入请假标题\",\"style\":{\"width\":\"100%\"},\"clearable\":true,\"prefix-icon\":\"\",\"suffix-icon\":\"\",\"maxlength\":null,\"show-word-limit\":false,\"readonly\":false,\"disabled\":false,\"__vModel__\":\"field101\"},{\"__config__\":{\"label\":\"请假天数\",\"labelWidth\":null,\"showLabel\":true,\"changeTag\":true,\"tag\":\"el-input\",\"tagIcon\":\"input\",\"required\":true,\"layout\":\"colFormItem\",\"span\":24,\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"regList\":[],\"formId\":101,\"renderKey\":\"1011646362752852\"},\"__slot__\":{\"prepend\":\"\",\"append\":\"\"},\"placeholder\":\"请输入请假天数\",\"style\":{\"width\":\"100%\"},\"clearable\":true,\"prefix-icon\":\"\",\"suffix-icon\":\"\",\"maxlength\":null,\"show-word-limit\":false,\"readonly\":false,\"disabled\":false,\"__vModel__\":\"day\"},{\"__config__\":{\"label\":\"请假备注\",\"labelWidth\":null,\"showLabel\":true,\"tag\":\"el-input\",\"tagIcon\":\"textarea\",\"required\":true,\"layout\":\"colFormItem\",\"span\":24,\"regList\":[],\"changeTag\":true,\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"formId\":102,\"renderKey\":\"1021650592469692\"},\"type\":\"textarea\",\"placeholder\":\"请输入请假备注\",\"autosize\":{\"minRows\":4,\"maxRows\":4},\"style\":{\"width\":\"100%\"},\"maxlength\":null,\"show-word-limit\":false,\"readonly\":false,\"disabled\":false,\"__vModel__\":\"field102\"}],\"formRef\":\"elForm\",\"formModel\":\"formData\",\"size\":\"medium\",\"labelPosition\":\"right\",\"labelWidth\":100,\"formRules\":\"rules\",\"gutter\":15,\"disabled\":false,\"span\":24,\"formBtns\":true}', '2022-12-11 21:02:39', NULL, NULL, NULL, '请假表单');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
                           `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
                           `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
                           `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
                           `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                           `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
                           `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
                           `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
                           `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
                           `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                           `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
                           PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-12-11 16:51:52', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
                               `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
                               `job_name` varchar(64) NOT NULL COMMENT '任务名称',
                               `job_group` varchar(64) NOT NULL COMMENT '任务组名',
                               `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                               `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
                               `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
                               `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
                               `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                               PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_listener
-- ----------------------------
DROP TABLE IF EXISTS `sys_listener`;
CREATE TABLE `sys_listener` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表单主键',
                                `name` varchar(128) DEFAULT NULL COMMENT '名称',
                                `type` char(2) DEFAULT NULL COMMENT '监听类型',
                                `event_type` varchar(32) DEFAULT NULL COMMENT '事件类型',
                                `value_type` char(2) DEFAULT NULL COMMENT '值类型',
                                `value` varchar(255) DEFAULT NULL COMMENT '执行内容',
                                `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                `create_by` bigint(20) DEFAULT NULL COMMENT '创建人员',
                                `update_by` bigint(20) DEFAULT NULL COMMENT '更新人员',
                                `status` tinyint(2) DEFAULT '0' COMMENT '状态',
                                `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='流程监听';

-- ----------------------------
-- Records of sys_listener
-- ----------------------------
BEGIN;
INSERT INTO `sys_listener` (`id`, `name`, `type`, `event_type`, `value_type`, `value`, `create_time`, `update_time`, `create_by`, `update_by`, `status`, `remark`) VALUES (1, '任务监听', '1', 'assignment', '1', 'com.ruoyi.flowable.listener.FlowTaskListener', '2022-12-25 12:31:50', NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_listener` (`id`, `name`, `type`, `event_type`, `value_type`, `value`, `create_time`, `update_time`, `create_by`, `update_by`, `status`, `remark`) VALUES (2, '执行监听', '2', 'start', '1', 'com.ruoyi.flowable.listener.FlowExecutionListener', '2022-12-25 12:41:10', NULL, NULL, NULL, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
                                  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
                                  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
                                  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
                                  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
                                  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
                                  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
                                  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
                                  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
                                  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
                            `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                            `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
                            `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
                            `path` varchar(200) DEFAULT '' COMMENT '路由地址',
                            `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
                            `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
                            `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
                            `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
                            `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
                            `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
                            `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
                            `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
                            `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT '' COMMENT '备注',
                            PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-12-11 16:51:52', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-12-11 16:51:52', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-12-11 16:51:52', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2022-12-11 16:51:52', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-12-11 16:51:52', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-12-11 16:51:52', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-12-11 16:51:52', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-12-11 16:51:52', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-12-11 16:51:52', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-12-11 16:51:52', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-12-11 16:51:52', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-12-11 16:51:52', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-12-11 16:51:52', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-12-11 16:51:52', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-12-11 16:51:52', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-12-11 16:51:52', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-12-11 16:51:52', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-12-11 16:51:52', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-12-11 16:51:52', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-12-11 16:51:52', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-12-11 16:51:52', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-12-11 16:51:52', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-12-11 16:51:52', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-12-11 16:51:52', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2020, '流程管理', 0, 6, 'flowable', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'cascader', 'tony', '2021-03-25 11:35:09', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2022, '流程定义', 2020, 2, 'definition', 'flowable/definition/index', NULL, 1, 0, 'C', '0', '0', '', 'job', 'tony', '2021-03-25 13:53:55', 'admin', '2021-03-29 09:39:07', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2023, '任务管理', 0, 7, 'task', NULL, NULL, 1, 0, 'M', '0', '0', '', 'dict', 'tony', '2021-03-26 10:53:10', 'admin', '2021-03-29 09:37:40', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2024, '待办任务', 2023, 2, 'todo', 'flowable/task/todo/index', NULL, 1, 1, 'C', '0', '0', '', 'cascader', 'admin', '2021-03-26 10:55:52', 'admin', '2021-03-30 09:26:36', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2025, '已办任务', 2023, 3, 'finished', 'flowable/task/finished/index', NULL, 1, 1, 'C', '0', '0', '', 'time-range', 'admin', '2021-03-26 10:57:54', 'admin', '2021-03-30 09:26:50', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2026, '我的流程', 2023, 1, 'process', 'flowable/task/myProcess/index', NULL, 1, 1, 'C', '0', '0', '', 'guide', 'admin', '2021-03-30 09:26:23', 'admin', '2022-12-12 09:58:07', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2027, '表单配置', 2020, 2, 'form', 'flowable/task/form/index', NULL, 1, 0, 'C', '0', '0', 'flowable:form:list', 'form', 'admin', '2021-03-30 22:55:12', 'admin', '2021-04-03 18:50:54', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2028, '新增', 2027, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'flowable:form:add', '#', 'admin', '2021-07-07 14:23:37', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2029, '删除', 2027, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'flowable:form:remove', '#', 'admin', '2021-07-07 14:24:10', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2030, '编辑', 2027, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'flowable:form:edit', '#', 'admin', '2021-07-07 14:24:31', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2031, '新增', 2026, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:deployment:add', '#', 'admin', '2021-07-07 14:25:22', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2032, '编辑', 2026, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:deployment:edit', '#', 'admin', '2021-07-07 14:25:47', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2033, '删除', 2026, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:deployment:remove', '#', 'admin', '2021-07-07 14:26:02', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2034, '查询', 2027, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'flowable:form:query', '#', 'admin', '2021-07-08 14:05:22', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2035, '修改密码', 100, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:user:updatePwd', '#', 'admin', '2022-04-29 11:27:13', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2036, '流程表达式', 2020, 3, 'expression', 'system/expression/index', NULL, 1, 1, 'C', '0', '0', 'system:expression:list', 'list', 'admin', '2022-12-12 17:12:19', 'admin', '2022-12-12 17:13:44', '流程达式菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2037, '流程达式查询', 2036, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:expression:query', '#', 'admin', '2022-12-12 17:12:19', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2038, '流程达式新增', 2036, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:expression:add', '#', 'admin', '2022-12-12 17:12:19', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2039, '流程达式修改', 2036, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:expression:edit', '#', 'admin', '2022-12-12 17:12:19', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2040, '流程达式删除', 2036, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:expression:remove', '#', 'admin', '2022-12-12 17:12:19', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2041, '流程达式导出', 2036, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:expression:export', '#', 'admin', '2022-12-12 17:12:19', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2042, '流程监听', 2020, 1, 'listener', 'system/listener/index', NULL, 1, 0, 'C', '0', '0', 'system:listener:list', '#', 'admin', '2022-12-25 11:44:16', '', NULL, '流程监听菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2043, '流程监听查询', 2042, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:listener:query', '#', 'admin', '2022-12-25 11:44:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2044, '流程监听新增', 2042, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:listener:add', '#', 'admin', '2022-12-25 11:44:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2045, '流程监听修改', 2042, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:listener:edit', '#', 'admin', '2022-12-25 11:44:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2046, '流程监听删除', 2042, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:listener:remove', '#', 'admin', '2022-12-25 11:44:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2047, '流程监听导出', 2042, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:listener:export', '#', 'admin', '2022-12-25 11:44:16', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
                              `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
                              `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
                              `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
                              `notice_content` longblob COMMENT '公告内容',
                              `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-12-11 16:51:52', '', NULL, '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-12-11 16:51:52', '', NULL, '管理员');
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
                                `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                `title` varchar(50) DEFAULT '' COMMENT '模块标题',
                                `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                `method` varchar(100) DEFAULT '' COMMENT '方法名称',
                                `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
                                `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
                                `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
                                `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
                                `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
                                `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
                                `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
                                `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
                                `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
                                `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
                                `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
                                `cost_time` bigint(20) DEFAULT '0' COMMENT '消耗时间',
                                PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
                            `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                            `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
                            `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
                            `post_sort` int(4) NOT NULL COMMENT '显示顺序',
                            `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-12-11 16:51:52', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-12-11 16:51:52', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
                            `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                            `role_name` varchar(30) NOT NULL COMMENT '角色名称',
                            `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
                            `role_sort` int(4) NOT NULL COMMENT '显示顺序',
                            `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
                            `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
                            `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
                            `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-12-11 16:51:52', '', NULL, '超级管理员');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-12-11 16:51:52', 'admin', '2022-12-26 11:30:33', '普通角色');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
                                 PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 100);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 101);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 105);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
                                 PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 4);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2034);
COMMIT;

-- ----------------------------
-- Table structure for sys_task_form
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_form`;
CREATE TABLE `sys_task_form` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                 `form_id` bigint(20) DEFAULT NULL COMMENT '表单主键',
                                 `task_id` varchar(50) DEFAULT NULL COMMENT '所属任务',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程任务关联表单';

-- ----------------------------
-- Records of sys_task_form
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
                            `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                            `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
                            `user_name` varchar(30) NOT NULL COMMENT '用户账号',
                            `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
                            `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
                            `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
                            `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
                            `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
                            `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
                            `password` varchar(100) DEFAULT '' COMMENT '密码',
                            `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
                            `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-12-28 15:47:23', 'admin', '2022-12-11 16:51:52', '', '2022-12-28 15:47:22', '管理员');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 105, 'ry', '李四', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-12-26 11:30:01', 'admin', '2022-12-11 16:51:52', 'admin', '2022-12-26 11:30:01', '测试员');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
                                 PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (1, 1);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (2, 2);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (2, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
