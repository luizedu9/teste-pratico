-- MySQL Workbench Synchronization
-- Generated: 2020-01-23 12:01
-- Model: New Model
-- Version: 1.0
-- Project: Teste Pratico
-- Author: Luiz Eduardo Pereira

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `teste_pratico` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Produto` (
  `cod` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Item` (
  `cod` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` INT(11) NOT NULL,
  `preco` FLOAT(11) NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `total` FLOAT(11) NOT NULL,
  `Produto_cod` INT(11) NOT NULL,
  PRIMARY KEY (`cod`),
  INDEX `fk_table1_Produto_idx` (`Produto_cod` ASC),
  CONSTRAINT `fk_table1_Produto`
    FOREIGN KEY (`Produto_cod`)
    REFERENCES `teste_pratico`.`Produto` (`cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Cliente` (
  `cod` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Venda` (
  `cod` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `total` FLOAT(11) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(255) NOT NULL,
  `numero` INT(11) NOT NULL,
  `complemento` VARCHAR(45) NULL DEFAULT NULL,
  `bairro` VARCHAR(255) NOT NULL,
  `localidade` VARCHAR(255) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `Cliente_cod` INT(11) NOT NULL,
  PRIMARY KEY (`cod`),
  INDEX `fk_Venda_Cliente1_idx` (`Cliente_cod` ASC),
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`Cliente_cod`)
    REFERENCES `teste_pratico`.`Cliente` (`cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `teste_pratico`.`Venda_Item` (
  `Venda_cod` INT(11) NOT NULL,
  `Item_cod` INT(11) NOT NULL,
  PRIMARY KEY (`Venda_cod`, `Item_cod`),
  INDEX `fk_Venda_has_Item_Item1_idx` (`Item_cod` ASC),
  INDEX `fk_Venda_has_Item_Venda1_idx` (`Venda_cod` ASC),
  CONSTRAINT `fk_Venda_has_Item_Venda1`
    FOREIGN KEY (`Venda_cod`)
    REFERENCES `teste_pratico`.`Venda` (`cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_has_Item_Item1`
    FOREIGN KEY (`Item_cod`)
    REFERENCES `teste_pratico`.`Item` (`cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE teste_pratico;

INSERT INTO Cliente 
	(nome, cnpj) 
VALUES 
	("Mercadinho Folha Verde", "24.992.563/0001-71"),
	("Mercadinho Iris Faria", "63.087.157/0001-16"),
	("Mercadinho Canastra", "51.490.721/0001-68"),
	("Mercadinho Vó Ana", "73.694.173/0001-20"),
	("Mercadinho Dois Irmãos", "33.652.201/0001-22");

INSERT INTO Produto 
	(descricao) 
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