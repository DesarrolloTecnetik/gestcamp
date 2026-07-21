-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-07-2026 a las 10:25:22
-- Versión del servidor: 11.4.12-MariaDB-cll-lve-log
-- Versión de PHP: 8.4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestcamp_gestcamp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campaign_bitacora`
--

CREATE TABLE `campaign_bitacora` (
  `id` int(11) NOT NULL,
  `uid` varchar(40) NOT NULL,
  `fecha` date DEFAULT NULL,
  `actividad` varchar(500) NOT NULL DEFAULT '',
  `responsable` varchar(250) DEFAULT NULL,
  `prioridad` enum('ALTA','MEDIA','BAJA') NOT NULL DEFAULT 'MEDIA',
  `fecha_inicio` date DEFAULT NULL,
  `acuerdos` text DEFAULT NULL,
  `status` enum('Pendiente','Proceso','Terminada') NOT NULL DEFAULT 'Pendiente',
  `avance` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `seg_fecha` date DEFAULT NULL,
  `seg_desc` text DEFAULT NULL,
  `proxima` varchar(500) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `campaign_bitacora`
--

INSERT INTO `campaign_bitacora` (`id`, `uid`, `fecha`, `actividad`, `responsable`, `prioridad`, `fecha_inicio`, `acuerdos`, `status`, `avance`, `seg_fecha`, `seg_desc`, `proxima`, `userid`, `created_at`, `updated_at`) VALUES
(5, 'mro95sngiuly', '2026-07-15', 'dfgdfg', 'dfgdfg', 'ALTA', '2026-07-14', 'dfgdfg', 'Terminada', 7, '2026-07-02', 'dfgdfg', 'dfgdfgdf', 0, '2026-07-16 19:21:48', '2026-07-16 19:21:48'),
(6, 'mroay2m8y5r2', '2026-05-29', 'Reunión con líderes vecinales', 'Carlos Hernández Díaz', 'ALTA', '2026-05-29', 'Se acordó reforzar la zona con más brigadistas', '', 90, '2026-06-02', '', 'Reunión de seguimiento la próxima semana', 0, '2026-05-29 11:08:00', '2026-05-29 11:08:00'),
(7, 'mro97qg1h0ar', '2026-09-21', 'Perifoneo en zona centro', 'José Luis Jiménez', 'ALTA', '2026-09-20', 'Se acordó reforzar la zona con más brigadistas', 'Terminada', 100, '2026-09-30', 'Actividad reprogramada por logística', 'Programar siguiente recorrido', 0, '2026-09-21 14:14:00', '2026-09-21 14:14:00'),
(8, 'mrob8osoty7o', '2026-08-06', 'Entrega de trípticos informativos', 'Claudia Ríos', 'MEDIA', '2026-08-06', 'Se acordó reportar avances a coordinación general', '', 40, '2026-08-16', 'Actividad reprogramada por logística', 'Reunión de seguimiento la próxima semana', 1, '2026-08-06 12:51:00', '2026-08-06 12:51:00'),
(9, 'mroaan956oht', '2026-05-18', 'Verificación de gastos de campaña', 'Alejandra Vázquez', 'ALTA', '2026-05-18', 'Se acordó revisar presupuesto asignado', 'Pendiente', 80, '2026-05-23', 'Actividad reprogramada por logística', 'Enviar reporte a coordinación general', 2, '2026-05-18 09:54:00', '2026-05-18 09:54:00'),
(10, 'mroan4dttohz', '2026-05-19', 'Reunión con comité de campaña', 'Fernando Castillo Nuño', 'ALTA', '2026-05-15', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 80, '2026-05-28', 'Se dará seguimiento la próxima semana', 'Confirmar logística del próximo evento', 3, '2026-05-19 19:15:00', '2026-05-19 19:15:00'),
(11, 'mro8yqo1pt9g', '2026-07-08', 'Levantamiento de censo de simpatizantes', 'Patricia Morales Vega', 'BAJA', '2026-07-08', 'Se acordó reportar avances a coordinación general', 'Terminada', 100, '2026-07-14', '', 'Confirmar logística del próximo evento', 3, '2026-07-08 11:41:00', '2026-07-08 11:41:00'),
(12, 'mrob05lx379a', '2026-09-27', 'Reunión de evaluación semanal', 'Sofía Guerrero', 'BAJA', '2026-09-24', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 40, '2026-09-30', 'Sin observaciones, todo en orden', 'Actualizar base de datos de simpatizantes', 3, '2026-09-27 16:31:00', '2026-09-27 16:31:00'),
(13, 'mro8rye7hl7i', '2026-09-13', 'Coordinación de logística para evento masivo', 'Laura Ramírez Cruz', 'MEDIA', '2026-09-11', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 70, '2026-09-15', 'Se detectaron observaciones menores', 'Reunión de seguimiento la próxima semana', 1, '2026-09-13 18:56:00', '2026-09-13 18:56:00'),
(14, 'mroap0r8nayx', '2026-09-07', 'Reunión con sector educativo', 'Juan Pérez López', 'BAJA', '2026-09-07', 'Se acordó revisar presupuesto asignado', '', 80, '2026-09-16', 'Se requiere validación del coordinador general', 'Programar siguiente recorrido', 0, '2026-09-07 17:12:00', '2026-09-07 17:12:00'),
(15, 'mrob13mnv4y8', '2026-08-01', 'Levantamiento de censo de simpatizantes', 'Verónica Romero', 'BAJA', '2026-07-30', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 25, '2026-08-05', 'Se detectaron observaciones menores', 'Reunión de seguimiento la próxima semana', 3, '2026-08-01 17:05:00', '2026-08-01 17:05:00'),
(16, 'mro9grhfnsxs', '2026-06-24', 'Capacitación a brigadistas', 'Patricia Morales Vega', 'ALTA', '2026-06-20', 'Se acordó dar continuidad la próxima semana', 'Terminada', 100, '2026-06-28', 'Actividad reprogramada por logística', 'Programar siguiente recorrido', 1, '2026-06-24 19:19:00', '2026-06-24 19:19:00'),
(17, 'mrobaupml4wf', '2026-09-28', 'Instalación de espectacularess', 'Verónica Romero', 'ALTA', '2026-09-27', 'Se acordó reportar avances a coordinación general', 'Pendiente', 0, '2026-09-29', 'Se solicitó apoyo adicional al equipo', '', 3, '2026-09-28 11:04:00', '2026-07-20 16:38:03'),
(18, 'mro9azz5mrqt', '2026-07-02', 'Gestión de transporte para brigadistas', 'María González Ruiz', 'BAJA', '2026-06-29', 'Se acordó dar continuidad la próxima semana', '', 100, '2026-07-06', 'Se dará seguimiento la próxima semana', 'Actualizar base de datos de simpatizantes', 2, '2026-07-02 09:06:00', '2026-07-02 09:06:00'),
(19, 'mro9cnbtbhtf', '2026-05-28', 'Gestión de transporte para brigadistas', 'Carlos Hernández Díaz', 'MEDIA', '2026-05-27', 'Se acordó reportar avances a coordinación general', 'Pendiente', 25, '2026-06-06', 'Pendiente confirmación de asistentes', 'Programar siguiente recorrido', 0, '2026-05-28 15:08:00', '2026-05-28 15:08:00'),
(20, 'mro9ge873ao0', '2026-05-24', 'Visita a mercado municipal', 'José Luis Jiménez', 'MEDIA', '2026-05-23', 'Se acordó revisar presupuesto asignado', '', 20, '2026-06-01', 'Sin observaciones, todo en orden', '', 3, '2026-05-24 15:13:00', '2026-05-24 15:13:00'),
(21, 'mro8r0kp3k33', '2026-06-09', 'Seguimiento a redes sociales', 'Verónica Romero', 'BAJA', '2026-06-08', 'Se acordó reportar avances a coordinación general', 'Pendiente', 30, '2026-06-10', 'Se solicitó apoyo adicional al equipo', 'Programar siguiente recorrido', 0, '2026-06-09 17:47:00', '2026-06-09 17:47:00'),
(22, 'mro8m2pdf25q', '2026-06-17', 'Reunión con representantes de casilla', 'Eduardo Navarro', 'BAJA', '2026-06-17', 'Se acordó reportar avances a coordinación general', 'Pendiente', 75, '2026-06-21', 'Actividad reprogramada por logística', 'Confirmar logística del próximo evento', 1, '2026-06-17 14:07:00', '2026-06-17 14:07:00'),
(23, 'mro9yk8ztk40', '2026-07-20', 'Gestión de permisos municipales', 'Mónica Delgado', 'BAJA', '2026-07-19', 'Se acordó dar continuidad la próxima semana', '', 30, '2026-07-23', 'Pendiente confirmación de asistentes', 'Reunión de seguimiento la próxima semana', 1, '2026-07-20 18:41:00', '2026-07-20 18:41:00'),
(24, 'mroa19ehasyj', '2026-09-07', 'Reunión con equipo jurídico', 'Alberto Chávez', 'ALTA', '2026-09-05', 'Se acordó reportar avances a coordinación general', '', 20, '2026-09-09', 'Se detectaron observaciones menores', '', 0, '2026-09-07 11:23:00', '2026-09-07 11:23:00'),
(25, 'mroa1ubedldg', '2026-06-04', 'Elaboración de material de campaña', 'Verónica Romero', 'MEDIA', '2026-06-02', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 10, '2026-06-13', 'Pendiente confirmación de asistentes', '', 3, '2026-06-04 10:17:00', '2026-06-04 10:17:00'),
(26, 'mroang61szrz', '2026-07-10', 'Reunión con líderes vecinales', 'Ana Martínez Silva', 'ALTA', '2026-07-10', 'Se acordó reforzar la zona con más brigadistas', '', 0, '2026-07-13', '', 'Programar siguiente recorrido', 2, '2026-07-10 18:16:00', '2026-07-10 18:16:00'),
(27, 'mro9mxre2mdf', '2026-09-27', 'Reunión con representantes de casilla', 'Ana Martínez Silva', 'MEDIA', '2026-09-23', 'Se acordó reportar avances a coordinación general', '', 20, '2026-09-30', 'Sin observaciones, todo en orden', 'Reunión de seguimiento la próxima semana', 1, '2026-09-27 08:19:00', '2026-09-27 08:19:00'),
(28, 'mro9srwjqfha', '2026-06-30', 'Reunión de evaluación semanal', 'Ana Martínez Silva', 'MEDIA', '2026-06-29', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 100, '2026-07-07', 'Se requiere validación del coordinador general', 'Enviar reporte a coordinación general', 1, '2026-06-30 08:11:00', '2026-06-30 08:11:00'),
(29, 'mroahryuplh4', '2026-08-26', 'Entrega de apoyos sociales', 'José Luis Jiménez', 'MEDIA', '2026-08-24', 'Se acordó reportar avances a coordinación general', 'Pendiente', 30, '2026-08-30', 'Sin observaciones, todo en orden', '', 2, '2026-08-26 08:42:00', '2026-08-26 08:42:00'),
(30, 'mroax0dqrmkr', '2026-05-08', 'Reunión con equipo jurídico', 'Alberto Chávez', 'ALTA', '2026-05-08', 'Sin acuerdos adicionales', 'Pendiente', 30, '2026-05-18', 'Avance conforme a lo planeado', 'Confirmar logística del próximo evento', 0, '2026-05-08 12:02:00', '2026-05-08 12:02:00'),
(31, 'mrob3x4blk7j', '2026-08-20', 'Elaboración de material de campaña', 'Gabriela Ortiz Reyes', 'BAJA', '2026-08-20', 'Sin acuerdos adicionales', 'Terminada', 100, '2026-08-24', 'Actividad reprogramada por logística', 'Actualizar base de datos de simpatizantes', 2, '2026-08-20 13:27:00', '2026-08-20 13:27:00'),
(32, 'mroal7m2jpz0', '2026-09-19', 'Actualización de padrón de voluntarios', 'Gabriela Ortiz Reyes', 'ALTA', '2026-09-18', 'Sin acuerdos adicionales', '', 25, '2026-09-26', 'Actividad reprogramada por logística', 'Actualizar base de datos de simpatizantes', 3, '2026-09-19 18:47:00', '2026-09-19 18:47:00'),
(33, 'mrob196liwl5', '2026-08-22', 'Planeación de cierre de campaña', 'Patricia Morales Vega', 'BAJA', '2026-08-17', 'Se acordó revisar presupuesto asignado', 'Terminada', 100, '2026-08-30', 'Avance conforme a lo planeado', 'Enviar reporte a coordinación general', 1, '2026-08-22 19:10:00', '2026-08-22 19:10:00'),
(34, 'mro9dzhmcovp', '2026-05-07', 'Reunión con comité de campaña', 'Roberto Sánchez Torres', 'BAJA', '2026-05-07', 'Se acordó dar continuidad la próxima semana', '', 25, '2026-05-17', 'Pendiente confirmación de asistentes', 'Actualizar base de datos de simpatizantes', 1, '2026-05-07 09:29:00', '2026-05-07 09:29:00'),
(35, 'mroauoist8tx', '2026-06-15', 'Análisis de encuesta de percepción', 'Mónica Delgado', 'MEDIA', '2026-06-10', 'Sin acuerdos adicionales', '', 70, '2026-06-16', '', 'Actualizar base de datos de simpatizantes', 3, '2026-06-15 16:15:00', '2026-06-15 16:15:00'),
(36, 'mroa2n35xvfh', '2026-06-10', 'Gestión de permisos municipales', 'Carlos Hernández Díaz', 'BAJA', '2026-06-05', 'Se acordó revisar presupuesto asignado', '', 60, '2026-06-15', 'Avance conforme a lo planeado', 'Confirmar logística del próximo evento', 2, '2026-06-10 11:53:00', '2026-06-10 11:53:00'),
(37, 'mroap0z6d4qq', '2026-07-21', 'Perifoneo en zona centro', 'Claudia Ríos', 'MEDIA', '2026-07-17', 'Sin acuerdos adicionales', 'Pendiente', 10, '2026-07-24', 'Se dará seguimiento la próxima semana', 'Enviar reporte a coordinación general', 3, '2026-07-21 11:24:00', '2026-07-21 11:24:00'),
(38, 'mrobffvimjoq', '2026-08-08', 'Análisis de encuesta de percepción', 'Claudia Ríos', 'BAJA', '2026-08-04', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 90, '2026-08-18', 'Se requiere validación del coordinador general', 'Enviar reporte a coordinación general', 2, '2026-08-08 14:30:00', '2026-08-08 14:30:00'),
(39, 'mro9ft0rat8y', '2026-08-20', 'Reunión con líderes vecinales', 'Ricardo Mendoza', 'BAJA', '2026-08-17', 'Se acordó reportar avances a coordinación general', '', 0, '2026-08-26', 'Se dará seguimiento la próxima semana', 'Programar siguiente recorrido', 3, '2026-08-20 18:43:00', '2026-08-20 18:43:00'),
(40, 'mroaeg0ytklo', '2026-06-04', 'Instalación de espectaculares', 'Sofía Guerrero', 'MEDIA', '2026-06-01', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 20, '2026-06-09', 'Se requiere validación del coordinador general', 'Programar siguiente recorrido', 0, '2026-06-04 14:20:00', '2026-06-04 14:20:00'),
(41, 'mroagnmz19f8', '2026-07-29', 'Reunión con medios de comunicación', 'Ana Martínez Silva', 'BAJA', '2026-07-28', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 80, '2026-07-30', 'Se requiere validación del coordinador general', '', 2, '2026-07-29 08:15:00', '2026-07-29 08:15:00'),
(42, 'mroax2cj1jop', '2026-08-03', 'Capacitación electoral', 'Miguel Ángel Flores', 'ALTA', '2026-08-02', 'Se acordó reportar avances a coordinación general', 'Terminada', 100, '2026-08-05', 'Avance conforme a lo planeado', 'Programar siguiente recorrido', 2, '2026-08-03 10:19:00', '2026-08-03 10:19:00'),
(43, 'mro9lvg44wl0', '2026-05-31', 'Gestión de transporte para brigadistas', 'Sofía Guerrero', 'MEDIA', '2026-05-27', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 100, '2026-06-06', 'Sin observaciones, todo en orden', 'Confirmar logística del próximo evento', 3, '2026-05-31 16:27:00', '2026-05-31 16:27:00'),
(44, 'mro8rqm0utrh', '2026-06-09', 'Perifoneo en zona centro', 'Patricia Morales Vega', 'ALTA', '2026-06-06', 'Se acordó revisar presupuesto asignado', 'Terminada', 100, '2026-06-18', 'Se requiere validación del coordinador general', 'Enviar reporte a coordinación general', 3, '2026-06-09 18:17:00', '2026-06-09 18:17:00'),
(45, 'mro9u2blbvdm', '2026-09-23', 'Reunión de evaluación semanal', 'José Luis Jiménez', 'MEDIA', '2026-09-19', 'Se acordó revisar presupuesto asignado', '', 80, '2026-09-29', 'Se detectaron observaciones menores', 'Reunión de seguimiento la próxima semana', 0, '2026-09-23 08:31:00', '2026-09-23 08:31:00'),
(46, 'mroa9ahuuvs1', '2026-09-10', 'Entrega de trípticos informativos', 'Gabriela Ortiz Reyes', 'ALTA', '2026-09-09', 'Sin acuerdos adicionales', 'Pendiente', 10, '2026-09-17', 'Avance conforme a lo planeado', 'Confirmar logística del próximo evento', 2, '2026-09-10 15:35:00', '2026-09-10 15:35:00'),
(47, 'mro9t0xfmthj', '2026-08-30', 'Instalación de espectaculares', 'Patricia Morales Vega', 'ALTA', '2026-08-26', 'Se acordó reforzar la zona con más brigadistas', '', 70, '2026-09-06', 'Actividad reprogramada por logística', 'Programar siguiente recorrido', 1, '2026-08-30 19:35:00', '2026-08-30 19:35:00'),
(48, 'mro8u684i6ci', '2026-06-19', 'Reunión con comité de campaña', 'Alejandra Vázquez', 'ALTA', '2026-06-18', 'Se acordó revisar presupuesto asignado', '', 90, '2026-06-24', 'Se dará seguimiento la próxima semana', '', 1, '2026-06-19 19:37:00', '2026-06-19 19:37:00'),
(49, 'mro908qd60iu', '2026-07-10', 'Reunión con medios de comunicación', 'Daniel Aguilar', 'MEDIA', '2026-07-10', 'Se acordó reforzar la zona con más brigadistas', 'Terminada', 100, '2026-07-15', 'Se dará seguimiento la próxima semana', 'Confirmar logística del próximo evento', 3, '2026-07-10 19:08:00', '2026-07-10 19:08:00'),
(50, 'mrob6v1k99j5', '2026-05-30', 'Reunión con comité de campaña', 'Ana Martínez Silva', 'BAJA', '2026-05-30', 'Sin acuerdos adicionales', '', 50, '2026-06-01', 'Avance conforme a lo planeado', 'Reunión de seguimiento la próxima semana', 3, '2026-05-30 17:40:00', '2026-05-30 17:40:00'),
(51, 'mrob5o6q6ddg', '2026-08-24', 'Reunión con representantes de casilla', 'Carlos Hernández Díaz', 'ALTA', '2026-08-21', 'Se acordó reforzar la zona con más brigadistas', 'Terminada', 100, '2026-08-31', 'Se solicitó apoyo adicional al equipo', 'Reunión de seguimiento la próxima semana', 0, '2026-08-24 12:36:00', '2026-08-24 12:36:00'),
(52, 'mrobamrseiit', '2026-06-10', 'Entrega de trípticos informativos', 'Patricia Morales Vega', 'MEDIA', '2026-06-10', 'Se acordó reportar avances a coordinación general', '', 50, '2026-06-20', 'Avance conforme a lo planeado', 'Actualizar base de datos de simpatizantes', 0, '2026-06-10 15:18:00', '2026-06-10 15:18:00'),
(53, 'mrob5s0qajis', '2026-09-17', 'Capacitación a brigadistas', 'Daniel Aguilar', 'BAJA', '2026-09-16', 'Se acordó revisar presupuesto asignado', 'Pendiente', 80, '2026-09-22', 'Sin observaciones, todo en orden', 'Confirmar logística del próximo evento', 3, '2026-09-17 10:04:00', '2026-09-17 10:04:00'),
(54, 'mroa7hhg15e1', '2026-08-21', 'Entrega de apoyos sociales', 'José Luis Jiménez', 'BAJA', '2026-08-21', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 75, '2026-08-28', 'Se solicitó apoyo adicional al equipo', 'Actualizar base de datos de simpatizantes', 3, '2026-08-21 19:20:00', '2026-08-21 19:20:00'),
(55, 'mro9pxsmqlk6', '2026-07-11', 'Gestión de transporte para brigadistas', 'Laura Ramírez Cruz', 'MEDIA', '2026-07-10', 'Sin acuerdos adicionales', '', 75, '2026-07-19', 'Se requiere validación del coordinador general', 'Confirmar logística del próximo evento', 3, '2026-07-11 09:30:00', '2026-07-11 09:30:00'),
(56, 'mroavnpqpw0y', '2026-09-18', 'Gestión de permisos municipales', 'Sofía Guerrero', 'ALTA', '2026-09-18', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 60, '2026-09-24', '', 'Confirmar logística del próximo evento', 3, '2026-09-18 12:20:00', '2026-09-18 12:20:00'),
(57, 'mroa0pprsv71', '2026-08-22', 'Verificación de gastos de campaña', 'Mónica Delgado', 'ALTA', '2026-08-22', 'Se acordó reforzar la zona con más brigadistas', '', 25, '2026-08-31', 'Se detectaron observaciones menores', 'Reunión de seguimiento la próxima semana', 0, '2026-08-22 10:59:00', '2026-08-22 10:59:00'),
(58, 'mroaotfjviwh', '2026-09-19', 'Coordinación de logística para evento masivo', 'Verónica Romero', 'MEDIA', '2026-09-16', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 10, '2026-09-21', 'Se requiere validación del coordinador general', 'Reunión de seguimiento la próxima semana', 1, '2026-09-19 15:07:00', '2026-09-19 15:07:00'),
(59, 'mro9dw8tlwh0', '2026-08-07', 'Actualización de padrón de voluntarios', 'Gabriela Ortiz Reyes', 'BAJA', '2026-08-06', 'Se acordó reportar avances a coordinación general', 'Terminada', 100, '2026-08-10', 'Se requiere validación del coordinador general', 'Enviar reporte a coordinación general', 3, '2026-08-07 09:17:00', '2026-08-07 09:17:00'),
(60, 'mro96mqfkcfo', '2026-09-15', 'Reunión con comité de campaña', 'Sofía Guerrero', 'ALTA', '2026-09-12', 'Se acordó revisar presupuesto asignado', '', 40, '2026-09-24', 'Se requiere validación del coordinador general', '', 3, '2026-09-15 16:24:00', '2026-09-15 16:24:00'),
(61, 'mroatsvwwl6s', '2026-08-07', 'Capacitación a brigadistas', 'Alberto Chávez', 'MEDIA', '2026-08-02', 'Se acordó dar continuidad la próxima semana', 'Terminada', 100, '2026-08-10', 'Se solicitó apoyo adicional al equipo', 'Actualizar base de datos de simpatizantes', 1, '2026-08-07 15:02:00', '2026-08-07 15:02:00'),
(62, 'mro9h1935lyo', '2026-05-20', 'Perifoneo en zona centro', 'Verónica Romero', 'BAJA', '2026-05-17', 'Se acordó dar continuidad la próxima semana', '', 100, '2026-05-26', 'Pendiente confirmación de asistentes', 'Enviar reporte a coordinación general', 2, '2026-05-20 17:44:00', '2026-05-20 17:44:00'),
(63, 'mroayfhjsaj1', '2026-06-28', 'Recorrido casa por casa', 'Fernando Castillo Nuño', 'ALTA', '2026-06-23', 'Se acordó revisar presupuesto asignado', '', 10, '2026-06-30', 'Actividad reprogramada por logística', 'Confirmar logística del próximo evento', 3, '2026-06-28 18:45:00', '2026-06-28 18:45:00'),
(64, 'mroak4l4ab5o', '2026-06-07', 'Reunión con equipo jurídico', 'Patricia Morales Vega', 'MEDIA', '2026-06-06', 'Se acordó reportar avances a coordinación general', '', 70, '2026-06-17', 'Se solicitó apoyo adicional al equipo', 'Enviar reporte a coordinación general', 3, '2026-06-07 18:50:00', '2026-06-07 18:50:00'),
(65, 'mroa0sadya4s', '2026-07-05', 'Reunión con sector comercial', 'Eduardo Navarro', 'MEDIA', '2026-07-02', 'Sin acuerdos adicionales', 'Terminada', 100, '2026-07-06', 'Se detectaron observaciones menores', 'Actualizar base de datos de simpatizantes', 2, '2026-07-05 15:57:00', '2026-07-05 15:57:00'),
(66, 'mro9nylvii1p', '2026-06-20', 'Instalación de espectaculares', 'Juan Pérez López', 'BAJA', '2026-06-17', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 60, '2026-06-24', 'Se requiere validación del coordinador general', 'Confirmar logística del próximo evento', 1, '2026-06-20 14:36:00', '2026-06-20 14:36:00'),
(67, 'mroarwpj62js', '2026-07-30', 'Recorrido casa por casa', 'Eduardo Navarro', 'MEDIA', '2026-07-29', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 80, '2026-08-09', 'Pendiente confirmación de asistentes', 'Confirmar logística del próximo evento', 2, '2026-07-30 12:43:00', '2026-07-30 12:43:00'),
(68, 'mro8ya2rhagu', '2026-08-15', 'Reunión de evaluación semanal', 'Gabriela Ortiz Reyes', 'BAJA', '2026-08-14', 'Se acordó revisar presupuesto asignado', 'Pendiente', 25, '2026-08-24', 'Pendiente confirmación de asistentes', 'Actualizar base de datos de simpatizantes', 0, '2026-08-15 13:33:00', '2026-08-15 13:33:00'),
(69, 'mrob09jbp0gy', '2026-06-06', 'Capacitación a brigadistas', 'Daniel Aguilar', 'MEDIA', '2026-06-05', 'Se acordó revisar presupuesto asignado', 'Terminada', 100, '2026-06-13', 'Sin observaciones, todo en orden', '', 2, '2026-06-06 16:23:00', '2026-06-06 16:23:00'),
(70, 'mro8nk80ke4t', '2026-05-28', 'Reunión con sector educativo', 'Gabriela Ortiz Reyes', 'BAJA', '2026-05-23', 'Sin acuerdos adicionales', '', 25, '2026-05-29', 'Pendiente confirmación de asistentes', 'Enviar reporte a coordinación general', 0, '2026-05-28 17:56:00', '2026-05-28 17:56:00'),
(71, 'mro8runz8otn', '2026-05-10', 'Reunión con representantes de casilla', 'Claudia Ríos', 'MEDIA', '2026-05-08', 'Se acordó reportar avances a coordinación general', 'Pendiente', 60, '2026-05-12', 'Se solicitó apoyo adicional al equipo', 'Actualizar base de datos de simpatizantes', 0, '2026-05-10 11:56:00', '2026-05-10 11:56:00'),
(72, 'mroadfpwssfn', '2026-09-03', 'Capacitación a brigadistas', 'Alejandra Vázquez', 'BAJA', '2026-08-30', 'Se acordó revisar presupuesto asignado', '', 50, '2026-09-04', 'Se dará seguimiento la próxima semana', 'Actualizar base de datos de simpatizantes', 2, '2026-09-03 19:23:00', '2026-09-03 19:23:00'),
(73, 'mrobcnsr3lf8', '2026-06-18', 'Reunión de evaluación semanal', 'Eduardo Navarro', 'ALTA', '2026-06-18', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 60, '2026-06-22', '', 'Enviar reporte a coordinación general', 1, '2026-06-18 18:40:00', '2026-06-18 18:40:00'),
(74, 'mroaqhio8ygb', '2026-06-29', 'Capacitación a brigadistas', 'Juan Pérez López', 'ALTA', '2026-06-27', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 100, '2026-07-09', 'Actividad reprogramada por logística', 'Enviar reporte a coordinación general', 2, '2026-06-29 08:17:00', '2026-06-29 08:17:00'),
(75, 'mro8twul74us', '2026-05-05', 'Entrega de apoyos sociales', 'Alejandra Vázquez', 'BAJA', '2026-05-04', 'Se acordó reportar avances a coordinación general', 'Pendiente', 30, '2026-05-08', 'Pendiente confirmación de asistentes', 'Actualizar base de datos de simpatizantes', 1, '2026-05-05 19:26:00', '2026-05-05 19:26:00'),
(76, 'mrobawes3upr', '2026-05-12', 'Reunión con representantes de casilla', 'Ana Martínez Silva', 'MEDIA', '2026-05-07', 'Sin acuerdos adicionales', 'Terminada', 100, '2026-05-21', 'Pendiente confirmación de asistentes', 'Programar siguiente recorrido', 2, '2026-05-12 12:29:00', '2026-05-12 12:29:00'),
(77, 'mro8pwp3koxi', '2026-06-07', 'Gestión de permisos municipales', 'Alberto Chávez', 'BAJA', '2026-06-07', 'Sin acuerdos adicionales', '', 20, '2026-06-17', 'Pendiente confirmación de asistentes', '', 0, '2026-06-07 18:37:00', '2026-06-07 18:37:00'),
(78, 'mro9rk8mtpq6', '2026-09-19', 'Perifoneo en zona centro', 'Sofía Guerrero', 'MEDIA', '2026-09-14', 'Se acordó revisar presupuesto asignado', '', 25, '2026-09-27', 'Actividad reprogramada por logística', 'Enviar reporte a coordinación general', 3, '2026-09-19 11:26:00', '2026-09-19 11:26:00'),
(79, 'mro9li0f8z3z', '2026-05-18', 'Análisis de encuesta de percepción', 'Fernando Castillo Nuño', 'BAJA', '2026-05-18', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 10, '2026-05-25', 'Sin observaciones, todo en orden', 'Confirmar logística del próximo evento', 3, '2026-05-18 09:47:00', '2026-05-18 09:47:00'),
(80, 'mro8x9prd9ue', '2026-05-14', 'Gestión de transporte para brigadistas', 'Ana Martínez Silva', 'MEDIA', '2026-05-12', 'Se acordó reportar avances a coordinación general', '', 75, '2026-05-20', 'Actividad reprogramada por logística', 'Programar siguiente recorrido', 2, '2026-05-14 09:36:00', '2026-05-14 09:36:00'),
(81, 'mro8oefo1h1b', '2026-09-24', 'Instalación de espectaculares', 'Gabriela Ortiz Reyes', 'MEDIA', '2026-09-23', 'Se acordó revisar presupuesto asignado', '', 100, '2026-10-03', 'Se dará seguimiento la próxima semana', 'Enviar reporte a coordinación general', 1, '2026-09-24 17:39:00', '2026-09-24 17:39:00'),
(82, 'mrobazlt5xdo', '2026-09-22', 'Coordinación de logística para evento masivo', 'Daniel Aguilar', 'MEDIA', '2026-09-17', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 50, '2026-09-25', 'Actividad reprogramada por logística', 'Confirmar logística del próximo evento', 2, '2026-09-22 19:40:00', '2026-09-22 19:40:00'),
(83, 'mrob7jxx5hsr', '2026-09-23', 'Reunión con medios de comunicación', 'Mónica Delgado', 'MEDIA', '2026-09-19', 'Sin acuerdos adicionales', 'Pendiente', 10, '2026-09-26', 'Se detectaron observaciones menores', 'Enviar reporte a coordinación general', 0, '2026-09-23 10:48:00', '2026-09-23 10:48:00'),
(84, 'mro9x1qi2ep3', '2026-07-28', 'Reunión con líderes vecinales', 'Miguel Ángel Flores', 'MEDIA', '2026-07-25', 'Se acordó reforzar la zona con más brigadistas', '', 10, '2026-08-07', 'Se solicitó apoyo adicional al equipo', 'Confirmar logística del próximo evento', 2, '2026-07-28 15:33:00', '2026-07-28 15:33:00'),
(85, 'mro9k52oyewz', '2026-07-23', 'Planeación de cierre de campaña', 'Alejandra Vázquez', 'ALTA', '2026-07-23', 'Sin acuerdos adicionales', '', 0, '2026-07-30', 'Se dará seguimiento la próxima semana', 'Actualizar base de datos de simpatizantes', 0, '2026-07-23 10:08:00', '2026-07-23 10:08:00'),
(86, 'mro9defpi7p1', '2026-08-26', 'Perifoneo en zona centro', 'Laura Ramírez Cruz', 'BAJA', '2026-08-26', 'Sin acuerdos adicionales', 'Terminada', 100, '2026-09-02', 'Actividad reprogramada por logística', 'Programar siguiente recorrido', 3, '2026-08-26 17:25:00', '2026-08-26 17:25:00'),
(87, 'mro9hcd4jlel', '2026-05-28', 'Entrega de apoyos sociales', 'Laura Ramírez Cruz', 'ALTA', '2026-05-27', 'Se acordó reportar avances a coordinación general', 'Terminada', 100, '2026-06-04', 'Pendiente confirmación de asistentes', 'Reunión de seguimiento la próxima semana', 1, '2026-05-28 16:05:00', '2026-05-28 16:05:00'),
(88, 'mroaq65ggcb9', '2026-07-29', 'Entrega de apoyos sociales', 'Carlos Hernández Díaz', 'ALTA', '2026-07-27', 'Sin acuerdos adicionales', 'Terminada', 100, '2026-08-01', 'Se requiere validación del coordinador general', 'Reunión de seguimiento la próxima semana', 3, '2026-07-29 11:06:00', '2026-07-29 11:06:00'),
(89, 'mroapcxts4us', '2026-09-22', 'Verificación de gastos de campaña', 'Gabriela Ortiz Reyes', 'MEDIA', '2026-09-17', 'Se acordó reportar avances a coordinación general', 'Terminada', 100, '2026-09-28', 'Se dará seguimiento la próxima semana', 'Confirmar logística del próximo evento', 0, '2026-09-22 18:20:00', '2026-09-22 18:20:00'),
(90, 'mroa0vvn45wo', '2026-07-19', 'Gestión de permisos municipales', 'Eduardo Navarro', 'BAJA', '2026-07-16', 'Se acordó dar continuidad la próxima semana', 'Pendiente', 60, '2026-07-20', 'Se requiere validación del coordinador general', 'Reunión de seguimiento la próxima semana', 1, '2026-07-19 13:53:00', '2026-07-19 13:53:00'),
(91, 'mroaxw3rl5wb', '2026-07-22', 'Recorrido casa por casa', 'Patricia Morales Vega', 'BAJA', '2026-07-18', 'Sin acuerdos adicionales', 'Terminada', 100, '2026-07-25', 'Se requiere validación del coordinador general', 'Reunión de seguimiento la próxima semana', 1, '2026-07-22 08:28:00', '2026-07-22 08:28:00'),
(92, 'mrob733el4l6', '2026-08-02', 'Análisis de encuesta de percepción', 'Ricardo Mendoza', 'MEDIA', '2026-07-31', 'Se acordó revisar presupuesto asignado', '', 30, '2026-08-09', 'Se solicitó apoyo adicional al equipo', 'Confirmar logística del próximo evento', 0, '2026-08-02 13:43:00', '2026-08-02 13:43:00'),
(93, 'mro9i10m85jz', '2026-09-27', 'Visita a mercado municipal', 'Fernando Castillo Nuño', 'ALTA', '2026-09-22', 'Se acordó reportar avances a coordinación general', '', 20, '2026-10-02', 'Pendiente confirmación de asistentes', '', 3, '2026-09-27 18:44:00', '2026-09-27 18:44:00'),
(94, 'mro9r241vce8', '2026-09-08', 'Levantamiento de censo de simpatizantes', 'Carlos Hernández Díaz', 'MEDIA', '2026-09-06', 'Se acordó dar continuidad la próxima semana', '', 0, '2026-09-13', '', 'Reunión de seguimiento la próxima semana', 0, '2026-09-08 10:13:00', '2026-09-08 10:13:00'),
(95, 'mroajzhaas2q', '2026-07-26', 'Reunión con sector comercial', 'Patricia Morales Vega', 'MEDIA', '2026-07-22', 'Se acordó reportar avances a coordinación general', 'Terminada', 100, '2026-08-02', 'Se detectaron observaciones menores', '', 3, '2026-07-26 10:10:00', '2026-07-26 10:10:00'),
(96, 'mro8lxw3stio', '2026-06-29', 'Elaboración de material de campaña', 'Alberto Chávez', 'MEDIA', '2026-06-25', 'Se acordó reforzar la zona con más brigadistas', '', 25, '2026-07-07', 'Avance conforme a lo planeado', 'Reunión de seguimiento la próxima semana', 1, '2026-06-29 11:23:00', '2026-06-29 11:23:00'),
(97, 'mroay20ax7i5', '2026-07-04', 'Entrega de apoyos sociales', 'Laura Ramírez Cruz', 'MEDIA', '2026-07-04', 'Sin acuerdos adicionales', '', 80, '2026-07-10', '', 'Enviar reporte a coordinación general', 3, '2026-07-04 16:59:00', '2026-07-04 16:59:00'),
(98, 'mro9h7wzwnfo', '2026-05-24', 'Entrega de trípticos informativos', 'Alejandra Vázquez', 'ALTA', '2026-05-23', 'Se acordó dar continuidad la próxima semana', '', 60, '2026-05-25', 'Actividad reprogramada por logística', 'Programar siguiente recorrido', 2, '2026-05-24 14:03:00', '2026-05-24 14:03:00'),
(99, 'mroarjoeus05', '2026-06-07', 'Reunión con líderes vecinales', 'José Luis Jiménez', 'ALTA', '2026-06-06', 'Se acordó reforzar la zona con más brigadistas', '', 0, '2026-06-15', '', '', 3, '2026-06-07 19:53:00', '2026-06-07 19:53:00'),
(100, 'mro9d0n0t47v', '2026-05-29', 'Reunión con equipo jurídico', 'Claudia Ríos', 'ALTA', '2026-05-27', 'Se acordó reportar avances a coordinación general', '', 25, '2026-05-31', 'Avance conforme a lo planeado', '', 1, '2026-05-29 08:15:00', '2026-05-29 08:15:00'),
(101, 'mro9dlq5b5xn', '2026-07-14', 'Entrega de trípticos informativos', 'Alberto Chávez', 'BAJA', '2026-07-11', 'Se acordó reportar avances a coordinación general', 'Terminada', 100, '2026-07-20', '', 'Reunión de seguimiento la próxima semana', 0, '2026-07-14 11:36:00', '2026-07-14 11:36:00'),
(102, 'mrobdkwqm4mf', '2026-08-08', 'Visita a comunidad rural', 'Ana Martínez Silva', 'BAJA', '2026-08-05', 'Se acordó revisar presupuesto asignado', 'Terminada', 100, '2026-08-15', 'Se solicitó apoyo adicional al equipo', 'Programar siguiente recorrido', 2, '2026-08-08 13:16:00', '2026-08-08 13:16:00'),
(103, 'mroajq7l84t2', '2026-09-17', 'Actualización de padrón de voluntarios', 'Miguel Ángel Flores', 'ALTA', '2026-09-15', 'Se acordó reforzar la zona con más brigadistas', 'Pendiente', 80, '2026-09-25', 'Se dará seguimiento la próxima semana', 'Confirmar logística del próximo evento', 2, '2026-09-17 19:30:00', '2026-09-17 19:30:00'),
(104, 'mroai534im3l', '2026-09-09', 'Instalación de espectaculares', 'Ana Martínez Silva', 'MEDIA', '2026-09-06', 'Sin acuerdos adicionales', '', 70, '2026-09-14', 'Sin observaciones, todo en orden', '', 3, '2026-09-09 08:48:00', '2026-09-09 08:48:00'),
(105, 'mro8v4xfh5r5', '2026-08-07', 'Coordinación de logística para evento masivo', 'Mónica Delgado', 'ALTA', '2026-08-05', 'Se acordó reportar avances a coordinación general', '', 20, '2026-08-15', 'Se detectaron observaciones menores', 'Confirmar logística del próximo evento', 0, '2026-08-07 13:59:00', '2026-08-07 13:59:00'),
(106, 'mroi23rcoq6m', NULL, 'dfdfdf', '', 'ALTA', NULL, '', 'Pendiente', 0, NULL, '', '', 0, '2026-07-16 23:30:53', '2026-07-16 23:30:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campaign_brm`
--

