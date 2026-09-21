-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_final
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria_insumos`
--

DROP TABLE IF EXISTS `categoria_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_insumos` (
  `Insu_categoria_id` int(11) NOT NULL AUTO_INCREMENT,
  `Insu_nombre_categoria` varchar(50) NOT NULL,
  PRIMARY KEY (`Insu_categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_insumos`
--

LOCK TABLES `categoria_insumos` WRITE;
/*!40000 ALTER TABLE `categoria_insumos` DISABLE KEYS */;
INSERT INTO `categoria_insumos` VALUES (1,'Cabello'),(2,'Uñas'),(3,'Masajes'),(4,'Facial'),(5,'Limpieza');
/*!40000 ALTER TABLE `categoria_insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_servicios`
--

DROP TABLE IF EXISTS `categoria_servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_servicios` (
  `Serv_categoria_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Serv_nombre_categoria` varchar(50) NOT NULL,
  PRIMARY KEY (`Serv_categoria_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_servicios`
--

LOCK TABLES `categoria_servicios` WRITE;
/*!40000 ALTER TABLE `categoria_servicios` DISABLE KEYS */;
INSERT INTO `categoria_servicios` VALUES (1,'Cabello'),(2,'Uñas'),(3,'Masajes'),(4,'Facial'),(5,'Spa');
/*!40000 ALTER TABLE `categoria_servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita`
--

DROP TABLE IF EXISTS `cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cita` (
  `Cita_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Cita_fecha` date NOT NULL,
  `Cita_hora` time NOT NULL,
  `Cita_servicio` int(11) DEFAULT NULL,
  `Cita_estado` varchar(20) DEFAULT 'Pendiente',
  `Cita_duracion` int(11) DEFAULT NULL,
  `Empl_acargo_Id` int(11) DEFAULT NULL,
  `Clie_Id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Cita_Id`),
  KEY `Cita_servicio` (`Cita_servicio`),
  KEY `Clie_Id` (`Clie_Id`),
  KEY `cita_ibfk_2` (`Empl_acargo_Id`),
  CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`Cita_servicio`) REFERENCES `servicios` (`Serv_Id`),
  CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`Empl_acargo_Id`) REFERENCES `empleados` (`Empl_Id`),
  CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`Clie_Id`) REFERENCES `cliente` (`Clie_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita`
--

LOCK TABLES `cita` WRITE;
/*!40000 ALTER TABLE `cita` DISABLE KEYS */;
INSERT INTO `cita` VALUES (1,'2026-08-21','09:00:00',1,'Pendiente',60,3,1),(2,'2026-08-21','10:30:00',2,'Confirmada',90,6,2),(3,'2026-08-21','12:00:00',3,'Pendiente',60,5,3),(4,'2026-08-22','09:00:00',4,'Confirmada',45,8,4),(5,'2026-08-22','11:00:00',5,'Pendiente',120,3,5),(6,'2026-08-23','10:00:00',1,'Confirmada',60,4,6),(7,'2026-08-23','12:00:00',2,'Pendiente',90,9,7),(8,'2026-08-24','09:30:00',3,'Confirmada',60,5,8),(9,'2026-08-24','11:00:00',4,'Pendiente',45,8,9),(10,'2026-08-25','14:00:00',5,'Confirmada',120,7,10);
/*!40000 ALTER TABLE `cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `Clie_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Clie_Nombre` varchar(100) NOT NULL,
  `Clie_telefono` varchar(20) DEFAULT NULL,
  `Clie_contraseña` varchar(255) NOT NULL,
  `Clie_correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Clie_Id`),
  UNIQUE KEY `Clie_correo` (`Clie_correo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Maria Lopez','3101112233','123456','maria@gmail.com'),(2,'Juan Rodriguez','3102223344','123456','juan@gmail.com'),(3,'Laura Martinez','3103334455','123456','laura@gmail.com'),(4,'Carlos Perez','3104445566','123456','carlos@gmail.com'),(5,'Sofia Gomez','3105556677','123456','sofia@gmail.com'),(6,'Valentina Torres','3106667788','123456','valentina@gmail.com'),(7,'Andres Ruiz','3107778899','123456','andres@gmail.com'),(8,'Camila Castro','3108889900','123456','camila@gmail.com'),(9,'Daniel Vargas','3109990011','123456','daniel@gmail.com'),(10,'Natalia Hernandez','3110001122','123456','natalia@gmail.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `Empl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Empl_nombre` varchar(100) NOT NULL,
  `Empl_telefono` varchar(20) DEFAULT NULL,
  `Empl_contraseña` varchar(255) NOT NULL,
  `Empl_correo` varchar(100) DEFAULT NULL,
  `Rol_Id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Empl_Id`),
  UNIQUE KEY `EmpI_correo` (`Empl_correo`),
  KEY `Rol_Id` (`Rol_Id`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`Rol_Id`) REFERENCES `rol_empleados` (`Rol_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Ana Martinez','3001112233','123456','ana@spa.com',1),(2,'Carlos Gomez','3002223344','123456','carlos@spa.com',2),(3,'Laura Rodriguez','3003334455','123456','laura@spa.com',3),(4,'Daniel Perez','3004445566','123456','daniel@spa.com',3),(5,'Sofia Torres','3005556677','123456','sofia@spa.com',4),(6,'Valentina Ruiz','3006667788','123456','valentina@spa.com',5),(7,'Andres Castro','3007778899','123456','andres@spa.com',3),(8,'Camila Vargas','3008889900','123456','camila@spa.com',4),(9,'Juan Hernandez','3009990011','123456','juan@spa.com',5),(10,'Mariana Lopez','3010001122','123456','mariana@spa.com',2);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumos`
--

DROP TABLE IF EXISTS `insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insumos` (
  `Insu_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Insu_precio` decimal(10,2) NOT NULL,
  `Insu_nombre` varchar(100) NOT NULL,
  `Insu_stock` int(11) DEFAULT 0,
  `Insu_unidad` varchar(20) DEFAULT NULL,
  `Insu_descripcion` text DEFAULT NULL,
  `Insu_estado` varchar(20) DEFAULT NULL,
  `Insu_categoria_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Insu_Id`),
  KEY `Insu_categoria_id` (`Insu_categoria_id`),
  CONSTRAINT `insumos_ibfk_1` FOREIGN KEY (`Insu_categoria_id`) REFERENCES `categoria_insumos` (`Insu_categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (1,25000.00,'Shampoo profesional',20,'Unidad','Shampoo para cabello','Disponible',1),(2,30000.00,'Acondicionador',15,'Unidad','Acondicionador profesional','Disponible',1),(3,18000.00,'Crema para peinar',12,'Unidad','Crema para peinar','Disponible',1),(4,12000.00,'Esmalte rojo',25,'Unidad','Esmalte para uñas','Disponible',2),(5,12000.00,'Esmalte rosado',20,'Unidad','Esmalte para uñas','Disponible',2),(6,15000.00,'Removedor de esmalte',18,'Unidad','Removedor de esmalte','Disponible',2),(7,35000.00,'Aceite para masaje',10,'Unidad','Aceite corporal','Disponible',3),(8,28000.00,'Crema corporal',14,'Unidad','Crema hidratante','Disponible',3),(9,22000.00,'Gel relajante',10,'Unidad','Gel para masajes','Disponible',3),(10,40000.00,'Mascarilla facial',10,'Unidad','Mascarilla hidratante','Disponible',4),(11,32000.00,'Crema facial',12,'Unidad','Crema hidratante facial','Disponible',4),(12,20000.00,'Agua micelar',15,'Unidad','Producto de limpieza facial','Disponible',4),(13,10000.00,'Toallas',50,'Unidad','Toallas para clientes','Disponible',5),(14,8000.00,'Guantes',60,'Par','Guantes desechables','Disponible',5),(15,15000.00,'Alcohol',30,'Unidad','Alcohol para limpieza','Disponible',5);
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recibos`
--

DROP TABLE IF EXISTS `recibos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recibos` (
  `Reci_numero` int(11) NOT NULL AUTO_INCREMENT,
  `Reci_fecha_hora_emision` datetime NOT NULL,
  `Reci_monto_servicio` decimal(10,2) NOT NULL,
  `Reci_tipo_pago` int(11) DEFAULT NULL,
  `Reci_estado` varchar(20) DEFAULT 'Pagado',
  `EmpI_Id` int(11) DEFAULT NULL,
  `Clie_Id` int(11) DEFAULT NULL,
  `Reci_formato` varchar(20) DEFAULT 'Fisico',
  PRIMARY KEY (`Reci_numero`),
  KEY `Reci_tipo_pago` (`Reci_tipo_pago`),
  KEY `EmpI_Id` (`EmpI_Id`),
  KEY `Clie_Id` (`Clie_Id`),
  CONSTRAINT `recibos_ibfk_1` FOREIGN KEY (`Reci_tipo_pago`) REFERENCES `tipo_pagos` (`Tipo_pago_Id`),
  CONSTRAINT `recibos_ibfk_2` FOREIGN KEY (`EmpI_Id`) REFERENCES `empleados` (`Empl_Id`),
  CONSTRAINT `recibos_ibfk_3` FOREIGN KEY (`Clie_Id`) REFERENCES `cliente` (`Clie_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recibos`
--

LOCK TABLES `recibos` WRITE;
/*!40000 ALTER TABLE `recibos` DISABLE KEYS */;
INSERT INTO `recibos` VALUES (1,'2026-08-01 09:00:00',50000.00,1,'Pagado',1,1,'Fisico'),(2,'2026-08-02 10:00:00',70000.00,2,'Pagado',2,2,'PDF'),(3,'2026-08-03 11:00:00',80000.00,1,'Pagado',3,3,'Fisico'),(4,'2026-08-04 12:00:00',60000.00,2,'Pagado',4,4,'PDF'),(5,'2026-08-05 13:00:00',150000.00,1,'Pagado',5,5,'Fisico'),(6,'2026-08-06 14:00:00',50000.00,2,'Pagado',6,6,'PDF'),(7,'2026-08-07 15:00:00',70000.00,1,'Pagado',7,7,'Fisico'),(8,'2026-08-08 16:00:00',80000.00,2,'Pagado',8,8,'PDF'),(9,'2026-08-09 17:00:00',60000.00,1,'Pagado',9,9,'Fisico'),(10,'2026-08-10 18:00:00',150000.00,2,'Pagado',10,10,'PDF');
/*!40000 ALTER TABLE `recibos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_empleados`
--

DROP TABLE IF EXISTS `rol_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_empleados` (
  `Rol_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rol_nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`Rol_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_empleados`
--

LOCK TABLES `rol_empleados` WRITE;
/*!40000 ALTER TABLE `rol_empleados` DISABLE KEYS */;
INSERT INTO `rol_empleados` VALUES (1,'Administrador'),(2,'Recepcionista'),(3,'Estilista'),(4,'Masajista'),(5,'Manicurista');
/*!40000 ALTER TABLE `rol_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `Serv_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Serv_duracion` int(11) DEFAULT NULL,
  `Serv_precio` decimal(10,2) NOT NULL,
  `Serv_nombre` varchar(100) NOT NULL,
  `Serv_categoria_Id` int(11) DEFAULT NULL,
  `Serv_insumo_Id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Serv_Id`),
  KEY `Serv_categoria_Id` (`Serv_categoria_Id`),
  KEY `insumos_Idfk_idx` (`Serv_insumo_Id`),
  CONSTRAINT `insumos_Idfk` FOREIGN KEY (`Serv_insumo_Id`) REFERENCES `insumos` (`Insu_Id`),
  CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`Serv_categoria_Id`) REFERENCES `categoria_servicios` (`Serv_categoria_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,60,50000.00,'Corte y peinado',1,2),(2,90,70000.00,'Manicure y pedicure',2,4),(3,60,80000.00,'Masaje relajante',3,7),(4,45,60000.00,'Limpieza facial',4,11),(5,120,150000.00,'Spa completo',5,7);
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pagos`
--

DROP TABLE IF EXISTS `tipo_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_pagos` (
  `Tipo_pago_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Tipo_pago_nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`Tipo_pago_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pagos`
--

LOCK TABLES `tipo_pagos` WRITE;
/*!40000 ALTER TABLE `tipo_pagos` DISABLE KEYS */;
INSERT INTO `tipo_pagos` VALUES (1,'Efectivo'),(2,'Transferencia');
/*!40000 ALTER TABLE `tipo_pagos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-24  1:39:15
