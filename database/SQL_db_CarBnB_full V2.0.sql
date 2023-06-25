DROP SCHEMA IF EXISTS `carbnb` ;

CREATE DATABASE  IF NOT EXISTS `carbnb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `carbnb`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: carbnb
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `brandID` smallint NOT NULL AUTO_INCREMENT,
  `brand` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`brandID`),
  UNIQUE KEY `brand_UNIQUE` (`brand`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Acura'),(2,'Audi'),(4,'Bentley'),(3,'BMW'),(5,'Buick'),(6,'Cadillac'),(7,'Chevrolet'),(8,'Chrysler'),(9,'Dodge'),(10,'Fiat'),(11,'Ford'),(13,'Genesis'),(12,'GMC'),(14,'Honda'),(15,'Hyundai'),(16,'Infiniti'),(17,'Jaguar'),(18,'Jeep'),(19,'Kia'),(20,'Land Rover'),(21,'Lexus'),(22,'Lincoln'),(23,'Lotus'),(24,'Lucid'),(25,'Maserati'),(26,'Mazda'),(27,'Mercedes'),(28,'Mercury'),(29,'Mini'),(30,'Mitsubishi'),(31,'Nissan'),(32,'Polestar'),(33,'Pontiac'),(34,'Porsche'),(35,'Ram'),(36,'Rivian'),(37,'Rolls-Royce'),(38,'Saab'),(39,'Saturn'),(40,'Scion'),(41,'Smart'),(42,'Subaru'),(43,'Suzuki'),(44,'Tesla'),(45,'Toyota'),(46,'Volkswagen'),(47,'Volvo');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car` (
  `carID` int NOT NULL AUTO_INCREMENT,
  `userID` int DEFAULT NULL,
  `brandID` smallint DEFAULT NULL,
  `cartypeID` tinyint DEFAULT NULL,
  `fuelID` tinyint DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `gear` varchar(1) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `description` varchar(450) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `plateNumber` varchar(45) DEFAULT NULL,
  `hourlyCost` int DEFAULT NULL,
  `dailyCost` int DEFAULT NULL,
  `seats` tinyint DEFAULT NULL,
  `doors` tinyint DEFAULT NULL,
  `lat` varchar(10) DEFAULT NULL,
  `long` varchar(10) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `dateCreated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`carID`),
  KEY `fk_Car_Brand_idx` (`brandID`),
  KEY `fk_Car_Type_idx` (`cartypeID`),
  KEY `fk_Car_User_idx` (`userID`),
  KEY `fk_Car_FuelType_idx` (`fuelID`),
  CONSTRAINT `fk_Car_Brand` FOREIGN KEY (`brandID`) REFERENCES `brand` (`brandID`),
  CONSTRAINT `fk_Car_FuelType` FOREIGN KEY (`fuelID`) REFERENCES `fueltype` (`fuelID`),
  CONSTRAINT `fk_Car_Type` FOREIGN KEY (`cartypeID`) REFERENCES `cartype` (`carTypeID`),
  CONSTRAINT `fk_Car_User` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (1,2,2,6,2,_binary '','A','Black','Only about a mile away from the new Warm Springs / South Fremont bart station, so very easy to pick up this car if you are traveling via bart! ','R8 2009','JR-FK-203',30,150,2,2,'52.5024','13.4541','Berlin','2022-01-16 09:00:00'),(2,3,4,6,2,_binary '','A','Black','The epitome of class and style!! Drive around the city in style and make a statement.','GT 2013','IM-LW-539',80,400,4,2,'53.550724','9.981607','Hamburg','2022-01-17 09:05:00'),(3,4,7,4,2,_binary '','A','White','Very nice new Silverado! Nice truck for you to move stuff around, or just for the fun of it.','Silverado 1500 2021','NF-LB-240',15,90,4,4,'48.134365','11.563115','Munich','2022-01-18 09:10:00'),(4,5,11,5,2,_binary '','A','White','This isn’t your typical Ford Transit you see so many of in the freeway. It has a lot of upgrades to make your trip more enjoyable for everyone coming. ','Transit Wagon 2015','FF-XH-978',30,120,10,5,'50.120314','8.699794','Frankfurt','2022-01-19 09:15:00'),(5,6,14,1,2,_binary '','A','Silver','A brand-new Accord LX, fresh from the dealership. Good on gas, excellent A/C, friendly CarPlay, USB chargers, large trunk, 17 miles on the odometer at the time of this writing.','Accord Sedan 2021','CN-MU-937',20,97,5,4,'50.923349','6.932998','Cologne','2022-01-20 09:20:00'),(6,2,15,1,2,_binary '','A','Blue','I bought this Sonata because I’ve had a great experience with a previous/older version back in 2014. Hyundai’s are known to be very fuel efficient, and when they’re well-taken care off they can last a lifetime. ','Sonata 2016','BH-XO-205',10,48,5,4,'51.209267','6.79653','Düsseldorf','2022-01-21 09:25:00'),(7,3,18,2,2,_binary '','A','Black','The 2019 Jeep Wrangler is the latest iteration of the iconic Jeep rock-crawler, newly redesigned last year with more features, power, safety and off-road ability.','Wrangler Unlimited 2019','YM-VE-695',20,120,5,4,'51.331647','12.379598','Leipzig','2022-01-22 09:30:00'),(8,4,21,1,2,_binary '','M','Silver','The Lexus ux drives how you would expect a Lexus to drive. The turning capability of this car is crazy making for very tight turns. Could have up to three bike racks upon request.','Ux 2019','TG-VC-619',10,63,5,4,'49.447295','11.079753','Nuremberg','2022-01-23 09:35:00'),(9,5,26,6,2,_binary '','A','Red','If you enjoy driving and seek to have an open top experience this car is for you. 6 speed manual, bright red, so much fun. The journalists are right when they say the answer is always Miata. ','MX-5 Miata','XQ-LS-689',10,68,2,2,'50.115199','8.688627','Frankfurt','2022-01-24 09:40:00'),(10,6,27,6,2,_binary '','A','Black','The best or nothing. The brand that needs no introduction. The epitome of Luxury, when you’re looking for class, there’s really is no other option. Mercedes Benz. The answer to every question. ','C-Class 2018','LP-NJ-373',10,89,2,2,'52.50066','13.457645','Berlin','2022-01-25 09:45:00'),(11,2,30,2,2,_binary '','A','White','I am a power host with 5000+ trips on Turo, all my cars are well maintained , you can rent with ease and confidence. ','Outlander Sport 2011','UM-UP-131',10,56,5,4,'50.11131','8.662735','Frankfurt','2022-01-26 09:50:00'),(12,3,31,1,2,_binary '','A','Blue',' The leaf has a rating of 150 mile range on a full charge however from my experience you will be able to drive about 120-130 miles before you would need to charge with less than 20% battery remaining. ','Leaf 2019','QH-LV-80',10,57,5,1,'52.506425','13.461283','Berlin','2022-01-27 09:55:00'),(13,4,34,2,2,_binary '','A','Black','The Macan is infotainment system syncs with iPhones to help make your commute easier with google maps navigation and sync your favorite music app while driving.  You will need the USB type C cord.','Macan 2020','GI-SQ-5',15,116,5,4,'50.09163','8.673843','Frankfurt','2022-01-28 10:00:00'),(14,5,41,1,3,_binary '','A','Gray','Smart car will be a unique experience around the Bay Area, Saves you tremendously on gas, and let’s you squeeze in the smallest parking spaces.','fortwo 2013','JJ-UC-47',8,36,2,2,'52.519386','13.44756','Berlin','2022-01-29 10:05:00'),(15,6,44,1,3,_binary '','A','Black','This Model S is the perfect balance between efficiency and ferocity, with a high EPA rating for electric vehicles and a 0-60 launch speed of 4.2 seconds, the ride will surely have you grinning ear to ear.','Model S 2016','GO-HS-964',20,151,5,4,'52.520601','13.430898','Berlin','2022-01-30 10:10:00'),(16,2,45,1,4,_binary '','A','Yellow','How would you like to take a trip in the rarest color Prius C? The sunbeam yellow will definitely put a smile on your face :).','Prius c 2014','EA-GO-78',8,53,5,4,'52.520146','13.424894','Berlin','2022-01-31 10:15:00'),(17,3,46,1,2,_binary '','A','Black','This is a brand new car. Less than 1 month old. The car is a little sister to Audi A7. Build on the same platform. ','Arteon 2020','UE-SS-521',15,115,5,4,'52.517468','13.418396','Berlin','2022-02-01 10:20:00'),(18,4,47,2,2,_binary '','A','Blue','Capable and elegant, the XC60 Momentum delivers the design, technology and performance you need to accommodate your adventures as well as your everyday journeys.','XC60 2019','YN-WY-427',10,86,5,4,'52.516985','13.412755','Berlin','2022-02-02 10:25:00'),(19,5,2,2,3,_binary '','A','Black','Brand new Audi E-Tron Premium plus. Luxurious, Powerful, quiet and fun Fully Electric SUV.  Fully loaded - cameras galore, screens a plenty','E-Tron 2019','EQ-PZ-247',28,140,5,4,'52.519257','13.407594','Berlin','2022-02-03 10:30:00'),(20,6,4,1,2,_binary '','A','Orange','You are looking at my red 2013 VW Jetta SE. I have three other VW Jettas on the platform and they are booked up so frequently I decided to just buy a fourth one.','Jetta 2013','BX-QK-392',10,45,5,4,'52.521732','13.401637','Berlin','2022-02-04 10:35:00'),(21,2,7,6,2,_binary '','A','Red','The FULL Corvette experience! This Candy Red Corvette Stingray with Red Leather interior is the ultimate ride!','Corvette Stingray 2014','GM-BR-15',20,150,2,2,'52.527011','13.4064','Berlin','2022-02-05 10:40:00'),(22,3,11,6,2,_binary '','A','Blue','Book your next trip in California style, with a classic dream car in a sporty grabber-blue hue.','Mustang 2010','SE-WI-1',10,53,3,2,'52.524956','13.395377','Berlin','2022-02-06 10:45:00'),(23,4,14,2,4,_binary '','A','White','This is the suv you wanna drive when you in San Francisco, is 4wd you can go to Tahoe anyway.  It’s  hybrid and gas saver suv, the lane keeper ,adoptive cruise control and brake hold make this suv unique.','','LO-E-45',15,89,5,4,'52.520667','13.390985','Berlin','2022-02-07 10:50:00'),(24,5,15,1,2,_binary '','A','Gold','This is a go get work done minimalist’s car. No frills, just get in and drive. Ideal for a short trip or a weekend getaway with a friend or two. ','Accent 2015','HQ-Z-44',15,50,5,4,'52.519068','13.385531','Berlin','2022-02-08 10:55:00'),(25,6,18,2,2,_binary '','M','Red','Brand new 2021 full fire cracker red rubicon.','Wrangler Unlimited 2021','PP-J-37',10,89,5,4,'52.508004','13.363391','Berlin','2022-02-09 11:00:00'),(26,2,21,2,2,_binary '','A','Black','Next to Bank of America. The major cross street is Steven Creek and Wolfe','RX 350 2013','NS-O-97',10,89,5,4,'52.519327','13.367407','Berlin','2022-02-10 11:05:00'),(27,3,26,6,2,_binary '','A','Silver','Since its introduction in 1989, the Mazda MX-5 Miata has been beloved by drivers all over the world, and for 2020 this automotive icon continues to be the focused sports car we love. ','MX-5 Miata RF 2020','UW-H-6',20,135,2,2,'52.538424','13.390742','Berlin','2022-02-11 11:10:00'),(28,4,27,2,2,_binary '','A','Black','It is cheaper to uber to my location to pick up the car (12min ride, and towards SF) than to request a $120 SFO delivery. ','GL-Class 2010','IN-W-76',10,69,5,4,'52.486648','13.427353','Berlin','2022-02-12 11:15:00'),(29,5,30,2,2,_binary '','A','Blue','Drive your next adventure in Style and confort make it an ideal driving experience. Mitsubishi Outlander is a S.U.V sport ,low fuel consumption, spacious so you can explore any type of terrain. ','Outlander Sport 2020','VZ-M-99',15,62,5,4,'52.486979','13.431324','Berlin','2022-02-13 11:20:00'),(30,6,31,1,2,_binary '','A','Gray','This 2018 Nissan Versa is the perfect car to get around town or book for a weekend getaway! It is easy to park, fun to drive, and great on gas!  ','Versa 2018','CO-C-22',10,45,5,1,'52.481018','13.441799','Berlin','2022-02-14 11:25:00'),(31,2,34,6,2,_binary '','A','Orange','Effortless performance, superb handling, and everyday usability makes the 911 a joy to drive, which will put a smile on your face as you wind your way along a twisting road while listening to the amazing engine sound!:)','911 2013','KA-L-20',25,176,2,2,'52.477767','13.439803','Berlin','2022-02-15 11:30:00'),(32,3,41,1,3,_binary '','A','Blue','This is as close to a Mercedes Benz go-kart as it is gonna get. Be sure to use the paddle shifters to smoke that tech-geek hipster is Prius off the stop light. ','fortwo 2009','RI-D-85',8,47,2,2,'52.477838','13.432546','Berlin','2022-02-16 11:35:00'),(33,4,44,1,3,_binary '','A','White','2021 Tesla Model 3, long range, all wheel drive vehicle boasts a 0-60 of 4.2s, and an impressive range of 315 to 350 miles on a single charge','Model 3 2021','CV-L-75',10,98,5,4,'52.475737','13.423753','Berlin','2022-02-17 11:40:00'),(34,5,45,4,2,_binary '','A','White','This Toyota Tacoma is an easy to drive hauler to get that home improvement project started (or finished), get that garage cleaned out or pick up the perfect sofa you just found on Craigslist. ','Tacoma 2010','ZS-G-39',10,62,3,2,'52.480208','13.378456','Berlin','2022-02-18 11:45:00'),(35,6,46,1,2,_binary '','A','Yellow','Enjoy the experience of driving this one & only Volkswagen Arteon in the bay area with this factory vibrant color. Enjoy drives to Napa, Tahoe, Monterey, or even LA for a night on the town or even special occasion.','Arteon 2019','DD-C-89',10,79,5,4,'52.492068','13.38146','Berlin','2022-02-19 11:50:00'),(36,2,47,2,2,_binary '','A','Black','Meet Valeria, aka Valerian Steel of SUVs. This new model by Volvo is the more affordable Tesla SUV (in my opinion). My trusty 2020 Volvo XC40 will get you there in true Bay Area fashion.','XC40 2020','LY-WOF-60',18,110,5,4,'52.485302','13.522695','Berlin','2022-02-20 11:55:00'),(37,3,14,1,4,_binary '','A','Red','You are booking fully loaded Accord hybrid that will give you around 40mpg. Comes loaded with premium sound, navigation, leather and front heated seats, sunroof, Blind spot camera, and Bluetooth connectivity.','Accord Hybrid 2015','CQ-SLX-17',12,80,5,4,'52.490572','13.518912','Berlin','2022-02-21 12:00:00'),(38,4,18,2,2,_binary '','A','Silver','This is Bucky; a 2021 2-door soft-top Willys with max traction mud-terrain tires for your city and adventuring needs. ','Wrangler 2021','G-OCV-84',13,86,4,2,'52.498772','13.5122','Berlin','2022-02-22 12:05:00'),(39,5,27,2,2,_binary '','M','Silver','Mercedes G-Wagon available for your pleasure. It is so nice to drive super smooth. Eight cylinders makes it go very fast. The Sun roof is perfect for traveling around, you will not be disappointed with this ride. ','G-Class 2012','T-PVX-59',15,101,5,4,'52.503506','13.509885','Berlin','2022-02-23 12:10:00'),(40,6,44,1,3,_binary '','A','Orange','Driving a Tesla is an experience like no other. If you are looking to buying a Tesla but are not sure how they drive then take mine and try it out yourself.','Model 3 2021','A-STV-72',16,109,5,4,'52.509697','13.505969','Berlin','2022-02-24 12:15:00'),(41,2,45,4,2,_binary '','A','Blue','Blue Tacoma in San Francisco for rent by owner. Reserved parking so you don’t have to worry about circling around at the end of your rental looking for a spot or getting stuck with parking tickets!!!','Tacoma 2019','D-HBZ-62',10,68,5,4,'52.513395','13.496945','Berlin','2022-02-25 12:20:00'),(42,3,46,2,2,_binary '','A','Silver','If your looking for the perfect size SUV for your friend’s, and family too get around in ,and great on gas, well look no more. ','Atlas 2018','B-HTK-982',15,90,5,4,'52.513161','13.483589','Berlin','2022-02-26 12:25:00'),(43,4,14,3,2,_binary '','A','Red','CURBSIDE delivery to many popular Bay Area locations including SFO and OAK. We meet at the Arrivals/Departures terminals for delivery and pickup, no need to shuttle or Uber anywhere to get to your car.','Odyssey 2022','U-FUJ-846',15,80,8,4,'52.510858','13.477056','Berlin','2022-02-27 12:30:00'),(44,5,18,2,2,_binary '','A','Yellow','High-end upgrade components (Metalcloak and Fox) installed for total amount of $25k making the total cost of this truck close to $100k.','Wrangler 2021','Z-ZGV-920',20,132,5,4,'52.536805','13.487097','Berlin','2022-02-28 12:35:00'),(45,6,27,1,2,_binary '','A','White','Hello! This gently used 2018 Mercedes Benz CLA 250 is available for rent. It has great gas mileage and rides smooth in the highway. It’s great for short road trips and nice drives around town. ','CLA-Class 2018','N-JIM-930',13,75,5,4,'52.543051','13.4937','Berlin','2022-03-01 12:40:00'),(46,2,44,2,3,_binary '','A','Black','Brand New 2020 Model X Performance Ludicrous+  (Black Exterior with Black Leather Seats) w/ Autopilot','Model X 2020','K-UIM-586',80,345,5,4,'52.551','13.481264','Berlin','2022-03-02 12:45:00'),(47,3,45,1,4,_binary '','A','Silver','The 2014 Prius Four is super easy  to drive and great on gas! The wide interior frame makes long-distance road trips amazingly comfortable with tons of trunk space to store laundry, groceries, or luggage. The Prius is the perfect car for any traveling need.','Prius 2014','S-THN-761',10,58,5,4,'52.543156','13.471021','Berlin','2022-03-03 12:50:00'),(48,4,46,1,2,_binary '','M','Blue','This is a Beautiful Unique convertible VW Blue Car with Brown interior leather. You will Enjoy the Bay Area on this free air VW. This is the last Edition of this timeless car. We frequently get the attention of other drivers and we think you will as well. Drive the Bay Area in Style.','Beetle 2015','P-OKK-654',10,69,4,2,'52.558778','13.434185','Berlin','2022-03-04 12:55:00'),(49,5,3,6,4,_binary '','A','Black','I would like to present this beautiful, matte black I8 with black interior. (will make you feel like you are Batman)','i8 2016','F-TAC-255',80,229,4,2,'52.482218','13.483905','Berlin','2022-03-05 13:00:00'),(50,6,3,6,4,_binary '','A','White','the epitome of driving excellence and top level performance from one of the top auto makers. This isn’t your average BMW. This car will turn heads everywhere you go, ','i8 2015','X-MLA-229',70,300,4,2,'52.456708','13.53142','Berlin','2022-03-06 13:05:00');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartype`
--

DROP TABLE IF EXISTS `cartype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartype` (
  `carTypeID` tinyint NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`carTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartype`
--

LOCK TABLES `cartype` WRITE;
/*!40000 ALTER TABLE `cartype` DISABLE KEYS */;
INSERT INTO `cartype` VALUES (1,'Cars'),(2,'SUVs'),(3,'Minivans'),(4,'Trucks'),(5,'Vans'),(6,'Sportcars'),(7,'RVs'),(8,'Limousine');
/*!40000 ALTER TABLE `cartype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq` (
  `faqID` int NOT NULL AUTO_INCREMENT,
  `question` varchar(255) DEFAULT NULL,
  `answer` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`faqID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
INSERT INTO `faq` VALUES (1,'What do I need to book a car on CarBnB?','To book a car on CarBnB, you must create a CarBnB account, be 18 years old or older with a valid driver’s license, and get approved to drive on CarBnB. In most cases, you’ll get approved immediately, and you’ll be set for every future road trip, business trip, and family vacation!'),(2,'Do I need my own insurance?','No, you don’t need personal insurance coverage to book a car on CarBnB. But, any personal insurance you may have that covers damage to the host’s vehicle would kick in before your CarBnB protection plan.When booking a car on CarBnB, you’ll choose between three protection plans — Premier, Standard, or Minimum — to get the level of coverage that’s right for you. With each plan, you’re covered with insurance provided under a policy issued to CarBnB.'),(3,'Do I need a region specific license to drive?','No, you don’t need a region specific license to book a car. But you do need a valid driver’s license — most international driver’s licenses are accepted.'),(4,'Can other people drive a car that I booked?','Yes, multiple guests can drive the car you book on CarBnB, as long as they are all approved to drive. The primary driver (whoever booked the car) can add additional drivers with no fees or additional charges. Only the primary driver can request to add drivers; CarBnB hosts cannot do it for you. We encourage you to request to add additional drivers before your trip starts.'),(5,'What is the cancellation policy on CarBnB?','You can cancel and get a full refund up to 24 hours before your trip starts. If you book a trip with less than 24 hours’ notice, you have one hour after booking to cancel free of charge.In the rare event a host cancels, you’ll be notified immediately so you can book another car.'),(6,'What happens if I have an accident?','If there’s an emergency or an issue with the car, call our emergency roadside assistance provider, available 24/7. We’ll make sure you’re safe, then help you get back on your way.'),(7,'Can I get my car delivered to me?','Yes, many hosts offer delivery to travel hubs like airports, train stations, and hotels, or to custom delivery locations. There are cars available on CarBnB near hundreds of airports, or you can have your car delivered for pickup and return at your hotel or vacation rental to save time and hassle. Some hosts offer free delivery, while others set their own delivery fee.'),(8,'What are the cleaning and safety policies on CarBnB?','Under the enhanced cleaning policy, hosts are required to clean and disinfect their vehicles thoroughly before every trip, so you can feel safe and comfortable behind the wheel. CarBnB hosts have access to training materials on enhanced cleaning practices to help prevent the spread of COVID-19 or other viruses. ');
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fueltype`
--

DROP TABLE IF EXISTS `fueltype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fueltype` (
  `fuelID` tinyint NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fuelID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fueltype`
--

LOCK TABLES `fueltype` WRITE;
/*!40000 ALTER TABLE `fueltype` DISABLE KEYS */;
INSERT INTO `fueltype` VALUES (1,'Diesel'),(2,'Gas'),(3,'Electric'),(4,'Hybrid');
/*!40000 ALTER TABLE `fueltype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance`
--

DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance` (
  `InsuranceID` tinyint NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `percentage` tinyint DEFAULT NULL,
  PRIMARY KEY (`InsuranceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance`
--

LOCK TABLES `insurance` WRITE;
/*!40000 ALTER TABLE `insurance` DISABLE KEYS */;
INSERT INTO `insurance` VALUES (1,'Premier plan','Includes a physical damage contract that limits your responsibility to 0 Euro',60),(2,'Standard plan','physical damage contract that limits your responsibility to 40% of Damage',40),(3,'Minimum plan','physical damage contract that limits your responsibility to 70% of Damage',20);
/*!40000 ALTER TABLE `insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `mediaID` int NOT NULL AUTO_INCREMENT,
  `carID` int DEFAULT NULL,
  `mediaLink` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mediaID`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,'/images/1.png'),(2,10,'/images/10.jpg'),(3,11,'/images/11.jpg'),(4,12,'/images/12.jpg'),(5,13,'/images/13.jpg'),(6,14,'/images/14.jpg'),(7,15,'/images/15.jpg'),(8,16,'/images/16.jpg'),(9,17,'/images/17.jpg'),(10,18,'/images/18.jpg'),(11,19,'/images/19.jpg'),(12,2,'/images/2.jpg'),(13,20,'/images/20.jpg'),(14,21,'/images/21.jpg'),(15,22,'/images/22.jpg'),(16,23,'/images/23.jpg'),(17,24,'/images/24.jpg'),(18,25,'/images/25.jpg'),(19,26,'/images/26.jpg'),(20,27,'/images/27.jpg'),(21,27,'/images/27-1.jpg'),(22,28,'/images/28.jpg'),(23,29,'/images/29.jpg'),(24,3,'/images/3.jpg'),(25,30,'/images/30.jpg'),(26,31,'/images/31.jpg'),(27,32,'/images/32.jpg'),(28,33,'/images/33.jpg'),(29,34,'/images/34.jpg'),(30,35,'/images/35.jpg'),(31,36,'/images/36.jpg'),(32,37,'/images/37.jpg'),(33,38,'/images/38.jpg'),(34,39,'/images/39.jpg'),(36,4,'/images/4.jpg'),(37,40,'/images/40.jpg'),(38,41,'/images/41.jpg'),(39,42,'/images/42.jpg'),(40,43,'/images/43.jpg'),(41,44,'/images/44.jpg'),(42,45,'/images/45.jpg'),(43,46,'/images/46.jpg'),(44,47,'/images/47.jpg'),(45,48,'/images/48.jpg'),(46,49,'/images/49.jpg'),(47,5,'/images/5.jpg'),(48,50,'/images/50.jpg'),(50,6,'/images/6.jpg'),(51,7,'/images/7.jpg'),(52,8,'/images/8.jpg'),(53,9,'/images/9.jpg');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `carID` int DEFAULT NULL,
  `ownerID` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `insuranceID` tinyint DEFAULT NULL,
  `statusID` tinyint DEFAULT NULL,
  `fromTime` datetime DEFAULT NULL,
  `toTime` datetime DEFAULT NULL,
  `total` decimal(10,0) DEFAULT NULL,
  `delivery` tinyint DEFAULT NULL,
  `transactionTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderID`),
  KEY `fk_Transaction_Owner_idx` (`ownerID`),
  KEY `fk_Transaction_User_idx` (`userID`),
  KEY `fk_Transaction_Car_idx` (`carID`),
  KEY `fk_Transaction_Status1_idx` (`statusID`),
  KEY `fk_Transaction_Insurance_idx` (`insuranceID`),
  CONSTRAINT `fk_Transaction_Car` FOREIGN KEY (`carID`) REFERENCES `car` (`carID`),
  CONSTRAINT `fk_Transaction_Insurance` FOREIGN KEY (`insuranceID`) REFERENCES `insurance` (`InsuranceID`),
  CONSTRAINT `fk_Transaction_Status` FOREIGN KEY (`statusID`) REFERENCES `orderstatus` (`orderStatusID`),
  CONSTRAINT `fk_Transaction_User` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `fk_Transaction_User_Owner` FOREIGN KEY (`ownerID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,2,4,1,1,'2022-02-03 11:30:00','2022-02-04 11:30:00',30,0,'2022-01-24 19:25:23'),(2,2,3,4,3,2,'2022-02-04 00:00:00','2022-02-04 00:00:00',35,0,'2022-01-26 19:25:23'),(3,3,4,3,3,1,'2022-02-04 00:00:00','2022-02-04 00:00:00',50,0,'2022-01-26 19:26:13'),(4,4,5,3,3,2,'2022-02-04 00:00:00','2022-02-04 00:00:00',60,0,'2022-01-26 19:27:26'),(5,5,6,5,2,1,'2022-02-03 11:30:00','2022-02-05 11:30:00',65,1,'2022-01-26 19:27:26'),(6,6,2,5,1,2,'2022-02-03 11:30:00','2022-02-05 11:30:00',70,0,'2022-01-26 19:27:26'),(7,7,3,6,1,1,'2022-02-03 11:30:00','2022-02-05 11:30:00',75,1,'2022-01-26 19:27:26'),(8,8,4,6,2,2,'2022-02-03 11:30:00','2022-02-05 11:30:00',80,1,'2022-01-26 19:27:26'),(9,9,5,2,3,1,'2022-02-03 11:30:00','2022-02-05 11:30:00',85,0,'2022-01-26 19:27:26'),(10,10,6,2,2,2,'2022-02-03 11:30:00','2022-02-05 11:30:00',100,1,'2022-01-26 19:27:26');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderstatus`
--

DROP TABLE IF EXISTS `orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderstatus` (
  `orderStatusID` tinyint NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderstatus`
--

LOCK TABLES `orderstatus` WRITE;
/*!40000 ALTER TABLE `orderstatus` DISABLE KEYS */;
INSERT INTO `orderstatus` VALUES (1,'Active'),(2,'Pending'),(3,'Finished'),(4,'Rejected'),(5,'Canceled');
/*!40000 ALTER TABLE `orderstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `phoneNumber` varchar(45) DEFAULT NULL,
  `password` varchar(60) NOT NULL,
  `profilePic` varchar(255) DEFAULT NULL,
  `dateCreated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `Email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Max','Mustermann','2001-01-20','max.mustermann@informatik.hs-fulda.de','012345678','$2b$10$qI6lD9ioEvCapXwxY6.tLuB1kUD.5mzAFRPAkR2PBKsT/uSeoc4Ny',NULL,'2030-11-20 11:00:00'),(2,'Obada','Tinawi','1993-07-20','Obada@gmail.com','012345678','$2b$10$hKsq5jHmk4guODiLW19uCe/.OIleQhotuH8qXCrd4TVIyhsaWxpXa',NULL,'2022-01-16 10:11:57'),(3,'Ahmed','Shahid','1993-07-20','Ahmed@gmail.com','012345678','$2b$10$NW4RQkQ7yQ5ELMebHcEjH.DBg0jDVA9j79ss8uJv1fVot6huSElxK',NULL,'2022-01-16 10:13:42'),(4,'Julia','Nürnberg','1993-07-20','Julia@gmail.com','012345678','$2b$10$lPc00vSd89wo95HQUqteRuGSLpemz30sS/vrj.3xY8pONU6oQiDCi',NULL,'2022-01-16 10:14:01'),(5,'Joshua','Rahimi','1993-07-20','Joshua@gmail.com','012345678','$2b$10$4U9LpeoOF/c0PAB2UHIRhOHFTaAdqdlMqaBizVry6uw7kECYAfuVa',NULL,'2022-01-16 10:14:33'),(6,'Julian','Günther','1993-07-20','Julian@gmail.com','012345678','$2b$10$oQMj50Qtx4OujI0v55WL4.LrPJuIELxo5cFCLPNQy7JErBwXs4d6K',NULL,'2022-01-16 10:14:54');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

-- VIEWS

--
-- Final view structure for view `all_active_cars`
--
DROP VIEW IF EXISTS `all_active_cars`;
CREATE VIEW `all_active_cars` AS select `car`.`carID` AS `carID`,`car`.`userID` AS `userID`,concat(`user`.`firstName`,concat(' ',`user`.`LastName`)) AS `Name`,`brand`.`brand` AS `brand`,`cartype`.`Type` AS `Type`,`fueltype`.`Type` AS `fuel`, `car`.`status` AS `status`, (case when (`car`.`gear` = 'A') then 'Automatic' when (`car`.`gear` = 'M') then 'Manual' end) AS `gear`,`car`.`color` AS `color`,`car`.`description` AS `description`,`car`.`model` AS `model`,`car`.`plateNumber` AS `plateNumber`,`car`.`hourlyCost` AS `hourlyCost`,`car`.`dailyCost` AS `dailyCost`,`car`.`seats` AS `seats`,`car`.`doors` AS `doors`,`car`.`lat` AS `lat`,`car`.`long` AS `long`,`car`.`city` AS `city`, `car`.`dateCreated` AS `dateCreated`, `media`.`mediaLink` as `mediaLink` from ((((`car` left join `brand` on((`brand`.`brandID` = `car`.`brandID`))) left join `cartype` on((`cartype`.`carTypeID` = `car`.`cartypeID`))) left join `fueltype` on((`fueltype`.`fuelID` = `car`.`fuelID`))) left join `user` on((`user`.`userID` = `car`.`userID`)) left join `media` on (`car`.`carID` = `media`.`carID`)) where (`car`.`status` = 1);

--
-- Final view structure for view `all_cars`
--
DROP VIEW IF EXISTS `all_cars`;
CREATE VIEW `all_cars` AS select `car`.`carID` AS `carID`,`car`.`userID` AS `userID`,concat(`user`.`firstName`,concat(' ',`user`.`LastName`)) AS `Name`,`brand`.`brand` AS `brand`,`cartype`.`Type` AS `Type`,`fueltype`.`Type` AS `fuel`, `car`.`status` AS `status`, (case when (`car`.`gear` = 'A') then 'Automatic' when (`car`.`gear` = 'M') then 'Manual' end) AS `gear`,`car`.`color` AS `color`,`car`.`description` AS `description`,`car`.`model` AS `model`,`car`.`plateNumber` AS `plateNumber`,`car`.`hourlyCost` AS `hourlyCost`,`car`.`dailyCost` AS `dailyCost`,`car`.`seats` AS `seats`,`car`.`doors` AS `doors`,`car`.`lat` AS `lat`,`car`.`long` AS `long`,`car`.`city` AS `city`,`car`.`dateCreated` AS `dateCreated`, `media`.`mediaLink` as `mediaLink` from ((((`car` left join `brand` on((`brand`.`brandID` = `car`.`brandID`))) left join `cartype` on((`cartype`.`carTypeID` = `car`.`cartypeID`))) left join `fueltype` on((`fueltype`.`fuelID` = `car`.`fuelID`))) left join `user` on((`user`.`userID` = `car`.`userID`)) left join `media` on (`car`.`carID` = `media`.`carID`));