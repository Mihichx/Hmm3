-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 19 2026 г., 23:22
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `hmm`
--

-- --------------------------------------------------------

--
-- Структура таблицы `biomes`
--

CREATE TABLE `biomes` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `biomes`
--

INSERT INTO `biomes` (`id`, `name`, `description`) VALUES
(1, 'магические равнины', 'Приводит к тому, что все заклинания произносятся на экспертном уровне, независимо от навыков героев. Сюда входят как приключенческие, так и боевые заклинания, а также заклинания, накладываемые существами, и некоторые магические способности существ.'),
(2, 'проклятые земли', 'Запрещает герою произносить заклинания выше 1-го уровня, включая приключенческие и боевые заклинания.\r\nТакже не позволяет существам произносить какие-либо заклинания.\r\nОтключает все бонусы на местности.\r\nСводит на нет все положительные эффекты боевого духа.\r\nСводит на нет все положительные эффекты удачи.\r\n\r\nВ \"Восстановлении Эрафии\" заклинания 1-го уровня также были запрещены на проклятой земле. \"Восстановление Эрафии\"\r\n\r\nВ \"Роге Бездны\", где была реализована функция \"отрицательная удача\", она также отменяет все эффекты \"отрицательной удачи\".'),
(3, 'каменистая местность', 'Приводит к тому, что все заклинания Магии Земли применяются на экспертном уровне, независимо от навыков героев. Это включает в себя как приключенческие, так и боевые заклинания, а также заклинания Рога Бездны, применяемые существами.'),
(4, 'огненные поля', 'Приводит к тому, что все заклинания магии огня применяются на экспертном уровне, независимо от навыков героев. Это включает в себя как приключенческие, так и боевые заклинания, а также заклинания Рога Бездны, применяемые существами.'),
(5, 'прозрачные омуты', 'Приводит к тому, что все заклинания магии воды будут произноситься на уровне эксперта, независимо от навыков героев. Это включает в себя как приключенческие, так и боевые заклинания, а также заклинания Рога Бездны, которые накладывают существа.'),
(6, 'волшебные облака', 'Приводит к тому, что все заклинания магии воздуха произносятся на экспертном уровне, независимо от навыков героев. Это включает в себя как приключенческие, так и боевые заклинания, а также заклинания \"Рога бездны\", накладываемые существами.Песчаные черви и Олгой-Хорхой вместо того, чтобы прятаться, передвигаются по Волшебным облакам. '),
(7, 'святые земли', 'Gives all good-aligned creatures +1 Morale, and all Evil-aligned creatures -1 Morale.'),
(8, 'злые туманы', 'Gives all evil-aligned creatures +1 Morale, and all Good-aligned creatures -1 Morale.'),
(9, 'клеверные поля', 'Gives all neutrally aligned creatures +2 Luck. Neutral creatures are not affected.'),
(10, 'благоприятные ветра', 'Reducing amount of consumed movement points by 1/3 (rounded up) for boats.\r\nUnlike other magical terrains, Favorable Winds do not affect combat in any way.\r\nIn Horn of the Abyss, Favorable Winds cannot be placed under another magical terrain, so they cancel effect of any magical terrain at the same tile.'),
(11, 'расколотые льды', 'Снижает защиту всех войск на 5.'),
(12, 'дюны', 'На поле боя присутствует от 15 до 20 невидимых пятен зыбучих песков. Они не могут быть удалены с помощью массового рассеивания и не видны для обитателей любой местности.\r\nПосле попадания в гексагон с пятном зыбучих песков отряд останавливается, и это пятно становится видимым для обоих игроков.'),
(13, 'поля славы', 'Дает всем войскам -2 к удаче.');

-- --------------------------------------------------------

--
-- Структура таблицы `building`
--

