/*
Navicat MySQL Data Transfer

Source Server         : Test
Source Server Version : 50171
Source Host           : localhost:3306
Source Database       : book

Target Server Type    : MYSQL
Target Server Version : 50171
File Encoding         : 65001

Date: 2018-04-16 10:57:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `admin_username` varchar(255) NOT NULL,
  `admin_password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bookname` varchar(255) NOT NULL,
  `type_id` int(11) NOT NULL,
  `book_author` varchar(255) NOT NULL,
  `book_introduction` varchar(2000) DEFAULT NULL,
  `book_publisher` varchar(255) DEFAULT NULL,
  `book_image` varchar(500) DEFAULT NULL,
  `book_price` decimal(10,2) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0: 默认状态  1: 删除状态   2: 下架状态',
  `create_time` datetime NOT NULL,
  `last_update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `last_update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cart_book
-- ----------------------------
DROP TABLE IF EXISTS `cart_book`;
CREATE TABLE `cart_book` (
  `book_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for count
-- ----------------------------
DROP TABLE IF EXISTS `count`;
CREATE TABLE `count` (
  `book_id` int(11) NOT NULL,
  `purchasecount` int(11) NOT NULL,
  `accesscount` int(11) NOT NULL,
  `replycount` int(11) NOT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0:  待支付   1: 已支付   2: 已发货',
  `submit_time` datetime NOT NULL,
  `pay_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_book
-- ----------------------------
DROP TABLE IF EXISTS `order_book`;
CREATE TABLE `order_book` (
  `book_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `replycontents` varchar(5000) NOT NULL,
  `replytime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `brief_introduction` varchar(2000) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `last_update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
DROP TRIGGER IF EXISTS `insert_to_count`;
DELIMITER ;;
CREATE TRIGGER `insert_to_count` AFTER INSERT ON `book` FOR EACH ROW BEGIN
            insert into count values(new.id,0,0,0);
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `insert`;
DELIMITER ;;
CREATE TRIGGER `insert` AFTER INSERT ON `reply` FOR EACH ROW BEGIN
           update count set replycount=replycount+1 where book_id=new.book_id;
END
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
