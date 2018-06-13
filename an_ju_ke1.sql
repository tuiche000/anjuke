/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 80011
Source Host           : localhost:3306
Source Database       : an_ju_ke

Target Server Type    : MYSQL
Target Server Version : 80011
File Encoding         : 65001

Date: 2018-06-13 15:51:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_table
-- ----------------------------
DROP TABLE IF EXISTS `admin_table`;
CREATE TABLE `admin_table` (
  `ID` varchar(32) NOT NULL COMMENT '用户得ID，由UUID负责生成，全局唯一 ',
  `username` varchar(32) NOT NULL COMMENT '用户名，不能重复',
  `password` varchar(32) NOT NULL COMMENT '密码，不能重复',
  `b_house` bit(1) DEFAULT NULL COMMENT '管理房屋权限',
  `b_ad` bit(1) DEFAULT NULL COMMENT '广告权限',
  `b_link` bit(1) DEFAULT NULL COMMENT '友情链接权限',
  `b_broker` bit(1) DEFAULT NULL COMMENT '房产经纪人权限',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_table
-- ----------------------------
INSERT INTO `admin_table` VALUES ('ceb20145f3ac4d8db76f4c1159099612', 'zhangsan', 'c33367701511b4f6020ec61ded352059', '', '\0', '\0', '');

-- ----------------------------
-- Table structure for admin_token_table
-- ----------------------------
DROP TABLE IF EXISTS `admin_token_table`;
CREATE TABLE `admin_token_table` (
  `ID` varchar(32) NOT NULL,
  `admin_ID` varchar(32) NOT NULL,
  `expires` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_token_table
-- ----------------------------
INSERT INTO `admin_token_table` VALUES ('c25f4422ee8d4d63a3b3cf895436ade4', '1', '1523428026');
INSERT INTO `admin_token_table` VALUES ('27ff874546e140b2a61f384a3de7c292', '1', '1523428729');
INSERT INTO `admin_token_table` VALUES ('ffc7c087de6747e09c8cbd5b0ea7a5ac', '1', '1523428855');
INSERT INTO `admin_token_table` VALUES ('c94116533aad47ab900f19ab5ffbe333', '1', '1523428934');
INSERT INTO `admin_token_table` VALUES ('ecf54a9f41b0483f9fe248c15b64fb3c', '1', '1523429012');
INSERT INTO `admin_token_table` VALUES ('38309820d49642bebd8467cf9b2dcef5', '1', '1523429320');
INSERT INTO `admin_token_table` VALUES ('cd676bfa234742a5a28a5b2a937b0709', '1', '1523429340');
INSERT INTO `admin_token_table` VALUES ('8095ba80dabc4d96ba63086fac9074af', '1', '1523429429');
INSERT INTO `admin_token_table` VALUES ('52204dcf432c46a285524c8915fed555', '1', '1523430325');
INSERT INTO `admin_token_table` VALUES ('4b2b63aadfd14ca8a7194d3c15915ff7', '1', '1523936198');
INSERT INTO `admin_token_table` VALUES ('5e3ea28ebb5b43dca9bc3a5d627d2f22', '1', '1524455501');
INSERT INTO `admin_token_table` VALUES ('399310fa6b8c427e8c80238a3973ae7b', '1', '1524456027');
INSERT INTO `admin_token_table` VALUES ('00da5c277ec84585a866d49d146a5f9f', '1', '1524714682');
INSERT INTO `admin_token_table` VALUES ('7b52652c78cc4c2fb5f03e42636b525a', '1', '1526544488');
INSERT INTO `admin_token_table` VALUES ('2a29bd28891d4cf284b3835aa10ed2ff', '1', '1526545674');
INSERT INTO `admin_token_table` VALUES ('82f64d0254214711a081f73e21055dc8', '1', '1526545863');
INSERT INTO `admin_token_table` VALUES ('96c0b52dac4e41afb8249fa8329e172b', '1', '1526895931');
INSERT INTO `admin_token_table` VALUES ('4ad94a1101cb4f09bfa15b5134cb90c9', '1', '1527589920');
INSERT INTO `admin_token_table` VALUES ('b9c73509a6944d1eb92a0a8267df6c5d', '1', '1527648193');
INSERT INTO `admin_token_table` VALUES ('934e523679754a758532596f947742f4', '1', '1527648213');
INSERT INTO `admin_token_table` VALUES ('e9a92923a7774deab795e374baeae5ec', '1', '1527649431');
INSERT INTO `admin_token_table` VALUES ('6f8aa92aeae44e3681ba3cde555e55ec', '1', '1528085339');
INSERT INTO `admin_token_table` VALUES ('19651340489143b78d82bf3c9432124a', '1', '1528281915');
INSERT INTO `admin_token_table` VALUES ('b3b77bcae75e41dea050962e5ff7c9fd', '1', '1528798781');
INSERT INTO `admin_token_table` VALUES ('2bc2172cbf9d4cb9b8f7743f9e33a349', '1', '1528856732');

-- ----------------------------
-- Table structure for ad_table
-- ----------------------------
DROP TABLE IF EXISTS `ad_table`;
CREATE TABLE `ad_table` (
  `ID` varchar(32) NOT NULL,
  `admin_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '哪个管理员发布的广告',
  `create_time` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '广告类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '广告标题',
  `link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '广告链接',
  `img_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '广告图片地址',
  `img_real_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '广告图片磁盘地址',
  `expires` int(11) DEFAULT NULL COMMENT '过期时间',
  `n_order` int(11) DEFAULT NULL COMMENT '序号',
  `n_show` int(11) DEFAULT '0' COMMENT '展现次数',
  `n_click` int(11) DEFAULT '0' COMMENT '点击次数',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ad_table
-- ----------------------------
INSERT INTO `ad_table` VALUES ('9db4c3eec88e425b9be48051c2d9f94d', '1', null, '1', 'xxx房屋', 'http://www.baidu.com', null, null, '1531449079', '1', '0', '0');

-- ----------------------------
-- Table structure for broker_table
-- ----------------------------
DROP TABLE IF EXISTS `broker_table`;
CREATE TABLE `broker_table` (
  `ID` varchar(32) NOT NULL,
  `admin_ID` varchar(32) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `title` varchar(16) DEFAULT NULL,
  `img_path` varchar(255) DEFAULT NULL,
  `img_real_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of broker_table
-- ----------------------------
INSERT INTO `broker_table` VALUES ('a53b3534d18a445eb92ee7c2d39b5c5d', null, null, '张三', null, null);
INSERT INTO `broker_table` VALUES ('7e1f3537a76c46d2b4e0fd26f16af72f', '1', '1528875543', '李四', '', '');

-- ----------------------------
-- Table structure for house_table
-- ----------------------------
DROP TABLE IF EXISTS `house_table`;
CREATE TABLE `house_table` (
  `ID` varchar(32) NOT NULL,
  `admin_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '哪个管理员创建的房屋信息',
  `create_time` int(11) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `sub_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '副标题',
  `postion_main` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '主要位置',
  `postion_secound` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '具体位置',
  `ave_price` int(11) DEFAULT NULL COMMENT '均价',
  `area_min` smallint(6) DEFAULT NULL COMMENT '最小面积',
  `area_max` smallint(6) DEFAULT NULL,
  `tel` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `sale_time` int(11) DEFAULT NULL COMMENT '开售时间',
  `submit_time` int(11) DEFAULT NULL COMMENT '交房时间',
  `building_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '建筑类型',
  `main_img_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '主要图片地址',
  `main_img_real_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '服务器磁盘图片地址',
  `img_paths` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '轮播图地址',
  `img_real_paths` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '服务器磁盘轮播图地址',
  `property_types` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '房屋类型',
  `property_img_paths` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '户型图',
  `property_img_real_paths` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '户型图真实磁盘地址',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of house_table
-- ----------------------------
INSERT INTO `house_table` VALUES ('0b8ed2732dd041119c58fce340f7e8c6', 'ceb20145f3ac4d8db76f4c1159099612', null, '新华联奥莱悦府', '04.22看房团火热报名中', '青浦 赵巷', '佳杰路88弄', '48000', '83', '145', '400 016 1359', '1528156800', '1529020800', '叠加别墅、高层', '/static_img/06c933908dbb4c34bfc086e9bcefdccd.jpg', 'E:\\anjuke\\upload\\06c933908dbb4c34bfc086e9bcefdccd.jpg', '/static_img/4e90ea416c7442e489bad4b83df3e352.jpg,/static_img/a5519103103a42b592adbccd0d324d7c.jpg,/static_img/607ead3b9b624374833796368801887b.jpg,/static_img/093589a62fa14ab092cd2d09dc7b51e7.jpg', 'E:\\anjuke\\upload/4e90ea416c7442e489bad4b83df3e352.jpg,E:\\anjuke\\upload/a5519103103a42b592adbccd0d324d7c.jpg,E:\\anjuke\\upload/607ead3b9b624374833796368801887b.jpg,E:\\anjuke\\upload/093589a62fa14ab092cd2d09dc7b51e7.jpg', 'F户型 3室2厅2卫,E户型 4室2厅3卫', '/static_img/3cf9b7918c514e56a4db00921743d76e.jpg,/static_img/316ab6cbc4a54a0db348cd0c096bd3c0.jpg', 'E:\\anjuke\\upload/3cf9b7918c514e56a4db00921743d76e.jpg,E:\\anjuke\\upload/316ab6cbc4a54a0db348cd0c096bd3c0.jpg');
INSERT INTO `house_table` VALUES ('25b61565ba5542598e6358abe68e3d6e', '1', null, '123', '123213123', '', '', '12321', '0', '0', '123213', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('02509d6ffa724844bed76472c7c939eb', '1', null, '10', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('e782cb3fc0464139bc09c1dcacb4a6f6', '1', null, '9', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('ff24eb048f1349509c9e2f48d3354585', '1', null, '11111', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('d58081dd955047c0a91642af5fae357d', '1', null, '2', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('c72311d60ae34da8bb223325d72874cf', '1', null, '3', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('de92058ad1cf46e7bd453f76f2199298', '1', null, '4', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('de3675a0a5f34899a53c8c4bcfd31e18', '1', null, '5', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('dfc488f69f854303a7e2cc26d5b0783f', '1', null, '6', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('dba90948483e4a62b1c55a1be7955fc5', '1', null, '7', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('555f4e0b4a5745e3abdd56fae0b43933', '1', null, '8', '', '', '', '0', '0', '0', '', '0', '0', '', '', '', '', '', '', '', '');
INSERT INTO `house_table` VALUES ('0ce9ddbf3923464aad6ab1fe3d51a194', '1', null, '回龙观', '123', '321', '123', '321', '123', '321', '111', '1529107200', '1529193600', '1', '1d6078521c93d40eec8bb154caab53e0', 'upload\\1d6078521c93d40eec8bb154caab53e0', '83e84bb433e0131ac1fb5f38136fa56e,407e597f349ffdd8ae64ac2d0a81f347,e33db2330d39070014dc66b421d29554,7940e64bbfd738295730052803c0799d', 'upload\\83e84bb433e0131ac1fb5f38136fa56e,upload\\407e597f349ffdd8ae64ac2d0a81f347,upload\\e33db2330d39070014dc66b421d29554,upload\\7940e64bbfd738295730052803c0799d', '123', '755054b2606900495acefc3548f26615', 'upload\\755054b2606900495acefc3548f26615');
INSERT INTO `house_table` VALUES ('52e1a9da6a3a4cf89b17d539674f1f9d', '1', '1528872243', '桃浦新村', '2', '1', '1', '23', '1', '1', '111', '1529712000', '1529539200', '1', 'undefined', 'undefined', 'undefined', 'undefined', '123', 'undefined', 'undefined');

-- ----------------------------
-- Table structure for link_table
-- ----------------------------
DROP TABLE IF EXISTS `link_table`;
CREATE TABLE `link_table` (
  `ID` varchar(32) NOT NULL,
  `admin_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '友情链接类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `n_order` int(11) DEFAULT NULL COMMENT '顺序',
  `expires` int(11) DEFAULT NULL COMMENT '到期时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of link_table
-- ----------------------------
INSERT INTO `link_table` VALUES ('01a977932ba94c22b12714b69abd6efb', '1', null, '1', '新浪乐居-1', 'http://sh.leju.com/', '1', '1531449079');
