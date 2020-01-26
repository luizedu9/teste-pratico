-- MySQL Workbench Synchronization
-- Generated: 2020-01-23 12:01
-- Model: Teste Pratico
-- Version: 1.0
-- Project: Teste Pratico
-- Author: Luiz Eduardo Pereira

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `teste_pratico` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Produto` (
  `pro_codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `pro_descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`pro_codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Item` (
  `ite_codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `ite_numero` INT(11) NOT NULL,
  `ite_preco` FLOAT(11) NOT NULL,
  `ite_quantidade` INT(11) NOT NULL,
  `ite_total` FLOAT(11) NOT NULL,
  `ite_pro_codigo` INT(11) NOT NULL,
  `ite_ven_codigo` INT(11) NOT NULL,
  PRIMARY KEY (`ite_codigo`),
  INDEX `fk_Item_Produto1_idx` (`ite_pro_codigo` ASC),
  INDEX `fk_Item_Venda1_idx` (`ite_ven_codigo` ASC),
  CONSTRAINT `fk_Item_Produto1`
    FOREIGN KEY (`ite_pro_codigo`)
    REFERENCES `teste_pratico`.`Produto` (`pro_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Venda1`
    FOREIGN KEY (`ite_ven_codigo`)
    REFERENCES `teste_pratico`.`Venda` (`ven_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Cliente` (
  `cli_codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `cli_nome` VARCHAR(255) NOT NULL,
  `cli_cnpj` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cli_codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Venda` (
  `ven_codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `ven_data` VARCHAR(45) NOT NULL,
  `ven_total` FLOAT(11) NOT NULL,
  `ven_cep` VARCHAR(45) NOT NULL,
  `ven_logradouro` VARCHAR(255) NOT NULL,
  `ven_numero` VARCHAR(45) NOT NULL,
  `ven_complemento` VARCHAR(45) NULL DEFAULT NULL,
  `ven_bairro` VARCHAR(255) NOT NULL,
  `ven_localidade` VARCHAR(255) NOT NULL,
  `ven_uf` VARCHAR(2) NOT NULL,
  `ven_cli_codigo` INT(11) NOT NULL,
  PRIMARY KEY (`ven_codigo`),
  INDEX `fk_Venda_Cliente1_idx` (`ven_cli_codigo` ASC),
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`ven_cli_codigo`)
    REFERENCES `teste_pratico`.`Cliente` (`cli_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE teste_pratico;

INSERT INTO Cliente 
	(cli_nome, cli_cnpj) 
VALUES 
	("Mercadinho São Judas", "24.992.563/0001-71"),
	("Mercadinho Iris Faria", "63.087.157/0001-16"),
	("Mercadinho Canastra", "51.490.721/0001-68"),
	("Mercadinho Vó Ana", "73.694.173/0001-20"),
	("Mercadinho Dois Irmãos", "33.652.201/0001-22");

INSERT INTO Produto 
	(pro_descricao) 
VALUES 
	("Batata"),
	("Cenoura"),
	("Alface"),
	("Beterraba"),
	("Couve-Flor"),
	("Espinafre"),
	("Mandioca"),
	("Tomate"),
	("Cebola"),
	("Couve"),
	("Quiabo");
