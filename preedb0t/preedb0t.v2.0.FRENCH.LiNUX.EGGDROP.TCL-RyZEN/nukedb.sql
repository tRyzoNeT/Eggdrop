SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for nukedb
-- ----------------------------
DROP TABLE IF EXISTS `nukedb`;
CREATE TABLE `nukedb` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `rlsname` varchar(256) NOT NULL,
  `grp` text NOT NULL,
  `status` text NOT NULL,
  `ctime` text NOT NULL,
  `reason` text NOT NULL,
  `nukenet` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
