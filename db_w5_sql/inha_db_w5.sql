-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema inha_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inha_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inha_db` DEFAULT CHARACTER SET utf8 ;
USE `inha_db` ;

-- -----------------------------------------------------
-- Table `inha_db`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`building` (
  `bid` INT NOT NULL,
  `b_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`bid`),
  UNIQUE INDEX `bname_UNIQUE` (`b_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`room` (
  `rid` INT NOT NULL,
  `r_name` VARCHAR(20) NOT NULL,
  `capacity` INT NOT NULL,
  `bid` INT NOT NULL,
  PRIMARY KEY (`rid`),
  INDEX `fk_room_building_idx` (`bid` ASC),
  UNIQUE INDEX `r_name_UNIQUE` (`r_name` ASC),
  CONSTRAINT `fk_room_building`
    FOREIGN KEY (`bid`)
    REFERENCES `inha_db`.`building` (`bid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`department` (
  `did` INT NOT NULL,
  `d_name` VARCHAR(50) NOT NULL,
  `d_email` VARCHAR(35) NOT NULL,
  `d_phonenumber` VARCHAR(15) NOT NULL,
  `rid` INT NOT NULL,
  PRIMARY KEY (`did`),
  UNIQUE INDEX `d_name_UNIQUE` (`d_name` ASC),
  UNIQUE INDEX `d_email_UNIQUE` (`d_email` ASC),
  UNIQUE INDEX `d_phonenumber_UNIQUE` (`d_phonenumber` ASC),
  INDEX `fk_department_room1_idx` (`rid` ASC),
  UNIQUE INDEX `rid_UNIQUE` (`rid` ASC),
  CONSTRAINT `fk_department_room1`
    FOREIGN KEY (`rid`)
    REFERENCES `inha_db`.`room` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`student` (
  `sid` INT NOT NULL AUTO_INCREMENT,
  `s_name` VARCHAR(15) NOT NULL,
  `s_email` VARCHAR(35) NULL,
  `s_phonenumber` VARCHAR(15) NULL,
  `stunentid` INT NOT NULL,
  `major_did` INT NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE INDEX `stunentid_UNIQUE` (`stunentid` ASC),
  INDEX `fk_student_department1_idx` (`major_did` ASC),
  UNIQUE INDEX `s_email_UNIQUE` (`s_email` ASC) VISIBLE,
  UNIQUE INDEX `s_phonenumber_UNIQUE` (`s_phonenumber` ASC),
  CONSTRAINT `fk_student_department1`
    FOREIGN KEY (`major_did`)
    REFERENCES `inha_db`.`department` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`class` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(40) NOT NULL,
  `professor` VARCHAR(20) NOT NULL,
  `numOfPartticipants` INT NOT NULL,
  `rid` INT NOT NULL,
  `did` INT NOT NULL,
  PRIMARY KEY (`cid`),
  INDEX `fk_class_room1_idx` (`rid` ASC),
  INDEX `fk_class_department1_idx` (`did` ASC),
  CONSTRAINT `fk_class_room1`
    FOREIGN KEY (`rid`)
    REFERENCES `inha_db`.`room` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_class_department1`
    FOREIGN KEY (`did`)
    REFERENCES `inha_db`.`department` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`sign_up`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`sign_up` (
  `class_cid` INT NOT NULL,
  `student_sid` INT NOT NULL,
  INDEX `fk_class_has_student_student1_idx` (`student_sid` ASC),
  INDEX `fk_class_has_student_class1_idx` (`class_cid` ASC),
  PRIMARY KEY (`student_sid`, `class_cid`),
  CONSTRAINT `sign_up_class`
    FOREIGN KEY (`class_cid`)
    REFERENCES `inha_db`.`class` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sign_up_student`
    FOREIGN KEY (`student_sid`)
    REFERENCES `inha_db`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`club` (
  `clid` INT NOT NULL AUTO_INCREMENT,
  `clname` VARCHAR(45) NULL,
  PRIMARY KEY (`clid`),
  UNIQUE INDEX `clname_UNIQUE` (`clname` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`employee` (
  `eid` INT NOT NULL AUTO_INCREMENT,
  `ename` VARCHAR(20) NOT NULL,
  `position_did` INT NOT NULL,
  PRIMARY KEY (`eid`),
  INDEX `fk_employee_department1_idx` (`position_did` ASC),
  CONSTRAINT `fk_employee_department1`
    FOREIGN KEY (`position_did`)
    REFERENCES `inha_db`.`department` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inha_db`.`club_join`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inha_db`.`club_join` (
  `club_clid` INT NOT NULL,
  `student_sid` INT NOT NULL,
  PRIMARY KEY (`club_clid`, `student_sid`),
  INDEX `fk_club_has_student_student1_idx` (`student_sid` ASC),
  INDEX `fk_club_has_student_club1_idx` (`club_clid` ASC),
  CONSTRAINT `fk_club_has_student_club1`
    FOREIGN KEY (`club_clid`)
    REFERENCES `inha_db`.`club` (`clid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_student_student1`
    FOREIGN KEY (`student_sid`)
    REFERENCES `inha_db`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO building
VALUES    (001, 'Main Building'),
          (007, 'Student Center'),
          (010, 'Hi-Tech Center'),
          (060, '60th Hall'),
          (100, 'Jeongseok Library');

INSERT INTO room
VALUES    (10232, '232', 50, 010),
          (10424, '424', 30, 010),
          (10426, '426', 30, 010),
          (60229, '229', 100, 010),
          (10002, '002', 50, 010),
          (07513, '513', 10, 007),
          (10342, '342', 10, 010),
          (10532, '532', 10, 010),
          (10736, '736', 10, 010);

INSERT INTO department
VALUES    (111, 'information comminication engineering', 'ice@inha.ac.kr', '032-860-7430', 10532),
          (112, 'computor engineering', 'ce@inha.ac.kr', '032-860-5843', 10736),
          (130, 'mechenical engineering', 'me@inha.ac.kr', '032-860-3234', 60229),
          (113, 'electrical engineering', 'ee@inha.ac.kr', '032-860-1223', 10342),
          (120, 'aerospace engineering', 'ase@inha.ac.kr', '032-860-1322', 10426);

INSERT INTO class
VALUES    (10900, 'database capstone design', 'choi wonik', 80, 10232, 111),
          (10901, 'mobile communication', 'kim duk kyoung', 50, 10232, 111),
          (10902, 'operating system', 'kim ki chang', 40, 10426, 111),
          (18900, 'vibration engineering', 'lee usik', 30, 10342, 130),
          (11100, 'algorithm', 'kim youngho', 70, 10736, 112);


INSERT INTO student
VALUES    (NULL, 'kim dong young', 'point1270@gmail.com', '010-9619-5317', 12204284, 111),
          (NULL, 'lee inha', 'inhha@inha.edu', '010-3343-2132', 12202929, 112),
          (NULL, 'hong kildong', 'kildong@inha.edu', NULL, 12170990, 111 ),
          (NULL, 'park cheolsoo', '12213234@inha.edu', '010-4339-9493', 12213234, 130),
          (NULL, 'hwang kelly', NULL, NULL, 12183223, 111);

INSERT INTO sign_up
VALUES    (10902, 1),
          (10901, 1),
          (10901, 3),
          (11100, 2),
          (18900, 5);
          
INSERT INTO club
VALUES	  	(NULL, "Sing Club"),
			(NULL, "Dance Club"),
            (NULL, "Programming Club"),
            (NULL, "Health Club"),
            (NULL, "Travel Club");
            
INSERT INTO employee
VALUES		(1001, 'park', 111),
			(1002, 'kang', 130),
            (1003, 'kang', 111),
            (1004, 'kang', 120),
            (1005, 'kang', 130);

INSERT INTO club_join
VALUES    (1, 1),
          (2, 1),
          (1, 3),
          (3, 2),
          (4, 5);


