-- MySQL Script generated by MySQL Workbench
-- Sa 09 Mai 2015 18:56:01 CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bastelfreak_test
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bastelfreak_test` ;

-- -----------------------------------------------------
-- Schema bastelfreak_test
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bastelfreak_test` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `bastelfreak_test` ;

-- -----------------------------------------------------
-- Table `bastelfreak_test`.`cache_option`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`cache_option` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`cache_option` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cache_type` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE UNIQUE INDEX `cache_type_UNIQUE` ON `bastelfreak_test`.`cache_option` (`cache_type` ASC);

CREATE UNIQUE INDEX `description_UNIQUE` ON `bastelfreak_test`.`cache_option` (`description` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`node_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`node_state` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`node_state` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `state_name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE UNIQUE INDEX `state_name_UNIQUE` ON `bastelfreak_test`.`node_state` (`state_name` ASC);

CREATE UNIQUE INDEX `description_UNIQUE` ON `bastelfreak_test`.`node_state` (`description` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`node` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`node` (
  `IPv4_addr_ext` BINARY(4) NOT NULL,
  `IPv6_addr_ext` BINARY(16) NOT NULL,
  `IPv4_gw_ext` BINARY(4) NOT NULL,
  `IPv6_gw_ext` BINARY(16) NOT NULL,
  `bond_interfaces` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `FQDN` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `location` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `state_id` INT(11) NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_node_1`
    FOREIGN KEY (`state_id`)
    REFERENCES `bastelfreak_test`.`node_state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE UNIQUE INDEX `IPv4_addr_ext` ON `bastelfreak_test`.`node` (`IPv4_addr_ext` ASC, `IPv6_addr_ext` ASC);

CREATE INDEX `fk_state_id_node` ON `bastelfreak_test`.`node` (`state_id` ASC);

CREATE UNIQUE INDEX `IPv4_addr_ext_UNIQUE` ON `bastelfreak_test`.`node` (`IPv4_addr_ext` ASC);

CREATE UNIQUE INDEX `IPv6_addr_ext_UNIQUE` ON `bastelfreak_test`.`node` (`IPv6_addr_ext` ASC);

CREATE UNIQUE INDEX `FQDN_UNIQUE` ON `bastelfreak_test`.`node` (`FQDN` ASC);

CREATE UNIQUE INDEX `location_UNIQUE` ON `bastelfreak_test`.`node` (`location` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`vm_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`vm_state` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`vm_state` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `state_name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE UNIQUE INDEX `description_UNIQUE` ON `bastelfreak_test`.`vm_state` (`description` ASC);

CREATE UNIQUE INDEX `state_name_UNIQUE` ON `bastelfreak_test`.`vm_state` (`state_name` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`virt_node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`virt_node` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`virt_node` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `node_id` INT NOT NULL,
  `local_storage_gb` INT NULL,
  `vg_name` VARCHAR(45) NULL,
  `local_storage_path` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vm_node_1`
    FOREIGN KEY (`node_id`)
    REFERENCES `bastelfreak_test`.`node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `node_id_UNIQUE` ON `bastelfreak_test`.`virt_node` (`node_id` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`virt_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`virt_method` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`virt_method` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `bastelfreak_test`.`virt_method` (`name` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`node_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`node_method` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`node_method` (
  `hypervisor_id` INT NOT NULL AUTO_INCREMENT,
  `node_id` INT NOT NULL,
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vm_hypervisor_1`
    FOREIGN KEY (`node_id`)
    REFERENCES `bastelfreak_test`.`virt_node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vm_hypervisor_2`
    FOREIGN KEY (`hypervisor_id`)
    REFERENCES `bastelfreak_test`.`virt_method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_node_id_vm_hypervisor` ON `bastelfreak_test`.`node_method` (`node_id` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`vm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`vm` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`vm` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cores` INT NULL,
  `ram` INT NULL,
  `customer_id` INT NULL,
  `cputime_limit` INT NULL,
  `state_id` INT NULL,
  `vm_hypervisor_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vm_2`
    FOREIGN KEY (`state_id`)
    REFERENCES `bastelfreak_test`.`vm_state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vm_1`
    FOREIGN KEY (`vm_hypervisor_id`)
    REFERENCES `bastelfreak_test`.`node_method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_state_id_vm` ON `bastelfreak_test`.`vm` (`state_id` ASC);

CREATE INDEX `fk_vm_hypervisor_id_vm` ON `bastelfreak_test`.`vm` (`vm_hypervisor_id` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`storage_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`storage_type` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`storage_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `storage_type` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE UNIQUE INDEX `storage_type_UNIQUE` ON `bastelfreak_test`.`storage_type` (`storage_type` ASC);

CREATE UNIQUE INDEX `description_UNIQUE` ON `bastelfreak_test`.`storage_type` (`description` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`storage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`storage` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`storage` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `storage_type_id` INT(11) NOT NULL,
  `cache_option_id` INT(11) NOT NULL,
  `size` INT(11) NOT NULL,
  `vm_id` INT NULL,
  `write_iops_limit` INT NULL,
  `read_iops_limit` INT NULL,
  `write_mbps_limit` INT NULL,
  `read_mbps_limit` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_storage_vm`
    FOREIGN KEY (`vm_id`)
    REFERENCES `bastelfreak_test`.`vm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_storage_cache_option`
    FOREIGN KEY (`cache_option_id`)
    REFERENCES `bastelfreak_test`.`cache_option` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_storage_storage_type`
    FOREIGN KEY (`storage_type_id`)
    REFERENCES `bastelfreak_test`.`storage_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_vm_id` ON `bastelfreak_test`.`storage` (`vm_id` ASC);

CREATE INDEX `fk_cache_option_id_storage` ON `bastelfreak_test`.`storage` (`cache_option_id` ASC);

CREATE INDEX `fk_storage_type_id_storage` ON `bastelfreak_test`.`storage` (`storage_type_id` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`vm_interface`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`vm_interface` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`vm_interface` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vm_id` INT NOT NULL,
  `mac` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vm_interface_1`
    FOREIGN KEY (`vm_id`)
    REFERENCES `bastelfreak_test`.`vm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_vm_id_vm_interface` ON `bastelfreak_test`.`vm_interface` (`vm_id` ASC);

CREATE UNIQUE INDEX `mac_UNIQUE` ON `bastelfreak_test`.`vm_interface` (`mac` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`ipv4`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`ipv4` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`ipv4` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ip` BINARY(4) NOT NULL,
  `vm_interface_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ipv4_1`
    FOREIGN KEY (`vm_interface_id`)
    REFERENCES `bastelfreak_test`.`vm_interface` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_vm_interface_id_ipv4` ON `bastelfreak_test`.`ipv4` (`vm_interface_id` ASC);

CREATE UNIQUE INDEX `ip_UNIQUE` ON `bastelfreak_test`.`ipv4` (`ip` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`ipv6`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`ipv6` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`ipv6` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ip` BINARY(16) NOT NULL,
  `vm_interface_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ipv6_1`
    FOREIGN KEY (`vm_interface_id`)
    REFERENCES `bastelfreak_test`.`vm_interface` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_vm_interface_id_ipv4` ON `bastelfreak_test`.`ipv6` (`vm_interface_id` ASC);

CREATE UNIQUE INDEX `ip_UNIQUE` ON `bastelfreak_test`.`ipv6` (`ip` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`ceph_pool`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`ceph_pool` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`ceph_pool` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `bastelfreak_test`.`ceph_pool` (`name` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`storage_ceph`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`storage_ceph` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`storage_ceph` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `storage_id` INT NOT NULL,
  `discard` TINYINT(1) NOT NULL DEFAULT 1,
  `pool_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_storage_ceph_1`
    FOREIGN KEY (`pool_id`)
    REFERENCES `bastelfreak_test`.`ceph_pool` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `storage_id_UNIQUE` ON `bastelfreak_test`.`storage_ceph` (`storage_id` ASC);

CREATE INDEX `fk_pool_id_storage_ceph` ON `bastelfreak_test`.`storage_ceph` (`pool_id` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`vlan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`vlan` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`vlan` (
  `vm_interface_id` INT NOT NULL AUTO_INCREMENT,
  `id` INT NOT NULL,
  `tag` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vlan_1`
    FOREIGN KEY (`vm_interface_id`)
    REFERENCES `bastelfreak_test`.`vm_interface` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_vm_interface_id_vlan` ON `bastelfreak_test`.`vlan` (`vm_interface_id` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`ceph_node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`ceph_node` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`ceph_node` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `port` INT NOT NULL,
  `node_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ceph_node_1`
    FOREIGN KEY (`node_id`)
    REFERENCES `bastelfreak_test`.`node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `node_id_UNIQUE` ON `bastelfreak_test`.`ceph_node` (`node_id` ASC);


-- -----------------------------------------------------
-- Table `bastelfreak_test`.`mon_node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bastelfreak_test`.`mon_node` ;

CREATE TABLE IF NOT EXISTS `bastelfreak_test`.`mon_node` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `port` INT NOT NULL,
  `node_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_mon_node_1`
    FOREIGN KEY (`node_id`)
    REFERENCES `bastelfreak_test`.`node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mon_node_1_idx` ON `bastelfreak_test`.`mon_node` (`node_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
