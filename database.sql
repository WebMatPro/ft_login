/**
 * @Project: FiveM Tools - Login
 * @License: GNU General Public License v3.0
 */


/** if you never or don't want to use my resource without ft_gamemode **/

CREATE TABLE IF NOT EXISTS `player` (
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
);


/** just add 2 more columns if you have already install ft_gamemode **/ 

ALTER TABLE `players` ADD `login` varchar(255) DEFAULT NULL;
ALTER TABLE `players` ADD `password` varchar(255) DEFAULT NULL;


/** for insert in table some player **/
/*************************************************** Change Here */
INSERT INTO `players` (`login`, `password`) VALUES ('log', 'pass');