CREATE TABLE `building` (
  `id` int NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cost(gold)` int NOT NULL,
  `cost(wood)` int NOT NULL,
  `cost(rock)` int NOT NULL,
  `cost(mercury)` int NOT NULL,
  `cost(sulfur)` int NOT NULL,
  `cost(crystals)` int NOT NULL,
  `cost(gems)` int NOT NULL,
  `Requirements1` int DEFAULT NULL,
  `Requirements2` int DEFAULT NULL,
  `Requirements3` int DEFAULT NULL,
  `Requirements4` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `towns_id` int NOT NULL,
  `image` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `building`
--

INSERT INTO `building` (`id`, `name`, `cost(gold)`, `cost(wood)`, `cost(rock)`, `cost(mercury)`, `cost(sulfur)`, `cost(crystals)`, `cost(gems)`, `Requirements1`, `Requirements2`, `Requirements3`, `Requirements4`, `description`, `towns_id`, `image`) VALUES
(1, 'Tavern', 500, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Hero recruitment, +1 to garrison morale', 1, ''),
(2, 'Village Hall', 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Available in every city, yields 500 gold daily.\r\n\r\n', 1, ''),
(3, 'Town Hall', 2500, 0, 0, 0, 0, 0, 0, 1, 2, NULL, NULL, 'Yields 1000 gold daily.\r\n\r\n', 1, ''),
(4, 'City Hall', 5000, 0, 0, 0, 0, 0, 0, 3, 9, 11, 12, 'Yields 2000 gold daily.\r\n\r\n', 1, ''),
(5, 'Capitol', 10000, 0, 0, 0, 0, 0, 0, 4, 8, NULL, NULL, 'Yields 4000 gold daily.\r\n\r\n', 1, ''),
(6, 'Fort', 5000, 20, 20, 0, 0, 0, 0, 2, NULL, NULL, NULL, 'Protects the city with fortress walls.', 1, ''),
(7, 'Citadel', 2500, 0, 5, 0, 0, 0, 0, 6, NULL, NULL, NULL, '+50% weekly unit growth, adds watchtower and moat for defense.', 1, ''),
(8, 'Castle', 5000, 10, 10, 0, 0, 0, 0, 7, NULL, NULL, NULL, '+2 towers, increase city defense, unit growth doubled.', 1, ''),
(9, 'Marketplace', 500, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Trade with market bonus. Share with allies.', 1, ''),
(10, 'Resource silo', 5000, 0, 5, 0, 0, 0, 0, 9, NULL, NULL, NULL, 'Provides 1 wood and 1 ore daily.\r\n\r\n', 1, ''),
(11, 'Blacksmith', 1000, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Guest heroes can buy ballistae.', 1, ''),
(12, 'Mage guild level 1', 2000, 5, 5, 0, 0, 0, 0, 2, NULL, NULL, NULL, 'Guest heroes learn 5 random level 1 spells', 1, ''),
(13, 'Mage guild level 2', 1000, 5, 5, 4, 4, 4, 4, 12, NULL, NULL, NULL, 'Guest heroes learn 4 random level 2 spells.\r\n\r\n', 1, ''),
(14, 'Mage guild level 3', 1000, 5, 5, 6, 6, 6, 6, 13, NULL, NULL, NULL, 'Guest heroes learn 3 random level 3 spells', 1, ''),
(15, 'Mage guild level 4', 1000, 5, 5, 8, 8, 8, 8, 14, NULL, NULL, NULL, 'Guest heroes learn 2 random level 4 spells.', 1, ''),
(16, 'Brotherhood of the Sword', 500, 5, 0, 0, 0, 0, 0, 1, NULL, NULL, NULL, '+1 to combat morale of defending troops.', 1, ''),
(17, 'Stables', 2000, 10, 0, 0, 0, 0, 0, 27, NULL, NULL, NULL, 'Fresh horses — extra movement for heroes.', 1, ''),
(18, 'Shipyard', 2000, 20, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Allows you to build ships.\r\n\r\n', 1, ''),
(19, 'Lighthouse', 2000, 0, 10, 0, 0, 0, 0, 18, NULL, NULL, NULL, 'City lighthouse — extra sea movement for all heroes.', 1, ''),
(20, 'Guardhouse', 500, 0, 10, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Allows you to hire spearmen.', 1, ''),
(21, 'Upg. guardhouse', 1000, 0, 5, 0, 0, 0, 0, 20, NULL, NULL, NULL, 'Allows you to hire halberdiers.', 1, ''),
(22, 'Archers tower', 1000, 5, 5, 0, 0, 0, 0, 20, NULL, NULL, NULL, 'Allows you to hire archers.', 1, ''),
(23, 'Upg. archers tower', 1000, 5, 5, 0, 0, 0, 0, 22, NULL, NULL, NULL, 'Allows you to hire shooters.', 1, ''),
(24, 'Griffin tower', 1000, 0, 5, 0, 0, 0, 0, 22, NULL, NULL, NULL, 'Allows you to hire griffins.', 1, ''),
(25, 'Upg. griffin tower', 1000, 0, 5, 0, 0, 0, 0, 24, NULL, NULL, NULL, 'Allows you to hire royal griffins.', 1, ''),
(26, 'Griffin bastion', 1000, 0, 0, 0, 0, 0, 0, 24, NULL, NULL, NULL, 'Increases the weekly gain of griffins by 3 units.', 1, ''),
(27, 'Barracks', 2000, 0, 5, 0, 0, 0, 0, 24, NULL, NULL, NULL, 'Allows you to hire knights.', 1, ''),
(28, 'Upg. barracks', 2000, 0, 5, 0, 5, 0, 0, 27, NULL, NULL, NULL, 'Allows you to hire crusaders.', 1, ''),
(29, 'Monastery', 3000, 5, 5, 2, 2, 2, 2, 12, 27, NULL, NULL, 'Allows you to hire monks.', 1, ''),
(30, 'Upg. monastery', 1000, 2, 2, 2, 2, 2, 2, 29, NULL, NULL, NULL, 'Allows you to hire fanatics.', 1, ''),
(31, 'Training grounds', 5000, 20, 0, 0, 0, 0, 0, 27, 17, NULL, NULL, 'Allows you to hire cavalrymen.', 1, ''),
(32, 'Portal of Glory', 20000, 0, 0, 10, 10, 10, 10, 29, 31, NULL, NULL, 'Allows you to hire angels .', 1, ''),
(33, 'Upg. training grounds', 3000, 10, 0, 0, 0, 0, 0, 31, NULL, NULL, NULL, 'The Training Grounds allows you to recruit Champions.', 1, ''),
(34, 'Upg. portal of Glory', 20000, 0, 0, 10, 10, 10, 10, 32, NULL, NULL, NULL, 'The Portal of Glory allows you to recruit Archangels.', 1, ''),
(35, 'Village hall', 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, '500 gold per day.', 2, ''),
(36, 'Town hall', 2500, 0, 0, 0, 0, 0, 0, 37, NULL, NULL, NULL, '1000 gold per day.', 2, ''),
(37, 'Tavern', 500, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'The Tavern increases morale for troops defending the city.', 2, ''),
(38, 'Fort', 5000, 20, 20, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'The Fort provides your town with defensive walls.', 2, ''),
(39, 'City hall', 5000, 0, 0, 0, 0, 0, 0, 36, 44, 43, 45, 'The City Hall allows you to purchase town structures and earns your kingdom 2000 gold per day.', 2, ''),
(40, 'Capitol', 10000, 0, 0, 0, 0, 0, 0, 39, NULL, NULL, NULL, 'The Capitol earns your kingdom 4000 gold per day.', 2, ''),
(41, 'Citadel', 2500, 0, 5, 0, 0, 0, 0, 38, NULL, NULL, NULL, 'Including a 50% increase to base creature growth, the Citadel adds a keep, and other terrain obstacles, to a town\'s defenses.', 2, ''),
(42, 'Castle', 5000, 10, 10, 0, 0, 0, 0, 41, NULL, NULL, NULL, 'The Castle adds two arrow towers, fortifies your kingdom\'s defenses, and doubles base creature growth.', 2, ''),
(43, 'Marketplace', 500, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'With the Marketplace, you can buy and sell resources (exchange rates increase with each Marketplace you own).', 2, ''),
(44, 'Blacksmith', 1000, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'The Blacksmith provides your armies with First Aid Tents.', 2, ''),
(45, 'Mage guild level 1', 2000, 5, 5, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 2, ''),
(46, 'Mage guild level 2', 1000, 5, 5, 4, 4, 4, 4, 45, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 2, ''),
(47, 'Mage guild level 3', 1000, 5, 5, 6, 6, 6, 6, 46, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 2, ''),
(48, 'Mage guild level 4', 1000, 5, 5, 8, 8, 8, 8, 47, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 2, ''),
(49, 'Mage guild level 5', 1000, 5, 5, 10, 10, 10, 10, 48, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 2, ''),
(50, 'Centaur stables', 500, 10, 0, 0, 0, 0, 0, 38, NULL, NULL, NULL, 'The Centaur Stables allows you to recruit Centaurs.', 2, ''),
(51, 'Dwarf cottage', 1000, 5, 0, 0, 0, 0, 0, 50, NULL, NULL, NULL, 'The dwarf cottage allows you to recruit Dwarves.', 2, ''),
(52, 'Homestead', 1500, 10, 0, 0, 0, 0, 0, 50, NULL, NULL, NULL, 'The Homestead allows you to recruit Wood Elves.', 2, ''),
(53, 'Enchanted spring', 2000, 0, 0, 0, 0, 10, 0, 52, NULL, NULL, NULL, 'The Enchanted Spring allows you to recruit Pegasi.', 2, ''),
(54, 'Dendroid arches', 2500, 0, 0, 0, 0, 0, 0, 52, NULL, NULL, NULL, 'The Dendroid Arches allows you to recruit Dendroid Guards.', 2, ''),
(55, 'Unicorn glade', 4000, 10, 10, 0, 0, 0, 10, 54, 53, NULL, NULL, 'The Unicorn Glade allows you to recruit Unicorns.', 2, ''),
(56, 'Dragon cliffs', 10000, 0, 30, 0, 0, 20, 0, 46, 55, NULL, NULL, 'The Dragon Cliffs allows you to recruit Green Dragons.', 2, ''),
(57, 'Upg. centaur stables', 1000, 5, 0, 0, 0, 0, 0, 50, NULL, NULL, NULL, 'The Centaur Stables allows you to recruit Centaur Captains.', 2, ''),
(58, 'Upg. dwarf cottage', 1500, 5, 0, 0, 0, 0, 0, 51, NULL, NULL, NULL, 'The Dwarf Cottage allows you to recruit Battle Dwarves.', 2, ''),
(59, 'Upg. homestead', 1000, 10, 0, 0, 0, 0, 0, 52, NULL, NULL, NULL, 'The Homestead allows you to recruit Grand Elves.', 2, ''),
(60, 'Upg. enchanted spring', 2000, 0, 0, 0, 0, 5, 0, 53, NULL, NULL, NULL, 'The Enchanted Spring allows you to recruit Silver Pegasi.', 2, ''),
(61, 'Upg. dendroid arches', 1500, 0, 0, 0, 0, 0, 0, 54, NULL, NULL, NULL, 'The Dendroid Arches allows you to recruit Dendroid Soliders.', 2, ''),
(62, 'Upg. unicorn glade', 3000, 0, 0, 0, 0, 0, 5, 55, NULL, NULL, NULL, 'The Unicorn Glade allows you to recruit War Unicorns.', 2, ''),
(63, 'Upg. dragon cliffs', 20000, 0, 30, 0, 0, 20, 0, 56, NULL, NULL, NULL, 'The Dragon Cliffs allows you to recruit Gold Dragons.', 2, ''),
(64, 'Resource silo', 5000, 0, 5, 0, 0, 0, 0, 43, NULL, NULL, NULL, 'The Resource Silo provides you with additional +1 crystal each day.', 2, ''),
(65, 'Mystic pond', 2000, 5, 5, 2, 2, 2, 2, NULL, NULL, NULL, NULL, 'The Mystic Pond produces a small random number of resources each week.', 2, ''),
(66, 'Miners\' guild', 1000, 0, 0, 0, 0, 0, 0, 51, NULL, NULL, NULL, 'The Miners\' Guild increases Dwarf production by 4 per week.', 2, ''),
(67, 'Treasury', 5000, 5, 10, 0, 0, 0, 0, 66, NULL, NULL, NULL, 'The Treasury earns you 10% interest on any gold you have at the start of each week.', 2, ''),
(68, 'Dendroid saplings', 2000, 0, 0, 0, 0, 0, 0, 54, NULL, NULL, NULL, 'The Dendroid Saplings increases Dendroid Guard production by 2 per week.', 2, ''),
(69, 'Fountain of Fortune', 1500, 0, 0, 0, 0, 10, 0, 65, NULL, NULL, NULL, 'The Fountain of Fortune increases the luck of the garrison hero by +2 when defending against a siege', 2, ''),
(70, 'Village hall', 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, '500 gold per day.', 3, ''),
(71, 'Town hall', 2500, 0, 0, 0, 0, 0, 0, 37, NULL, NULL, NULL, '1000 gold per day.', 3, ''),
(72, 'Tavern', 500, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'The Tavern increases morale for troops defending the city.', 3, ''),
(73, 'Fort', 5000, 20, 20, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'The Fort provides your town with defensive walls.', 3, ''),
(74, 'City hall', 5000, 0, 0, 0, 0, 0, 0, 36, 44, 43, 45, 'The City Hall allows you to purchase town structures and earns your kingdom 2000 gold per day.', 3, ''),
(75, 'Capitol', 10000, 0, 0, 0, 0, 0, 0, 39, NULL, NULL, NULL, 'The Capitol earns your kingdom 4000 gold per day.', 3, ''),
(76, 'Citadel', 2500, 0, 5, 0, 0, 0, 0, 38, NULL, NULL, NULL, 'Including a 50% increase to base creature growth, the Citadel adds a keep, and other terrain obstacles, to a town\'s defenses.', 3, ''),
(77, 'Castle', 5000, 10, 10, 0, 0, 0, 0, 41, NULL, NULL, NULL, 'The Castle adds two arrow towers, fortifies your kingdom\'s defenses, and doubles base creature growth.', 3, ''),
(78, 'Marketplace', 500, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'With the Marketplace, you can buy and sell resources (exchange rates increase with each Marketplace you own).', 3, ''),
(79, 'Blacksmith', 1000, 5, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'The Blacksmith provides your armies with First Aid Tents.', 3, ''),
(80, 'Mage guild level 1', 2000, 5, 5, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 3, ''),
(81, 'Mage guild level 2', 1000, 5, 5, 4, 4, 4, 4, 45, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 3, ''),
(82, 'Mage guild level 3', 1000, 5, 5, 6, 6, 6, 6, 46, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 3, ''),
(83, 'Mage guild level 4', 1000, 5, 5, 8, 8, 8, 8, 47, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 3, ''),
(84, 'Mage guild level 5', 1000, 5, 5, 10, 10, 10, 10, 48, NULL, NULL, NULL, 'Entering the Mage Guild will allow a visiting hero to learn the spells kept within.', 3, ''),
(85, 'Resource silo', 5000, 0, 5, 0, 0, 0, 0, 9, NULL, NULL, NULL, 'Provides 1 wood and 1 ore daily.\r\n\r\n', 3, ''),
(86, 'Lookout tower', 1000, 5, 0, 0, 0, 0, 0, 73, NULL, NULL, NULL, 'The lookout tower extends the visible distance around your city.', 3, ''),
(87, 'Artifact merchants	', 10000, 0, 0, 0, 0, 0, 0, 78, NULL, NULL, NULL, 'For a nominal fee, you can purchase artifacts from the Artifact Merchants.', 3, ''),
(88, 'Sculptor\'s wings', 1000, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'The Sculptor\'s Wings increase Stone Gargoyle production by 4 per week.', 3, ''),
(89, 'Library', 1500, 5, 5, 5, 5, 5, 5, 80, NULL, NULL, NULL, 'The library provides your mage guild with additional spells.', 3, ''),
(90, 'Wall of Knowledge', 0, 0, 5, 0, 0, 0, 0, 80, NULL, NULL, NULL, 'The Wall of Knowledge increases the Knowledge skill of any visiting hero by +1.', 3, ''),
(93, 'Workshop', 300, 5, 5, 0, 0, 0, 0, 73, NULL, NULL, NULL, 'The Workshop allows you to recruit Gremlins.', 3, ''),
(94, 'Parapet', 1000, 0, 10, 0, 0, 0, 0, 93, NULL, NULL, NULL, 'The Parapet allows you to recruit Stone Gargoyles.', 3, ''),
(95, 'Golem factory', 2000, 5, 5, 0, 0, 0, 0, 93, NULL, NULL, NULL, 'The Golem Factory allows you to recruit Stone Golems.', 3, ''),
(96, 'Mage tower', 2000, 5, 5, 5, 5, 5, 5, 80, 94, 95, NULL, 'The Mage Tower allows you to recruit Mages.', 3, ''),
(97, 'Altar of Wishes', 3000, 0, 10, 0, 0, 0, 10, 96, NULL, NULL, NULL, 'The Altar of Wishes allows you to recruit Genies.', 3, ''),
(98, 'Golden pavilion', 4000, 5, 5, 2, 2, 2, 2, 96, NULL, NULL, NULL, 'The Golden Pavilion allows you to recruit Nagas.', 3, ''),
(99, 'Cloud temple', 10, 10, 0, 0, 0, 0, 10, 97, 98, NULL, NULL, 'The Cloud Temple allows you to recruit Giants.', 3, ''),
(100, 'Upg. Workshop', 1000, 0, 0, 0, 0, 0, 0, 93, NULL, NULL, NULL, 'The Workshop allows you to recruit Master gremlins.', 3, ''),
(101, 'Upg. Parapet', 0, 10, 0, 0, 0, 0, 0, 94, NULL, NULL, NULL, 'The Parapet allows you to recruit Obsidian Gargoyles.', 3, ''),
(102, 'Upg. Golem Factory', 5, 5, 0, 5, 0, 0, 0, 95, NULL, NULL, NULL, 'The Golem Factory allows you to recruit Iron Golems.', 3, ''),
(103, 'Upg. Mage Tower', 2000, 5, 0, 0, 0, 0, 0, 96, 89, NULL, NULL, 'The Mage Tower allows you to recruit Arch Mages.', 3, ''),
(104, 'Upg. Altar of Wishes', 2000, 5, 0, 0, 0, 0, 0, 97, NULL, NULL, NULL, 'The Altar of Wishes allows you to recruit Master Genies.', 3, ''),
(105, 'Upg. Golden Pavilion	', 3000, 0, 0, 3, 3, 3, 3, 98, NULL, NULL, NULL, 'The Golden Pavilion allows you to recruit Naga Queens.', 3, ''),
(106, 'Upg. Cloud Temple', 5, 5, 0, 0, 0, 0, 30, 99, NULL, NULL, NULL, 'The Cloud Temple allows you to recruit Titans.', 3, '');

-- --------------------------------------------------------

--
-- Структура таблицы `fractions`
--

CREATE TABLE `fractions` (
  `id` int NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `territory_id` int NOT NULL,
  `icon` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `fractions`
--

INSERT INTO `fractions` (`id`, `name`, `territory_id`, `icon`) VALUES
(1, 'Castle', 2, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/0/04/Замок_-_Н3.jpg/revision/latest?cb=20160607151345&path-prefix=ru'),
(2, 'Rampart', 2, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/2/2f/Оплот_-_H3.jpg/revision/latest?cb=20170108053447&path-prefix=ru'),
(3, 'Tower', 7, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/1/15/Башня_-_Н3.jpg/revision/latest?cb=20160610081026&path-prefix=ru'),
(4, 'Inferno', 3, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/b/b5/Инферно_-_H3.jpg/revision/latest?cb=20170108053353&path-prefix=ru'),
(5, 'Necropolis', 1, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/6/61/Некрополис_-_H3.jpg/revision/latest?cb=20170108053433&path-prefix=ru'),
(6, 'Dungeon', 4, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/9/95/Подземелье_-_H3.jpg/revision/latest?cb=20170108053503&path-prefix=ru'),
(7, 'Fortress', 8, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/e/ee/Крепость_-_H3.jpg/revision/latest?cb=20170108053410&path-prefix=ru'),
(8, 'Conflux', 9, 'https://static.wikia.nocookie.net/heroesofmightandmagic/images/b/b9/Сопряжение_-_Н3.jpg/revision/latest?cb=20160609121611&path-prefix=ru'),
(10, 'Stronghold', 2, '');

-- --------------------------------------------------------

--
-- Структура таблицы `game_scenarios`
--

CREATE TABLE `game_scenarios` (
  `id` int NOT NULL,
  `players_total` int NOT NULL COMMENT 'Всего игроков (первая цифра)',
  `players_human` int NOT NULL COMMENT 'Игроков людей (вторая цифра)',
  `map_size` enum('S','M','L','XL') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Размер: S=Малая, M=Средняя, L=Большая, XL=Огромная',
  `map_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'RoE' COMMENT 'Иконка трубы (Версия карты)',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Название сценария',
  `victory_condition` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Уничтожить всех' COMMENT 'Белый флаг (Условие победы)',
  `loss_condition` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Потеря всех войск' COMMENT 'Рваный флаг (Условие поражения)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `game_scenarios`
--

INSERT INTO `game_scenarios` (`id`, `players_total`, `players_human`, `map_size`, `map_version`, `title`, `victory_condition`, `loss_condition`) VALUES
(1, 4, 4, 'M', 'RoE', 'Багрянец и Клевер', 'Уничтожить всех', 'Потеря всех войск'),
(2, 4, 4, 'M', 'RoE', 'Багрянец и Клевер (С)', 'Уничтожить всех', 'Потеря всех войск'),
(3, 7, 6, 'L', 'RoE', 'Вознаграждение Ксатраса', 'Захватить город', 'Потеря всех войск'),
(4, 8, 8, 'L', 'RoE', 'Воинственные Лорды!', 'Уничтожить всех', 'Потеря всех войск'),
(5, 8, 8, 'L', 'RoE', 'Воинственные Лорды! (С)', 'Уничтожить всех', 'Потеря всех войск'),
(6, 3, 3, 'M', 'RoE', 'Восхождение', 'Уничтожить всех', 'Потеря всех войск'),
(7, 8, 8, 'L', 'RoE', 'Воюют все!', 'Уничтожить всех', 'Потеря всех войск'),
(8, 3, 2, 'M', 'RoE', 'Все за одного', 'Уничтожить всех', 'Потеря всех войск');

-- --------------------------------------------------------

--
-- Структура таблицы `magic_schools`
--

CREATE TABLE `magic_schools` (
  `id` int NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `book_tab_icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `border_highlight_asset` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `magic_schools`
--

INSERT INTO `magic_schools` (`id`, `name`, `icon`, `book_tab_icon`, `border_highlight_asset`) VALUES
(1, 'магия воздуха', 'air_icon.png', 'book_air.png', ''),
(2, 'магия земли', 'earth_icon.png', ' book_earth.png', ''),
(3, 'магия огня', 'fire_icon.png', 'book_fire.png', ''),
(4, 'магия воды', 'water_icon.png', ' book_water.png', '');

-- --------------------------------------------------------

--
-- Структура таблицы `scenarios`
--

CREATE TABLE `scenarios` (
  `id` int NOT NULL,
  `players_total` int NOT NULL,
  `players_human` int NOT NULL,
  `map_size` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `victory_condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `scenarios`
--

INSERT INTO `scenarios` (`id`, `players_total`, `players_human`, `map_size`, `title`, `victory_condition`) VALUES
(1, 4, 4, 'M', 'Багрянец и Клевер	', 'Уничтожить всех'),
(2, 7, 4, 'L', 'Вознаграждение Ксатраса	', 'Захватить город'),
(3, 8, 8, 'L', 'Воинственные лорды!', 'Уничтожить всех'),
(4, 3, 3, 'M', 'Восхождение', 'Уничтожить всех'),
(5, 8, 8, 'L', 'Воюют все!', 'Уничтожить всех');

-- --------------------------------------------------------

--
-- Структура таблицы `spells`
--

CREATE TABLE `spells` (
  `id` int NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `level` int NOT NULL,
  `school_id` int NOT NULL,
  `mana_cost` int NOT NULL,
  `icon` varchar(105) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `spells`
--

INSERT INTO `spells` (`id`, `name`, `level`, `school_id`, `mana_cost`, `icon`) VALUES
(1, 'Волшебная стрела', 1, 1, 5, ''),
(2, 'Ускорение', 1, 1, 6, ''),
(3, 'Небесное око', 1, 1, 2, ''),
(4, 'Видения', 2, 1, 4, ''),
(5, 'Маскировка', 2, 1, 3, ''),
(6, 'Разрушающий луч', 2, 1, 10, ''),
(7, 'Фортуна', 2, 1, 7, ''),
(8, 'Молния', 2, 1, 10, ''),
(9, 'Точность', 2, 1, 8, ''),
(10, 'Защита от воздуха', 2, 1, 7, ''),
(11, 'Воздушный щит', 3, 1, 12, ''),
(12, 'Уничтожить нежить', 3, 1, 15, ''),
(13, 'Гипноз', 3, 1, 18, ''),
(14, 'Цепная молния', 4, 1, 24, ''),
(15, 'Контрудар', 4, 1, 24, ''),
(16, 'Молния титана', 4, 1, 0, ''),
(17, 'Дверь измерений', 5, 1, 25, ''),
(18, 'Полёт', 5, 1, 20, ''),
(19, 'Призыв воздушного знаменателя', 5, 1, 25, ''),
(20, 'Волшебное зеркало', 5, 1, 25, ''),
(21, 'Волшебная стрела', 1, 2, 5, ''),
(22, 'Каменная кожа', 1, 2, 5, ''),
(23, 'Медлительность', 1, 2, 6, ''),
(24, 'Просмотр земли', 1, 2, 2, ''),
(25, 'Щит', 1, 2, 5, ''),
(26, 'Волна смерти', 2, 2, 10, ''),
(27, 'Зыбучие пески', 2, 2, 8, ''),
(28, 'Антимагия', 3, 2, 15, ''),
(29, 'Защита от земли', 3, 2, 12, ''),
(30, 'Землетрясение', 3, 2, 20, ''),
(31, 'Поднятие мертвецов', 3, 2, 15, ''),
(32, 'Силовое поле', 3, 2, 12, ''),
(33, 'Воскрешение', 4, 2, 20, ''),
(34, 'Городской портал', 4, 2, 16, ''),
(35, 'Метеоритный дождь', 4, 2, 16, ''),
(36, 'Печаль', 4, 2, 16, ''),
(37, 'Взрыв', 5, 2, 30, ''),
(38, 'Элементаль Земли', 5, 2, 25, ''),
(39, 'Волшебная стрела', 1, 3, 5, ''),
(40, 'Жажда крови', 1, 3, 5, ''),
(41, 'Защита от Огня', 1, 3, 5, ''),
(42, 'Проклятие', 1, 3, 6, ''),
(43, 'Видения', 2, 3, 4, ''),
(44, 'Слепота', 2, 3, 10, ''),
(45, 'Стена огня', 2, 3, 8, ''),
(46, 'Минное поле', 3, 3, 18, ''),
(47, 'Неудача', 3, 3, 12, ''),
(48, 'Огненный шар', 3, 3, 15, ''),
(49, 'Армагеддон', 4, 3, 24, ''),
(50, 'Берсерк', 4, 3, 20, ''),
(51, 'Бешенство', 4, 3, 16, ''),
(52, 'Инферно', 4, 3, 16, ''),
(53, 'Огненный щит', 4, 3, 16, ''),
(54, 'Палач', 4, 3, 16, ''),
(55, 'Жертва', 5, 3, 25, ''),
(56, 'Элементаль Огня', 5, 3, 25, ''),
(57, 'Волшебная стрела', 1, 4, 5, ''),
(58, 'Благословение', 1, 4, 5, ''),
(59, 'Защита от Воды', 1, 4, 5, ''),
(60, 'Снятие заклинаний', 1, 4, 5, ''),
(61, 'Лечение', 1, 4, 6, ''),
(62, 'Вызвать корабль', 1, 4, 6, ''),
(63, 'Видения', 2, 4, 4, ''),
(64, 'Ледяная стрела', 2, 4, 8, ''),
(65, 'Уничтожить корабль', 2, 4, 8, ''),
(66, 'Устранение преград', 2, 4, 7, ''),
(67, 'Слабость', 2, 4, 8, ''),
(68, 'Забывчивость', 3, 4, 12, ''),
(69, 'Кольцо холода', 3, 4, 12, ''),
(70, 'Радость', 3, 4, 12, ''),
(71, 'Телепорт', 2, 4, 15, ''),
(72, 'Клон', 4, 4, 24, ''),
(73, 'Молитва', 4, 4, 16, ''),
(74, 'Хождение по воде', 4, 4, 12, ''),
(75, 'Элементаль вода', 5, 4, 25, '');

-- --------------------------------------------------------

--
-- Структура таблицы `terrain`
--

CREATE TABLE `terrain` (
  `id` int NOT NULL,
  `name` text COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `img_link` text COLLATE utf8mb4_general_ci NOT NULL,
  `fraction` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `terrain`
--

INSERT INTO `terrain` (`id`, `name`, `description`, `img_link`, `fraction`) VALUES
(1, 'Грязь', 'Штрафа нет', 'dirt.png', 5),
(2, 'Трава', 'Штрафа нет', 'grass.png', 1),
(3, 'Лава', 'Штрафа нет', 'lava.png', 4),
(4, 'Подземелье', 'Нет штрафа', 'underground.png', 7),
(5, 'Камни', 'Штраф – 25%', 'rough.png', 10),
(6, 'Песок', 'Штраф – 50%', 'sand.png', NULL),
(7, 'Снег', 'Штраф – 50%', 'snow.png', 3),
(8, 'Болото', 'Штраф – 75%', 'swamp.png', 7),
(9, 'Высокогорье', 'Нет штрафа', 'highlands.png', 8),
(10, 'Вода', 'Отдельная система подсчёта очков передвижения.', 'water.png', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `units`
--

CREATE TABLE `units` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fraction` int NOT NULL,
  `price` int NOT NULL,
  `housing` int NOT NULL,
  `AI` int NOT NULL,
  `Attack` int NOT NULL,
  `Protection` int NOT NULL,
  `min_damage` int NOT NULL,
  `max_damage` int NOT NULL,
  `Health` int NOT NULL,
  `speed` int NOT NULL,
  `increase` int NOT NULL,
  `ammunition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `units`
--

INSERT INTO `units` (`id`, `name`, `fraction`, `price`, `housing`, `AI`, `Attack`, `Protection`, `min_damage`, `max_damage`, `Health`, `speed`, `increase`, `ammunition`, `icon`) VALUES
(1, 'Spearman', 1, 60, 20, 80, 4, 5, 1, 3, 10, 4, 14, 'No', 'spearman.png'),
(2, 'Archer', 1, 100, 22, 126, 6, 3, 2, 3, 10, 4, 9, '12', 'archer.png'),
(3, 'Griffon', 1, 200, 24, 351, 8, 8, 3, 6, 25, 6, 7, 'No', 'grifon.png'),
(4, 'Swordsman', 1, 300, 27, 445, 10, 12, 6, 9, 35, 5, 4, 'No', 'swordman.png'),
(5, 'Monk', 1, 400, 29, 485, 12, 7, 10, 12, 30, 5, 3, '12', 'monk.png'),
(6, 'Cavalier', 1, 1000, 31, 1946, 15, 15, 15, 25, 100, 7, 2, 'No', 'cavalier.png'),
(7, 'Angel', 1, 3000, 32, 5019, 20, 20, 50, 50, 200, 12, 1, 'No', 'angel.png'),
(8, 'Halberdier', 1, 75, 21, 115, 6, 5, 2, 3, 10, 5, 14, 'No', 'halberdier.png'),
(9, 'Marksman', 1, 150, 23, 184, 6, 3, 2, 3, 10, 6, 9, '24', 'marksman.png'),
(10, 'Royal griffin', 1, 240, 25, 488, 9, 9, 3, 6, 25, 9, 7, 'No', 'royal_grifon.png'),
(11, 'Crusader', 1, 400, 28, 588, 12, 12, 7, 10, 35, 6, 4, 'No', 'crusader.png'),
(12, 'Zealot', 1, 450, 30, 750, 12, 10, 10, 12, 30, 7, 3, '24', 'zealot.png'),
(13, 'Champion', 1, 1200, 33, 2100, 16, 16, 20, 25, 100, 9, 2, 'No', 'champion.png'),
(14, 'Archangel', 1, 5000, 34, 8776, 30, 30, 50, 50, 250, 18, 1, 'No', 'archangel.png'),
(15, 'Centaur', 2, 70, 50, 100, 5, 3, 2, 3, 8, 6, 14, 'No', ''),
(16, 'Captain of the Centaurs', 2, 90, 57, 138, 6, 3, 2, 3, 10, 8, 14, 'No', ''),
(17, 'Dwarf', 2, 120, 51, 138, 6, 7, 2, 4, 20, 3, 8, 'No', ''),
(18, 'Battle Dwarf', 2, 150, 58, 209, 7, 7, 2, 4, 20, 5, 8, 'No', ''),
(19, 'Wood elf', 2, 200, 52, 234, 9, 5, 3, 5, 15, 6, 7, '24', ''),
(20, 'Grand elf', 2, 225, 59, 331, 9, 5, 3, 5, 15, 7, 7, '24', ''),
(21, 'Pegasus', 2, 250, 53, 518, 9, 8, 5, 9, 30, 8, 5, 'No', ''),
(22, 'Silver pegasus', 2, 275, 60, 532, 9, 10, 5, 9, 30, 12, 5, 'No', ''),
(23, 'Dendroid guard', 2, 350, 54, 517, 9, 12, 10, 14, 55, 3, 3, 'No', ''),
(24, 'Dendroid soldier', 2, 425, 61, 803, 9, 12, 10, 14, 65, 4, 3, 'No', ''),
(25, 'Unicorn', 2, 850, 55, 1806, 15, 14, 18, 22, 90, 7, 2, 'No', ''),
(26, 'War unicorn', 2, 950, 62, 2030, 15, 14, 18, 22, 110, 9, 2, 'No', ''),
(27, 'Green dragon', 2, 2400, 56, 4872, 18, 18, 40, 50, 180, 10, 1, 'No', ''),
(28, 'Gold dragon', 2, 4000, 63, 8613, 27, 27, 40, 50, 250, 16, 1, 'No', ''),
(29, 'Gremlin', 3, 30, 93, 44, 3, 3, 1, 2, 4, 4, 16, 'No', ''),
(30, 'Master Gremlin', 3, 40, 100, 66, 4, 4, 1, 2, 4, 5, 16, '8', ''),
(31, 'Stone Gargoyle', 3, 130, 94, 165, 6, 6, 2, 3, 16, 6, 9, 'No', ''),
(32, 'Obsidian Gargoyle', 3, 160, 101, 201, 7, 7, 2, 3, 16, 9, 9, 'No', ''),
(33, 'Stone Golem', 3, 150, 95, 260, 7, 10, 4, 5, 30, 3, 6, 'No', ''),
(34, 'Iron Golem', 3, 200, 102, 412, 9, 10, 4, 5, 35, 5, 6, 'No', ''),
(35, 'Mage', 3, 350, 96, 570, 11, 8, 7, 9, 25, 5, 4, '24', ''),
(36, 'Arch Mage', 3, 450, 103, 680, 12, 9, 7, 9, 30, 7, 4, '24', ''),
(37, 'Genie', 3, 550, 97, 884, 12, 12, 13, 16, 40, 7, 3, 'No', ''),
(38, 'Master Genie', 3, 600, 104, 942, 12, 12, 13, 16, 40, 11, 3, 'No', ''),
(39, 'Naga', 3, 1100, 98, 1814, 16, 13, 20, 20, 110, 5, 2, 'No', ''),
(40, 'Naga Queen', 3, 1600, 105, 2840, 16, 13, 30, 30, 110, 7, 2, 'No', ''),
(41, 'Giant', 3, 2000, 99, 3718, 19, 16, 40, 60, 150, 7, 1, 'No', ''),
(42, 'Titan', 3, 5000, 106, 7500, 24, 24, 40, 60, 300, 11, 1, '24', '');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `biomes`
--
ALTER TABLE `biomes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `building`
--
ALTER TABLE `building`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `towns_id` (`towns_id`),
  ADD KEY `Requirements1` (`Requirements1`,`Requirements2`,`Requirements3`,`Requirements4`),
  ADD KEY `Requirements2` (`Requirements2`),
  ADD KEY `Requirements3` (`Requirements3`),
  ADD KEY `Requirements4` (`Requirements4`);

--
-- Индексы таблицы `fractions`
--
ALTER TABLE `fractions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Индексы таблицы `game_scenarios`
--
ALTER TABLE `game_scenarios`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `magic_schools`
--
ALTER TABLE `magic_schools`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `scenarios`
--
ALTER TABLE `scenarios`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `spells`
--
ALTER TABLE `spells`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `terrain`
--
ALTER TABLE `terrain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fraction` (`fraction`);

--
-- Индексы таблицы `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fraction` (`fraction`),
  ADD KEY `housing` (`housing`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `biomes`
--
ALTER TABLE `biomes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT для таблицы `fractions`
--
ALTER TABLE `fractions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `game_scenarios`
--
ALTER TABLE `game_scenarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `magic_schools`
--
ALTER TABLE `magic_schools`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `scenarios`
--
ALTER TABLE `scenarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `spells`
--
ALTER TABLE `spells`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT для таблицы `terrain`
--
ALTER TABLE `terrain`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `units`
--
ALTER TABLE `units`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `building`
--
ALTER TABLE `building`
  ADD CONSTRAINT `building_ibfk_1` FOREIGN KEY (`Requirements1`) REFERENCES `building` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `building_ibfk_2` FOREIGN KEY (`Requirements2`) REFERENCES `building` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `building_ibfk_3` FOREIGN KEY (`Requirements3`) REFERENCES `building` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `building_ibfk_4` FOREIGN KEY (`Requirements4`) REFERENCES `building` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `building_ibfk_5` FOREIGN KEY (`towns_id`) REFERENCES `fractions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `terrain`
--
ALTER TABLE `terrain`
  ADD CONSTRAINT `terrain_ibfk_1` FOREIGN KEY (`fraction`) REFERENCES `fractions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
