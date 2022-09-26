SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for maindb
-- ----------------------------
DROP TABLE IF EXISTS `maindb`;
CREATE TABLE `maindb` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `rlsname` varchar(256) NOT NULL,
  `grp` text NOT NULL,
  `section` text NOT NULL,
  `ctime` text NOT NULL,
  `files` text,
  `size` text,
  `genre` text,
  `url` text,
  `status` text,
  `m3uname` text,
  `nfoname` text,
  `sfvname` text,
  `nuke_status` text,
  `nuke_ctime` text,
  `nuke_reason` text,
  `nuke_net` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