CREATE TABLE `campaign_brm` (
  `id` int(11) NOT NULL,
  `uid` varchar(40) NOT NULL,
  `nombre` varchar(250) NOT NULL DEFAULT '',
  `telefono` varchar(20) DEFAULT NULL,
  `zona` varchar(150) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `ine_photo` longtext DEFAULT NULL,
  `selfie_photo` longtext DEFAULT NULL,
  `consent` tinyint(1) NOT NULL DEFAULT 0,
  `userid` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campaign_eventos`
--

CREATE TABLE `campaign_eventos` (
  `id` int(11) NOT NULL,
  `uid` varchar(40) NOT NULL,
  `tipo` varchar(150) NOT NULL DEFAULT 'Mitin',
  `fecha` date DEFAULT NULL,
  `lugar` varchar(250) DEFAULT NULL,
  `responsable` varchar(250) DEFAULT NULL,
  `participantes` int(11) NOT NULL DEFAULT 0,
  `estatus` enum('Programado','Realizado','Cancelado') NOT NULL DEFAULT 'Programado',
  `descripcion` text DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `campaign_eventos`
--

INSERT INTO `campaign_eventos` (`id`, `uid`, `tipo`, `fecha`, `lugar`, `responsable`, `participantes`, `estatus`, `descripcion`, `userid`, `created_at`, `updated_at`) VALUES
(605, 'mro8ow145ko0', 'Encuesta', '2026-09-20', 'San Pablo Yaganiza', 'Sofía Guerrero', 50, 'Programado', 'Presentación de propuestas de campañasdfsdf', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(606, 'mroalq0f5vrl', 'Encuesta', '2026-09-19', 'San Andrés Sinaxtla', 'Alberto Chávez', 500, 'Programado', 'Evento de acercamiento con la comunidad', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(607, 'mroateix6pnl', 'Entrega de beneficios', '2026-09-18', 'Santa Cruz Acatepec', 'Roberto Sánchez Torres', 25, 'Cancelado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(608, 'mrob4ndsjrf3', 'Entrega de beneficios', '2026-09-15', 'San Mateo Peñasco', 'Carlos Hernández Díaz', 500, 'Realizado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(609, 'mroba03vpvbi', 'Mitin', '2026-09-14', 'Heroica Villa Tezoatlán de Segura y Luna, Cuna de la Independencia de Oaxaca', 'Juan Pérez López', 30, 'Programado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(610, 'mro8n3mu73zw', 'Encuesta', '2026-09-12', 'San Juan Mixtepec', 'Eduardo Navarro', 80, 'Cancelado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(611, 'mroauurcr8u4', 'Encuesta', '2026-09-10', 'San Lucas Quiaviní', 'Ricardo Mendoza', 15, 'Programado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(612, 'mroabzx9mxi5', 'Reunión', '2026-09-10', 'San Mateo Yucutindoo', 'Miguel Ángel Flores', 120, 'Realizado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(613, 'mrob5vl2h88f', 'Mitin', '2026-09-09', 'San Francisco Telixtlahuaca', 'Fernando Castillo Nuño', 300, 'Programado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(614, 'mrob89p8uno9', 'Mitin', '2026-09-08', 'San Juan Bautista Tlachichilco', 'María González Ruiz', 80, 'Programado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(615, 'mro8s2b2y9h5', 'Encuesta', '2026-09-06', 'San Pedro Mártir Yucuxaco', 'Carlos Hernández Díaz', 80, 'Realizado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(616, 'mroarpk4xdzk', 'Encuesta', '2026-09-06', 'Santiago Tilantongo', 'Alberto Chávez', 50, 'Cancelado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(617, 'mro9snnkuxt9', 'Mitin', '2026-09-06', 'Santos Reyes Nopala', 'Roberto Sánchez Torres', 40, 'Programado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(618, 'mro8mm1oanag', 'Encuesta', '2026-09-05', 'San Antonino Monte Verde', 'Eduardo Navarro', 120, 'Cancelado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(619, 'mro8hr014x0n', 'Encuesta', '2026-09-04', 'San Pedro Tapanatepec', 'Roberto Sánchez Torres', 50, 'Programado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(620, 'mro9e269os45', 'Reunión', '2026-09-03', 'Santa María Ixcatlán', 'Alberto Chávez', 150, 'Cancelado', 'Reunión con líderes comunitarios', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(621, 'mro8izto7mmt', 'Entrega de beneficios', '2026-09-03', 'San Juan Bautista Atatlahuca', 'Gabriela Ortiz Reyes', 500, 'Cancelado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(622, 'mro9hvz6n7cy', 'Reunión', '2026-09-03', 'San Juan Bautista Tlacoatzintepec', 'Claudia Ríos', 10, 'Realizado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(623, 'mroa3dbfi7yo', 'Entrega de beneficios', '2026-09-03', 'Santa María Cortijo', 'Alejandra Vázquez', 200, 'Realizado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(624, 'mroaidcy7ufd', 'Reunión', '2026-08-31', 'Santa María Ecatepec', 'Patricia Morales Vega', 80, 'Realizado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(625, 'mroa506tucfh', 'Entrega de beneficios', '2026-08-26', 'San Pedro Huamelula', 'Patricia Morales Vega', 30, 'Cancelado', 'Reunión con líderes comunitarios', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(626, 'mroakyf97080', 'Mitin', '2026-08-25', 'San José Chiltepec', 'Verónica Romero', 40, 'Realizado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(627, 'mroazsg4tm4y', 'Encuesta', '2026-08-25', 'Santa María Guelacé', 'Miguel Ángel Flores', 50, 'Realizado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(628, 'mro9x4mz1pg0', 'Mitin', '2026-08-25', 'San Juan del Estado', 'Eduardo Navarro', 15, 'Cancelado', 'Evento de acercamiento con la comunidad', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(629, 'mroaiae93ho2', 'Entrega de beneficios', '2026-08-24', 'Pinotepa de Don Luis', 'Miguel Ángel Flores', 200, 'Programado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(630, 'mro8yjyp9m1u', 'Entrega de beneficios', '2026-08-23', 'San Antonio Acutla', 'Gabriela Ortiz Reyes', 50, 'Realizado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(631, 'mro9dbsky2ny', 'Encuesta', '2026-08-23', 'San Agustín Yatareni', 'Ana Martínez Silva', 200, 'Cancelado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(632, 'mroasthqjah5', 'Encuesta', '2026-08-21', 'Santa Catarina Quioquitani', 'José Luis Jiménez', 15, 'Programado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(633, 'mro8yrhm8jfg', 'Entrega de beneficios', '2026-08-21', 'San Jacinto Amilpas', 'Sofía Guerrero', 200, 'Cancelado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(634, 'mrob14niif45', 'Reunión', '2026-08-19', 'San Miguel Santa Flor', 'Roberto Sánchez Torres', 50, 'Cancelado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(635, 'mroale12zavi', 'Reunión', '2026-08-17', 'San Francisco Jaltepetongo', 'Laura Ramírez Cruz', 40, 'Realizado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(636, 'mroaue60omrk', 'Encuesta', '2026-08-14', 'San Francisco Jaltepetongo', 'Patricia Morales Vega', 30, 'Programado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(637, 'mro9wo9wk5zt', 'Mitin', '2026-08-11', 'Ayoquezco de Aldama', 'Alejandra Vázquez', 25, 'Realizado', 'Reunión con líderes comunitarios', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(638, 'mro9x406snh6', 'Entrega de beneficios', '2026-08-08', 'San Felipe Tejalápam', 'Carlos Hernández Díaz', 20, 'Realizado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(639, 'mroa5ibfnwvt', 'Encuesta', '2026-08-06', 'San Andrés Tepetlapa', 'Verónica Romero', 200, 'Cancelado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(640, 'mro8rklm8m7b', 'Encuesta', '2026-08-05', 'Villa Díaz Ordaz', 'Ricardo Mendoza', 80, 'Programado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(641, 'mroacr3391gz', 'Entrega de beneficios', '2026-08-03', 'Santa María Tecomavaca', 'Gabriela Ortiz Reyes', 20, 'Realizado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(642, 'mro96qdynqzu', 'Reunión', '2026-08-03', 'Villa Díaz Ordaz', 'Miguel Ángel Flores', 200, 'Programado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(643, 'mro8ixi340gd', 'Reunión', '2026-08-02', 'Huautepec', 'María González Ruiz', 200, 'Realizado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(644, 'mro8m02ezcnz', 'Encuesta', '2026-08-02', 'San Pablo Macuiltianguis', 'Carlos Hernández Díaz', 50, 'Realizado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(645, 'mrob119z4jpu', 'Entrega de beneficios', '2026-08-01', 'Teococuilco de Marcos Pérez', 'Sofía Guerrero', 200, 'Realizado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(646, 'mro97n42nns4', 'Encuesta', '2026-08-01', 'San Francisco Chindúa', 'Alberto Chávez', 40, 'Cancelado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(647, 'mro9ji67zwvq', 'Mitin', '2026-07-31', 'Santo Domingo Armenta', 'Sofía Guerrero', 150, 'Realizado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(648, 'mro960dgfej5', 'Entrega de beneficios', '2026-07-30', 'Guadalupe de Ramírez', 'Carlos Hernández Díaz', 50, 'Realizado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(649, 'mro9f4se9job', 'Encuesta', '2026-07-28', 'Villa Díaz Ordaz', 'Verónica Romero', 25, 'Cancelado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(650, 'mro93nr42iqb', 'Mitin', '2026-07-28', 'San Francisco Cajonos', 'Sofía Guerrero', 40, 'Cancelado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(651, 'mro8zqdq8wth', 'Entrega de beneficios', '2026-07-25', 'San Juan Guelavía', 'Ana Martínez Silva', 40, 'Realizado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(652, 'mroas28ejkcu', 'Encuesta', '2026-07-24', 'San Pedro Pochutla', 'Laura Ramírez Cruz', 50, 'Realizado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(653, 'mrobbqufuge3', 'Mitin', '2026-07-24', 'Santiago Tlazoyaltepec', 'Laura Ramírez Cruz', 80, 'Realizado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(654, 'mro8josfv5ws', 'Encuesta', '2026-07-23', 'Magdalena Tequisistlán', 'Daniel Aguilar', 20, 'Programado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(655, 'mro8vzo3tvjv', 'Entrega de beneficios', '2026-07-23', 'Cosolapa', 'Carlos Hernández Díaz', 50, 'Programado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(656, 'mroa7ymd963i', 'Reunión', '2026-07-21', 'Santa Lucía Ocotlán', 'Mónica Delgado', 50, 'Realizado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(657, 'mroaslie94x0', 'Entrega de beneficios', '2026-07-20', 'San José Estancia Grande', 'Daniel Aguilar', 40, 'Realizado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(658, 'mrob0wb6s7fd', 'Mitin', '2026-07-16', 'Santa Ana del Valle', 'Mónica Delgado', 120, 'Realizado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(659, 'mro8ze5cct68', 'Encuesta', '2026-07-16', 'San Pedro Jocotipac', 'Juan Pérez López', 50, 'Programado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(660, 'mroal8hhnwe7', 'Reunión', '2026-07-16', 'San Juan Lalana', 'Roberto Sánchez Torres', 25, 'Cancelado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(661, 'mrob3809sbs5', 'Encuesta', '2026-07-13', 'San Pedro Teutila', 'Alejandra Vázquez', 150, 'Programado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(662, 'mro8yt5yxoz7', 'Reunión', '2026-07-11', 'San Miguel Huautla', 'José Luis Jiménez', 150, 'Programado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(663, 'mroifw2j9zxg', 'Reunión', '2026-07-09', 'El vigia', 'Abner Gonzalez', 40, 'Programado', 'Sisga', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(664, 'mroat211vl32', 'Entrega de beneficios', '2026-07-08', 'San Andrés Yaá', 'Daniel Aguilar', 10, 'Realizado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(665, 'mroava3atjap', 'Entrega de beneficios', '2026-07-06', 'Santo Domingo Tlatayápam', 'Gabriela Ortiz Reyes', 150, 'Cancelado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(666, 'mro9zhq1cbpr', 'Reunión', '2026-07-05', 'Santos Reyes Nopala', 'Fernando Castillo Nuño', 15, 'Programado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(667, 'mro9yaubdxwc', 'Entrega de beneficios', '2026-07-03', 'Santa María Chilchotla', 'Gabriela Ortiz Reyes', 120, 'Cancelado', 'Evento de acercamiento con la comunidad', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(668, 'mroadh0a38wi', 'Mitin', '2026-07-02', 'San Martín Huamelúlpam', 'Eduardo Navarro', 40, 'Realizado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(669, 'mroa1y6vvuiy', 'Reunión', '2026-07-01', 'Ayoquezco de Aldama', 'Ana Martínez Silva', 50, 'Cancelado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(670, 'mro9e6h6jh3z', 'Entrega de beneficios', '2026-06-30', 'San Juan Bautista Guelache', 'Sofía Guerrero', 80, 'Programado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(671, 'mro8pj6olgvv', 'Encuesta', '2026-06-28', 'Santiago Llano Grande', 'Laura Ramírez Cruz', 150, 'Cancelado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(672, 'mroa3rk14n7w', 'Entrega de beneficios', '2026-06-27', 'Magdalena Ocotlán', 'Laura Ramírez Cruz', 25, 'Programado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(673, 'mroa24k1y2bk', 'Encuesta', '2026-06-24', 'Ciudad Ixtepec', 'Miguel Ángel Flores', 100, 'Realizado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(674, 'mro8qfyvijuf', 'Encuesta', '2026-06-23', 'Santa María Jaltianguis', 'Gabriela Ortiz Reyes', 60, 'Cancelado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(675, 'mrobdq1yfd46', 'Mitin', '2026-06-18', 'Guevea de Humboldt', 'Daniel Aguilar', 100, 'Programado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(676, 'mroa5ncaofsh', 'Reunión', '2026-06-17', 'San Pedro y San Pablo Tequixtepec', 'Gabriela Ortiz Reyes', 100, 'Realizado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(677, 'mroavb6i1lrh', 'Entrega de beneficios', '2026-06-12', 'Taniche', 'Carlos Hernández Díaz', 30, 'Programado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(678, 'mrobanp6heyi', 'Mitin', '2026-06-12', 'San José del Peñasco', 'Daniel Aguilar', 100, 'Cancelado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(679, 'mro9goq0lr60', 'Mitin', '2026-06-12', 'San Andrés Tepetlapa', 'José Luis Jiménez', 25, 'Cancelado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(680, 'mro9s22ywwyv', 'Encuesta', '2026-06-11', 'San Pedro Huilotepec', 'Verónica Romero', 300, 'Cancelado', 'Evento de acercamiento con la comunidad', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(681, 'mro9rdd19kkm', 'Encuesta', '2026-06-10', 'Santa María Guienagati', 'Roberto Sánchez Torres', 200, 'Realizado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(682, 'mroai8fp1skq', 'Reunión', '2026-06-07', 'San Ildefonso Sola', 'Sofía Guerrero', 150, 'Programado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(683, 'mroafcc4xumu', 'Entrega de beneficios', '2026-06-06', 'San Andrés Teotilálpam', 'Daniel Aguilar', 150, 'Realizado', 'Evento masivo de arranque de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(684, 'mro8oc6gx8of', 'Encuesta', '2026-06-06', 'San Miguel Aloápam', 'Miguel Ángel Flores', 40, 'Programado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(685, 'mro9pglryhya', 'Reunión', '2026-06-05', 'San Pedro Yaneri', 'Gabriela Ortiz Reyes', 30, 'Programado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(686, 'mrob5z64x243', 'Encuesta', '2026-06-05', 'Asunción Ocotlán', 'Sofía Guerrero', 20, 'Programado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(687, 'mroa8xyu3xee', 'Mitin', '2026-06-05', 'Magdalena Ocotlán', 'Ana Martínez Silva', 50, 'Cancelado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(688, 'mroajmj8n9wo', 'Entrega de beneficios', '2026-06-04', 'Santa María Temaxcalapa', 'Mónica Delgado', 20, 'Programado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(689, 'mroam7sm9al2', 'Entrega de beneficios', '2026-06-02', 'Eloxochitlán de Flores Magón', 'Carlos Hernández Díaz', 10, 'Cancelado', '', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(690, 'mro8vim0m8zb', 'Entrega de beneficios', '2026-06-02', 'San Dionisio del Mar', 'Sofía Guerrero', 80, 'Cancelado', 'Evento de acercamiento con la comunidad', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(691, 'mro8hg4tpk1h', 'Encuesta', '2026-05-26', 'Santiago Ihuitlán Plumas', 'Verónica Romero', 25, 'Programado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(692, 'mro9309mucik', 'Reunión', '2026-05-26', 'San Pablo Etla', 'María González Ruiz', 500, 'Programado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(693, 'mro9bx7easms', 'Entrega de beneficios', '2026-05-21', 'Ixtlán de Juárez', 'Alejandra Vázquez', 100, 'Cancelado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(694, 'mro9ikfmylo8', 'Entrega de beneficios', '2026-05-20', 'Salina Cruz', 'Alberto Chávez', 150, 'Programado', 'Actividad de cierre de campaña en la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(695, 'mrobch4zl6af', 'Entrega de beneficios', '2026-05-18', 'Santos Reyes Pápalo', 'Laura Ramírez Cruz', 80, 'Programado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(696, 'mro9lfpm3uv1', 'Reunión', '2026-05-18', 'Asunción Ocotlán', 'Claudia Ríos', 80, 'Programado', 'Recorrido y saludo con vecinos', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(697, 'mro8wa9xa19s', 'Mitin', '2026-05-15', 'Heroica Ciudad de Ejutla de Crespo', 'Roberto Sánchez Torres', 15, 'Cancelado', 'Levantamiento de encuesta de percepción ciudadana', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(698, 'mroaafs9r560', 'Encuesta', '2026-05-14', 'San Juan Teposcolula', 'Verónica Romero', 15, 'Cancelado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(699, 'mro98zykgudc', 'Entrega de beneficios', '2026-05-11', 'Villa Hidalgo Yalálag', 'José Luis Jiménez', 500, 'Cancelado', 'Foro de propuestas con jóvenes', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(700, 'mro9b4cvb66x', 'Entrega de beneficios', '2026-05-05', 'San Francisco del Mar', 'Patricia Morales Vega', 25, 'Cancelado', 'Encuentro con sector productivo local', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(701, 'mrob5ada6ybn', 'Reunión', '2026-05-02', 'San Pedro Yólox', 'Miguel Ángel Flores', 60, 'Programado', 'Presentación de propuestas de campaña', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10'),
(702, 'mro8qnaqryoe', 'Mitin', '2026-05-01', 'San Mateo Sindihui', 'Daniel Aguilar', 40, 'Realizado', 'Entrega de apoyos a familias de la zona', 1, '2026-07-20 11:03:10', '2026-07-20 11:03:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_zonas`
--

CREATE TABLE `cat_zonas` (
  `id` int(10) UNSIGNED NOT NULL,
  `cve_geo` varchar(5) NOT NULL,
  `cve_ent` varchar(2) NOT NULL,
  `cve_mun` varchar(3) NOT NULL,
  `nombre_municipio` varchar(100) NOT NULL,
  `nombre_entidad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cat_zonas`
--

INSERT INTO `cat_zonas` (`id`, `cve_geo`, `cve_ent`, `cve_mun`, `nombre_municipio`, `nombre_entidad`) VALUES
(1, '20001', '20', '001', 'Abejones', 'Oaxaca'),
(2, '20002', '20', '002', 'Acatlán de Pérez Figueroa', 'Oaxaca'),
(3, '20003', '20', '003', 'Asunción Cacalotepec', 'Oaxaca'),
(4, '20004', '20', '004', 'Asunción Cuyotepeji', 'Oaxaca'),
(5, '20005', '20', '005', 'Asunción Ixtaltepec', 'Oaxaca'),
(6, '20006', '20', '006', 'Asunción Nochixtlán', 'Oaxaca'),
(7, '20007', '20', '007', 'Asunción Ocotlán', 'Oaxaca'),
(8, '20008', '20', '008', 'Asunción Tlacolulita', 'Oaxaca'),
(9, '20009', '20', '009', 'Ayotzintepec', 'Oaxaca'),
(10, '20010', '20', '010', 'El Barrio de la Soledad', 'Oaxaca'),
(11, '20011', '20', '011', 'Calihualá', 'Oaxaca'),
(12, '20012', '20', '012', 'Candelaria Loxicha', 'Oaxaca'),
(13, '20013', '20', '013', 'Ciénega de Zimatlán', 'Oaxaca'),
(14, '20014', '20', '014', 'Ciudad Ixtepec', 'Oaxaca'),
(15, '20015', '20', '015', 'Coatecas Altas', 'Oaxaca'),
(16, '20016', '20', '016', 'Coicoyán de las Flores', 'Oaxaca'),
(17, '20017', '20', '017', 'La Compañía', 'Oaxaca'),
(18, '20018', '20', '018', 'Concepción Buenavista', 'Oaxaca'),
(19, '20019', '20', '019', 'Concepción Pápalo', 'Oaxaca'),
(20, '20020', '20', '020', 'Constancia del Rosario', 'Oaxaca'),
(21, '20021', '20', '021', 'Cosolapa', 'Oaxaca'),
(22, '20022', '20', '022', 'Cosoltepec', 'Oaxaca'),
(23, '20023', '20', '023', 'Cuilápam de Guerrero', 'Oaxaca'),
(24, '20024', '20', '024', 'Cuyamecalco Villa de Zaragoza', 'Oaxaca'),
(25, '20025', '20', '025', 'Chahuites', 'Oaxaca'),
(26, '20026', '20', '026', 'Chalcatongo de Hidalgo', 'Oaxaca'),
(27, '20027', '20', '027', 'Chiquihuitlán de Benito Juárez', 'Oaxaca'),
(28, '20028', '20', '028', 'Heroica Ciudad de Ejutla de Crespo', 'Oaxaca'),
(29, '20029', '20', '029', 'Eloxochitlán de Flores Magón', 'Oaxaca'),
(30, '20030', '20', '030', 'El Espinal', 'Oaxaca'),
(31, '20031', '20', '031', 'Tamazulápam del Espíritu Santo', 'Oaxaca'),
(32, '20032', '20', '032', 'Fresnillo de Trujano', 'Oaxaca'),
(33, '20033', '20', '033', 'Guadalupe Etla', 'Oaxaca'),
(34, '20034', '20', '034', 'Guadalupe de Ramírez', 'Oaxaca'),
(35, '20035', '20', '035', 'Guelatao de Juárez', 'Oaxaca'),
(36, '20036', '20', '036', 'Guevea de Humboldt', 'Oaxaca'),
(37, '20037', '20', '037', 'Mesones Hidalgo', 'Oaxaca'),
(38, '20038', '20', '038', 'Villa Hidalgo Yalálag', 'Oaxaca'),
(39, '20039', '20', '039', 'Heroica Ciudad de Huajuapan de León', 'Oaxaca'),
(40, '20040', '20', '040', 'Huautepec', 'Oaxaca'),
(41, '20041', '20', '041', 'Huautla de Jiménez', 'Oaxaca'),
(42, '20042', '20', '042', 'Ixtlán de Juárez', 'Oaxaca'),
(43, '20043', '20', '043', 'Juchitán de Zaragoza', 'Oaxaca'),
(44, '20044', '20', '044', 'Loma Bonita', 'Oaxaca'),
(45, '20045', '20', '045', 'Magdalena Apasco', 'Oaxaca'),
(46, '20046', '20', '046', 'Magdalena Jaltepec', 'Oaxaca'),
(47, '20047', '20', '047', 'Santa Magdalena Jicotlán', 'Oaxaca'),
(48, '20048', '20', '048', 'Magdalena Mixtepec', 'Oaxaca'),
(49, '20049', '20', '049', 'Magdalena Ocotlán', 'Oaxaca'),
(50, '20050', '20', '050', 'Magdalena Peñasco', 'Oaxaca'),
(51, '20051', '20', '051', 'Magdalena Teitipac', 'Oaxaca'),
(52, '20052', '20', '052', 'Magdalena Tequisistlán', 'Oaxaca'),
(53, '20053', '20', '053', 'Magdalena Tlacotepec', 'Oaxaca'),
(54, '20054', '20', '054', 'Magdalena Zahuatlán', 'Oaxaca'),
(55, '20055', '20', '055', 'Mariscala de Juárez', 'Oaxaca'),
(56, '20056', '20', '056', 'Mártires de Tacubaya', 'Oaxaca'),
(57, '20057', '20', '057', 'Matías Romero Avendaño', 'Oaxaca'),
(58, '20058', '20', '058', 'Mazatlán Villa de Flores', 'Oaxaca'),
(59, '20059', '20', '059', 'Miahuatlán de Porfirio Díaz', 'Oaxaca'),
(60, '20060', '20', '060', 'Mixistlán de la Reforma', 'Oaxaca'),
(61, '20061', '20', '061', 'Monjas', 'Oaxaca'),
(62, '20062', '20', '062', 'Natividad', 'Oaxaca'),
(63, '20063', '20', '063', 'Nazareno Etla', 'Oaxaca'),
(64, '20064', '20', '064', 'Nejapa de Madero', 'Oaxaca'),
(65, '20065', '20', '065', 'Ixpantepec Nieves', 'Oaxaca'),
(66, '20066', '20', '066', 'Santiago Niltepec', 'Oaxaca'),
(67, '20067', '20', '067', 'Oaxaca de Juárez', 'Oaxaca'),
(68, '20068', '20', '068', 'Ocotlán de Morelos', 'Oaxaca'),
(69, '20069', '20', '069', 'La Pe', 'Oaxaca'),
(70, '20070', '20', '070', 'Pinotepa de Don Luis', 'Oaxaca'),
(71, '20071', '20', '071', 'Pluma Hidalgo', 'Oaxaca'),
(72, '20072', '20', '072', 'San José del Progreso', 'Oaxaca'),
(73, '20073', '20', '073', 'Putla Villa de Guerrero', 'Oaxaca'),
(74, '20074', '20', '074', 'Santa Catarina Quioquitani', 'Oaxaca'),
(75, '20075', '20', '075', 'Reforma de Pineda', 'Oaxaca'),
(76, '20076', '20', '076', 'La Reforma', 'Oaxaca'),
(77, '20077', '20', '077', 'Reyes Etla', 'Oaxaca'),
(78, '20078', '20', '078', 'Rojas de Cuauhtémoc', 'Oaxaca'),
(79, '20079', '20', '079', 'Salina Cruz', 'Oaxaca'),
(80, '20080', '20', '080', 'San Agustín Amatengo', 'Oaxaca'),
(81, '20081', '20', '081', 'San Agustín Atenango', 'Oaxaca'),
(82, '20082', '20', '082', 'San Agustín Chayuco', 'Oaxaca'),
(83, '20083', '20', '083', 'San Agustín de las Juntas', 'Oaxaca'),
(84, '20084', '20', '084', 'San Agustín Etla', 'Oaxaca'),
(85, '20085', '20', '085', 'San Agustín Loxicha', 'Oaxaca'),
(86, '20086', '20', '086', 'San Agustín Tlacotepec', 'Oaxaca'),
(87, '20087', '20', '087', 'San Agustín Yatareni', 'Oaxaca'),
(88, '20088', '20', '088', 'San Andrés Cabecera Nueva', 'Oaxaca'),
(89, '20089', '20', '089', 'San Andrés Dinicuiti', 'Oaxaca'),
(90, '20090', '20', '090', 'San Andrés Huaxpaltepec', 'Oaxaca'),
(91, '20091', '20', '091', 'San Andrés Huayápam', 'Oaxaca'),
(92, '20092', '20', '092', 'San Andrés Ixtlahuaca', 'Oaxaca'),
(93, '20093', '20', '093', 'San Andrés Lagunas', 'Oaxaca'),
(94, '20094', '20', '094', 'San Andrés Nuxiño', 'Oaxaca'),
(95, '20095', '20', '095', 'San Andrés Paxtlán', 'Oaxaca'),
(96, '20096', '20', '096', 'San Andrés Sinaxtla', 'Oaxaca'),
(97, '20097', '20', '097', 'San Andrés Solaga', 'Oaxaca'),
(98, '20098', '20', '098', 'San Andrés Teotilálpam', 'Oaxaca'),
(99, '20099', '20', '099', 'San Andrés Tepetlapa', 'Oaxaca'),
(100, '20100', '20', '100', 'San Andrés Yaá', 'Oaxaca'),
(101, '20101', '20', '101', 'San Andrés Zabache', 'Oaxaca'),
(102, '20102', '20', '102', 'San Andrés Zautla', 'Oaxaca'),
(103, '20103', '20', '103', 'San Antonino Castillo Velasco', 'Oaxaca'),
(104, '20104', '20', '104', 'San Antonino el Alto', 'Oaxaca'),
(105, '20105', '20', '105', 'San Antonino Monte Verde', 'Oaxaca'),
(106, '20106', '20', '106', 'San Antonio Acutla', 'Oaxaca'),
(107, '20107', '20', '107', 'San Antonio de la Cal', 'Oaxaca'),
(108, '20108', '20', '108', 'San Antonio Huitepec', 'Oaxaca'),
(109, '20109', '20', '109', 'San Antonio Nanahuatípam', 'Oaxaca'),
(110, '20110', '20', '110', 'San Antonio Sinicahua', 'Oaxaca'),
(111, '20111', '20', '111', 'San Antonio Tepetlapa', 'Oaxaca'),
(112, '20112', '20', '112', 'San Baltazar Chichicápam', 'Oaxaca'),
(113, '20113', '20', '113', 'San Baltazar Loxicha', 'Oaxaca'),
(114, '20114', '20', '114', 'San Baltazar Yatzachi el Bajo', 'Oaxaca'),
(115, '20115', '20', '115', 'San Bartolo Coyotepec', 'Oaxaca'),
(116, '20116', '20', '116', 'San Bartolomé Ayautla', 'Oaxaca'),
(117, '20117', '20', '117', 'San Bartolomé Loxicha', 'Oaxaca'),
(118, '20118', '20', '118', 'San Bartolomé Quialana', 'Oaxaca'),
(119, '20119', '20', '119', 'San Bartolomé Yucuañe', 'Oaxaca'),
(120, '20120', '20', '120', 'San Bartolomé Zoogocho', 'Oaxaca'),
(121, '20121', '20', '121', 'San Bartolo Soyaltepec', 'Oaxaca'),
(122, '20122', '20', '122', 'San Bartolo Yautepec', 'Oaxaca'),
(123, '20123', '20', '123', 'San Bernardo Mixtepec', 'Oaxaca'),
(124, '20124', '20', '124', 'Heroica Villa de San Blas Atempa', 'Oaxaca'),
(125, '20125', '20', '125', 'San Carlos Yautepec', 'Oaxaca'),
(126, '20126', '20', '126', 'San Cristóbal Amatlán', 'Oaxaca'),
(127, '20127', '20', '127', 'San Cristóbal Amoltepec', 'Oaxaca'),
(128, '20128', '20', '128', 'San Cristóbal Lachirioag', 'Oaxaca'),
(129, '20129', '20', '129', 'San Cristóbal Suchixtlahuaca', 'Oaxaca'),
(130, '20130', '20', '130', 'San Dionisio del Mar', 'Oaxaca'),
(131, '20131', '20', '131', 'San Dionisio Ocotepec', 'Oaxaca'),
(132, '20132', '20', '132', 'San Dionisio Ocotlán', 'Oaxaca'),
(133, '20133', '20', '133', 'San Esteban Atatlahuca', 'Oaxaca'),
(134, '20134', '20', '134', 'San Felipe Jalapa de Díaz', 'Oaxaca'),
(135, '20135', '20', '135', 'San Felipe Tejalápam', 'Oaxaca'),
(136, '20136', '20', '136', 'San Felipe Usila', 'Oaxaca'),
(137, '20137', '20', '137', 'San Francisco Cahuacuá', 'Oaxaca'),
(138, '20138', '20', '138', 'San Francisco Cajonos', 'Oaxaca'),
(139, '20139', '20', '139', 'San Francisco Chapulapa', 'Oaxaca'),
(140, '20140', '20', '140', 'San Francisco Chindúa', 'Oaxaca'),
(141, '20141', '20', '141', 'San Francisco del Mar', 'Oaxaca'),
(142, '20142', '20', '142', 'San Francisco Huehuetlán', 'Oaxaca'),
(143, '20143', '20', '143', 'San Francisco Ixhuatán', 'Oaxaca'),
(144, '20144', '20', '144', 'San Francisco Jaltepetongo', 'Oaxaca'),
(145, '20145', '20', '145', 'San Francisco Lachigoló', 'Oaxaca'),
(146, '20146', '20', '146', 'San Francisco Logueche', 'Oaxaca'),
(147, '20147', '20', '147', 'San Francisco Nuxaño', 'Oaxaca'),
(148, '20148', '20', '148', 'San Francisco Ozolotepec', 'Oaxaca'),
(149, '20149', '20', '149', 'San Francisco Sola', 'Oaxaca'),
(150, '20150', '20', '150', 'San Francisco Telixtlahuaca', 'Oaxaca'),
(151, '20151', '20', '151', 'San Francisco Teopan', 'Oaxaca'),
(152, '20152', '20', '152', 'San Francisco Tlapancingo', 'Oaxaca'),
(153, '20153', '20', '153', 'San Gabriel Mixtepec', 'Oaxaca'),
(154, '20154', '20', '154', 'San Ildefonso Amatlán', 'Oaxaca'),
(155, '20155', '20', '155', 'San Ildefonso Sola', 'Oaxaca'),
(156, '20156', '20', '156', 'San Ildefonso Villa Alta', 'Oaxaca'),
(157, '20157', '20', '157', 'San Jacinto Amilpas', 'Oaxaca'),
(158, '20158', '20', '158', 'San Jacinto Tlacotepec', 'Oaxaca'),
(159, '20159', '20', '159', 'San Jerónimo Coatlán', 'Oaxaca'),
(160, '20160', '20', '160', 'San Jerónimo Silacayoapilla', 'Oaxaca'),
(161, '20161', '20', '161', 'San Jerónimo Sosola', 'Oaxaca'),
(162, '20162', '20', '162', 'San Jerónimo Taviche', 'Oaxaca'),
(163, '20163', '20', '163', 'San Jerónimo Tecóatl', 'Oaxaca'),
(164, '20164', '20', '164', 'San Jorge Nuchita', 'Oaxaca'),
(165, '20165', '20', '165', 'San José Ayuquila', 'Oaxaca'),
(166, '20166', '20', '166', 'San José Chiltepec', 'Oaxaca'),
(167, '20167', '20', '167', 'San José del Peñasco', 'Oaxaca'),
(168, '20168', '20', '168', 'San José Estancia Grande', 'Oaxaca'),
(169, '20169', '20', '169', 'San José Independencia', 'Oaxaca'),
(170, '20170', '20', '170', 'San José Lachiguiri', 'Oaxaca'),
(171, '20171', '20', '171', 'San José Tenango', 'Oaxaca'),
(172, '20172', '20', '172', 'San Juan Achiutla', 'Oaxaca'),
(173, '20173', '20', '173', 'San Juan Atepec', 'Oaxaca'),
(174, '20174', '20', '174', 'Ánimas Trujano', 'Oaxaca'),
(175, '20175', '20', '175', 'San Juan Bautista Atatlahuca', 'Oaxaca'),
(176, '20176', '20', '176', 'San Juan Bautista Coixtlahuaca', 'Oaxaca'),
(177, '20177', '20', '177', 'San Juan Bautista Cuicatlán', 'Oaxaca'),
(178, '20178', '20', '178', 'San Juan Bautista Guelache', 'Oaxaca'),
(179, '20179', '20', '179', 'San Juan Bautista Jayacatlán', 'Oaxaca'),
(180, '20180', '20', '180', 'San Juan Bautista Lo de Soto', 'Oaxaca'),
(181, '20181', '20', '181', 'San Juan Bautista Suchitepec', 'Oaxaca'),
(182, '20182', '20', '182', 'San Juan Bautista Tlacoatzintepec', 'Oaxaca'),
(183, '20183', '20', '183', 'San Juan Bautista Tlachichilco', 'Oaxaca'),
(184, '20184', '20', '184', 'San Juan Bautista Tuxtepec', 'Oaxaca'),
(185, '20185', '20', '185', 'San Juan Cacahuatepec', 'Oaxaca'),
(186, '20186', '20', '186', 'San Juan Cieneguilla', 'Oaxaca'),
(187, '20187', '20', '187', 'San Juan Coatzóspam', 'Oaxaca'),
(188, '20188', '20', '188', 'San Juan Colorado', 'Oaxaca'),
(189, '20189', '20', '189', 'San Juan Comaltepec', 'Oaxaca'),
(190, '20190', '20', '190', 'San Juan Cotzocón', 'Oaxaca'),
(191, '20191', '20', '191', 'San Juan Chicomezúchil', 'Oaxaca'),
(192, '20192', '20', '192', 'San Juan Chilateca', 'Oaxaca'),
(193, '20193', '20', '193', 'San Juan del Estado', 'Oaxaca'),
(194, '20194', '20', '194', 'San Juan del Río', 'Oaxaca'),
(195, '20195', '20', '195', 'San Juan Diuxi', 'Oaxaca'),
(196, '20196', '20', '196', 'San Juan Evangelista Analco', 'Oaxaca'),
(197, '20197', '20', '197', 'San Juan Guelavía', 'Oaxaca'),
(198, '20198', '20', '198', 'San Juan Guichicovi', 'Oaxaca'),
(199, '20199', '20', '199', 'San Juan Ihualtepec', 'Oaxaca'),
(200, '20200', '20', '200', 'San Juan Juquila Mixes', 'Oaxaca'),
(201, '20201', '20', '201', 'San Juan Juquila Vijanos', 'Oaxaca'),
(202, '20202', '20', '202', 'San Juan Lachao', 'Oaxaca'),
(203, '20203', '20', '203', 'San Juan Lachigalla', 'Oaxaca'),
(204, '20204', '20', '204', 'San Juan Lajarcia', 'Oaxaca'),
(205, '20205', '20', '205', 'San Juan Lalana', 'Oaxaca'),
(206, '20206', '20', '206', 'San Juan de los Cués', 'Oaxaca'),
(207, '20207', '20', '207', 'San Juan Mazatlán', 'Oaxaca'),
(208, '20208', '20', '208', 'San Juan Mixtepec', 'Oaxaca'),
(209, '20209', '20', '209', 'San Juan Mixtepec', 'Oaxaca'),
(210, '20210', '20', '210', 'San Juan Ñumí', 'Oaxaca'),
(211, '20211', '20', '211', 'San Juan Ozolotepec', 'Oaxaca'),
(212, '20212', '20', '212', 'San Juan Petlapa', 'Oaxaca'),
(213, '20213', '20', '213', 'San Juan Quiahije', 'Oaxaca'),
(214, '20214', '20', '214', 'San Juan Quiotepec', 'Oaxaca'),
(215, '20215', '20', '215', 'San Juan Sayultepec', 'Oaxaca'),
(216, '20216', '20', '216', 'San Juan Tabaá', 'Oaxaca'),
(217, '20217', '20', '217', 'San Juan Tamazola', 'Oaxaca'),
(218, '20218', '20', '218', 'San Juan Teita', 'Oaxaca'),
(219, '20219', '20', '219', 'San Juan Teitipac', 'Oaxaca'),
(220, '20220', '20', '220', 'San Juan Tepeuxila', 'Oaxaca'),
(221, '20221', '20', '221', 'San Juan Teposcolula', 'Oaxaca'),
(222, '20222', '20', '222', 'San Juan Yaeé', 'Oaxaca'),
(223, '20223', '20', '223', 'San Juan Yatzona', 'Oaxaca'),
(224, '20224', '20', '224', 'San Juan Yucuita', 'Oaxaca'),
(225, '20225', '20', '225', 'San Lorenzo', 'Oaxaca'),
(226, '20226', '20', '226', 'San Lorenzo Albarradas', 'Oaxaca'),
(227, '20227', '20', '227', 'San Lorenzo Cacaotepec', 'Oaxaca'),
(228, '20228', '20', '228', 'San Lorenzo Cuaunecuiltitla', 'Oaxaca'),
(229, '20229', '20', '229', 'San Lorenzo Texmelúcan', 'Oaxaca'),
(230, '20230', '20', '230', 'San Lorenzo Victoria', 'Oaxaca'),
(231, '20231', '20', '231', 'San Lucas Camotlán', 'Oaxaca'),
(232, '20232', '20', '232', 'San Lucas Ojitlán', 'Oaxaca'),
(233, '20233', '20', '233', 'San Lucas Quiaviní', 'Oaxaca'),
(234, '20234', '20', '234', 'San Lucas Zoquiápam', 'Oaxaca'),
(235, '20235', '20', '235', 'San Luis Amatlán', 'Oaxaca'),
(236, '20236', '20', '236', 'San Marcial Ozolotepec', 'Oaxaca'),
(237, '20237', '20', '237', 'San Marcos Arteaga', 'Oaxaca'),
(238, '20238', '20', '238', 'San Martín de los Cansecos', 'Oaxaca'),
(239, '20239', '20', '239', 'San Martín Huamelúlpam', 'Oaxaca'),
(240, '20240', '20', '240', 'San Martín Itunyoso', 'Oaxaca'),
(241, '20241', '20', '241', 'San Martín Lachilá', 'Oaxaca'),
(242, '20242', '20', '242', 'San Martín Peras', 'Oaxaca'),
(243, '20243', '20', '243', 'San Martín Tilcajete', 'Oaxaca'),
(244, '20244', '20', '244', 'San Martín Toxpalan', 'Oaxaca'),
(245, '20245', '20', '245', 'San Martín Zacatepec', 'Oaxaca'),
(246, '20246', '20', '246', 'San Mateo Cajonos', 'Oaxaca'),
(247, '20247', '20', '247', 'Capulálpam de Méndez', 'Oaxaca'),
(248, '20248', '20', '248', 'San Mateo del Mar', 'Oaxaca'),
(249, '20249', '20', '249', 'San Mateo Yoloxochitlán', 'Oaxaca'),
(250, '20250', '20', '250', 'San Mateo Etlatongo', 'Oaxaca'),
(251, '20251', '20', '251', 'San Mateo Nejápam', 'Oaxaca'),
(252, '20252', '20', '252', 'San Mateo Peñasco', 'Oaxaca'),
(253, '20253', '20', '253', 'San Mateo Piñas', 'Oaxaca'),
(254, '20254', '20', '254', 'San Mateo Río Hondo', 'Oaxaca'),
(255, '20255', '20', '255', 'San Mateo Sindihui', 'Oaxaca'),
(256, '20256', '20', '256', 'San Mateo Tlapiltepec', 'Oaxaca'),
(257, '20257', '20', '257', 'San Melchor Betaza', 'Oaxaca'),
(258, '20258', '20', '258', 'San Miguel Achiutla', 'Oaxaca'),
(259, '20259', '20', '259', 'San Miguel Ahuehuetitlán', 'Oaxaca'),
(260, '20260', '20', '260', 'San Miguel Aloápam', 'Oaxaca'),
(261, '20261', '20', '261', 'San Miguel Amatitlán', 'Oaxaca'),
(262, '20262', '20', '262', 'San Miguel Amatlán', 'Oaxaca'),
(263, '20263', '20', '263', 'San Miguel Coatlán', 'Oaxaca'),
(264, '20264', '20', '264', 'San Miguel Chicahua', 'Oaxaca'),
(265, '20265', '20', '265', 'San Miguel Chimalapa', 'Oaxaca'),
(266, '20266', '20', '266', 'San Miguel del Puerto', 'Oaxaca'),
(267, '20267', '20', '267', 'San Miguel del Río', 'Oaxaca'),
(268, '20268', '20', '268', 'San Miguel Ejutla', 'Oaxaca'),
(269, '20269', '20', '269', 'San Miguel el Grande', 'Oaxaca'),
(270, '20270', '20', '270', 'San Miguel Huautla', 'Oaxaca'),
(271, '20271', '20', '271', 'San Miguel Mixtepec', 'Oaxaca'),
(272, '20272', '20', '272', 'San Miguel Panixtlahuaca', 'Oaxaca'),
(273, '20273', '20', '273', 'San Miguel Peras', 'Oaxaca'),
(274, '20274', '20', '274', 'San Miguel Piedras', 'Oaxaca'),
(275, '20275', '20', '275', 'San Miguel Quetzaltepec', 'Oaxaca'),
(276, '20276', '20', '276', 'San Miguel Santa Flor', 'Oaxaca'),
(277, '20277', '20', '277', 'Villa Sola de Vega', 'Oaxaca'),
(278, '20278', '20', '278', 'San Miguel Soyaltepec', 'Oaxaca'),
(279, '20279', '20', '279', 'San Miguel Suchixtepec', 'Oaxaca'),
(280, '20280', '20', '280', 'Villa Talea de Castro', 'Oaxaca'),
(281, '20281', '20', '281', 'San Miguel Tecomatlán', 'Oaxaca'),
(282, '20282', '20', '282', 'San Miguel Tenango', 'Oaxaca'),
(283, '20283', '20', '283', 'San Miguel Tequixtepec', 'Oaxaca'),
(284, '20284', '20', '284', 'San Miguel Tilquiápam', 'Oaxaca'),
(285, '20285', '20', '285', 'San Miguel Tlacamama', 'Oaxaca'),
(286, '20286', '20', '286', 'San Miguel Tlacotepec', 'Oaxaca'),
(287, '20287', '20', '287', 'San Miguel Tulancingo', 'Oaxaca'),
(288, '20288', '20', '288', 'San Miguel Yotao', 'Oaxaca'),
(289, '20289', '20', '289', 'San Nicolás', 'Oaxaca'),
(290, '20290', '20', '290', 'San Nicolás Hidalgo', 'Oaxaca'),
(291, '20291', '20', '291', 'San Pablo Coatlán', 'Oaxaca'),
(292, '20292', '20', '292', 'San Pablo Cuatro Venados', 'Oaxaca'),
(293, '20293', '20', '293', 'San Pablo Etla', 'Oaxaca'),
(294, '20294', '20', '294', 'San Pablo Huitzo', 'Oaxaca'),
(295, '20295', '20', '295', 'San Pablo Huixtepec', 'Oaxaca'),
(296, '20296', '20', '296', 'San Pablo Macuiltianguis', 'Oaxaca'),
(297, '20297', '20', '297', 'San Pablo Tijaltepec', 'Oaxaca'),
(298, '20298', '20', '298', 'San Pablo Villa de Mitla', 'Oaxaca'),
(299, '20299', '20', '299', 'San Pablo Yaganiza', 'Oaxaca'),
(300, '20300', '20', '300', 'San Pedro Amuzgos', 'Oaxaca'),
(301, '20301', '20', '301', 'San Pedro Apóstol', 'Oaxaca'),
(302, '20302', '20', '302', 'San Pedro Atoyac', 'Oaxaca'),
(303, '20303', '20', '303', 'San Pedro Cajonos', 'Oaxaca'),
(304, '20304', '20', '304', 'San Pedro Coxcaltepec Cántaros', 'Oaxaca'),
(305, '20305', '20', '305', 'San Pedro Comitancillo', 'Oaxaca'),
(306, '20306', '20', '306', 'San Pedro el Alto', 'Oaxaca'),
(307, '20307', '20', '307', 'San Pedro Huamelula', 'Oaxaca'),
(308, '20308', '20', '308', 'San Pedro Huilotepec', 'Oaxaca'),
(309, '20309', '20', '309', 'San Pedro Ixcatlán', 'Oaxaca'),
(310, '20310', '20', '310', 'San Pedro Ixtlahuaca', 'Oaxaca'),
(311, '20311', '20', '311', 'San Pedro Jaltepetongo', 'Oaxaca'),
(312, '20312', '20', '312', 'San Pedro Jicayán', 'Oaxaca'),
(313, '20313', '20', '313', 'San Pedro Jocotipac', 'Oaxaca'),
(314, '20314', '20', '314', 'San Pedro Juchatengo', 'Oaxaca'),
(315, '20315', '20', '315', 'San Pedro Mártir', 'Oaxaca'),
(316, '20316', '20', '316', 'San Pedro Mártir Quiechapa', 'Oaxaca'),
(317, '20317', '20', '317', 'San Pedro Mártir Yucuxaco', 'Oaxaca'),
(318, '20318', '20', '318', 'San Pedro Mixtepec', 'Oaxaca'),
(319, '20319', '20', '319', 'San Pedro Mixtepec', 'Oaxaca'),
(320, '20320', '20', '320', 'San Pedro Molinos', 'Oaxaca'),
(321, '20321', '20', '321', 'San Pedro Nopala', 'Oaxaca'),
(322, '20322', '20', '322', 'San Pedro Ocopetatillo', 'Oaxaca'),
(323, '20323', '20', '323', 'San Pedro Ocotepec', 'Oaxaca'),
(324, '20324', '20', '324', 'San Pedro Pochutla', 'Oaxaca'),
(325, '20325', '20', '325', 'San Pedro Quiatoni', 'Oaxaca'),
(326, '20326', '20', '326', 'San Pedro Sochiápam', 'Oaxaca'),
(327, '20327', '20', '327', 'San Pedro Tapanatepec', 'Oaxaca'),
(328, '20328', '20', '328', 'San Pedro Taviche', 'Oaxaca'),
(329, '20329', '20', '329', 'San Pedro Teozacoalco', 'Oaxaca'),
(330, '20330', '20', '330', 'San Pedro Teutila', 'Oaxaca'),
(331, '20331', '20', '331', 'San Pedro Tidaá', 'Oaxaca'),
(332, '20332', '20', '332', 'San Pedro Topiltepec', 'Oaxaca'),
(333, '20333', '20', '333', 'San Pedro Totolápam', 'Oaxaca'),
(334, '20334', '20', '334', 'Villa de Tututepec', 'Oaxaca'),
(335, '20335', '20', '335', 'San Pedro Yaneri', 'Oaxaca'),
(336, '20336', '20', '336', 'San Pedro Yólox', 'Oaxaca'),
(337, '20337', '20', '337', 'San Pedro y San Pablo Ayutla', 'Oaxaca'),
(338, '20338', '20', '338', 'Villa de Etla', 'Oaxaca'),
(339, '20339', '20', '339', 'San Pedro y San Pablo Teposcolula', 'Oaxaca'),
(340, '20340', '20', '340', 'San Pedro y San Pablo Tequixtepec', 'Oaxaca'),
(341, '20341', '20', '341', 'San Pedro Yucunama', 'Oaxaca'),
(342, '20342', '20', '342', 'San Raymundo Jalpan', 'Oaxaca'),
(343, '20343', '20', '343', 'San Sebastián Abasolo', 'Oaxaca'),
(344, '20344', '20', '344', 'San Sebastián Coatlán', 'Oaxaca'),
(345, '20345', '20', '345', 'San Sebastián Ixcapa', 'Oaxaca'),
(346, '20346', '20', '346', 'San Sebastián Nicananduta', 'Oaxaca'),
(347, '20347', '20', '347', 'San Sebastián Río Hondo', 'Oaxaca'),
(348, '20348', '20', '348', 'San Sebastián Tecomaxtlahuaca', 'Oaxaca'),
(349, '20349', '20', '349', 'San Sebastián Teitipac', 'Oaxaca'),
(350, '20350', '20', '350', 'San Sebastián Tutla', 'Oaxaca'),
(351, '20351', '20', '351', 'San Simón Almolongas', 'Oaxaca'),
(352, '20352', '20', '352', 'San Simón Zahuatlán', 'Oaxaca'),
(353, '20353', '20', '353', 'Santa Ana', 'Oaxaca'),
(354, '20354', '20', '354', 'Santa Ana Ateixtlahuaca', 'Oaxaca'),
(355, '20355', '20', '355', 'Santa Ana Cuauhtémoc', 'Oaxaca'),
(356, '20356', '20', '356', 'Santa Ana del Valle', 'Oaxaca'),
(357, '20357', '20', '357', 'Santa Ana Tavela', 'Oaxaca'),
(358, '20358', '20', '358', 'Santa Ana Tlapacoyan', 'Oaxaca'),
(359, '20359', '20', '359', 'Santa Ana Yareni', 'Oaxaca'),
(360, '20360', '20', '360', 'Santa Ana Zegache', 'Oaxaca'),
(361, '20361', '20', '361', 'Santa Catalina Quierí', 'Oaxaca'),
(362, '20362', '20', '362', 'Santa Catarina Cuixtla', 'Oaxaca'),
(363, '20363', '20', '363', 'Santa Catarina Ixtepeji', 'Oaxaca'),
(364, '20364', '20', '364', 'Santa Catarina Juquila', 'Oaxaca'),
(365, '20365', '20', '365', 'Santa Catarina Lachatao', 'Oaxaca'),
(366, '20366', '20', '366', 'Santa Catarina Loxicha', 'Oaxaca'),
(367, '20367', '20', '367', 'Santa Catarina Mechoacán', 'Oaxaca'),
(368, '20368', '20', '368', 'Santa Catarina Minas', 'Oaxaca'),
(369, '20369', '20', '369', 'Santa Catarina Quiané', 'Oaxaca'),
(370, '20370', '20', '370', 'Santa Catarina Tayata', 'Oaxaca'),
(371, '20371', '20', '371', 'Santa Catarina Ticuá', 'Oaxaca'),
(372, '20372', '20', '372', 'Santa Catarina Yosonotú', 'Oaxaca'),
(373, '20373', '20', '373', 'Santa Catarina Zapoquila', 'Oaxaca'),
(374, '20374', '20', '374', 'Santa Cruz Acatepec', 'Oaxaca'),
(375, '20375', '20', '375', 'Santa Cruz Amilpas', 'Oaxaca'),
(376, '20376', '20', '376', 'Santa Cruz de Bravo', 'Oaxaca'),
(377, '20377', '20', '377', 'Santa Cruz Itundujia', 'Oaxaca'),
(378, '20378', '20', '378', 'Santa Cruz Mixtepec', 'Oaxaca'),
(379, '20379', '20', '379', 'Santa Cruz Nundaco', 'Oaxaca'),
(380, '20380', '20', '380', 'Santa Cruz Papalutla', 'Oaxaca'),
(381, '20381', '20', '381', 'Santa Cruz Tacache de Mina', 'Oaxaca'),
(382, '20382', '20', '382', 'Santa Cruz Tacahua', 'Oaxaca'),
(383, '20383', '20', '383', 'Santa Cruz Tayata', 'Oaxaca'),
(384, '20384', '20', '384', 'Santa Cruz Xitla', 'Oaxaca'),
(385, '20385', '20', '385', 'Santa Cruz Xoxocotlán', 'Oaxaca'),
(386, '20386', '20', '386', 'Santa Cruz Zenzontepec', 'Oaxaca'),
(387, '20387', '20', '387', 'Santa Gertrudis', 'Oaxaca'),
(388, '20388', '20', '388', 'Santa Inés del Monte', 'Oaxaca'),
(389, '20389', '20', '389', 'Santa Inés Yatzeche', 'Oaxaca'),
(390, '20390', '20', '390', 'Santa Lucía del Camino', 'Oaxaca'),
(391, '20391', '20', '391', 'Santa Lucía Miahuatlán', 'Oaxaca'),
(392, '20392', '20', '392', 'Santa Lucía Monteverde', 'Oaxaca'),
(393, '20393', '20', '393', 'Santa Lucía Ocotlán', 'Oaxaca'),
(394, '20394', '20', '394', 'Santa María Alotepec', 'Oaxaca'),
(395, '20395', '20', '395', 'Santa María Apazco', 'Oaxaca'),
(396, '20396', '20', '396', 'Santa María la Asunción', 'Oaxaca'),
(397, '20397', '20', '397', 'Heroica Ciudad de Tlaxiaco', 'Oaxaca'),
(398, '20398', '20', '398', 'Ayoquezco de Aldama', 'Oaxaca'),
(399, '20399', '20', '399', 'Santa María Atzompa', 'Oaxaca'),
(400, '20400', '20', '400', 'Santa María Camotlán', 'Oaxaca'),
(401, '20401', '20', '401', 'Santa María Colotepec', 'Oaxaca'),
(402, '20402', '20', '402', 'Santa María Cortijo', 'Oaxaca'),
(403, '20403', '20', '403', 'Santa María Coyotepec', 'Oaxaca'),
(404, '20404', '20', '404', 'Santa María Chachoápam', 'Oaxaca'),
(405, '20405', '20', '405', 'Villa de Chilapa de Díaz', 'Oaxaca'),
(406, '20406', '20', '406', 'Santa María Chilchotla', 'Oaxaca'),
(407, '20407', '20', '407', 'Santa María Chimalapa', 'Oaxaca'),
(408, '20408', '20', '408', 'Santa María del Rosario', 'Oaxaca'),
(409, '20409', '20', '409', 'Santa María del Tule', 'Oaxaca'),
(410, '20410', '20', '410', 'Santa María Ecatepec', 'Oaxaca'),
(411, '20411', '20', '411', 'Santa María Guelacé', 'Oaxaca'),
(412, '20412', '20', '412', 'Santa María Guienagati', 'Oaxaca'),
(413, '20413', '20', '413', 'Santa María Huatulco', 'Oaxaca'),
(414, '20414', '20', '414', 'Santa María Huazolotitlán', 'Oaxaca'),
(415, '20415', '20', '415', 'Santa María Ipalapa', 'Oaxaca'),
(416, '20416', '20', '416', 'Santa María Ixcatlán', 'Oaxaca'),
(417, '20417', '20', '417', 'Santa María Jacatepec', 'Oaxaca'),
(418, '20418', '20', '418', 'Santa María Jalapa del Marqués', 'Oaxaca'),
(419, '20419', '20', '419', 'Santa María Jaltianguis', 'Oaxaca'),
(420, '20420', '20', '420', 'Santa María Lachixío', 'Oaxaca'),
(421, '20421', '20', '421', 'Santa María Mixtequilla', 'Oaxaca'),
(422, '20422', '20', '422', 'Santa María Nativitas', 'Oaxaca'),
(423, '20423', '20', '423', 'Santa María Nduayaco', 'Oaxaca'),
(424, '20424', '20', '424', 'Santa María Ozolotepec', 'Oaxaca'),
(425, '20425', '20', '425', 'Santa María Pápalo', 'Oaxaca'),
(426, '20426', '20', '426', 'Santa María Peñoles', 'Oaxaca'),
(427, '20427', '20', '427', 'Santa María Petapa', 'Oaxaca'),
(428, '20428', '20', '428', 'Santa María Quiegolani', 'Oaxaca'),
(429, '20429', '20', '429', 'Santa María Sola', 'Oaxaca'),
(430, '20430', '20', '430', 'Santa María Tataltepec', 'Oaxaca'),
(431, '20431', '20', '431', 'Santa María Tecomavaca', 'Oaxaca'),
(432, '20432', '20', '432', 'Santa María Temaxcalapa', 'Oaxaca'),
(433, '20433', '20', '433', 'Santa María Temaxcaltepec', 'Oaxaca'),
(434, '20434', '20', '434', 'Santa María Teopoxco', 'Oaxaca'),
(435, '20435', '20', '435', 'Santa María Tepantlali', 'Oaxaca'),
(436, '20436', '20', '436', 'Santa María Texcatitlán', 'Oaxaca'),
(437, '20437', '20', '437', 'Santa María Tlahuitoltepec', 'Oaxaca'),
(438, '20438', '20', '438', 'Santa María Tlalixtac', 'Oaxaca'),
(439, '20439', '20', '439', 'Santa María Tonameca', 'Oaxaca'),
(440, '20440', '20', '440', 'Santa María Totolapilla', 'Oaxaca'),
(441, '20441', '20', '441', 'Santa María Xadani', 'Oaxaca'),
(442, '20442', '20', '442', 'Santa María Yalina', 'Oaxaca'),
(443, '20443', '20', '443', 'Santa María Yavesía', 'Oaxaca'),
(444, '20444', '20', '444', 'Santa María Yolotepec', 'Oaxaca'),
(445, '20445', '20', '445', 'Santa María Yosoyúa', 'Oaxaca'),
(446, '20446', '20', '446', 'Santa María Yucuhiti', 'Oaxaca'),
(447, '20447', '20', '447', 'Santa María Zacatepec', 'Oaxaca'),
(448, '20448', '20', '448', 'Santa María Zaniza', 'Oaxaca'),
(449, '20449', '20', '449', 'Santa María Zoquitlán', 'Oaxaca'),
(450, '20450', '20', '450', 'Santiago Amoltepec', 'Oaxaca'),
(451, '20451', '20', '451', 'Santiago Apoala', 'Oaxaca'),
(452, '20452', '20', '452', 'Santiago Apóstol', 'Oaxaca'),
(453, '20453', '20', '453', 'Santiago Astata', 'Oaxaca'),
(454, '20454', '20', '454', 'Santiago Atitlán', 'Oaxaca'),
(455, '20455', '20', '455', 'Santiago Ayuquililla', 'Oaxaca'),
(456, '20456', '20', '456', 'Santiago Cacaloxtepec', 'Oaxaca'),
(457, '20457', '20', '457', 'Santiago Camotlán', 'Oaxaca'),
(458, '20458', '20', '458', 'Santiago Comaltepec', 'Oaxaca'),
(459, '20459', '20', '459', 'Villa de Santiago Chazumba', 'Oaxaca'),
(460, '20460', '20', '460', 'Santiago Choápam', 'Oaxaca'),
(461, '20461', '20', '461', 'Santiago del Río', 'Oaxaca'),
(462, '20462', '20', '462', 'Santiago Huajolotitlán', 'Oaxaca'),
(463, '20463', '20', '463', 'Santiago Huauclilla', 'Oaxaca'),
(464, '20464', '20', '464', 'Santiago Ihuitlán Plumas', 'Oaxaca'),
(465, '20465', '20', '465', 'Santiago Ixcuintepec', 'Oaxaca'),
(466, '20466', '20', '466', 'Santiago Ixtayutla', 'Oaxaca'),
(467, '20467', '20', '467', 'Santiago Jamiltepec', 'Oaxaca'),
(468, '20468', '20', '468', 'Santiago Jocotepec', 'Oaxaca'),
(469, '20469', '20', '469', 'Santiago Juxtlahuaca', 'Oaxaca'),
(470, '20470', '20', '470', 'Santiago Lachiguiri', 'Oaxaca'),
(471, '20471', '20', '471', 'Santiago Lalopa', 'Oaxaca'),
(472, '20472', '20', '472', 'Santiago Laollaga', 'Oaxaca'),
(473, '20473', '20', '473', 'Santiago Laxopa', 'Oaxaca'),
(474, '20474', '20', '474', 'Santiago Llano Grande', 'Oaxaca'),
(475, '20475', '20', '475', 'Santiago Matatlán', 'Oaxaca'),
(476, '20476', '20', '476', 'Santiago Miltepec', 'Oaxaca'),
(477, '20477', '20', '477', 'Santiago Minas', 'Oaxaca'),
(478, '20478', '20', '478', 'Santiago Nacaltepec', 'Oaxaca'),
(479, '20479', '20', '479', 'Santiago Nejapilla', 'Oaxaca'),
(480, '20480', '20', '480', 'Santiago Nundiche', 'Oaxaca'),
(481, '20481', '20', '481', 'Santiago Nuyoó', 'Oaxaca'),
(482, '20482', '20', '482', 'Santiago Pinotepa Nacional', 'Oaxaca'),
(483, '20483', '20', '483', 'Santiago Suchilquitongo', 'Oaxaca'),
(484, '20484', '20', '484', 'Santiago Tamazola', 'Oaxaca'),
(485, '20485', '20', '485', 'Santiago Tapextla', 'Oaxaca'),
(486, '20486', '20', '486', 'Villa Tejúpam de la Unión', 'Oaxaca'),
(487, '20487', '20', '487', 'Santiago Tenango', 'Oaxaca'),
(488, '20488', '20', '488', 'Santiago Tepetlapa', 'Oaxaca'),
(489, '20489', '20', '489', 'Santiago Tetepec', 'Oaxaca'),
(490, '20490', '20', '490', 'Santiago Texcalcingo', 'Oaxaca'),
(491, '20491', '20', '491', 'Santiago Textitlán', 'Oaxaca'),
(492, '20492', '20', '492', 'Santiago Tilantongo', 'Oaxaca'),
(493, '20493', '20', '493', 'Santiago Tillo', 'Oaxaca'),
(494, '20494', '20', '494', 'Santiago Tlazoyaltepec', 'Oaxaca'),
(495, '20495', '20', '495', 'Santiago Xanica', 'Oaxaca'),
(496, '20496', '20', '496', 'Santiago Xiacuí', 'Oaxaca'),
(497, '20497', '20', '497', 'Santiago Yaitepec', 'Oaxaca'),
(498, '20498', '20', '498', 'Santiago Yaveo', 'Oaxaca'),
(499, '20499', '20', '499', 'Santiago Yolomécatl', 'Oaxaca'),
(500, '20500', '20', '500', 'Santiago Yosondúa', 'Oaxaca'),
(501, '20501', '20', '501', 'Santiago Yucuyachi', 'Oaxaca'),
(502, '20502', '20', '502', 'Santiago Zacatepec', 'Oaxaca'),
(503, '20503', '20', '503', 'Santiago Zoochila', 'Oaxaca'),
(504, '20504', '20', '504', 'Nuevo Zoquiápam', 'Oaxaca'),
(505, '20505', '20', '505', 'Santo Domingo Ingenio', 'Oaxaca'),
(506, '20506', '20', '506', 'Santo Domingo Albarradas', 'Oaxaca'),
(507, '20507', '20', '507', 'Santo Domingo Armenta', 'Oaxaca'),
(508, '20508', '20', '508', 'Santo Domingo Chihuitán', 'Oaxaca'),
(509, '20509', '20', '509', 'Santo Domingo de Morelos', 'Oaxaca'),
(510, '20510', '20', '510', 'Santo Domingo Ixcatlán', 'Oaxaca'),
(511, '20511', '20', '511', 'Santo Domingo Nuxaá', 'Oaxaca'),
(512, '20512', '20', '512', 'Santo Domingo Ozolotepec', 'Oaxaca'),
(513, '20513', '20', '513', 'Santo Domingo Petapa', 'Oaxaca'),
(514, '20514', '20', '514', 'Santo Domingo Roayaga', 'Oaxaca'),
(515, '20515', '20', '515', 'Santo Domingo Tehuantepec', 'Oaxaca'),
(516, '20516', '20', '516', 'Santo Domingo Teojomulco', 'Oaxaca'),
(517, '20517', '20', '517', 'Santo Domingo Tepuxtepec', 'Oaxaca'),
(518, '20518', '20', '518', 'Santo Domingo Tlatayápam', 'Oaxaca'),
(519, '20519', '20', '519', 'Santo Domingo Tomaltepec', 'Oaxaca'),
(520, '20520', '20', '520', 'Santo Domingo Tonalá', 'Oaxaca'),
(521, '20521', '20', '521', 'Santo Domingo Tonaltepec', 'Oaxaca'),
(522, '20522', '20', '522', 'Santo Domingo Xagacía', 'Oaxaca'),
(523, '20523', '20', '523', 'Santo Domingo Yanhuitlán', 'Oaxaca'),
(524, '20524', '20', '524', 'Santo Domingo Yodohino', 'Oaxaca'),
(525, '20525', '20', '525', 'Santo Domingo Zanatepec', 'Oaxaca'),
(526, '20526', '20', '526', 'Santos Reyes Nopala', 'Oaxaca'),
(527, '20527', '20', '527', 'Santos Reyes Pápalo', 'Oaxaca'),
(528, '20528', '20', '528', 'Santos Reyes Tepejillo', 'Oaxaca'),
(529, '20529', '20', '529', 'Santos Reyes Yucuná', 'Oaxaca'),
(530, '20530', '20', '530', 'Santo Tomás Jalieza', 'Oaxaca'),
(531, '20531', '20', '531', 'Santo Tomás Mazaltepec', 'Oaxaca'),
(532, '20532', '20', '532', 'Santo Tomás Ocotepec', 'Oaxaca'),
(533, '20533', '20', '533', 'Santo Tomás Tamazulapan', 'Oaxaca'),
(534, '20534', '20', '534', 'San Vicente Coatlán', 'Oaxaca'),
(535, '20535', '20', '535', 'San Vicente Lachixío', 'Oaxaca'),
(536, '20536', '20', '536', 'San Vicente Nuñú', 'Oaxaca'),
(537, '20537', '20', '537', 'Silacayoápam', 'Oaxaca'),
(538, '20538', '20', '538', 'Sitio de Xitlapehua', 'Oaxaca'),
(539, '20539', '20', '539', 'Soledad Etla', 'Oaxaca'),
(540, '20540', '20', '540', 'Villa de Tamazulápam del Progreso', 'Oaxaca'),
(541, '20541', '20', '541', 'Tanetze de Zaragoza', 'Oaxaca'),
(542, '20542', '20', '542', 'Taniche', 'Oaxaca'),
(543, '20543', '20', '543', 'Tataltepec de Valdés', 'Oaxaca'),
(544, '20544', '20', '544', 'Teococuilco de Marcos Pérez', 'Oaxaca'),
(545, '20545', '20', '545', 'Teotitlán de Flores Magón', 'Oaxaca'),
(546, '20546', '20', '546', 'Teotitlán del Valle', 'Oaxaca'),
(547, '20547', '20', '547', 'Teotongo', 'Oaxaca'),
(548, '20548', '20', '548', 'Tepelmeme Villa de Morelos', 'Oaxaca'),
(549, '20549', '20', '549', 'Heroica Villa Tezoatlán de Segura y Luna, Cuna de la Independencia de Oaxaca', 'Oaxaca'),
(550, '20550', '20', '550', 'San Jerónimo Tlacochahuaya', 'Oaxaca'),
(551, '20551', '20', '551', 'Tlacolula de Matamoros', 'Oaxaca'),
(552, '20552', '20', '552', 'Tlacotepec Plumas', 'Oaxaca'),
(553, '20553', '20', '553', 'Tlalixtac de Cabrera', 'Oaxaca'),
(554, '20554', '20', '554', 'Totontepec Villa de Morelos', 'Oaxaca'),
(555, '20555', '20', '555', 'Trinidad Zaachila', 'Oaxaca'),
(556, '20556', '20', '556', 'La Trinidad Vista Hermosa', 'Oaxaca'),
(557, '20557', '20', '557', 'Unión Hidalgo', 'Oaxaca'),
(558, '20558', '20', '558', 'Valerio Trujano', 'Oaxaca'),
(559, '20559', '20', '559', 'San Juan Bautista Valle Nacional', 'Oaxaca'),
(560, '20560', '20', '560', 'Villa Díaz Ordaz', 'Oaxaca'),
(561, '20561', '20', '561', 'Yaxe', 'Oaxaca'),
(562, '20562', '20', '562', 'Magdalena Yodocono de Porfirio Díaz', 'Oaxaca'),
(563, '20563', '20', '563', 'Yogana', 'Oaxaca'),
(564, '20564', '20', '564', 'Yutanduchi de Guerrero', 'Oaxaca'),
(565, '20565', '20', '565', 'Villa de Zaachila', 'Oaxaca'),
(566, '20566', '20', '566', 'San Mateo Yucutindoo', 'Oaxaca'),
(567, '20567', '20', '567', 'Zapotitlán Lagunas', 'Oaxaca'),
(568, '20568', '20', '568', 'Zapotitlán Palmas', 'Oaxaca'),
(569, '20569', '20', '569', 'Santa Inés de Zaragoza', 'Oaxaca'),
(570, '20570', '20', '570', 'Zimatlán de Álvarez', 'Oaxaca');

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
  `anthropic_api_key` varchar(255) DEFAULT NULL,
  `onesignal` varchar(500) NOT NULL DEFAULT 'c23c6d51-d492-4c88-a111-88cc8d7b624d',
  `stripe_public` varchar(500) DEFAULT NULL,
  `stripe_private` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `config`
--

INSERT INTO `config` (`title`, `slogan`, `url`, `time_cookie`, `reset_time_expired`, `reset_max_request`, `limit_login`, `time_zone`, `sbpanel`, `facebook`, `twitter`, `instagram`, `email_contact`, `twitter_user`, `google_api`, `anthropic_api_key`, `onesignal`, `stripe_public`, `stripe_private`) VALUES
('GestCamp', 'SLOGAN', 'https://gest-camp.com', 600, 300, 3, 5, 'America/Mexico_City', 'http://localhost/sbpanel', NULL, NULL, NULL, 'emailcontacto', NULL, '', NULL, '', NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`userid`, `user`, `pass`, `rank`, `lastlogin`, `last_ip`, `premium`, `navegator`, `lang`, `server`, `isonline`, `country`, `verified`, `token`, `idref`, `name`, `lastname`, `ifecha`, `cedula`, `direccion`, `ciudad`, `phone`, `movil`, `email`, `comentario`, `ipas`, `avatar`, `header`, `interes`, `sexo`, `nacimiento`, `map_lat`, `map_lon`, `status`, `idatetime`, `pushid`, `hashpush`) VALUES
(1, 'Administrador', 'H-CAD,#!C-V-E.#1D-3AE.3)F,#,P-C@V839C9&4S9C$X,V5B.3,P80``\n`\n', 9999, '2026-07-21 10:20:24', '187.224.8.217', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'es', 2, 1, 'MX', 1, 'tdzFwNXX0azE5cvNkOXLwsTlxs7F4s/A1bPJzMTczo3G4sMlaOTmJCjmoyVqA==', NULL, 'Ricardo', 'Bocardo Marin', '2020-05-09', '123-2222222-2', 'Manuel R Gutierrez', 'Acayucan', '(921) 222 1602', '9212221602', 'ricardobomar@gmail.com', 'Administrador', NULL, 'avatar_ricardomarin.png', 'default.jpg', 8, 'Masculino', '2021-09-23', '17.9238338', '-94.8910404', 1, '2022-02-02 14:27:28', NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `logs`
--

INSERT INTO `logs` (`id`, `title`, `descrip`, `user`, `itime`, `ihours`, `ip`, `server`, `idaction`) VALUES
(1, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-17', '05:59:54', '189.196.209.234', NULL, NULL),
(2, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-17', '06:07:16', '189.196.209.234', NULL, NULL),
(3, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-17', '16:30:58', '187.224.8.217', NULL, NULL),
(4, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-17', '16:38:22', '187.224.8.217', NULL, NULL),
(5, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-17', '17:44:50', '187.224.8.217', NULL, NULL),
(6, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-17', '18:47:08', '187.224.8.217', NULL, NULL),
(7, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-17', '18:47:20', '187.224.8.217', NULL, NULL),
(8, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-18', '02:13:07', '189.163.142.172', NULL, NULL),
(9, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-20', '16:27:29', '187.224.8.217', NULL, NULL),
(10, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-20', '17:40:49', '187.224.8.217', NULL, NULL),
(11, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-20', '17:42:27', '187.224.8.217', NULL, NULL),
(12, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-20', '21:34:53', '187.224.8.217', NULL, NULL),
(13, 'Cierre sesión forzoso', 'Se cerró la sesión por inactividad del usuario.', 1, '2026-07-21', '16:20:24', '187.224.8.217', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `campaign_bitacora`
--
ALTER TABLE `campaign_bitacora`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD KEY `fecha` (`fecha`),
  ADD KEY `status` (`status`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `campaign_brm`
--
ALTER TABLE `campaign_brm`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD KEY `zona` (`zona`),
  ADD KEY `fecha` (`fecha`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `campaign_eventos`
--
ALTER TABLE `campaign_eventos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD KEY `fecha` (`fecha`),
  ADD KEY `estatus` (`estatus`),
  ADD KEY `lugar` (`lugar`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `cat_zonas`
--
ALTER TABLE `cat_zonas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cve_geo` (`cve_geo`);

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
-- AUTO_INCREMENT de la tabla `campaign_bitacora`
--
ALTER TABLE `campaign_bitacora`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT de la tabla `campaign_brm`
--
ALTER TABLE `campaign_brm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `campaign_eventos`
--
ALTER TABLE `campaign_eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=896;

--
-- AUTO_INCREMENT de la tabla `cat_zonas`
--
ALTER TABLE `cat_zonas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=571;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
