-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-12-2022 a las 17:55:11
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdtit2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `id_area` int(11) NOT NULL,
  `area` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`id_area`, `area`) VALUES
(1, 'area1'),
(2, 'area2'),
(3, 'area3'),
(4, 'area4');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobante_de_hora`
--

CREATE TABLE `comprobante_de_hora` (
  `id_comprobante` int(11) NOT NULL,
  `respuesta` enum('Solicitud Rechazada','Solicitud Aprobada') NOT NULL,
  `id_hora` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comprobante_de_hora`
--

INSERT INTO `comprobante_de_hora` (`id_comprobante`, `respuesta`, `id_hora`) VALUES
(1, 'Solicitud Aprobada', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `id_especialidad` int(11) NOT NULL,
  `especialidad` varchar(30) NOT NULL,
  `id_area` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`id_especialidad`, `especialidad`, `id_area`) VALUES
(1, 'Medicina General', 1),
(2, 'Nutricion', 2),
(3, 'Kinesiologia', 3),
(4, 'Psicologo', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha_general`
--

CREATE TABLE `ficha_general` (
  `id_general` int(11) NOT NULL,
  `rut` varchar(13) NOT NULL,
  `fecha` date NOT NULL,
  `patologias` text NOT NULL,
  `observaciones` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ficha_general`
--

INSERT INTO `ficha_general` (`id_general`, `rut`, `fecha`, `patologias`, `observaciones`) VALUES
(1, '15.202.532-4', '2022-03-03', 'asma', 'presenta crisis durante muy poco periodo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha_nutricional`
--

CREATE TABLE `ficha_nutricional` (
  `id_nutri` int(11) NOT NULL,
  `rut` varchar(13) NOT NULL,
  `fecha` date NOT NULL,
  `actividad_laboral` varchar(45) NOT NULL,
  `actividad_fisica` varchar(45) NOT NULL,
  `hrs_fisica_semanal` int(3) NOT NULL,
  `consumo_alcohol` tinyint(1) NOT NULL,
  `cant_alcohol_semanal` int(3) NOT NULL,
  `habito_tabaco` tinyint(1) NOT NULL,
  `cant_tabaco_semana` int(3) NOT NULL,
  `antecedentes_morbidos` varchar(45) NOT NULL,
  `otras_patologias` varchar(45) NOT NULL,
  `peso` int(3) NOT NULL,
  `talla` int(3) NOT NULL,
  `imc` int(3) NOT NULL,
  `pitri` float NOT NULL,
  `pibi` float NOT NULL,
  `pisb` float NOT NULL,
  `pisc` float NOT NULL,
  `porcentaje_grasa` float NOT NULL,
  `gmb` float NOT NULL,
  `tiempo_de_comida` int(3) NOT NULL,
  `peso_ideal` int(2) NOT NULL,
  `alimentos_porciones` varchar(100) NOT NULL,
  `observaciones` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ficha_nutricional`
--

INSERT INTO `ficha_nutricional` (`id_nutri`, `rut`, `fecha`, `actividad_laboral`, `actividad_fisica`, `hrs_fisica_semanal`, `consumo_alcohol`, `cant_alcohol_semanal`, `habito_tabaco`, `cant_tabaco_semana`, `antecedentes_morbidos`, `otras_patologias`, `peso`, `talla`, `imc`, `pitri`, `pibi`, `pisb`, `pisc`, `porcentaje_grasa`, `gmb`, `tiempo_de_comida`, `peso_ideal`, `alimentos_porciones`, `observaciones`) VALUES
(2, '13.782.362-5', '2022-10-01', 'cajero', 'Nada', 0, 0, 3, 0, 0, 'Ninguno', 'Ninguna', 90, 113, 12, 0.9, 5.5, 12.6, 12.12, 0.4, 5, 1, 70, '1/4 de porcion', 'Comienzo de la dieta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha_psicologica`
--

CREATE TABLE `ficha_psicologica` (
  `id_psico` int(11) NOT NULL,
  `rut` varchar(13) NOT NULL,
  `fecha` date NOT NULL,
  `obsrvaciones` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ficha_psicologica`
--

INSERT INTO `ficha_psicologica` (`id_psico`, `rut`, `fecha`, `obsrvaciones`) VALUES
(1, '16.672.322-5', '2022-09-12', 'presenta sintomas de depresion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hora_medica`
--

CREATE TABLE `hora_medica` (
  `id_hora` int(11) NOT NULL,
  `disponibilidad` enum('Disponible','Reservado') NOT NULL DEFAULT 'Disponible',
  `fecha_hora` datetime NOT NULL,
  `rut_p` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hora_medica`
--

INSERT INTO `hora_medica` (`id_hora`, `disponibilidad`, `fecha_hora`, `rut_p`) VALUES
(18, 'Reservado', '2022-10-13 13:30:00', '15.457.123-0'),
(19, 'Disponible', '2022-10-10 14:00:00', '11.444.666-1'),
(20, 'Reservado', '2022-10-12 16:00:00', '9.356.987-4'),
(22, 'Reservado', '2022-12-24 10:00:00', '15.457.123-0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `rut` varchar(13) NOT NULL,
  `fecha_ingreso` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`rut`, `fecha_ingreso`) VALUES
('12.492.852-5', '2017-12-17'),
('13.782.362-5', '2019-10-11'),
('15.202.532-4', '2021-09-01'),
('16.672.322-5', '2020-01-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `rut` varchar(13) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono_personal` varchar(12) NOT NULL,
  `telefono_contacto` varchar(12) NOT NULL,
  `sexo` enum('M','F') NOT NULL,
  `talla` enum('S','M','L','XL') NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`rut`, `nombres`, `apellidos`, `telefono_personal`, `telefono_contacto`, `sexo`, `talla`, `fecha_nacimiento`, `correo_electronico`, `direccion`) VALUES
('12.123.123-9', 'Pedro', 'Hernandez Figueroa', '12344321', '43211234', 'M', 'XL', '2022-12-02', 'andres.sbr11@gmail.com', 'balboa 32 valparaiso'),
('12.492.852-5', 'Yared', 'Sosa', '7136245288', '9137687534', 'F', 'M', '1992-12-10', 'yaredsosa71@gmail.com', 'Victoria 71'),
('13.782.362-5', 'Adel', 'Leon', '9335766260', '3445082852', 'F', 'S', '1995-05-24', 'adelleon@gmail.com', 'jackson 777'),
('14.212.952-3', 'Vivian', 'Bustamante', '8403480260', '2223615077', 'F', 'L', '1983-04-19', 'vivianbustamante@hotmail.com', 'AV.valparaiso 67'),
('15.202.532-4', 'Tatan', 'Cisternas', '8702581472', '4831314748', 'M', 'XL', '1999-08-18', 'tatancisternas@hotmail.com', 'Quinta 98'),
('15.902.812-4', 'Gabrial', 'Lopez', '2611291661', '6363686752', 'M', 'M', '1983-09-14', 'gabriellopoz@gmail.com', 'Victoria 131'),
('16.672.322-5', 'Gerardo', 'Perez', '6243804856', '6586514943', 'M', 'XL', '1987-05-23', 'gerardoperez87@gmaol.com', 'Villa esperanza 90'),
('20.123.123-1', '', '', '', '', 'M', '', '0000-00-00', '', ''),
('20.172.699-9', 'Matias', 'Rojas', '12344321', '43211234', 'M', 'XL', '2022-12-01', 'andres.sbr11@gmail.com', 'balboa 32 valparaiso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesional`
--

CREATE TABLE `profesional` (
  `rut_p` varchar(13) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `correo` varchar(30) NOT NULL,
  `fono` varchar(12) NOT NULL,
  `num_sala` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesional`
--

INSERT INTO `profesional` (`rut_p`, `nombre`, `correo`, `fono`, `num_sala`) VALUES
('11.444.666-1', 'Loreto Diaz', 'loretodias@gmail.com', '912344567', 2),
('13.456.867-8', 'Mario Perez', 'luisperez@gmail.com', '945235678', 1),
('15.457.123-0', 'Juan Rojas', 'juanrojas@gmail.com', '998765432', 3),
('16.333.999-k', 'Luis Jara', 'luisjara@hotmail.com', '911223344', 4),
('9.356.987-4', 'Joel Garcia', 'joelgarcia@hotmail.com', '95667788', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pro_espec`
--

CREATE TABLE `pro_espec` (
  `id_especialidad` int(3) NOT NULL,
  `rut_p` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pro_espec`
--

INSERT INTO `pro_espec` (`id_especialidad`, `rut_p`) VALUES
(1, '11.444.666-1'),
(2, '13.456.867-8'),
(2, '9.356.987-4'),
(3, '15.457.123-0'),
(4, '16.333.999-k');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala`
--

CREATE TABLE `sala` (
  `num_sala` int(3) NOT NULL,
  `ubicacion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sala`
--

INSERT INTO `sala` (`num_sala`, `ubicacion`) VALUES
(1, 'Laboratorio lecofq'),
(2, 'Laboratorio lecofq'),
(3, 'Laboratorio lecofq'),
(4, 'Laboratorio lecofq');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('NhbSVnWXy2_5jFCWmpiWxx-9xHRVzMHx', 1670497640, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{}}'),
('XGC2l6xbKou1u2bk8hgdDSMIpur2mH3p', 1670516269, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicita`
--

CREATE TABLE `solicita` (
  `motivo` varchar(120) NOT NULL,
  `id_solicita` int(11) NOT NULL,
  `id_hora` int(3) NOT NULL,
  `rut` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicita`
--

INSERT INTO `solicita` (`motivo`, `id_solicita`, `id_hora`, `rut`) VALUES
('Tengo multiples dolores', 1, 18, '15.902.812-4'),
('222', 28, 20, '20.123.123-1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `correo` varchar(100) NOT NULL,
  `rut` varchar(13) NOT NULL,
  `contrasena` varchar(60) NOT NULL,
  `tipo` enum('secretario','profesional','paciente') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`correo`, `rut`, `contrasena`, `tipo`) VALUES
('yaredsosa71@gmail.com', '12.492.852-5', '$2a$10$yyHi3s9gpOmf3aVuYNOu7eueq6VaIPUNO5063bGpD7JQC/uBBPzgO', 'secretario'),
('adelleon@gmail.com', '13.782.362-5', '$2a$10$AWQAQiVSU82rG6m0kS80Q.sy6I3fdkdX3QHScaUTdRyMAPJc14/66', 'paciente'),
('juanito@gmail.com', '15.457.123-0', '$2a$10$c/ucpR8ksirGq9k.13gW.uKqRChugbjjUahLtD8ssnCWXzsL4U5FW', 'profesional');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `comprobante_de_hora`
--
ALTER TABLE `comprobante_de_hora`
  ADD PRIMARY KEY (`id_comprobante`),
  ADD KEY `id_hora` (`id_hora`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`id_especialidad`),
  ADD KEY `id_area` (`id_area`);

--
-- Indices de la tabla `ficha_general`
--
ALTER TABLE `ficha_general`
  ADD PRIMARY KEY (`id_general`,`rut`),
  ADD KEY `rut` (`rut`);

--
-- Indices de la tabla `ficha_nutricional`
--
ALTER TABLE `ficha_nutricional`
  ADD PRIMARY KEY (`id_nutri`,`rut`),
  ADD KEY `rut` (`rut`);

--
-- Indices de la tabla `ficha_psicologica`
--
ALTER TABLE `ficha_psicologica`
  ADD PRIMARY KEY (`id_psico`,`rut`),
  ADD KEY `rut` (`rut`);

--
-- Indices de la tabla `hora_medica`
--
ALTER TABLE `hora_medica`
  ADD PRIMARY KEY (`id_hora`),
  ADD KEY `rut_p` (`rut_p`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`rut`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`rut`);

--
-- Indices de la tabla `profesional`
--
ALTER TABLE `profesional`
  ADD PRIMARY KEY (`rut_p`),
  ADD KEY `num_sala` (`num_sala`);

--
-- Indices de la tabla `pro_espec`
--
ALTER TABLE `pro_espec`
  ADD PRIMARY KEY (`id_especialidad`,`rut_p`),
  ADD KEY `rut_p` (`rut_p`),
  ADD KEY `id_especialidad` (`id_especialidad`);

--
-- Indices de la tabla `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`num_sala`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indices de la tabla `solicita`
--
ALTER TABLE `solicita`
  ADD PRIMARY KEY (`id_solicita`,`rut`),
  ADD KEY `rut` (`rut`),
  ADD KEY `id_hora` (`id_hora`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`rut`,`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `comprobante_de_hora`
--
ALTER TABLE `comprobante_de_hora`
  MODIFY `id_comprobante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `id_especialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ficha_general`
--
ALTER TABLE `ficha_general`
  MODIFY `id_general` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ficha_nutricional`
--
ALTER TABLE `ficha_nutricional`
  MODIFY `id_nutri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ficha_psicologica`
--
ALTER TABLE `ficha_psicologica`
  MODIFY `id_psico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `hora_medica`
--
ALTER TABLE `hora_medica`
  MODIFY `id_hora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `solicita`
--
ALTER TABLE `solicita`
  MODIFY `id_solicita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comprobante_de_hora`
--
ALTER TABLE `comprobante_de_hora`
  ADD CONSTRAINT `comprobante_de_hora_ibfk_1` FOREIGN KEY (`id_hora`) REFERENCES `hora_medica` (`id_hora`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD CONSTRAINT `especialidad_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `area` (`id_area`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ficha_general`
--
ALTER TABLE `ficha_general`
  ADD CONSTRAINT `ficha_general_ibfk_1` FOREIGN KEY (`rut`) REFERENCES `paciente` (`rut`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ficha_nutricional`
--
ALTER TABLE `ficha_nutricional`
  ADD CONSTRAINT `ficha_nutricional_ibfk_1` FOREIGN KEY (`rut`) REFERENCES `paciente` (`rut`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ficha_psicologica`
--
ALTER TABLE `ficha_psicologica`
  ADD CONSTRAINT `ficha_psicologica_ibfk_1` FOREIGN KEY (`rut`) REFERENCES `paciente` (`rut`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `hora_medica`
--
ALTER TABLE `hora_medica`
  ADD CONSTRAINT `hora_medica_ibfk_1` FOREIGN KEY (`rut_p`) REFERENCES `profesional` (`rut_p`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `paciente_ibfk_1` FOREIGN KEY (`rut`) REFERENCES `persona` (`rut`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `profesional`
--
ALTER TABLE `profesional`
  ADD CONSTRAINT `profesional_ibfk_1` FOREIGN KEY (`num_sala`) REFERENCES `sala` (`num_sala`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pro_espec`
--
ALTER TABLE `pro_espec`
  ADD CONSTRAINT `pro_espec_ibfk_1` FOREIGN KEY (`rut_p`) REFERENCES `profesional` (`rut_p`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pro_espec_ibfk_2` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidad` (`id_especialidad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicita`
--
ALTER TABLE `solicita`
  ADD CONSTRAINT `solicita_ibfk_1` FOREIGN KEY (`rut`) REFERENCES `persona` (`rut`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `solicita_ibfk_2` FOREIGN KEY (`id_hora`) REFERENCES `hora_medica` (`id_hora`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
