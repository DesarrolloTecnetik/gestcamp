-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-10-2025 a las 21:03:59
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbclean`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `config`
--

CREATE TABLE `config` (
  `title` varchar(125) NOT NULL DEFAULT 'DragoRO Top',
  `slogan` varchar(200) NOT NULL DEFAULT 'Ragnarok Online',
  `url` varchar(125) NOT NULL DEFAULT 'http://localhost',
  `time_cookie` int(7) NOT NULL DEFAULT 1800,
  `reset_time_expired` int(7) NOT NULL DEFAULT 300,
  `reset_max_request` int(7) NOT NULL DEFAULT 3,
  `limit_login` int(3) NOT NULL DEFAULT 5,
  `time_zone` varchar(250) NOT NULL DEFAULT 'America/Mexico_city',
  `sbpanel` varchar(500) NOT NULL DEFAULT 'http://localhost/pincredit/sbpanel',
  `facebook` varchar(500) DEFAULT NULL,
  `twitter` varchar(500) DEFAULT NULL,
  `instagram` varchar(500) DEFAULT NULL,
  `email_contact` varchar(500) NOT NULL DEFAULT 'contacto@repartoya.com',
  `twitter_user` varchar(150) DEFAULT NULL,
  `google_api` varchar(500) NOT NULL DEFAULT 'AIzaSyA_ydFQiAhgKWK6a3IFjr-DUjiNC2W1iL8',
  `onesignal` varchar(500) NOT NULL DEFAULT 'c23c6d51-d492-4c88-a111-88cc8d7b624d',
  `stripe_public` varchar(500) DEFAULT NULL,
  `stripe_private` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `config`
--

INSERT INTO `config` (`title`, `slogan`, `url`, `time_cookie`, `reset_time_expired`, `reset_max_request`, `limit_login`, `time_zone`, `sbpanel`, `facebook`, `twitter`, `instagram`, `email_contact`, `twitter_user`, `google_api`, `onesignal`, `stripe_public`, `stripe_private`) VALUES
('TITULO', 'SLOGAN', 'http://localhost', 600, 300, 3, 5, 'America/Mexico_City', 'http://localhost/sbpanel', NULL, NULL, NULL, 'emailcontacto', NULL, '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `userid` int(11) NOT NULL,
  `user` varchar(35) DEFAULT NULL,
  `pass` text DEFAULT NULL,
  `rank` int(7) NOT NULL DEFAULT 1,
  `lastlogin` datetime DEFAULT NULL,
  `last_ip` varchar(125) DEFAULT NULL,
  `premium` tinyint(1) NOT NULL DEFAULT 0,
  `navegator` text DEFAULT NULL,
  `lang` varchar(7) NOT NULL DEFAULT 'es',
  `server` tinyint(1) NOT NULL DEFAULT 1,
  `isonline` tinyint(1) NOT NULL DEFAULT 0,
  `country` varchar(11) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 1,
  `token` text DEFAULT NULL,
  `idref` int(11) DEFAULT NULL,
  `name` varchar(175) DEFAULT NULL,
  `lastname` varchar(250) DEFAULT NULL,
  `ifecha` date DEFAULT NULL,
  `cedula` varchar(100) DEFAULT NULL,
  `direccion` varchar(500) DEFAULT NULL,
  `ciudad` varchar(125) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `movil` varchar(15) DEFAULT NULL,
  `email` varchar(275) DEFAULT NULL,
  `comentario` varchar(500) DEFAULT NULL,
  `ipas` varchar(250) DEFAULT NULL,
  `avatar` varchar(500) NOT NULL DEFAULT 'default.jpg',
  `header` varchar(500) DEFAULT 'default.jpg',
  `interes` float NOT NULL DEFAULT 8,
  `sexo` varchar(75) NOT NULL DEFAULT 'Masculino',
  `nacimiento` date DEFAULT NULL,
  `map_lat` varchar(250) DEFAULT '18.6698995',
  `map_lon` varchar(250) DEFAULT '-70.130055',
  `status` int(12) DEFAULT 1,
  `idatetime` datetime NOT NULL DEFAULT current_timestamp(),
  `pushid` varchar(500) DEFAULT NULL,
  `hashpush` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`userid`, `user`, `pass`, `rank`, `lastlogin`, `last_ip`, `premium`, `navegator`, `lang`, `server`, `isonline`, `country`, `verified`, `token`, `idref`, `name`, `lastname`, `ifecha`, `cedula`, `direccion`, `ciudad`, `phone`, `movil`, `email`, `comentario`, `ipas`, `avatar`, `header`, `interes`, `sexo`, `nacimiento`, `map_lat`, `map_lon`, `status`, `idatetime`, `pushid`, `hashpush`) VALUES
(1, 'Administrador', 'H-CAD,#!C-V-E.#1D-3AE.3)F,#,P-C@V839C9&4S9C$X,V5B.3,P80``\n`\n', 9999, '2024-08-13 02:14:48', '127.0.0.1', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'es', 2, 1, 'MX', 1, 'tdzFwNXX0azE5cvNkOXLwsTlxs7F4s/A1bPJzMTczo3G4sMlaOTmJCjmoyVqA==', NULL, 'Ricardo', 'Bocardo Marin', '2020-05-09', '123-2222222-2', 'Manuel R Gutierrez', 'Acayucan', '(921) 222 1602', '9212221602', 'ricardobomar@gmail.com', 'Administrador', NULL, 'avatar_ricardomarin.png', 'default.jpg', 8, 'Masculino', '2021-09-23', '17.9238338', '-94.8910404', 1, '2022-02-02 14:27:28', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_alerts`
--

