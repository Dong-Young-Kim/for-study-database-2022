SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `inha_db` DEFAULT CHARACTER SET utf8 ;
USE `inha_db` ;


CREATE TABLE IF NOT EXISTS `inha_db`.`building` (
  `bid` INT NOT NULL,
  `b_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`bid`),
  UNIQUE INDEX `bname_UNIQUE` (`b_name` ASC))
ENGINE = InnoDB;


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
  CONSTRAINT `fk_department_room1`
    FOREIGN KEY (`rid`)
    REFERENCES `inha_db`.`room` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `inha_db`.`student` (
  `sid` INT NOT NULL AUTO_INCREMENT,
  `s_name` VARCHAR(15) NOT NULL,
  `s_email` VARCHAR(35) NULL,
  `s_phonenumber` VARCHAR(15) NULL,
  `major` VARCHAR(30) NOT NULL,
  `stunentid` INT NOT NULL,
  `did` INT NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE INDEX `stunentid_UNIQUE` (`stunentid` ASC),
  INDEX `fk_student_department1_idx` (`did` ASC),
  UNIQUE INDEX `s_email_UNIQUE` (`s_email` ASC),
  UNIQUE INDEX `s_phonenumber_UNIQUE` (`s_phonenumber` ASC),
  CONSTRAINT `fk_student_department1`
    FOREIGN KEY (`did`)
    REFERENCES `inha_db`.`department` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `inha_db`.`class` (
  `cid` INT NOT NULL,
  `cname` VARCHAR(40) NOT NULL,
  `professor` VARCHAR(20) NOT NULL,
  `numofpartticipants` INT NOT NULL,
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


CREATE TABLE IF NOT EXISTS `inha_db`.`sign_up` (
  `class_cid` INT NOT NULL,
  `student_sid` INT NOT NULL,
  INDEX `fk_class_has_student_student1_idx` (`student_sid` ASC),
  INDEX `fk_class_has_student_class1_idx` (`class_cid` ASC),
  PRIMARY KEY (`student_sid`, `class_cid`),
  CONSTRAINT `fk_class_has_student_class1`
    FOREIGN KEY (`class_cid`)
    REFERENCES `inha_db`.`class` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_class_has_student_student1`
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
VALUES    (12204284, 'kim dong young', 'point1270@gmail.com', '010-9619-5317', 'information comminication eng', 12204284, 111),
          (12202929, 'lee inha', 'inhha@inha.edu', '010-3343-2132', 'computer engineering', 12202929, 112),
          (12170990, 'hong kildong', 'kildong@inha.edu', NULL, 'information comminication eng', 12170990, 111 ),
          (12213234, 'park cheolsoo', '12213234@inha.edu', '010-4339-9493', 'mechenical engineering', 12213234, 130),
          (12183223, 'hwang kelly', NULL, NULL, 'information comminication eng', 12183223, 111);

INSERT INTO sign_up
VALUES    (10902, 12204284),
          (10901, 12204284),
          (10901, 12170990),
          (11100, 12202929),
          (18900, 12213234);