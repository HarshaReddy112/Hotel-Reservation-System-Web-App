-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: hotel_db
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hotel` varchar(255) NOT NULL,
  `room_type` int DEFAULT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `room_type` (`room_type`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`userID`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_type`) REFERENCES `rooms` (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (11,'Heritage Inn',109,'2025-06-17','2025-06-20',3975.00,'2025-06-01 17:29:25',1004),(12,'Mountain Lodge',109,'2025-06-08','2025-06-10',2725.00,'2025-06-01 17:33:36',1001),(13,'Mountain Lodge',101,'2025-06-08','2025-06-10',2616.00,'2025-06-01 17:41:16',1003),(14,'Grand Palace',110,'2025-06-24','2025-06-27',4452.00,'2025-06-02 12:42:18',1001),(16,'Mountain Lodge',207,'2025-06-17','2025-06-19',7194.00,'2025-06-03 08:17:10',1001),(17,'Snow Crest',213,'2025-06-18','2025-06-20',4752.40,'2025-06-03 09:18:07',1004),(18,'Seaside Resort',203,'2025-06-27','2025-06-30',4293.00,'2025-06-03 09:41:53',1001),(19,'Heritage Inn',106,'2025-06-11','2025-06-13',6540.00,'2025-06-03 09:44:52',NULL),(20,'Heritage Inn',106,'2025-06-11','2025-06-13',6540.00,'2025-06-03 09:44:54',NULL);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotels` (
  `hotel_id` int NOT NULL AUTO_INCREMENT,
  `hotel_name` varchar(255) NOT NULL,
  `manager` varchar(255) DEFAULT NULL,
  `no_of_rooms_booked` int DEFAULT '0',
  `manager_id` int DEFAULT NULL,
  PRIMARY KEY (`hotel_id`),
  KEY `fk_manager` (`manager_id`,`manager`),
  CONSTRAINT `fk_manager` FOREIGN KEY (`manager_id`, `manager`) REFERENCES `manager` (`manager_id`, `name`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (10,'Grand Palace','K K Johnson',1,1),(20,'SeaSide Resort','Raj Sharma',1,2),(30,'Mountain Lodge','J J Williams',3,3),(40,'Heritage Inn','K K Johnson',3,1),(50,'Breeze Retreat','Sunitha M',0,4),(60,'Snow Crest','Laura S',1,5);
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `manager_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`manager_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'K K Johnson',45,'Male',75000.00,'kkjohnson','pass123'),(2,'Raj Sharma',38,'Male',68000.00,'rajsharma','secure456'),(3,'J J Williams',50,'Male',80000.00,'jjwilliams','mypassword'),(4,'Sunitha M',40,'Female',70000.00,'sunitham','sunpass789'),(5,'Laura S',35,'Female',65000.00,'lauras','laurapass');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_no` int NOT NULL,
  `room_type` varchar(50) NOT NULL,
  `floor` int DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `amenities` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (101,'Standard',1,1200.00,'Fan'),(102,'Standard',1,1300.00,'Wi-Fi'),(103,'Standard',1,1250.00,'Desk'),(104,'Deluxe',1,2000.00,'AC'),(105,'Deluxe',1,2100.00,'TV'),(106,'Suite',1,3000.00,'Mini-Fridge'),(107,'Suite',1,3500.00,'Ocean View'),(108,'Standard',1,1350.00,'Desk'),(109,'Standard',1,1250.00,'Fan'),(110,'Standard',1,1400.00,'Wi-Fi'),(111,'Deluxe',1,2200.00,'Balcony'),(112,'Deluxe',1,2150.00,'TV'),(113,'Suite',1,3200.00,'Lounge'),(114,'Suite',1,3300.00,'2 Beds'),(115,'Standard',1,1450.00,'Desk'),(116,'Deluxe',1,2250.00,'Mini-Bar'),(201,'Standard',2,1250.00,'Fan'),(202,'Standard',2,1300.00,'Wi-Fi'),(203,'Standard',2,1350.00,'Desk'),(204,'Deluxe',2,2200.00,'Balcony'),(205,'Deluxe',2,2150.00,'TV'),(206,'Suite',2,3200.00,'Lounge'),(207,'Suite',2,3300.00,'2 Beds'),(208,'Standard',2,1260.00,'Fan'),(209,'Standard',2,1310.00,'Wi-Fi'),(210,'Deluxe',2,2250.00,'Balcony'),(211,'Suite',2,3400.00,'Ocean View'),(212,'Standard',2,1360.00,'Desk'),(213,'Deluxe',2,2180.00,'TV'),(214,'Standard',2,1290.00,'Wi-Fi'),(215,'Suite',2,3250.00,'Lounge'),(216,'Suite',2,3450.00,'Mini-Fridge');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `no_of_bookings` int DEFAULT '0',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1001,'John','123456',4),(1002,'Harry','abcdefg',0),(1003,'Jane','flowers123',1),(1004,'Jack','abcxyz',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-19  1:10:35
