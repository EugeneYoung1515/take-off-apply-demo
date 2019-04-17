DROP TABLE IF EXISTS `t_take_off`;
CREATE TABLE `t_take_off` (
  `off_id` int(11) NOT NULL AUTO_INCREMENT,
  `off_type` int(11) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `off_reason` varchar(1600) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `first_check_user_id` int(11) DEFAULT NULL,
  `first_check_user_opinion` varchar(800) DEFAULT NULL,
  `second_check_user_id` int(11) DEFAULT NULL,
  `second_check_user_opinion` varchar(800) DEFAULT NULL,
  `third_check_user_id` int(11) DEFAULT NULL,
  `third_check_user_opinion` varchar(800) DEFAULT NULL,
  `first_check_datetime` datetime DEFAULT NULL,
  `second_check_datetime` datetime DEFAULT NULL,
  `third_check_datetime` datetime DEFAULT NULL,
  `apply_datetime` datetime DEFAULT NULL,
  `off_status` int(11) DEFAULT NULL,
  `is_accepted_by_first` int(11) DEFAULT NULL,
  `is_accepted_by_second` int(11) DEFAULT NULL,
  `is_accepted_by_third` int(11) DEFAULT NULL,
  PRIMARY KEY (`off_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

INSERT INTO `t_take_off` VALUES (76,1,'2019-04-18 00:00:00','2019-04-19 00:00:00','test\r\ntest',1,4,'test',5,'test',6,'test','2019-04-17 02:33:12','2019-04-17 02:34:25','2019-04-17 02:34:55','2019-04-17 02:32:43',3,1,1,1),(77,1,'2019-04-18 00:00:00','2019-04-19 00:00:00','test',2,4,'不同意',NULL,NULL,NULL,NULL,'2019-04-17 02:36:25',NULL,NULL,'2019-04-17 02:36:02',4,0,NULL,NULL),(78,3,'2019-04-18 00:00:00','2019-04-19 00:00:00','测试',3,4,'同意',NULL,NULL,NULL,NULL,'2019-04-17 02:38:35',NULL,NULL,'2019-04-17 02:38:10',1,1,NULL,NULL),(79,2,'2019-04-18 14:00:00','2019-04-19 08:00:00','陪老婆去喝喜酒\r\n希望同意',7,4,'同意\r\n不要喝太多 影响第二天工作',5,'今天晚上先加班吧',6,'先同意最新申请的','2019-04-17 09:50:12','2019-04-17 09:51:36','2019-04-17 09:53:41','2019-04-17 09:49:23',3,1,1,1);


DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `user_type` int(11) DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

INSERT INTO `t_user` VALUES (1,'user1','user1',0),(2,'user2','user2',0),(3,'user3','user3',0),(4,'user4','user4',1),(5,'user5','user5',2),(6,'user6','user6',3),(7,'user7','user7',0);