CREATE TABLE `login_alerts` (
  `id` int(12) NOT NULL,
  `userid` int(12) DEFAULT NULL,
  `name` varchar(125) DEFAULT NULL,
  `descrip` varchar(500) DEFAULT NULL,
  `serverid` int(12) DEFAULT NULL,
  `idate` date DEFAULT NULL,
  `itime` varchar(25) DEFAULT NULL,
  `iview` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_attemp`
--

CREATE TABLE `login_attemp` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `itime` date DEFAULT NULL,
  `ihours` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_banned`
--

CREATE TABLE `login_banned` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `descrip` text NOT NULL,
  `itimeid` int(11) DEFAULT NULL,
  `itime` date NOT NULL,
  `ihours` varchar(25) DEFAULT NULL,
  `rankid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_banned_times`
--

CREATE TABLE `login_banned_times` (
  `id` int(11) NOT NULL,
  `name` varchar(125) DEFAULT NULL,
  `itime_days` varchar(11) DEFAULT '1',
  `ispermanent` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `login_banned_times`
--

INSERT INTO `login_banned_times` (`id`, `name`, `itime_days`, `ispermanent`) VALUES
(1, 'Un día', '1', 0),
(9999, 'Permanente', '99999999', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_captcha`
--

CREATE TABLE `login_captcha` (
  `id` int(11) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `itime` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_filters`
--

CREATE TABLE `login_filters` (
  `id` int(11) NOT NULL,
  `word` varchar(125) DEFAULT NULL,
  `new_word` varchar(125) DEFAULT 'DragoRO'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `login_filters`
--

INSERT INTO `login_filters` (`id`, `word`, `new_word`) VALUES
(1, 'Administrador', 'filtro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_permissions`
--

CREATE TABLE `login_permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(250) DEFAULT 'Titulo del permiso',
  `descrip` varchar(200) DEFAULT NULL,
  `interno` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_rank`
--

CREATE TABLE `login_rank` (
  `id` int(11) NOT NULL,
  `name` varchar(125) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `permissions` varchar(5000) DEFAULT NULL,
  `interno` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `login_rank`
--

INSERT INTO `login_rank` (`id`, `name`, `rank`, `permissions`, `interno`) VALUES
(1, 'Administrador', 9999, 'all', 1),
(2, 'Custom', 2, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_temp`
--

CREATE TABLE `login_temp` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `itime` int(11) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `ip` varchar(125) DEFAULT NULL,
  `token` text DEFAULT NULL,
  `uagent` varchar(500) DEFAULT NULL,
  `remember` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT 'Acción Log',
  `descrip` text DEFAULT NULL,
  `user` int(11) NOT NULL DEFAULT 0,
  `itime` date DEFAULT NULL,
  `ihours` varchar(25) DEFAULT NULL,
  `ip` varchar(125) DEFAULT NULL,
  `server` varchar(250) DEFAULT NULL,
  `idaction` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `config`
--
ALTER TABLE `config`
  ADD UNIQUE KEY `title` (`title`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`userid`);

--
-- Indices de la tabla `login_alerts`
--
ALTER TABLE `login_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `login_attemp`
--
ALTER TABLE `login_attemp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `login_banned`
--
ALTER TABLE `login_banned`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `login_banned_times`
--
ALTER TABLE `login_banned_times`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `login_captcha`
--
ALTER TABLE `login_captcha`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `login_filters`
--
ALTER TABLE `login_filters`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `login_permissions`
--
ALTER TABLE `login_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `login_rank`
--
ALTER TABLE `login_rank`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `login_temp`
--
ALTER TABLE `login_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `login_alerts`
--
ALTER TABLE `login_alerts`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_attemp`
--
ALTER TABLE `login_attemp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_banned`
--
ALTER TABLE `login_banned`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_banned_times`
--
ALTER TABLE `login_banned_times`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10000;

--
-- AUTO_INCREMENT de la tabla `login_captcha`
--
ALTER TABLE `login_captcha`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_filters`
--
ALTER TABLE `login_filters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `login_permissions`
--
ALTER TABLE `login_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_rank`
--
ALTER TABLE `login_rank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `login_temp`
--
ALTER TABLE `login_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
