-- @Project: FiveM Tools ft_login
-- @License: GNU General Public License v3.0


/** if you never or don't want to use my resource without ft_gamemode **/

CREATE TABLE IF NOT EXISTS `players` (
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
);


/** just add 2 more columns if you have already install ft_gamemode **/ 

ALTER TABLE `players` ADD `username` varchar(255) DEFAULT NULL;
ALTER TABLE `players` ADD `password` varchar(255) DEFAULT NULL;


/** for insert in table some player **/
/*************************************************** Change Here */
INSERT INTO `players` (`username`, `password`) VALUES ('log', 'pass');