create database c1720260_edc;

-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 28-06-2024 a las 12:48:25
-- Versión del servidor: 5.7.41-log
-- Versión de PHP: 7.4.33

USE c1720260_edc;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `c1720260_edc`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_calculador_mamposteria`
--

CREATE TABLE `tbl_calculador_mamposteria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `ancho` int(11) NOT NULL,
  `alto` int(11) NOT NULL,
  `largo` int(11) NOT NULL,
  `es_portante` tinyint(1) NOT NULL,
  `cal` float DEFAULT NULL,
  `arena` float NOT NULL,
  `cemento` float DEFAULT NULL,
  `plasticor` float DEFAULT NULL,
  `ancho_pared` float NOT NULL,
  `espesor` float NOT NULL,
  `vol_mezcla` float NOT NULL,
  `can_ladrillos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_calculador_mamposteria`
--

INSERT INTO `tbl_calculador_mamposteria` (`id`, `nombre`, `ancho`, `alto`, `largo`, `es_portante`, `cal`, `arena`, `cemento`, `plasticor`, `ancho_pared`, `espesor`, `vol_mezcla`, `can_ladrillos`) VALUES
(1, 'Ladrillo Común', 33, 5, 25, 1, 0.235, 0.00116, 0.123, NULL, 33, 1.5, 82, 116),
(2, 'Bloque Cerámico', 40, 19, 18, 1, 0.25, 0.0012, 0.065, NULL, 20, 1, 13, 13),
(3, 'Bloque de Hormigón', 19, 19, 39, 1, 0.23, 0.001066, 0.235, NULL, 15, 1.5, 23, 16),
(4, 'Ladrillo Común', 12, 5, 25, 0, 0.23, 0.001066, 0.235, NULL, 15, 1.5, 32, 59),
(5, 'Ladrillo Hueco', 18, 12, 33, 0, 0.23, 0.001066, 0.235, NULL, 15, 1.5, 15, 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_calculador_revoques`
--

CREATE TABLE `tbl_calculador_revoques` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `cal` float DEFAULT NULL,
  `arena` float NOT NULL,
  `cemento` float DEFAULT NULL,
  `hidrofugo` varchar(100) DEFAULT NULL,
  `plasticor` float DEFAULT NULL,
  `espesor` float NOT NULL,
  `vol_mezcla` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_calculador_revoques`
--

INSERT INTO `tbl_calculador_revoques` (`id`, `nombre`, `cal`, `arena`, `cemento`, `hidrofugo`, `plasticor`, `espesor`, `vol_mezcla`) VALUES
(1, 'Hidrófugo', NULL, 0.006, 2.7, 'Según tipo', NULL, 0.5, 5),
(2, 'Revoque grueso - Empleando cal y cemento', 0.235, 0.00116, 0.123, NULL, NULL, 1.5, 15),
(3, 'Revoque grueso - Empleando cemento de albañilería', NULL, 1330, NULL, NULL, 0.255, 1.5, 15),
(4, 'Revoque fino', 1.6, 0.006, 0.45, NULL, NULL, 0.5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_calculador_terminaciones`
--

CREATE TABLE `tbl_calculador_terminaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `cal` float NOT NULL,
  `arena` float NOT NULL,
  `cemento` float NOT NULL,
  `vol_mezcla` float NOT NULL,
  `espesor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_calculador_terminaciones`
--

INSERT INTO `tbl_calculador_terminaciones` (`id`, `nombre`, `cal`, `arena`, `cemento`, `vol_mezcla`, `espesor`) VALUES
(1, 'Colocación de mosaicos', 5.9, 0.03, 3.1, 25, 2.5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_categorias`
--

CREATE TABLE `tbl_categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_categorias`
--

INSERT INTO `tbl_categorias` (`id`, `nombre`) VALUES
(1, 'Cimientos y estructuras'),
(2, 'Albañilería y mampostería'),
(3, 'Reparaciones');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cupones`
--

CREATE TABLE `tbl_cupones` (
  `id` int(11) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `vencimiento` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_cupones`
--

INSERT INTO `tbl_cupones` (`id`, `codigo`, `vencimiento`) VALUES
(1, 'ABC123', '2024-07-01 02:59:59'),
(2, 'EFG456', '2024-08-01 02:59:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cupones_usuarios`
--

CREATE TABLE `tbl_cupones_usuarios` (
  `id` int(11) NOT NULL,
  `id_cupon` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_examenes`
--

CREATE TABLE `tbl_examenes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `url` varchar(500) NOT NULL,
  `id_video` int(11) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_examenes`
--

INSERT INTO `tbl_examenes` (`id`, `nombre`, `url`, `id_video`, `categoria_id`) VALUES
(1, 'FUNDACIONES', 'https://docs.google.com/forms/d/e/1FAIpQLSc16YNh7XB3jtqFzfCu3q9cL6fxLuQvAdsh8qS-xDidRIj49Q/viewform', 1, 1),
(2, 'ENCADENADO', 'https://docs.google.com/forms/d/e/1FAIpQLSc16YNh7XB3jtqFzfCu3q9cL6fxLuQvAdsh8qS-xDidRIj49Q/viewform', 4, 1),
(3, 'TABIQUES', 'https://docs.google.com/forms/d/e/1FAIpQLSdxA_c62d4xUnfx-IGpwst3miOmxp7d2JuYkfPB5m1XVHk3mg/viewform', 6, 1),
(4, 'COLUMNAS', 'https://docs.google.com/forms/d/e/1FAIpQLSddVr-2F1Q0uXbmVviE_WayXmOFkLIpFxthtgZMTc7PcKI_Cg/viewform', 7, 1),
(5, 'VIGAS', 'https://docs.google.com/forms/d/e/1FAIpQLSfYbbvTlQ-KTYoXd9g7Hcrvy2uHZA8E4MEfHYSGpzyEZoKr6A/viewform', 8, 1),
(6, 'DINTEL', 'https://docs.google.com/forms/d/e/1FAIpQLSdPmylbZF2ecINW5lfNA5dNqu0ABPthUwkjtxLohhIv8voOtw/viewform', 9, 1),
(7, 'CONTRAPISO', 'https://docs.google.com/forms/d/e/1FAIpQLSdAGeGu7VD1F1c1Zya_KUxE392xDDEx9vJN8omfpejzCtfXZg/viewform', 26, 1),
(8, 'CAPA DE COMPRESIÓN', 'https://docs.google.com/forms/d/e/1FAIpQLSeJVa3dewdbRmGeKVLzho3gV6T5-aLjFysee1BNX3ScIUE6NA/viewform', 27, 1),
(9, 'CAJÓN HIDRÓFUGO', 'https://docs.google.com/forms/d/e/1FAIpQLScyX5n9RbQ7cidj3f7T82WQxZyh6g1edmtKy-cRPUfb1cs6hw/viewform', 10, 2),
(10, 'MAMPOSTERÍA', 'https://docs.google.com/forms/d/e/1FAIpQLSfEB8qXZHvduqTwX-Go6Mx7RB9zFQatYxf3LFCDRTIdVXMTWA/viewform', 11, 2),
(11, 'REVOQUES', 'https://docs.google.com/forms/d/e/1FAIpQLScT482mI7v1Ssv-eOWpk14cyveGlrt0icYjHsw1RAYJ167prQ/viewform', 16, 2),
(12, 'TERMINACIONES', 'https://docs.google.com/forms/d/e/1FAIpQLSdpBIMlXW3z4wwpFU_rDey6Yfl0bZkgU1HfdoBFwvcRoAUsLA/viewform', 19, 2),
(13, 'REPARACIONES/VICIOS OCULTOS', 'https://docs.google.com/forms/d/e/1FAIpQLSeewk3VoORlq4dOxGi7WkFN7mZt82m-umcht1lxc8u9Y3dwzQ/viewform', 23, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_historial_usuarios`
--

CREATE TABLE `tbl_historial_usuarios` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_video` int(11) DEFAULT NULL,
  `origen_id` int(11) NOT NULL,
  `fecha_visualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_historial_usuarios`
--

INSERT INTO `tbl_historial_usuarios` (`id`, `id_usuario`, `id_video`, `origen_id`, `fecha_visualizacion`) VALUES
(1, 2, 1, 1, '2024-06-11 01:56:59'),
(2, 1, 1, 1, '2024-06-11 20:28:10'),
(5, 4, 2, 1, '2024-06-12 22:46:29'),
(10, 8, 1, 1, '2024-06-26 18:40:39'),
(11, 8, 2, 1, '2024-06-26 18:40:42'),
(12, 8, 1, 1, '2024-06-26 18:40:50'),
(13, 8, 4, 1, '2024-06-26 18:42:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_insignias`
--

CREATE TABLE `tbl_insignias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `imagen_url` varchar(255) DEFAULT NULL,
  `examen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_insignias`
--

INSERT INTO `tbl_insignias` (`id`, `nombre`, `descripcion`, `imagen_url`, `examen_id`) VALUES
(1, 'Fundaciones', NULL, 'fundaciones', 1),
(2, 'Encadenado', NULL, 'encadenado', 2),
(3, 'Tabiques', NULL, 'tabiques', 3),
(4, 'Columas', NULL, 'columnas', 4),
(5, 'Vigas', NULL, 'vigas', 5),
(6, 'Dintel', NULL, 'dintel', 6),
(7, 'Contrapiso sobre terreno natural', NULL, 'contrapiso-sobre-terreno-natural', 7),
(8, 'Cajón de compresión', NULL, 'capa-de-compresion', 8),
(9, 'Cajón hidrófugo', NULL, 'cajon-hidrofugo', 9),
(10, 'Mamposterías', NULL, 'mamposterias', 10),
(11, 'Revoques', NULL, 'revoques', 11),
(12, 'Terminaciones', NULL, 'terminaciones', 12),
(13, 'Reparaciones/Vicios Ocultos', NULL, 'rajaduras-de-mamposteria', 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_insignias_usuario`
--

CREATE TABLE `tbl_insignias_usuario` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_insignia` int(11) DEFAULT NULL,
  `puntaje` int(11) DEFAULT NULL,
  `aprobado` tinyint(1) NOT NULL DEFAULT '0',
  `origen_id` int(11) NOT NULL,
  `fecha_aprobacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_insignias_usuario`
--

INSERT INTO `tbl_insignias_usuario` (`id`, `id_usuario`, `id_insignia`, `puntaje`, `aprobado`, `origen_id`, `fecha_aprobacion`) VALUES
(2, 1, 1, 10, 0, 2, '2024-06-14 23:29:08'),
(11, 1, 1, 10, 0, 2, '2024-06-14 23:29:08'),
(12, 1, 1, 80, 1, 2, '2024-06-14 23:31:57'),
(13, 1, 1, 0, 0, 2, '2024-06-14 23:55:43'),
(14, 1, 1, 0, 0, 2, '2024-06-15 00:00:45'),
(15, 1, 2, 20, 0, 2, '2024-06-15 00:06:24'),
(16, 1, 2, 90, 1, 2, '2024-06-15 00:09:26'),
(17, 1, 13, 100, 1, 2, '2024-06-15 02:13:32'),
(18, 1, 13, 10, 0, 2, '2024-06-15 02:17:37'),
(19, 3, 1, 30, 0, 2, '2024-06-18 23:26:49'),
(31, 1, 1, 0, 0, 1, '2024-06-24 12:26:17'),
(32, 1, 1, 0, 0, 1, '2024-06-24 12:26:17'),
(33, 1, 1, 100, 1, 1, '2024-06-24 12:31:28'),
(34, 1, 1, 100, 1, 1, '2024-06-24 12:38:19'),
(35, 8, 1, 20, 0, 2, '2024-06-26 21:26:24'),
(36, 5, 6, 0, 0, 2, '2024-06-26 21:28:43'),
(37, 8, 1, 90, 1, 2, '2024-06-26 21:32:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_last_login`
--

CREATE TABLE `tbl_last_login` (
  `id` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `sessionData` varchar(2048) NOT NULL,
  `machineIp` varchar(1024) NOT NULL,
  `userAgent` varchar(128) NOT NULL,
  `agentString` varchar(1024) NOT NULL,
  `platform` varchar(128) NOT NULL,
  `createdDtm` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_last_login`
--

INSERT INTO `tbl_last_login` (`id`, `userId`, `sessionData`, `machineIp`, `userAgent`, `agentString`, `platform`, `createdDtm`) VALUES
(1, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\"}', '::1', 'Chrome 112.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'Windows 10', '2023-12-04 16:17:06'),
(2, 6, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\"}', '::1', 'Chrome 112.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'Windows 10', '2024-01-10 10:06:09'),
(3, 6, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\"}', '::1', 'Chrome 112.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'Windows 10', '2024-01-10 13:39:55'),
(4, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\"}', '::1', 'Chrome 112.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'Windows 10', '2024-01-12 16:42:58'),
(5, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\"}', '::1', 'Chrome 112.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'Windows 10', '2024-01-12 16:45:33'),
(6, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-03 15:43:30'),
(7, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-20 16:55:04'),
(8, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-21 14:33:29'),
(9, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-21 17:00:40'),
(10, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\",\"lastname\":null,\"provincia\":null,\"ciudad\":null}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-22 09:18:49'),
(11, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\",\"lastname\":null,\"provincia\":null,\"ciudad\":null}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-23 15:49:39'),
(12, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\",\"lastname\":null,\"provincia\":null,\"ciudad\":null}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-28 15:29:21'),
(13, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\",\"lastname\":\"saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":null}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-28 15:57:10'),
(14, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\",\"lastname\":\"saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36', 'Android', '2024-05-29 09:52:49'),
(15, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\",\"lastname\":\"saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-30 12:01:30'),
(16, 1, '{\"role\":\"1\",\"roleText\":\"Administrador\",\"name\":\"Damian\",\"lastname\":\"saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-05-30 15:46:33'),
(17, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"SAAVEDRA\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"A. Corti\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-06 17:27:41'),
(18, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Kahoot\",\"lastname\":\"P\\u00e9rez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-06 18:10:44'),
(19, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"SAAVEDRA\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"A. Corti\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-07 13:00:51'),
(20, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"SAAVEDRA\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"A. Corti\"}', '::1', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-10 07:21:00'),
(21, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:3d8b:15f6:1f9d:29d8', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-10 18:03:05'),
(22, 2, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Mariano\",\"lastname\":\"Dieguez\",\"provincia\":\"Chubut\",\"ciudad\":\"Apeleg\"}', '2800:810:496:8835:919a:fef0:f108:ecce', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-10 19:55:29'),
(23, 2, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Mariano\",\"lastname\":\"Dieguez\",\"provincia\":\"Chubut\",\"ciudad\":\"Apeleg\"}', '2800:810:496:8835:919a:fef0:f108:ecce', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-10 19:55:32'),
(24, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:897f:ec4:56c6:3808', 'Chrome 108.0.0.0', 'Mozilla/5.0 (Linux; Android 11; SM-A107M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-11 13:40:51'),
(25, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:8dd8:5bb7:c4b6:44e0', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-11 14:24:48'),
(26, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:9167:4d98:f6b6:d23b', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-12 07:48:48'),
(27, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 11:12:22'),
(28, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 11:13:21'),
(29, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:9167:4d98:f6b6:d23b', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-12 13:17:09'),
(30, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:36:11'),
(31, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '200.127.83.186', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:37:03'),
(32, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '200.127.83.186', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:37:38'),
(33, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '200.127.83.186', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:38:30'),
(34, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:9167:4d98:f6b6:d23b', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-12 16:40:54'),
(35, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '200.127.83.186', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:41:36'),
(36, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '200.127.83.186', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:41:54'),
(37, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:41:54'),
(38, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 16:55:01'),
(39, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:897f:ec4:56c6:3808', 'Chrome 108.0.0.0', 'Mozilla/5.0 (Linux; Android 11; SM-A107M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-12 17:47:40'),
(40, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:b534:459e:33fb:74a8', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-13 00:45:07'),
(41, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 02:16:31'),
(42, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 02:18:14'),
(43, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:4503:5a01:7c11:2590', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-13 07:37:32'),
(44, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '2802:8010:900b:6400:958d:eb3d:d64:87c5', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 08:57:46'),
(45, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '190.174.131.32', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 10:04:50'),
(46, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:4503:5a01:7c11:2590', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-13 10:44:38'),
(47, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 10:58:10'),
(48, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '2802:8010:900b:6400:958d:eb3d:d64:87c5', 'Chrome 121.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/25.0 Chrome/121.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 11:04:57'),
(49, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 11:07:28'),
(50, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '190.174.131.32', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 11:11:38'),
(51, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '190.174.131.32', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 11:13:51'),
(52, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows 10', '2024-06-13 11:19:39'),
(53, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '2802:8010:900b:6400:958d:eb3d:d64:87c5', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 14:34:09'),
(54, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:897f:ec4:56c6:3808', 'Chrome 108.0.0.0', 'Mozilla/5.0 (Linux; Android 11; SM-A107M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 15:19:37'),
(55, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:897f:ec4:56c6:3808', 'Chrome 108.0.0.0', 'Mozilla/5.0 (Linux; Android 11; SM-A107M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 15:20:56'),
(56, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '186.138.233.32', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Mac OS X', '2024-06-13 15:36:38'),
(57, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:4503:5a01:7c11:2590', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-13 16:00:41'),
(58, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '186.138.233.32', 'Chrome 121.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/25.0 Chrome/121.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 16:00:59'),
(59, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '186.138.233.32', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Mac OS X', '2024-06-13 16:03:51'),
(60, 4, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Juan\",\"lastname\":\"Carlos\",\"provincia\":\"Entre R\\u00edos\",\"ciudad\":\"Aldea El Chaleco\"}', '186.138.233.32', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Mac OS X', '2024-06-13 16:08:23'),
(61, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows 10', '2024-06-13 16:12:40'),
(62, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '2802:8010:9011:6101:462:a287:917:9d56', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 16:14:17'),
(63, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '2802:8010:9011:6101:462:a287:917:9d56', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-13 16:14:41'),
(64, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.113.119', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows 10', '2024-06-14 10:34:23'),
(65, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:494e:5a54:4f28:e6e5', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-14 14:23:23'),
(66, 7, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Julieta\",\"lastname\":\"Fuoco\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.2.63.193', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows 10', '2024-06-18 10:12:09'),
(67, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.144.243', 'Chrome 125.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows 10', '2024-06-18 14:14:35'),
(68, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:865b:23c9:7c43:3806:684e', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-20 05:59:36'),
(69, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-24 10:53:56'),
(70, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-24 10:54:05'),
(71, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-24 14:46:26'),
(72, 1, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:6c04:ee57:15ff:79e3', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-24 14:56:53'),
(73, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-24 15:52:49'),
(74, 3, '{\"role\":\"2\",\"roleText\":\"Usuario\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-24 15:52:49'),
(75, 3, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-25 00:00:41'),
(76, 3, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-25 00:00:41'),
(77, 3, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Windows 10', '2024-06-25 11:15:25'),
(78, 1, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:9428:c2c1:5d9b:e37e', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-25 12:12:11'),
(79, 3, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Ruben\",\"lastname\":\"Gonzalez\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Achupallas\"}', '190.174.114.76', 'Chrome 116.0.0.0', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36', 'Android', '2024-06-25 13:42:09'),
(80, 1, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Damian\",\"lastname\":\"Saavedra\",\"provincia\":\"Buenos Aires\",\"ciudad\":\"Merlo\"}', '2800:810:494:11ff:9428:c2c1:5d9b:e37e', 'Chrome 122.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows 10', '2024-06-25 15:15:39'),
(81, 8, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Damian\",\"lastname\":\"Boo\",\"provincia\":\"CABA\",\"ciudad\":\"Caballito\"}', '181.229.50.201', 'Safari 604.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/126.0.6478.54 Mobile/15E148 Safari/604.1', 'iOS', '2024-06-26 12:14:43'),
(82, 8, '{\"role\":\"2\",\"roleText\":\"Solo lectura\",\"name\":\"Damian\",\"lastname\":\"Boo\",\"provincia\":\"CABA\",\"ciudad\":\"Caballito\"}', '190.2.63.193', 'Chrome 126.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0', 'Windows 10', '2024-06-26 12:16:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_origen_usuario`
--

CREATE TABLE `tbl_origen_usuario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_origen_usuario`
--

INSERT INTO `tbl_origen_usuario` (`id`, `nombre`) VALUES
(1, 'WhatsApp'),
(2, 'Sitio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_preguntas`
--

CREATE TABLE `tbl_preguntas` (
  `id` int(11) NOT NULL,
  `examen_id` int(11) DEFAULT NULL,
  `pregunta` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_preguntas`
--

INSERT INTO `tbl_preguntas` (`id`, `examen_id`, `pregunta`) VALUES
(1, 1, 'Para fundar un cuadrado con vigas de 3 m de largo, ¿cuantos pilotines necesito?'),
(2, 1, '¿Qué herramienta se recomienda utilizar para la compactación del hormigón en un pilotín?'),
(3, 1, 'Como es conveniente hacer el avance de los pozos para pilotines?'),
(4, 1, 'Para asegurar el correcto recubrimiento del pilotín, ¿a qué distancia de las paredes del pozo debe quedar la armadura de un pilotín?'),
(5, 1, '¿Cuál es la función principal de una zapata aislada en la construcción?'),
(6, 1, 'Para una carga determinada y profundidad fija, establezca el principio correcto'),
(7, 1, '¿Qué característica debe tener la armadura de una zapata en su encuentro con la armadura de la columna?'),
(8, 1, '¿Cuál es la primera barrera hidráulica que se coloca antes de rellenar con tosca en una platea?'),
(9, 1, '¿Qué es fundamental tener definido antes de ejecutar la losa de una platea?'),
(10, 1, 'El vibrado en el hormigón se hace para'),
(11, 2, 'Para darle unidad a las bases y soporte a las mamposterías se utilizan…'),
(12, 2, '¿Qué se debe aplicar primero en el encofrado para facilitar la retirada de las tablas?'),
(13, 2, '¿Cómo se determina el tamaño de las armaduras y el diámetro de los hierros en el encadenado sobre terreno natural?'),
(14, 2, '¿Qué herramienta se recomienda utilizar para compactar el hormigón al llenarlo en el encofrado?'),
(15, 2, '¿Cuántos días se debe esperar, como mínimo, para retirar el encofrado lateral en condiciones climáticas normales?'),
(16, 2, 'Las cargas provenientes de la losa liviana se distribuyen hacia las columnas a través de:'),
(17, 2, '¿Por qué es importante mojar bien los ladrillos antes de llenar el encofrado con hormigón?'),
(18, 2, '¿Qué se debe hacer para asegurar el correcto recubrimiento de las armaduras?'),
(19, 2, '¿Cuál es la función principal del encadenado sobre mampostería en una construcción?'),
(20, 2, '¿Cuántos días se debe esperar, como mínimo, para retirar el encofrado lateral en condiciones climáticas frías?'),
(21, 3, '¿Cuál es la función principal de los tabiques en una estructura de construcción?'),
(22, 3, '¿Por qué se fija la armadura a los hierros de empalme del cimiento en la preparación de los tabiques?'),
(23, 3, '¿Cuál es la principal ventaja de utilizar hormigón elaborado para llenar los tabiques?'),
(24, 3, '¿Qué instrumento se utiliza para alisar la superficie del tabique después de verter el hormigón?'),
(25, 3, '¿Se puede dejar expuesto al aire libre el tabique de hormigón?'),
(26, 3, '¿Cómo se determina el tamaño de las armaduras y el diámetro de los hierros en los tabiques?'),
(27, 3, '¿Por qué es importante mojar bien el cimiento antes de llenar el tabique con hormigón?'),
(28, 3, '¿Qué se debe verificar antes de comenzar el llenado del tabique con hormigón?'),
(29, 3, 'Al llenar un tabique de hormigón, la compactación del mismo se debe hacer:'),
(30, 3, '¿Cuál es el orden correcto de los pasos a seguir para construir un tabique de manera adecuada, considerando la secuencia de acciones detallada?'),
(31, 4, '¿Cuál es la función principal de las columnas en una construcción?'),
(32, 4, '¿Por qué es importante asegurar la resistencia de la parte inferior al verter hormigón en estado fresco al construir tabiques?'),
(33, 4, '¿Cuál es el orden correcto de los pasos para preparar y llenar una columna?'),
(34, 4, 'Las columnas..'),
(35, 4, '¿Con qué materiales se debe alisar la superficie al finalizar el llenado de la columna?'),
(36, 4, '¿Cuál es el propósito de compactar el material durante el llenado de la columna?'),
(37, 4, '¿Qué se debe hacer en climas fríos respecto al tiempo de espera para retirar el encofrado de la columna?'),
(38, 4, '¿Por qué es importante mojar muy bien el cimiento antes de verter el hormigón al construir columnas de hormigón?'),
(39, 4, '¿Cómo se puede compactar el material durante el llenado de la columna si no se cuenta con un vibrador?'),
(40, 5, '¿Cuál es la función principal de las vigas en una estructura?'),
(41, 5, '¿Cuál es el orden correcto de los pasos a seguir para construir una viga de manera adecuada, considerando la secuencia de acciones detallada?'),
(42, 5, 'Las vigas..'),
(43, 5, 'Los separadores que se utilizan en la armadura…'),
(44, 5, 'El material de las armaduras que se utilizan para hacer una viga es:'),
(45, 5, 'El retiro de los laterales y fondo del encofrado se debe hacer:'),
(46, 5, '¿Qué se debe hacer en climas fríos respecto al tiempo de espera para retirar el encofrado de la columna?'),
(47, 5, '¿Qué paso final se realiza después de llenar y compactar el hormigón en la viga?'),
(48, 5, '¿Cuánto tiempo se debe esperar para retirar los laterales del encofrado de las vigas en condiciones normales?'),
(49, 5, '¿Cuánto tiempo se debe esperar para retirar el fondo del encofrado de las vigas luego del hormigonado?'),
(50, 6, '¿Cuál es la función principal de un dintel en una construcción?'),
(51, 6, 'El dintel es…'),
(52, 6, '¿Qué se debe hacer primero al preparar el encofrado para un dintel?'),
(53, 6, '¿Cuál es la composición correcta del mezcla utilizada para el dintel de ladrillo armado?'),
(54, 6, '¿Cuál es el espesor recomendado para la línea de concreto sobre el encofrado en un dintel de ladrillo armado?'),
(55, 6, '¿Cuál debe ser el mínimo de apoyo en los laterales para la armadura del dintel?'),
(56, 6, '¿Qué se debe hacer si el largo de la abertura del dintel supera los 2 metros?'),
(57, 6, '¿Cuánto tiempo se debe esperar antes de retirar el encofrado del dintel en condiciones climáticas normales?'),
(58, 6, '¿Cuál es la composición correcta de la mezcla utilizada para las siguientes hiladas posteriores al dintel?'),
(59, 6, '¿Qué material se utiliza para las armaduras en el dintel de ladrillo armado?'),
(60, 7, '¿Cuál es la función principal del contrapiso sobre terreno natural?'),
(61, 7, '¿Qué se debe hacer primero al preparar el suelo para el contrapiso?'),
(62, 7, 'El film de polietileno que se coloca antes de llenar el contrapiso sirve para'),
(63, 7, '¿Cuál es la proporción correcta de Plasticor en la mezcla para el contrapiso?'),
(64, 7, '¿Por qué es importante mojar las fajas de nivelación y cimientos antes de volcar la mezcla del contrapiso?'),
(65, 7, '¿Cuál es el espesor recomendado para el contrapiso?'),
(66, 7, '¿Cómo se debe nivelar el material del contrapiso?'),
(67, 7, '¿Qué se recomienda hacer para evitar fisuras o rajaduras en el contrapiso?'),
(68, 7, '¿Cuál es la función principal del cascote molido en la mezcla para el contrapiso sobre terreno natural?'),
(69, 7, '¿Qué se debe hacer si el contrapiso está expuesto al sol durante el curado?'),
(70, 8, '¿Qué es la capa de compresión?'),
(71, 8, '¿Cuál es el primer paso en la preparación de la capa de compresión?'),
(72, 8, '¿Cuáles son las consideraciones clave al momento de elegir el espesor de la capa de compresión y por qué son importantes para la integridad estructural del proyecto?'),
(73, 8, 'La principal funcionalidad de la capa de compresión es:'),
(74, 8, '¿Cuál es la secuencia correcta para realizar una capa de compresión en una losa de viguetas y ladrillos sapos?'),
(75, 8, '¿Qué espesor mínimo se recomienda para la capa de compresión?'),
(76, 8, '¿Qué se debe utilizar para nivelar la capa de compresión?'),
(77, 8, '¿Qué tipo de hormigón se recomienda para la capa de compresión?'),
(78, 8, '¿Por qué se debe pedir el hormigón caracterizado según los requerimientos de la obra?'),
(79, 8, '¿Cuál es la función principal de la malla de acero electrosoldada en la preparación de la capa de compresión?.'),
(80, 9, '¿Cuál es la función principal del cajón hidrófugo?'),
(81, 9, '¿Qué tipo de ladrillos se utilizan para construir el cajón hidrófugo?'),
(82, 9, '¿Cuál es el propósito de zarandear la arena antes de mezclarla?'),
(83, 9, '¿Cuál es la proporción recomendada para preparar el mortero del cajón hidrófugo?'),
(84, 9, '¿Cuál es la altura recomendada para el cajón hidrófugo?'),
(85, 9, '¿Cuál es el espesor recomendado para el revoque del cajón hidrófugo?'),
(86, 9, '¿Qué se debe tener en cuenta al realizar el revoque a ambos lados y en la parte superior del cajón hidrófugo?'),
(87, 9, '¿Por qué es necesario seguir las indicaciones del fabricante al preparar el hidrófugo?'),
(88, 9, '¿En qué situaciones debemos realizar un cajón hidrófugo?'),
(89, 9, 'La altura recomendada del cajón por encima del piso terminado es de:'),
(90, 10, 'Los espesores de mampostería portante de ladrillo común pueden ser de:'),
(91, 10, 'Al trabajar en una mampostería portante ladrillo cerámico ¿en qué situación deben colocarse los hierros de refuerzo?'),
(92, 10, 'Los bloques de hormigón se diferencian de los ladrillos cerámicos, entre otros factores, porque'),
(93, 10, '¿Qué tipo de mezcla se recomienda utilizar para la primera hilada de una pared portante de ladrillo cerámico si se trabaja sobre una fundación en terreno natural o al exterior?'),
(94, 10, '¿Cuál es la función principal de la primera hilada en la construcción de una pared portante de bloque de hormigón?'),
(95, 10, '¿Por qué se recomienda colocar armaduras en sentido horizontal cada tres hiladas en una pared portante de ladrillo hueco?'),
(96, 10, '¿Cuál se considera la altura total de una hilada en la construcción de mampostería de ladrillo hueco?'),
(97, 10, '¿Qué medida de seguridad se debe tomar al levantar una mampostería de ladrillo común?'),
(98, 10, '¿Cuál es la diferencia principal entre la colocacion de la primera hilada y el resto?'),
(99, 10, '¿Qué recomendación se da para la colocación de armaduras en una pared portante de ladrillo cerámico?'),
(100, 11, '¿Cuál es la función principal del revoque hidrófugo?'),
(101, 11, 'Al preparar la mezcla para el revoque hidrófugo la arena debe zarandearse para:'),
(102, 11, '¿Cuál es la función principal del revoque fino?'),
(103, 11, '¿Por qué se recomienda mojar la pared antes de aplicar el revoque hidrófugo?'),
(104, 11, '¿Qué se debe hacer después de aplicar la mezcla de revoque hidrófugo?'),
(105, 11, '¿Cuál es la finalidad del revoque grueso?'),
(106, 11, 'Al finalizar el revoque grueso, este debe peinarse para:'),
(107, 11, '¿Cuál es la mezcla correcta para el mortero del revoque grueso?'),
(108, 11, '¿Qué se debe hacer para corregir las imperfecciones durante la aplicación del revoque grueso?'),
(109, 11, '¿Cuál es el paso a seguir después de extender el mortero sobre la pared en el proceso de aplicación del revoque fino?'),
(110, 12, '¿Cuál es el objetivo principal del bolseado?'),
(111, 12, '¿Qué se debe hacer antes de preparar la mezcla para el bolseado?'),
(112, 12, '¿Qué se utiliza para \"bolsar\" el revoque durante el proceso de bolseado?'),
(113, 12, '¿Qué se recomienda hacer después de aplicar el bolseado?'),
(114, 12, '¿Cuál es el primer paso en la preparación para la colocación de mosaicos?'),
(115, 12, '¿Cuándo se debe realizar el llenado de juntas en la instalación de mosaicos?'),
(116, 12, '¿Cuál es la función principal de la carpeta hidrófuga?'),
(117, 12, '¿Cuál es la diferencia principal entre la carpeta hidrófuga y la carpeta de nivelación en términos de su composición?'),
(118, 12, '¿Cuál es la función principal de la carpeta de nivelación?'),
(119, 12, '¿Cuál es el espesor mínimo recomendado para aplicar la carpeta de nivelación?'),
(120, 13, '¿Cuál es el primer paso para reparar una rajadura en la mampostería?'),
(121, 13, '¿Qué se utiliza para fijar las llaves durante la reparación de una rajadura en la mampostería?'),
(122, 13, '¿Qué diferencias importantes existen entre la preparación para reparar rajaduras en mampostería y la preparación para reparar humedad presente en muros?'),
(123, 13, '¿Por qué es importante realizar una inspección ocular en la preparación para reparar humedad presente en muros?'),
(124, 13, '¿Por qué es crucial seguir un proceso de secado adecuado después de completar la reparación de humedad presente en muros?'),
(125, 13, '¿Cuál es el primer paso para reparar rajaduras de revoque y/o desprendimientos?'),
(126, 13, '¿Qué se recomienda hacer después de aplicar una mezcla de cemento y arena durante la reparación de rajaduras de revoque y/o desprendimientos?'),
(127, 13, '¿Qué medida se debe tomar después de picar el revoque agrietado o flojo durante la preparación para reparar rajaduras de revoque y/o desprendimientos?'),
(128, 13, '¿Cuál es el propósito de lavar la superficie con abundante agua y cepillo durante la preparación para reparar rajaduras de revoque y/o desprendimientos?');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_reset_password`
--

CREATE TABLE `tbl_reset_password` (
  `id` bigint(20) NOT NULL,
  `email` varchar(128) NOT NULL,
  `activation_id` varchar(32) NOT NULL,
  `agent` varchar(512) NOT NULL,
  `client_ip` varchar(32) NOT NULL,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  `createdBy` bigint(20) NOT NULL DEFAULT '1',
  `createdDtm` datetime NOT NULL,
  `updatedBy` bigint(20) DEFAULT NULL,
  `updatedDtm` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_respuestas`
--

CREATE TABLE `tbl_respuestas` (
  `id` int(11) NOT NULL,
  `pregunta_id` int(11) DEFAULT NULL,
  `respuesta` text COLLATE utf8_spanish_ci NOT NULL,
  `correcta` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_respuestas`
--

INSERT INTO `tbl_respuestas` (`id`, `pregunta_id`, `respuesta`, `correcta`) VALUES
(1, 1, '9', 0),
(2, 1, '8', 1),
(3, 1, '4', 0),
(4, 2, 'Mazo de goma o vibrador', 0),
(5, 2, 'Martillo neumático o varilla con punta redondeada', 0),
(6, 2, 'Vibrador o varilla con punta redondeada', 1),
(7, 3, 'Iniciar excavando el total de la obra', 0),
(8, 3, 'Iniciar excavando la mitad de los pozos', 0),
(9, 3, 'Hacer solo aquellos que se lleguen a hormigonar en el día', 1),
(10, 4, '2 cm', 0),
(11, 4, '3 cm', 1),
(12, 4, '5 cm', 0),
(13, 5, 'Proveer aislamiento térmico', 0),
(14, 5, 'Transmitir la carga de una columna al suelo', 1),
(15, 5, 'Reducir el costo de construcción', 0),
(16, 6, 'A mayor capacidad portante del suelo, menor será la dimensión de la zapata', 1),
(17, 6, 'A menor capacidad portante del suelo, menor será la dimensión de la zapata', 0),
(18, 6, 'A mayor capacidad portante del suelo, mayor será la dimensión de la zapata', 0),
(19, 7, 'Debe estar hecha de aluminio', 0),
(20, 7, 'Debe tener un plegado en los extremos en ángulo de 90°', 1),
(21, 7, 'Debe ser removida antes del llenado con hormigón', 0),
(22, 8, 'Relleno de piedra', 0),
(23, 8, 'Film de polietileno', 1),
(24, 8, 'Capa de arcilla compactada', 0),
(25, 9, 'El proyecto de muros, muros portantes e instalaciones', 1),
(26, 9, 'El número de operadores en la obra', 0),
(27, 9, 'El tipo de vegetación circundante', 0),
(28, 10, 'que el hormigón endurezca más rápido', 0),
(29, 10, 'que el hormigón se vea más brillante', 0),
(30, 10, 'que el hormigón sea más homogéneo', 1),
(31, 11, 'Vigas Cantilever', 0),
(32, 11, 'Vigas invertidas', 0),
(33, 11, 'Vigas de encadenado sobre terreno natural', 1),
(34, 12, 'Lubricante', 0),
(35, 12, 'Desencofrante', 1),
(36, 12, 'Pintura antiadherente', 0),
(37, 13, 'Según la estética deseada', 0),
(38, 13, 'Por cálculo, según las cargas que soporten', 1),
(39, 13, 'Según las buenas prácticas', 0),
(40, 14, 'Pala de punta', 0),
(41, 14, 'Varilla con punta redondeada', 1),
(42, 14, 'Rodillo compactador', 0),
(43, 15, '1 día', 0),
(44, 15, '2 a 3 días', 1),
(45, 15, '4 a 5 días', 0),
(46, 16, 'Paredes de ladrillos huecos comunes', 0),
(47, 16, 'Vigas de encadenado superior', 1),
(48, 16, 'Dinteles', 0),
(49, 17, 'Para que los ladrillos se enfríen', 0),
(50, 17, 'Para que no le quiten agua a la mezcla y se despegue', 1),
(51, 17, 'Para que se endurezca más rápido', 0),
(52, 18, 'Utilizar separadores', 1),
(53, 18, 'Utilizar cinta adhesiva', 0),
(54, 18, 'Pintar las armaduras', 0),
(55, 19, 'Actuar como una barrera contra la humedad ascendente en las paredes.', 0),
(56, 19, 'Distribuir las cargas provenientes del techo a través de la estructura hasta el suelo, mejorando la estabilidad y la resistencia de los muros.', 1),
(57, 19, 'Proveer una base sobre la cual se puede aplicar el revoque de terminación', 0),
(58, 20, '1 día', 0),
(59, 20, '2 a 3 días', 0),
(60, 20, '3 a 5 días', 1),
(61, 21, 'Actuar de barrera acústica.', 0),
(62, 21, 'Proporcionar resistencia estructural y Delimitar espacios.', 1),
(63, 21, 'Servir como barrera contra la humedad.', 0),
(64, 22, 'Para evitar el desplazamiento del cimiento.', 0),
(65, 22, 'Para garantizar la unión entre el tabique y el cimiento.', 1),
(66, 22, 'Para crear una barrera contra la humedad.', 0),
(67, 23, 'Es más económico.', 0),
(68, 23, 'Garantiza una mejor calidad.', 1),
(69, 23, 'Facilita la aplicación manual.', 0),
(70, 24, 'Cepillo metálico.', 0),
(71, 24, 'Cuchara de albañil y regla.', 1),
(72, 24, 'Pala ancha y regla.', 0),
(73, 25, 'No.', 0),
(74, 25, 'Si.', 1),
(75, 25, 'Solo si está al interior.', 0),
(76, 26, 'Según la estética deseada', 0),
(77, 26, 'Por cálculo, según las cargas que soporten', 1),
(78, 26, 'De acuerdo con la normativa local', 0),
(79, 27, 'Para que los cimientos se enfríen', 0),
(80, 27, 'Para que no le quiten agua a la mezcla y se despegue', 1),
(81, 27, 'Para aumentar la adherencia de la pintura', 0),
(82, 28, 'Que el hormigón esté frío', 0),
(83, 28, 'Que los encofrados y armaduras estén firmes y en posición', 1),
(84, 28, 'Que el clima sea seco', 0),
(85, 29, 'A medida que se va llenando', 1),
(86, 29, 'Realizar siempre dos capas', 0),
(87, 29, 'Al final, luego de colocar todo el hormigón', 0),
(88, 30, 'Aplicar desencofrante en el cajón, fijar la armadura al cimiento, mojar el cimiento, llenar el tabique con hormigón elaborado, compactar el material y esperar 1 día para retirarlo.', 0),
(89, 30, 'Mojar el cimiento, aplicar desencofrante en el cajón, compactar el material, fijar la armadura al cimiento, llenar el tabique con hormigón elaborado y esperar al menos 28 días para retirarlo.', 0),
(90, 30, 'Fijar la armadura al cimiento, aplicar desencofrante en el cajón, mojar el cimiento, llenar el tabique con hormigón elaborado, compactar el material y esperar al menos 3 o 4 días para retirarlo.', 1),
(91, 31, 'Aislar térmicamente el edificio.', 0),
(92, 31, 'Transmitir esfuerzos y cargas hacia las fundaciones.', 1),
(93, 31, 'Mejorar la estética del edificio.', 0),
(94, 32, 'Para evitar fugas de agua.', 0),
(95, 32, 'Para garantizar la estabilidad estructural del encofrado.', 1),
(96, 32, 'Para prevenir la corrosión del acero.', 0),
(97, 33, 'Pasar desencofrante en el cajón; mojar muy bien el cimiento; colocar separadores en la armadura; fijar la armadura a los hierros de empalme del cimiento; llenar la columna con hormigón; asegurar la resistencia de la parte inferior.', 0),
(98, 33, 'Pasar desencofrante en el cajón; colocar separadores en la armadura; fijar la armadura a los hierros de empalme del cimiento; asegurar la resistencia de la parte inferior; mojar muy bien el cimiento; llenar la columna con hormigón.', 0),
(99, 33, 'Pasar desencofrante en el cajón; colocar separadores en la armadura; fijar la armadura a los hierros de empalme del cimiento; mojar muy bien el cimiento; asegurar la resistencia de la parte inferior; llenar la columna con hormigón.', 1),
(100, 34, 'Forman parte de las instalaciones de una obra.', 0),
(101, 34, 'Forman parte de los elementos estructurales de una obra.', 1),
(102, 34, 'Forman parte de las terminaciones de una obra.', 0),
(103, 35, 'Regla', 0),
(104, 35, 'Cuchara de albañil', 1),
(105, 35, 'Pala de punta', 0),
(106, 36, 'Mejorar el aislamiento térmico.', 0),
(107, 36, 'Asegurar un correcto llenado.', 1),
(108, 36, 'Facilitar el retiro del encofrado.', 0),
(109, 37, 'Esperar uno o dos días menos.', 0),
(110, 37, 'Esperar el mismo tiempo que en condiciones normales.', 0),
(111, 37, 'Esperar uno o dos días más.', 1),
(112, 38, 'Para evitar que se formen grietas en el cimiento durante el proceso de llenado.', 0),
(113, 38, 'Para prevenir que el cimiento absorba el agua del hormigón, lo que podría debilitar su estructura.', 1),
(114, 38, 'Para bajar la temperatura del hormigón.', 0),
(115, 39, 'Con una varilla con punta redondeada y golpes suaves a los laterales del encofrado.', 1),
(116, 39, 'Con una mezcla más líquida.', 0),
(117, 39, 'Con una espátula de albañil.', 0),
(118, 40, 'Transmitir cargas de las losas hacia las columnas y tabiques', 1),
(119, 40, 'Solo soportar el peso de las paredes exteriores', 0),
(120, 40, 'Proveer aislamiento térmico', 0),
(121, 41, 'Colocar desencofrante, unir la armadura a los hierros de empalme, acomodar la armadura dentro del encofrado, llenar la viga con hormigón elaborado, compactar el material, alisar la superficie y esperar 3 días para retirar los laterales y 28 días para el fondo del encofrado.', 0),
(122, 41, 'Unir la armadura a los hierros de empalme, colocar desencofrante, acomodar la armadura dentro del encofrado, llenar la viga con hormigón elaborado, compactar el material, alisar la superficie y esperar 3 días para retirar los laterales y 28 días para el fondo del encofrado.', 0),
(123, 41, 'Colocar desencofrante, unir la armadura a los hierros de empalme, llenar la viga con hormigón elaborado, acomodar la armadura dentro del encofrado, compactar el material, alisar la superficie y esperar 3 días para retirar los laterales y 28 días para el fondo del encofrado.', 1),
(124, 42, 'Forman parte de los elementos estructurales de una obra', 1),
(125, 42, 'Forman parte de las instalaciones de una obra', 0),
(126, 42, 'Forman parte de las terminaciones de una obra', 0),
(127, 43, 'Deben ser fabricados dentro de la obra', 0),
(128, 43, 'Pueden ser industrializados', 0),
(129, 43, 'Es indistinto', 1),
(130, 44, 'Hierro', 1),
(131, 44, 'Hierro o plástico', 0),
(132, 44, 'Plástico', 0),
(133, 45, 'En simultaneo', 0),
(134, 45, 'Primero los laterales y luego el fondo', 1),
(135, 45, 'Primero el fondo y luego los laterales', 0),
(136, 46, 'Esperar uno o dos días menos.', 0),
(137, 46, 'Esperar el mismo tiempo que en condiciones normales.', 0),
(138, 46, 'Esperar uno o dos días más.', 1),
(139, 47, 'Pintar la superficie', 0),
(140, 47, 'Alisar la superficie con la cuchara de albañil', 1),
(141, 47, 'Retirar de inmediato los encofrados', 0),
(142, 48, '1 día', 0),
(143, 48, '3 días', 1),
(144, 48, '5 días', 0),
(145, 49, 'Entre 3 y 7 días', 0),
(146, 49, '14 días', 0),
(147, 49, '28 días', 1),
(148, 50, 'Proveer aislamiento térmico.', 0),
(149, 50, 'Sostener la porción de pared que está por encima y distribuir la carga hacia los apoyos.', 1),
(150, 50, 'Mejorar la estética de la edificación.', 0),
(151, 51, 'El cierre superior de un vano', 1),
(152, 51, 'El cierre lateral de un vano', 0),
(153, 51, 'El cierre inferior de un vano', 0),
(154, 52, 'Colocar la armadura en el encofrado.', 0),
(155, 52, 'Aplicar el desencofrante en la tabla.', 0),
(156, 52, 'Nivelar y asegurar una tabla entre las paredes laterales.', 1),
(157, 53, '1 parte de cemento, 3 partes de arena, y agua según sea necesario.', 1),
(158, 53, '2 partes de cemento, 4 partes de arena, y agua según sea necesario.', 0),
(159, 53, '1 parte de cemento, 4 partes de arena, y agua según sea necesario.', 0),
(160, 54, '1 a 2 cm.', 0),
(161, 54, '2 a 3 cm.', 1),
(162, 54, '3 a 4 cm.', 0),
(163, 55, '10 cm.', 0),
(164, 55, '15 cm.', 0),
(165, 55, '20 cm.', 1),
(166, 56, 'Asegurarse de que el encofrado esté más firme.', 0),
(167, 56, 'Repetir la armadura en la tercera hilada.', 1),
(168, 56, 'Aplicar una capa extra de concreto.', 0),
(169, 57, '3 días.', 0),
(170, 57, '5 días.', 0),
(171, 57, '7 días.', 1),
(172, 58, 'Igual a la del dintel', 0),
(173, 58, '1 Parte de Plasticor, 4 partes de arena y agua', 1),
(174, 58, '1 Parte de Plasticor, 3 partes de arena y agua', 0),
(175, 59, 'Madera.', 0),
(176, 59, 'Fibra de vidrio.', 0),
(177, 59, 'Acero', 1),
(178, 60, 'Aislamiento térmico', 0),
(179, 60, 'Base para carpetas y pisos', 1),
(180, 60, 'Decoración del suelo', 0),
(181, 61, 'Pintarlo con pintura resistente y cubrirlo con un film de polietileno', 0),
(182, 61, 'Nivelarlo, limpiarlo y cubrirlo con un film de polietileno', 1),
(183, 61, 'Rociarlo con agua y dejarlo secar', 0),
(184, 62, 'Evitar que se genere polvo', 0),
(185, 62, 'Evitar pérdida de agua y barrera contra la humedad', 1),
(186, 62, 'Evitar la fisuración', 0),
(187, 63, '2 partes de Plasticor; 4 partes de arena, 1 parte de cascote molido y agua', 0),
(188, 63, '1 parte de Plasticor, 4 partes de arena, 6 partes de cascote molido y agua', 1),
(189, 63, '3 partes de Plasticor, 3 partes de arena, 6 partes de cascote molido y agua', 0),
(190, 64, 'Para evitar que se adhieran al hormigón', 0),
(191, 64, 'Para que no le quiten agua a la mezcla y se despegue', 1),
(192, 64, 'Para mejorar la adherencia del film de polietileno', 0),
(193, 65, '5 a 10 cm', 0),
(194, 65, '10 a 15 cm', 1),
(195, 65, '15 a 20 cm', 0),
(196, 66, 'Con una llana', 0),
(197, 66, 'Con una regla, usando movimientos de zigzag', 1),
(198, 66, 'Con una escoba', 0),
(199, 67, 'Mantenerlo seco durante 5 días', 0),
(200, 67, 'Mantenerlo hidratado al menos por 5 días', 1),
(201, 67, 'Cubrirlo con papeles', 0),
(202, 68, 'Proporcionar un acabado más suave y uniforme en la superficie del contrapiso.', 0),
(203, 68, 'Ocupar volumen de manera económica y liviana.', 1),
(204, 68, 'Mejorar la capacidad de drenaje y reducir la retención de humedad en la mezcla.', 0),
(205, 69, 'Dejarlo secar al aire libre', 0),
(206, 69, 'Cubrirlo para mantener la hidratación', 1),
(207, 69, 'Aplicar una capa de pintura reflectante', 0),
(208, 70, 'Una cobertura de hormigón que se realiza sobre una losa de viguetas y ladrillos sapos', 1),
(209, 70, 'Una base para pisos cerámicos', 0),
(210, 70, 'Una capa de pintura protectora', 0),
(211, 71, 'Mojar la superficie', 0),
(212, 71, 'Colocar la malla de acero electrosoldada', 1),
(213, 71, 'Colocar los ladrillos sapos', 0),
(214, 72, 'La elección del espesor debe basarse únicamente en consideraciones estéticas para garantizar un acabado uniforme, lo que garantiza la estabilidad visual del proyecto.', 0),
(215, 72, 'El espesor debe determinarse en función de la resistencia del hormigón utilizado, ya que un espesor inadecuado puede comprometer la capacidad de carga y durabilidad de la estructura.', 1),
(216, 72, 'El espesor debe estar determinado principalmente por la disponibilidad de materiales de construcción en el sitio, ya que un espesor adecuado garantiza la eficiencia en el uso de los recursos disponibles.', 0),
(217, 73, 'Transmitir las cargas a las viguetas', 1),
(218, 73, 'Proporcionar aislamiento térmico a la losa', 0),
(219, 73, 'Actuar como una capa decorativa sobre la losa', 0),
(220, 74, 'Primero, mojar la superficie, luego colocar la malla de acero electrosoldada, esparcir y compactar el hormigón, y por último, utilizar separadores entre las armaduras y nivelar con una regla de corte.', 0),
(221, 74, 'Primero, ubicar la malla de acero electrosoldada, utilizar separadores entre las armaduras, mojar la superficie, llenar la capa de compresión con hormigón, esparcir y compactar el material, y por último, nivelar utilizando una regla de corte.', 1),
(222, 74, 'Primero, llenar la capa de compresión con hormigón, esparcir y compactar el material, mojar la superficie, ubicar la malla de acero electrosoldada, utilizar separadores entre las armaduras, y por último, nivelar con una regla de corte.', 0),
(223, 75, '2 a 3 cm', 0),
(224, 75, '4 a 5 cm', 1),
(225, 75, '6 a 7 cm', 0),
(226, 76, 'Una llana de acero', 0),
(227, 76, 'Una regla de corte realizando movimientos de zigzag', 1),
(228, 76, 'Una escoba de cerdas duras', 0),
(229, 77, 'Hormigón elaborado', 1),
(230, 77, 'Hormigón mezclado en obra', 0),
(231, 77, 'Hormigón de cascotes', 0),
(232, 78, 'Para reducir el costo de la obra', 0),
(233, 78, 'Para evitar ajustes posteriores', 1),
(234, 78, 'Para aumentar la velocidad de construcción', 0),
(235, 79, 'Reforzar la estructura de la losa', 1),
(236, 79, 'Prevenir la formación de grietas y fisuras en la capa de compresión.', 0),
(237, 79, 'Facilitar la nivelación y alisado del hormigón durante su aplicación.', 0),
(238, 80, 'Evitar la entrada de aire en las paredes.', 0),
(239, 80, 'Prevenir la humedad ascendente desde el suelo hacia las paredes.', 1),
(240, 80, 'Proporcionar aislamiento térmico en los cimientos.', 0),
(241, 81, 'Ladrillos cerámicos.', 0),
(242, 81, 'Ladrillos huecos.', 0),
(243, 81, 'Ladrillos comunes macizos.', 1),
(244, 82, 'Aumentar la resistencia del mortero.', 0),
(245, 82, 'Evitar las impurezas en la mezcla.', 1),
(246, 82, 'Facilitar la mezcla con el cemento.', 0),
(247, 83, '1 parte de cemento y 2 partes de arena.', 0),
(248, 83, '1 parte de cemento y 3 partes de arena zarandeada.', 1),
(249, 83, '1 parte de cemento y 4 partes de arena zarandeada.', 0),
(250, 84, '1 hilada', 0),
(251, 84, '3 hiladas.', 1),
(252, 84, '2 hiladas.', 0),
(253, 85, '2 cm.', 0),
(254, 85, '1 cm.', 1),
(255, 85, '3 cm.', 0),
(256, 86, 'Presionar y aplanar muy bien el material.', 1),
(257, 86, 'Dejar que el mortero se seque al aire libre.', 0),
(258, 86, 'Aplicar una capa de pintura impermeabilizante.', 0),
(259, 87, 'Para evitar que la mezcla se endurezca demasiado rápido.', 0),
(260, 87, 'Para garantizar la efectividad del producto en la prevención de humedad.', 1),
(261, 87, 'Para aumentar la resistencia del mortero.', 0),
(262, 88, 'Solo si se va a levantar pared de ladrillo hueco', 0),
(263, 88, 'Luego de cualquier fundación sobre terreno natural', 1),
(264, 88, 'Solo si la fundación fue hecha con cascotes', 0),
(265, 89, '7 cm', 1),
(266, 89, '6 cm', 0),
(267, 89, '5 cm', 0),
(268, 90, '8 y 12 cm', 0),
(269, 90, '15 y 18cm', 0),
(270, 90, '20 y 30 cm', 1),
(271, 91, 'Solo si son paredes al exterior', 0),
(272, 91, 'En todos los casos', 1),
(273, 91, 'Solo si uso Plasticor', 0),
(274, 92, 'Solo con ellos se pueden hacer paredes portantes', 0),
(275, 92, 'Solo estos bloques permiten hacer paredes de 20 cm', 0),
(276, 92, 'Solo estos bloques no deben ser mojados previamente', 1),
(277, 93, 'Mezcla de cemento y arena.', 0),
(278, 93, 'Mezcla hidrófuga.', 1),
(279, 93, 'Mezcla de cal y arena.', 0),
(280, 94, 'Proporcionar una base nivelada para el levantamiento del muro.', 1),
(281, 94, 'Asegurar la resistencia a la compresión del bloque.', 0),
(282, 94, 'Proporcionar aislación térmica.', 0),
(283, 95, 'Para aumentar exclusivamente la resistencia a la compresión de la pared.', 0),
(284, 95, 'Para prevenir la formación de grietas.', 0),
(285, 95, 'Para distribuir las cargas y reforzar la estructura.', 1),
(286, 96, '10 cm.', 0),
(287, 96, 'Altura del ladrillo + ancho de junta.', 1),
(288, 96, '30 cm.', 0),
(289, 97, 'No mojar los ladrillos antes de su colocación.', 0),
(290, 97, 'Colocar las armaduras en cada hilada.', 0),
(291, 97, 'No sobrecargar la base con más de 13 hiladas por día.', 1),
(292, 98, 'La cantidad de mortero requerida.', 0),
(293, 98, 'El tipo de mezcla utilizado.', 1),
(294, 98, 'La necesidad de mojar los ladrillos y cimientos antes de su colocación.', 0),
(295, 99, 'Colocar armaduras horizontales en todas las hiladas.', 0),
(296, 99, 'Colocar armaduras verticales en las esquinas y encuentros de paredes y cada 3 hiladas.', 1),
(297, 99, 'No es necesario colocar armaduras en este tipo de paredes.', 0),
(298, 100, 'Regularizar la superficie de los ladrillos.', 0),
(299, 100, 'Aislar a la estructura de la humedad.', 1),
(300, 100, 'Mejorar la adherencia del revoque grueso.', 0),
(301, 101, 'Evitar filtraciones', 1),
(302, 101, 'Mezclar el material', 0),
(303, 101, 'Hacer rendir a la mezcla', 0),
(304, 102, 'Impermeabilizar.', 0),
(305, 102, 'Mejorar la adherencia del revestimiento.', 0),
(306, 102, 'Proporcionar una capa de textura lisa para mejorar la terminación.', 1),
(307, 103, 'Para evitar que los ladrillos absorban el agua del mortero.', 1),
(308, 103, 'Para facilitar la adherencia del revoque.', 0),
(309, 103, 'Para acelerar el proceso de secado del mortero.', 0),
(310, 104, 'Dejar secar al aire.', 0),
(311, 104, 'Esperar que la mezcla tire y cubrirla con una capa de salpicado.', 1),
(312, 104, 'Inmediatamente cubrirla con una capa de salpicado', 0),
(313, 105, 'Aislar a la estructura de la humedad.', 0),
(314, 105, 'Regularizar la superficie de los ladrillos.', 1),
(315, 105, 'Alcanzar la terminación fina.', 0),
(316, 106, 'Mejorar la adherencia de la capa siguiente', 1),
(317, 106, 'Evitar fisuraciones', 0),
(318, 106, 'Lograr acelerar el fragüe', 0),
(319, 107, '1 parte de Plasticor, 4 partes de arena y agua.', 0),
(320, 107, '1 parte de Plasticor, 5 partes de arena y agua.', 1),
(321, 107, '1 parte de Plasticor, 3 partes de arena y agua.', 0),
(322, 108, 'Aplanar con una cuchara.', 0),
(323, 108, 'Cortar el excedente con una regla.', 1),
(324, 108, 'Añadir más agua a la mezcla.', 0),
(325, 109, 'Humedecer un fratacho de fieltro en agua de cal y repasar toda la superficie.', 0),
(326, 109, 'Volver a cargar el material en sentido cruzado para asentarlo.', 1),
(327, 109, 'Pasar el fratacho en forma circular.', 0),
(328, 110, 'Regularizar la superficie de los ladrillos.', 0),
(329, 110, 'Obtener una terminación agradable visualmente.', 1),
(330, 110, 'Mejorar la adherencia del revoque grueso.', 0),
(331, 111, 'Humedecer la pared.', 1),
(332, 111, 'Zarandear la arena.', 0),
(333, 111, 'Mojar el contrapiso y los mosaicos.', 0),
(334, 112, 'Un rodillo.', 0),
(335, 112, 'Una cuchara.', 0),
(336, 112, 'Una tela de arpillera.', 1),
(337, 113, 'Cubrirlo con plástico.', 0),
(338, 113, 'Mantenerlo hidratado por 2 o 3 días.', 1),
(339, 113, 'Dejarlo secar al aire libre.', 0),
(340, 114, 'Mojar el contrapiso y los mosaicos.', 1),
(341, 114, 'Colocar un puente de adherencia.', 0),
(342, 114, 'Preparar la mezcla utilizando Plasticor, arena y agua.', 0),
(343, 115, 'Antes de colocar los mosaicos.', 0),
(344, 115, 'Después de 48 horas desde la colocación.', 0),
(345, 115, 'Entre las 24 y 48 horas desde la colocación.', 1),
(346, 116, 'Evitar la pérdida de agua.', 0),
(347, 116, 'Proteger de la humedad.', 1),
(348, 116, 'Aislar térmicamente.', 0),
(349, 117, 'La carpeta hidrófuga se compone de cemento, arena, y agua, mientras que la carpeta de nivelación se hace con cal y arena.', 0),
(350, 117, 'La carpeta hidrófuga se prepara con una mezcla de cemento, arena, e hidrófugo, mientras que la carpeta de nivelación utiliza únicamente cemento y arena.', 1),
(351, 117, 'Ambas carpetas se preparan con la misma composición, pero la carpeta hidrófuga se caracteriza por su espesor mínimo de 2,5 cm.', 0),
(352, 118, 'Evitar la humedad ascendente.', 0),
(353, 118, 'Proporcionar una superficie plana para la instalación del piso.', 1),
(354, 118, 'Mejorar la resistencia del contrapiso.', 0),
(355, 119, '1 cm', 0),
(356, 119, '2,5 cm', 1),
(357, 119, '5,5 cm', 0),
(358, 120, 'Picar la pared y remover el revoque.', 0),
(359, 120, 'Marcar las llaves en la zona afectada.', 1),
(360, 120, 'Lavar la superficie con abundante agua y cepillo.', 0),
(361, 121, 'Cemento y arena.', 1),
(362, 121, 'Metal desplegado.', 0),
(363, 121, 'Hormigón', 0),
(364, 122, 'El uso de llaves de refuerzo.', 1),
(365, 122, 'La necesidad de picar la pared y la inspección ocular.', 0),
(366, 122, 'La lavada de la superficie.', 0),
(367, 123, 'Para determinar la cantidad de material necesario.', 0),
(368, 123, 'Para verificar la consistencia correcta del mortero.', 0),
(369, 123, 'Para encontrar el punto de ingreso de la humedad.', 1),
(370, 124, 'Para evitar que se formen nuevas rajaduras.', 0),
(371, 124, 'Para asegurar la adherencia correcta del revoque.', 0),
(372, 124, 'Para permitir que la humedad interna seque completamente.', 1),
(373, 125, 'Lavar la superficie con abundante agua y cepillo.', 0),
(374, 125, 'Picar el revoque agrietado o flojo.', 1),
(375, 125, 'Realizar una inspección para buscar grietas en los muros.', 0),
(376, 126, 'Dejar secar al aire libre.', 0),
(377, 126, 'Pintar la superficie.', 0),
(378, 126, 'Revocar con una mezcla de Plasticor, arena y agua.', 1),
(379, 127, 'Lavar la superficie con abundante agua y cepillo.', 0),
(380, 127, 'Realizar una inspección para buscar grietas en los muros.', 0),
(381, 127, 'Tomar unos centímetros del perímetro sano.', 1),
(382, 128, 'Eliminar toda partícula suelta y polvo.', 1),
(383, 128, 'Asegurar una mejor adherencia de la mezcla.', 0),
(384, 128, 'Identificar el origen de la rajadura.', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `roleId` tinyint(4) NOT NULL COMMENT 'role id',
  `role` varchar(50) NOT NULL COMMENT 'role text'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_roles`
--

INSERT INTO `tbl_roles` (`roleId`, `role`) VALUES
(1, 'Administrador'),
(2, 'Solo lectura'),
(3, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_topico`
--

CREATE TABLE `tbl_topico` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_users`
--

CREATE TABLE `tbl_users` (
  `userId` int(11) NOT NULL,
  `email` varchar(128) NOT NULL COMMENT 'login email',
  `password` varchar(128) NOT NULL COMMENT 'hashed login password',
  `name` varchar(128) DEFAULT NULL COMMENT 'full name of user',
  `lastname` varchar(30) NOT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `dni` varchar(30) DEFAULT NULL,
  `provincia` varchar(200) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `corralon` varchar(200) DEFAULT NULL,
  `trabajador_contruccion` varchar(10) NOT NULL,
  `profesion` varchar(100) DEFAULT NULL,
  `antiguedad` varchar(100) DEFAULT NULL,
  `roleId` tinyint(4) NOT NULL,
  `verificationcode` int(5) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  `createdBy` int(11) NOT NULL,
  `createdDtm` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDtm` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_users`
--

INSERT INTO `tbl_users` (`userId`, `email`, `password`, `name`, `lastname`, `mobile`, `dni`, `provincia`, `ciudad`, `corralon`, `trabajador_contruccion`, `profesion`, `antiguedad`, `roleId`, `verificationcode`, `verified`, `isDeleted`, `createdBy`, `createdDtm`, `updatedBy`, `updatedDtm`) VALUES
(1, 'dev1@eycreativehub.com', '$2y$10$7YTmlDrfAXk74FRyCpuF9uHEr9OI6Q.glxHtl1gBzGnAc2fGFYI0O', 'Damian', 'Saavedra', '1162584242', NULL, 'Buenos Aires', 'Merlo', 'En ninguno', 'Si', 'Albañil', 'Entre 6 y 9 años', 2, 5068, 0, 0, 0, '2024-06-10 18:02:50', NULL, NULL),
(2, 'marianohernandieguez@gmail.com', '$2y$10$9VMRFGJrO5mbMDvG8UCWL.t9IXCAh/uYGizzAk6QB1zUU.R1zZBG6', 'Mariano', 'Dieguez', '1165879544', NULL, 'Chubut', 'Apeleg', 'Coco', 'Si', 'Albañil', '', 2, 5263, 0, 0, 0, '2024-06-10 19:54:44', NULL, NULL),
(3, 'rgonzalez@eycreativehub.com', '$2y$10$r2SN8SBunNrkAjC9.rFEXuwm3FDVbZkXmMGXecGWix6nxmV8Tdh.a', 'Ruben', 'Gonzalez', '1131385026', NULL, 'Buenos Aires', 'Achupallas', 'Lo de Beto', 'Si', 'Afines', 'Mas de 10 años', 2, 8327, 0, 0, 0, '2024-06-12 11:11:38', NULL, NULL),
(4, 'carlos@ga.com', '$2y$10$5G20rsy7G0MjqM1WG.gxNOBntSfPpW5IdKvuA1Nfd4hIm.Jke4Oay', 'Juan', 'Carlos', '1122222222', NULL, 'Entre Ríos', 'Aldea El Chaleco', 'Iu', 'Si', 'Afines', '', 2, 1712, 0, 0, 0, '2024-06-12 16:36:04', NULL, NULL),
(5, 'camilapicon00@gmail.com', '$2y$10$1KzO/agCXK34UCGYWS45J.JxPPvjJxCT9Ro0VDMFVdXl2vv5nt792', 'Camila', 'Picon', '2213549090', NULL, 'Buenos Aires', 'La Plata', '', 'No', '', '', 2, 8673, 0, 0, 0, '2024-06-13 17:01:05', NULL, NULL),
(6, 'cliente@gmail.com', '$2y$10$0VRJ0uJFCLTkooftxr1ZdurOsv4OZEQXMOpY3NhpwE0kToaGlfoRm', 'Prueba', 'Test', '1144442222', NULL, 'Salta', 'Ampascachi', 'En ninguno', 'No', '', '', 2, 8716, 0, 0, 0, '2024-06-14 12:00:27', NULL, NULL),
(7, 'julieta.fuoco@gmail.com', '$2y$10$7h2OYVoIHWDvyStY7qt/MecFwxq6I30RooV/cB6PTdynDWDbPftim', 'Julieta', 'Fuoco', '1158957807', NULL, 'Buenos Aires', 'Achupallas', '', 'Si', 'Carpintero/herrero de obra', 'Menos de 5 años', 2, 5332, 0, 0, 0, '2024-06-18 10:11:55', NULL, NULL),
(8, 'damiangbo@gmail.com', '$2y$10$VdBqCOtNnBkG0GuiqlROYez9O3Fhy0z.sCPUNQZcJEy4t0DhNGIxe', 'Damian', 'Boo', '1165850248', NULL, 'CABA', 'Caballito', 'Prueba', 'Si', 'Albañil', 'Entre 6 y 9 años', 2, 2330, 0, 0, 0, '2024-06-26 12:13:30', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_videos`
--

CREATE TABLE `tbl_videos` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `watch_id` varchar(100) DEFAULT NULL,
  `descripcion` text,
  `imagen` varchar(200) NOT NULL,
  `examen_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_videos`
--

INSERT INTO `tbl_videos` (`id`, `url`, `titulo`, `watch_id`, `descripcion`, `imagen`, `examen_id`) VALUES
(1, 'https://youtube.com/shorts/MKSpRXBmiBg?feature=share', 'Pilote', 'MKSpRXBmiBg', NULL, 'thumbnail.jpg', 1),
(2, 'https://youtube.com/shorts/FYa3kCwCJAk?feature=share', 'Zapata', 'FYa3kCwCJAk', NULL, 'thumbnail.jpg', 1),
(3, 'https://youtube.com/shorts/_PaQz26Vchs?feature=share', 'Platea', '_PaQz26Vchs', NULL, 'thumbnail.jpg', 1),
(4, 'https://youtube.com/shorts/JdOIslBHXms?feature=share', 'Encadenado Sobre terreno natural', 'JdOIslBHXms', NULL, 'thumbnail.jpg', 2),
(5, 'https://youtube.com/shorts/oC5wBtwAVLc?feature=share', 'Encadenado Sobre mamposteria', 'oC5wBtwAVLc', NULL, 'thumbnail.jpg', 2),
(6, 'https://youtube.com/shorts/A-jV3Jy88QY?feature=share', 'Tabiques', 'A-jV3Jy88QY', NULL, 'thumbnail.jpg', 3),
(7, 'https://youtube.com/shorts/Z0jcbA-psaw?feature=share', 'Columnas', 'Z0jcbA-psaw', NULL, 'thumbnail.jpg', 4),
(8, 'https://youtube.com/shorts/GhdyufI2VjU?feature=share', 'Vigas', 'GhdyufI2VjU', NULL, 'thumbnail.jpg', 5),
(9, 'https://youtube.com/shorts/NRrDENIhBg4?feature=share', 'Dintel', 'NRrDENIhBg4', NULL, 'thumbnail.jpg', 6),
(10, 'https://youtube.com/shorts/6-1TBh82uDg?feature=share', 'Cajón hidrófugo', '6-1TBh82uDg', NULL, 'thumbnail.jpg', 9),
(11, 'https://youtube.com/shorts/dbPYvYEXO9s?feature=share', 'PORTANTE DE LADRILLO COMÚN', 'dbPYvYEXO9s', NULL, 'thumbnail.jpg', 10),
(12, 'https://youtube.com/shorts/h9ktGChr71Y?feature=share', 'PORTANTE DE LADRILLO CERÁMICO', 'h9ktGChr71Y', NULL, 'thumbnail.jpg', 10),
(13, 'https://youtube.com/shorts/CKM6MbOHXSk?feature=share', 'PORTANTE DE BLOQUE DE HORMIGÓN', 'CKM6MbOHXSk', NULL, 'thumbnail.jpg', 10),
(14, 'https://youtube.com/shorts/cX2Z-gYpprA?feature=share', 'DE LADRILLO COMÚN', 'cX2Z-gYpprA', NULL, 'thumbnail.jpg', 10),
(15, 'https://youtube.com/shorts/dRnyhf3NRdY?feature=share', 'DE LADRILLO HUECO', 'dRnyhf3NRdY', NULL, 'thumbnail.jpg', 10),
(16, 'https://youtube.com/shorts/vzRnaw0tEBs?feature=share', 'Hidrofugo', 'vzRnaw0tEBs', NULL, 'thumbnail.jpg', 11),
(17, 'https://youtube.com/shorts/1YyAonfB-uY?feature=share', 'Grueso', '1YyAonfB-uY', NULL, 'thumbnail.jpg', 11),
(18, 'https://youtube.com/shorts/_K3xTxT8A0A?feature=share', 'Fino', '_K3xTxT8A0A', NULL, 'thumbnail.jpg', 11),
(19, 'https://youtube.com/shorts/YYjt-2tse1M?feature=share', 'Bolseado', 'YYjt-2tse1M', NULL, 'thumbnail.jpg', 12),
(20, 'https://youtube.com/shorts/i29JJoc6sbU?feature=share', 'Carpeta hidrofuga', 'i29JJoc6sbU', NULL, 'thumbnail.jpg', 12),
(21, 'https://youtube.com/shorts/Ij9Ka6MDe54?feature=share', 'Carpeta de nivelacion', 'Ij9Ka6MDe54', NULL, 'thumbnail.jpg', 12),
(22, 'https://youtube.com/shorts/WG1jbpp7jkE?feature=share', 'Colocacion de mosaicos', 'WG1jbpp7jkE', NULL, 'thumbnail.jpg', 12),
(23, 'https://youtube.com/shorts/SeOPxd8edIU?feature=share', 'Rajaduras de mamposteria', 'SeOPxd8edIU', NULL, 'thumbnail.jpg', 13),
(24, 'https://youtube.com/shorts/hAwlibANGtQ?feature=share', 'Rajaduras de revoque o desprendimientos', 'hAwlibANGtQ', NULL, 'thumbnail.jpg', 13),
(25, 'https://youtube.com/shorts/cmOJnx7mk3Q?feature=share', 'Humedad presente en muros', 'cmOJnx7mk3Q', NULL, 'thumbnail.jpg', 13),
(26, 'https://youtube.com/shorts/o68Zjjo7294?feature=share', 'Contrapisos Sobre terreno natural', 'o68Zjjo7294', NULL, 'thumbnail.jpg', 7),
(27, 'https://youtube.com/shorts/AglXNVHwY2Q?feature=share', 'CAPA DE COMPRESION', 'AglXNVHwY2Q', NULL, 'thumbnail.jpg', 8);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `last_activity_idx` (`last_activity`);

--
-- Indices de la tabla `tbl_calculador_mamposteria`
--
ALTER TABLE `tbl_calculador_mamposteria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_calculador_revoques`
--
ALTER TABLE `tbl_calculador_revoques`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_calculador_terminaciones`
--
ALTER TABLE `tbl_calculador_terminaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_categorias`
--
ALTER TABLE `tbl_categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_cupones`
--
ALTER TABLE `tbl_cupones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_cupones_usuarios`
--
ALTER TABLE `tbl_cupones_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cupon` (`id_cupon`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tbl_examenes`
--
ALTER TABLE `tbl_examenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tbl_examenes_ibfk_1` (`categoria_id`),
  ADD KEY `id_video` (`id_video`);

--
-- Indices de la tabla `tbl_historial_usuarios`
--
ALTER TABLE `tbl_historial_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_video` (`id_video`),
  ADD KEY `id_usuario` (`id_usuario`) USING BTREE,
  ADD KEY `origen_id` (`origen_id`);

--
-- Indices de la tabla `tbl_insignias`
--
ALTER TABLE `tbl_insignias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `examen_id` (`examen_id`);

--
-- Indices de la tabla `tbl_insignias_usuario`
--
ALTER TABLE `tbl_insignias_usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `origen_id` (`origen_id`),
  ADD KEY `id_insignia` (`id_insignia`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tbl_last_login`
--
ALTER TABLE `tbl_last_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indices de la tabla `tbl_origen_usuario`
--
ALTER TABLE `tbl_origen_usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_preguntas`
--
ALTER TABLE `tbl_preguntas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `examen_id` (`examen_id`);

--
-- Indices de la tabla `tbl_reset_password`
--
ALTER TABLE `tbl_reset_password`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_respuestas`
--
ALTER TABLE `tbl_respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pregunta_id` (`pregunta_id`);

--
-- Indices de la tabla `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`roleId`);

--
-- Indices de la tabla `tbl_topico`
--
ALTER TABLE `tbl_topico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`userId`),
  ADD KEY `roleId` (`roleId`);

--
-- Indices de la tabla `tbl_videos`
--
ALTER TABLE `tbl_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `examen_id` (`examen_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_calculador_mamposteria`
--
ALTER TABLE `tbl_calculador_mamposteria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tbl_calculador_revoques`
--
ALTER TABLE `tbl_calculador_revoques`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tbl_calculador_terminaciones`
--
ALTER TABLE `tbl_calculador_terminaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tbl_categorias`
--
ALTER TABLE `tbl_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_cupones`
--
ALTER TABLE `tbl_cupones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_cupones_usuarios`
--
ALTER TABLE `tbl_cupones_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_examenes`
--
ALTER TABLE `tbl_examenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tbl_historial_usuarios`
--
ALTER TABLE `tbl_historial_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tbl_insignias`
--
ALTER TABLE `tbl_insignias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tbl_insignias_usuario`
--
ALTER TABLE `tbl_insignias_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `tbl_last_login`
--
ALTER TABLE `tbl_last_login`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `tbl_origen_usuario`
--
ALTER TABLE `tbl_origen_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_preguntas`
--
ALTER TABLE `tbl_preguntas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT de la tabla `tbl_reset_password`
--
ALTER TABLE `tbl_reset_password`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_respuestas`
--
ALTER TABLE `tbl_respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=385;

--
-- AUTO_INCREMENT de la tabla `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `roleId` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'role id', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_topico`
--
ALTER TABLE `tbl_topico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tbl_videos`
--
ALTER TABLE `tbl_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_cupones_usuarios`
--
ALTER TABLE `tbl_cupones_usuarios`
  ADD CONSTRAINT `tbl_cupones_usuarios_ibfk_1` FOREIGN KEY (`id_cupon`) REFERENCES `tbl_cupones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_cupones_usuarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_users` (`userId`);

--
-- Filtros para la tabla `tbl_examenes`
--
ALTER TABLE `tbl_examenes`
  ADD CONSTRAINT `tbl_examenes_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `tbl_categorias` (`id`),
  ADD CONSTRAINT `tbl_examenes_ibfk_2` FOREIGN KEY (`id`) REFERENCES `tbl_insignias` (`examen_id`),
  ADD CONSTRAINT `tbl_examenes_ibfk_3` FOREIGN KEY (`id_video`) REFERENCES `tbl_videos` (`id`);

--
-- Filtros para la tabla `tbl_historial_usuarios`
--
ALTER TABLE `tbl_historial_usuarios`
  ADD CONSTRAINT `tbl_historial_usuarios_ibfk_1` FOREIGN KEY (`id_video`) REFERENCES `tbl_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_historial_usuarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_users` (`userId`),
  ADD CONSTRAINT `tbl_historial_usuarios_ibfk_3` FOREIGN KEY (`origen_id`) REFERENCES `tbl_origen_usuario` (`id`);

--
-- Filtros para la tabla `tbl_insignias`
--
ALTER TABLE `tbl_insignias`
  ADD CONSTRAINT `tbl_insignias_ibfk_1` FOREIGN KEY (`examen_id`) REFERENCES `tbl_examenes` (`id`);

--
-- Filtros para la tabla `tbl_insignias_usuario`
--
ALTER TABLE `tbl_insignias_usuario`
  ADD CONSTRAINT `tbl_insignias_usuario_ibfk_1` FOREIGN KEY (`origen_id`) REFERENCES `tbl_origen_usuario` (`id`),
  ADD CONSTRAINT `tbl_insignias_usuario_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_users` (`userId`),
  ADD CONSTRAINT `tbl_insignias_usuario_ibfk_3` FOREIGN KEY (`id_insignia`) REFERENCES `tbl_insignias` (`id`);

--
-- Filtros para la tabla `tbl_preguntas`
--
ALTER TABLE `tbl_preguntas`
  ADD CONSTRAINT `tbl_preguntas_ibfk_1` FOREIGN KEY (`examen_id`) REFERENCES `tbl_examenes` (`id`);

--
-- Filtros para la tabla `tbl_respuestas`
--
ALTER TABLE `tbl_respuestas`
  ADD CONSTRAINT `tbl_respuestas_ibfk_1` FOREIGN KEY (`pregunta_id`) REFERENCES `tbl_preguntas` (`id`);

--
-- Filtros para la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD CONSTRAINT `tbl_users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `tbl_roles` (`roleId`);

--
-- Filtros para la tabla `tbl_videos`
--
ALTER TABLE `tbl_videos`
  ADD CONSTRAINT `tbl_videos_ibfk_1` FOREIGN KEY (`examen_id`) REFERENCES `tbl_examenes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
