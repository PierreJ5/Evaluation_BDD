-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mydatabase
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `complex`
--

DROP TABLE IF EXISTS `complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_complex` varchar(255) NOT NULL,
  `ville` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complex`
--

LOCK TABLES `complex` WRITE;
/*!40000 ALTER TABLE `complex` DISABLE KEYS */;
INSERT INTO `complex` VALUES (1,'complex Parisien','Paris'),(2,'complex Lillois','Lille'),(3,'complex Lyonnais - B1','Lyon'),(4,'complex Lyonnais - B2','Lyon');
/*!40000 ALTER TABLE `complex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film`
--

DROP TABLE IF EXISTS `film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `film` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `realisateur` varchar(255) NOT NULL,
  `duree` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film`
--

LOCK TABLES `film` WRITE;
/*!40000 ALTER TABLE `film` DISABLE KEYS */;
INSERT INTO `film` VALUES (1,'Spiderman Homecoming','Arnold Schwarzi','01:25:00'),(2,'Conan le Barbare','Arnold Schwarzi','01:32:00'),(3,'Les indestructibles','Arnold Schwarzi','01:31:00'),(4,'Le Seigneur des Anneaux - Les deux Tours','Arnold Schwarzi','02:14:00'),(5,'John Carter','Arnold Schwarzi','01:45:00'),(6,'Ratatouille','Arnold Schwarzi','01:32:00'),(7,'Resident Evil - Extinction','Arnold Schwarzi','01:22:34'),(8,'Matrix','Arnold Schwarzi','01:50:00');
/*!40000 ALTER TABLE `film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jointure_reservation`
--

DROP TABLE IF EXISTS `jointure_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jointure_reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int NOT NULL,
  `tarif_id` int NOT NULL,
  `quantite` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `tarif_id` (`tarif_id`),
  CONSTRAINT `jointure_reservation_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`),
  CONSTRAINT `jointure_reservation_ibfk_2` FOREIGN KEY (`tarif_id`) REFERENCES `tarif` (`tarif_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jointure_reservation`
--

LOCK TABLES `jointure_reservation` WRITE;
/*!40000 ALTER TABLE `jointure_reservation` DISABLE KEYS */;
INSERT INTO `jointure_reservation` VALUES (1,1,1,1),(2,1,3,2),(3,2,1,2),(4,2,3,6),(5,3,2,1),(6,4,1,2),(7,4,3,3),(8,5,1,1),(9,5,3,14),(10,6,1,1),(11,6,3,2),(12,7,1,1),(13,7,3,2),(14,8,2,2),(15,9,1,3),(16,9,2,1),(17,9,3,3),(18,10,1,3),(19,10,3,3),(20,11,1,4),(21,11,3,8),(22,12,2,2),(23,13,1,2),(24,14,1,1),(25,14,3,4);
/*!40000 ALTER TABLE `jointure_reservation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calcul_montant` AFTER INSERT ON `jointure_reservation` FOR EACH ROW BEGIN
    DECLARE total DECIMAL(5, 2);
    
    SELECT SUM(tarif.montant * jointure_reservation.quantite) INTO total
    FROM jointure_reservation
    JOIN tarif ON jointure_reservation.tarif_id = tarif.tarif_id
    WHERE jointure_reservation.reservation_id = NEW.reservation_id;
    
    UPDATE reservations
    SET montant_total = total
    WHERE id = NEW.reservation_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seance_reservee` int NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nb_places` int NOT NULL,
  `e_paiement` tinyint(1) NOT NULL,
  `montant_total` decimal(5,2) NOT NULL DEFAULT '0.00',
  `date_paiement` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `seance_reservee` (`seance_reservee`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`seance_reservee`) REFERENCES `seance` (`id_attribution`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1,1,'Doe','John','johndoe@example.com',3,1,21.00,'2023-11-05 16:00:31'),(2,1,'Doe','Jeanne','jeannedoe@example.com',8,1,53.80,'2023-11-05 16:00:31'),(3,1,'Doe','Gary','garydoe@example.com',1,0,7.60,'2023-11-05 16:00:31'),(4,1,'Doe','Alphonse','alphonsedoe@example.com',5,0,36.10,'2023-11-05 16:00:31'),(5,1,'Doe','Tom','tomdoe@example.com',15,0,91.80,'2023-11-05 16:00:31'),(6,2,'Couturier','Sarah','sarahcouturier@example.com',3,1,21.00,'2023-11-05 16:00:31'),(7,2,'Couturier','Pierre','pierrecouturier@example.com',3,1,21.00,'2023-11-05 16:00:31'),(8,4,'Hassani','Eli','elihassani@example.com',2,1,15.20,'2023-11-05 16:00:31'),(9,4,'Hassani','John','hohnhassani@example.com',7,1,52.90,'2023-11-05 16:00:31'),(10,4,'Hassani','Jeanne','jeannehassani@example.com',6,1,45.30,'2023-11-05 16:00:31'),(11,4,'Hassani','Marvin','marvinhassani@example.com',12,0,84.00,'2023-11-05 16:00:31'),(12,5,'Smith','Robert','robertsmith@example.com',2,1,15.20,'2023-11-05 16:00:31'),(13,5,'Smith','Carla','carlasmith@example.com',2,0,18.40,'2023-11-05 16:00:31'),(14,5,'Smith','Marie','mariesmith@example.com',5,1,32.80,'2023-11-05 16:00:31');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_places` BEFORE INSERT ON `reservations` FOR EACH ROW BEGIN
    DECLARE checking INT;
    SELECT places_restantes INTO checking 
    FROM seance 
    WHERE id_attribution = NEW.seance_reservee;

    IF NEW.nb_places > checking THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pas assez de place disponible';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `soustraction_places` AFTER INSERT ON `reservations` FOR EACH ROW BEGIN
    DECLARE valeur INT;

    SELECT nb_places INTO valeur
    FROM reservations
    WHERE NEW.id = reservations.id;

    UPDATE seance
    SET places_restantes = places_restantes - valeur
    WHERE id_attribution = NEW.seance_reservee;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `supprs_reservation` BEFORE DELETE ON `reservations` FOR EACH ROW BEGIN
    DECLARE valeur INT;

    SELECT nb_places INTO valeur
    FROM reservations
    WHERE id = OLD.id;

    UPDATE seance
    SET places_restantes = places_restantes + valeur
    WHERE id_attribution = OLD.seance_reservee;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salle`
--

DROP TABLE IF EXISTS `salle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_complex` int NOT NULL,
  `num_salle` int NOT NULL,
  `places_max` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_complex` (`id_complex`),
  CONSTRAINT `salle_ibfk_1` FOREIGN KEY (`id_complex`) REFERENCES `complex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salle`
--

LOCK TABLES `salle` WRITE;
/*!40000 ALTER TABLE `salle` DISABLE KEYS */;
INSERT INTO `salle` VALUES (1,1,101,100),(2,1,102,100),(3,1,103,150),(4,1,104,100),(5,1,105,150),(6,1,201,100),(7,1,202,100),(8,1,203,150),(9,1,204,100),(10,1,205,150),(11,2,101,100),(12,2,102,100),(13,2,103,150),(14,2,104,100),(15,2,105,150),(16,2,201,100),(17,2,202,100),(18,2,203,150),(19,2,204,100),(20,2,205,150),(21,2,301,300),(22,3,101,100),(23,3,102,100),(24,3,103,150),(25,3,104,100),(26,3,105,150),(27,3,201,100),(28,3,202,100),(29,3,203,150),(30,4,101,200),(31,4,102,200),(32,4,103,250),(33,4,104,300),(34,4,105,300),(35,4,201,100),(36,4,202,100),(37,4,203,150);
/*!40000 ALTER TABLE `salle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seance`
--

DROP TABLE IF EXISTS `seance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seance` (
  `id_attribution` int NOT NULL AUTO_INCREMENT,
  `id_complex` int NOT NULL,
  `id_salle` int NOT NULL,
  `id_film` int NOT NULL,
  `date_diffusion` date NOT NULL,
  `heure_debut` time NOT NULL,
  `places_restantes` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_attribution`),
  KEY `id_complex` (`id_complex`),
  KEY `id_salle` (`id_salle`),
  KEY `id_film` (`id_film`),
  CONSTRAINT `seance_ibfk_1` FOREIGN KEY (`id_complex`) REFERENCES `complex` (`id`),
  CONSTRAINT `seance_ibfk_2` FOREIGN KEY (`id_salle`) REFERENCES `salle` (`id`),
  CONSTRAINT `seance_ibfk_3` FOREIGN KEY (`id_film`) REFERENCES `film` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seance`
--

LOCK TABLES `seance` WRITE;
/*!40000 ALTER TABLE `seance` DISABLE KEYS */;
INSERT INTO `seance` VALUES (1,1,1,1,'2023-12-25','18:00:00',68),(2,1,1,5,'2023-12-25','21:00:00',94),(3,1,2,8,'2023-12-25','18:00:00',100),(4,1,3,7,'2023-12-26','20:00:00',123),(5,2,11,1,'2023-12-25','18:00:00',91),(6,2,12,5,'2023-12-25','21:00:00',100),(7,2,13,4,'2023-12-25','18:00:00',150),(8,2,13,3,'2023-12-26','20:00:00',150),(9,3,22,1,'2023-12-25','18:00:00',100),(10,3,23,5,'2023-12-25','21:00:00',100),(11,3,24,8,'2023-12-25','18:00:00',150),(12,3,25,7,'2023-12-26','20:00:00',100),(13,4,30,2,'2023-12-25','18:00:00',200),(14,4,31,5,'2023-12-25','21:00:00',200),(15,4,32,2,'2023-12-25','18:00:00',250),(16,4,33,7,'2023-12-26','20:00:00',300),(17,3,27,2,'2023-12-27','19:00:00',100),(18,4,31,5,'2023-12-27','22:00:00',200),(19,1,2,2,'2023-12-27','19:00:00',100),(20,4,33,7,'2023-12-28','20:00:00',300);
/*!40000 ALTER TABLE `seance` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_seance_true` BEFORE INSERT ON `seance` FOR EACH ROW BEGIN
    DECLARE id_complex_salle INT;
    SELECT id_complex INTO id_complex_salle 
    FROM salle 
    WHERE id = NEW.id_salle;
    IF NEW.id_complex <> id_complex_salle THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La salle n appartient pas au complex';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_place_par_seance` BEFORE INSERT ON `seance` FOR EACH ROW BEGIN
    DECLARE placesmax INT;

    SELECT places_max INTO placesmax
    FROM salle
    WHERE NEW.id_salle = salle.id;

    SET NEW.places_restantes = placesmax;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tarif`
--

DROP TABLE IF EXISTS `tarif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarif` (
  `tarif_id` int NOT NULL AUTO_INCREMENT,
  `nom_tarif` varchar(255) NOT NULL,
  `montant` decimal(5,2) NOT NULL,
  PRIMARY KEY (`tarif_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarif`
--

LOCK TABLES `tarif` WRITE;
/*!40000 ALTER TABLE `tarif` DISABLE KEYS */;
INSERT INTO `tarif` VALUES (1,'Tarif Plein',9.20),(2,'Tarif Étudiant',7.60),(3,'Tarif Moins 14 ans',5.90);
/*!40000 ALTER TABLE `tarif` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-05 17:22:01
