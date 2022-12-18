-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema car_dealer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema car_dealer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `car_dealer` DEFAULT CHARACTER SET utf8 ;
USE `car_dealer` ;

-- -----------------------------------------------------
-- Table `car_dealer`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`User` (
  `uid` INT NOT NULL,
  `id` VARCHAR(20) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`uid`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `car_dealer`.`User` (`id` ASC) VISIBLE;

CREATE UNIQUE INDEX `user_UNIQUE` ON `car_dealer`.`User` (`uid` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `car_dealer`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`Customer` (
  `Ssn` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Ssn`),
  CONSTRAINT `customer_id`
    FOREIGN KEY (`Ssn`)
    REFERENCES `car_dealer`.`User` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_dealer`.`Model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`Model` (
  `Mid` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Mid`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Name_UNIQUE` ON `car_dealer`.`Model` (`Name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `car_dealer`.`Vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`Vehicle` (
  `Vin` INT NOT NULL AUTO_INCREMENT,
  `Mid` INT NOT NULL,
  `Price` INT NOT NULL,
  `Ssn` INT NULL,
  PRIMARY KEY (`Vin`),
  CONSTRAINT `Reservation`
    FOREIGN KEY (`Ssn`)
    REFERENCES `car_dealer`.`Customer` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Vehicle_model`
    FOREIGN KEY (`Mid`)
    REFERENCES `car_dealer`.`Model` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Vehicle_Customer1_idx` ON `car_dealer`.`Vehicle` (`Ssn` ASC) VISIBLE;

CREATE INDEX `fk_Vehicle_model1_idx` ON `car_dealer`.`Vehicle` (`Mid` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `car_dealer`.`Salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`Salesperson` (
  `SId` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`SId`),
  CONSTRAINT `salesperson_id`
    FOREIGN KEY (`SId`)
    REFERENCES `car_dealer`.`User` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_dealer`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`sale` (
  `Vin` INT NOT NULL,
  `SId` INT NOT NULL,
  `Ssn` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `saled` VARCHAR(10) NULL,
  PRIMARY KEY (`Vin`, `SId`, `Ssn`),
  CONSTRAINT `sales_vehicle`
    FOREIGN KEY (`Vin`)
    REFERENCES `car_dealer`.`Vehicle` (`Vin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sales_person`
    FOREIGN KEY (`SId`)
    REFERENCES `car_dealer`.`Salesperson` (`SId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `buying_customer`
    FOREIGN KEY (`Ssn`)
    REFERENCES `car_dealer`.`Customer` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_sale_Salesperson1_idx` ON `car_dealer`.`sale` (`SId` ASC) VISIBLE;

CREATE UNIQUE INDEX `Vehicle_Vin_UNIQUE` ON `car_dealer`.`sale` (`Vin` ASC) VISIBLE;

CREATE INDEX `fk_sale_Customer1_idx` ON `car_dealer`.`sale` (`Ssn` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `car_dealer`.`Car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`Car` (
  `Mid` INT NOT NULL,
  `Engine_size` INT NOT NULL,
  PRIMARY KEY (`Mid`),
  CONSTRAINT `fk_Car_Vehicle1`
    FOREIGN KEY (`Mid`)
    REFERENCES `car_dealer`.`Model` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Vehicle_Vin_UNIQUE` ON `car_dealer`.`Car` (`Mid` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `car_dealer`.`Truck`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`Truck` (
  `Mid` INT NOT NULL,
  `Tonnage` INT NOT NULL,
  PRIMARY KEY (`Mid`),
  CONSTRAINT `fk_Truck_Vehicle1`
    FOREIGN KEY (`Mid`)
    REFERENCES `car_dealer`.`Model` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Vehicle_Vin_UNIQUE` ON `car_dealer`.`Truck` (`Mid` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `car_dealer`.`SUV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`SUV` (
  `Mid` INT NOT NULL,
  `No_seats` INT NOT NULL,
  PRIMARY KEY (`Mid`),
  CONSTRAINT `fk_SUV_Vehicle1`
    FOREIGN KEY (`Mid`)
    REFERENCES `car_dealer`.`Model` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Vin_UNIQUE` ON `car_dealer`.`SUV` (`Mid` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `car_dealer`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealer`.`Address` (
  `Ssn` INT NOT NULL,
  `State` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  PRIMARY KEY (`Ssn`),
  CONSTRAINT `fk_Adress_Customer1`
    FOREIGN KEY (`Ssn`)
    REFERENCES `car_dealer`.`Customer` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `car_dealer`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (10001, 'cus001', 'pas0001');
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (10002, 'cus002', 'pas0002');
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (10003, 'cus003', 'pas0003');
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (10004, 'cus004', 'pas0004');
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (10005, 'cus005', 'pas0005');
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (20001, 'sal001', 'pas0001');
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (20002, 'sal002', 'pas0002');
INSERT INTO `car_dealer`.`User` (`uid`, `id`, `password`) VALUES (20003, 'sal003', 'pas0003');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`Customer` (`Ssn`, `Name`) VALUES (10001, '홍길동');
INSERT INTO `car_dealer`.`Customer` (`Ssn`, `Name`) VALUES (10002, 'John Doe');
INSERT INTO `car_dealer`.`Customer` (`Ssn`, `Name`) VALUES (10003, 'Jean Dupont');
INSERT INTO `car_dealer`.`Customer` (`Ssn`, `Name`) VALUES (10004, 'Juan Pérez');
INSERT INTO `car_dealer`.`Customer` (`Ssn`, `Name`) VALUES (10005, 'Mario Rossi');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`Model`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (10000, 'Equus');
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (10001, 'Elantra');
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (10002, 'Sorento');
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (20000, 'Elise');
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (20001, 'Tiguan');
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (30000, 'Porter');
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (31000, 'FH16');
INSERT INTO `car_dealer`.`Model` (`Mid`, `Name`) VALUES (31001, 'F150');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`Vehicle`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (1, 10002, 40000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (2, 10000, 40000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (3, 20000, 35000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (4, 20000, 35000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (5, 10001, 18000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (6, 20001, 45000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (7, 30000, 20000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (8, 10000, 40000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (9, 10002, 39000, NULL);
INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (10, 31000, 216000, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`Salesperson`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`Salesperson` (`SId`, `Name`) VALUES (20001, '김철수');
INSERT INTO `car_dealer`.`Salesperson` (`SId`, `Name`) VALUES (20002, 'Manuel dos Santos');
INSERT INTO `car_dealer`.`Salesperson` (`SId`, `Name`) VALUES (20003, '홍길동');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`Car`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`Car` (`Mid`, `Engine_size`) VALUES (10000, 5000);
INSERT INTO `car_dealer`.`Car` (`Mid`, `Engine_size`) VALUES (10001, 1600);
INSERT INTO `car_dealer`.`Car` (`Mid`, `Engine_size`) VALUES (20000, 3800);

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`Truck`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`Truck` (`Mid`, `Tonnage`) VALUES (30000, 1);
INSERT INTO `car_dealer`.`Truck` (`Mid`, `Tonnage`) VALUES (31000, 60);
INSERT INTO `car_dealer`.`Truck` (`Mid`, `Tonnage`) VALUES (31001, 2.5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`SUV`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`SUV` (`Mid`, `No_seats`) VALUES (10002, 7);
INSERT INTO `car_dealer`.`SUV` (`Mid`, `No_seats`) VALUES (20001, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_dealer`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_dealer`;
INSERT INTO `car_dealer`.`Address` (`Ssn`, `State`, `City`, `Street`) VALUES (10001, 'Seoul', '서울', '종로구');
INSERT INTO `car_dealer`.`Address` (`Ssn`, `State`, `City`, `Street`) VALUES (10002, 'Incheon', '인천', '미추홀구');
INSERT INTO `car_dealer`.`Address` (`Ssn`, `State`, `City`, `Street`) VALUES (10003, 'Pays de la Loire', 'Region', 'Le Mans');
INSERT INTO `car_dealer`.`Address` (`Ssn`, `State`, `City`, `Street`) VALUES (10004, 'Catalunya', NULL, NULL);
INSERT INTO `car_dealer`.`Address` (`Ssn`, `State`, `City`, `Street`) VALUES (10005, 'Emilia-Romagna', 'Modena', 'Maranello');

COMMIT;

-- -----------------------------------------------------
-- Data for table `car_dealer`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
CREATE VIEW stockModel AS 
SELECT NAME, COUNT(Vin) AS STOCK, MIN(PRICE) AS MIN_PRICE 
FROM MODEL LEFT JOIN VEHICLE ON MODEL.MID = VEHICLE.MID 
WHERE VEHICLE.Ssn IS NULL 
GROUP BY NAME;
COMMIT;