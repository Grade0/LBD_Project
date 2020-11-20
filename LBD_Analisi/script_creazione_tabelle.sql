-- MySQL Script generated by MySQL Workbench
-- Tue Oct 20 23:33:52 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
-- Created by Saverio Catania

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cervecita
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cervecita
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cervecita` DEFAULT CHARACTER SET utf8 ;
USE `Cervecita` ;

-- -----------------------------------------------------
-- Table `Cervecita`.`Fornitori`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Fornitori` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Fornitori` (
  `idfornitore` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(13) NOT NULL,
  `indirizzo` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `ragione_sociale` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfornitore`),
  UNIQUE INDEX `ragione_sociale_UNIQUE` (`ragione_sociale` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Clienti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Clienti` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Clienti` (
  `idcliente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(13) NOT NULL,
  `indirizzo` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `ragione_sociale` VARCHAR(45) NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `ragione_sociale_UNIQUE` (`ragione_sociale` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Birrai`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Birrai` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Birrai` (
  `idbirraio` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(13) NOT NULL,
  `indirizzo` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `ragione_sociale` VARCHAR(45) NULL,
  PRIMARY KEY (`idbirraio`),
  UNIQUE INDEX `ragione_sociale_UNIQUE` (`ragione_sociale` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Tipi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Tipi` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Tipi` (
  `idtipo` TINYINT(1) NOT NULL,
  `nome` ENUM("malto", "luppolo", "varie") NOT NULL,
  `unita_di_misura` ENUM("g", "mg", "kg") NOT NULL,
  PRIMARY KEY (`idtipo`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Ingredienti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Ingredienti` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Ingredienti` (
  `idingrediente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(100) NOT NULL,
  `prezzo_unitario` INT NOT NULL,
  `utilizzable` BOOLEAN NOT NULL,
  `idtipo` TINYINT(1) NOT NULL,
  `idfornitore` INT NOT NULL,
  PRIMARY KEY (`idingrediente`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `idtipo_idx` (`idtipo` ASC) VISIBLE,
  INDEX `idfornitore_idx` (`idfornitore` ASC) VISIBLE,
  CONSTRAINT `idtipo`
    FOREIGN KEY (`idtipo`)
    REFERENCES `Cervecita`.`Tipi` (`idtipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idfornitore`
    FOREIGN KEY (`idfornitore`)
    REFERENCES `Cervecita`.`Fornitori` (`idfornitore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`OrdiniBirrai`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`OrdiniBirrai` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`OrdiniBirrai` (
  `idordine` INT NOT NULL,
  `numero_fattura` VARCHAR(9) NULL,
  `data_ordine` DATE NOT NULL,
  `prezzo_totale` DOUBLE,
  `id_birraio` INT NOT NULL,
  PRIMARY KEY (`idordine`),
  INDEX `idbirraio_idx` (`id_birraio` ASC) VISIBLE,
  UNIQUE INDEX `numero_fattura_UNIQUE` (`numero_fattura` ASC) VISIBLE,
  CONSTRAINT `idbirraio`
    FOREIGN KEY (`id_birraio`)
    REFERENCES `Cervecita`.`Birrai` (`idbirraio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`IngredientiBirrai`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`IngredientiBirrai` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`IngredientiBirrai` (
  `idingrediente` INT NOT NULL,
  `idbirraio` INT NOT NULL,
  `quantità` DOUBLE NOT NULL,
  PRIMARY KEY (`idingrediente`, `idbirraio`),
  INDEX `idbirraio_idx` (`idbirraio` ASC) VISIBLE,
  CONSTRAINT `idingrediente`
    FOREIGN KEY (`idingrediente`)
    REFERENCES `Cervecita`.`Ingredienti` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idbirraio`
    FOREIGN KEY (`idbirraio`)
    REFERENCES `Cervecita`.`Birrai` (`idbirraio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Rifornimenti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Rifornimenti` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Rifornimenti` (
  `idrifornimento` INT NOT NULL,
  `prezzo_ingrediente` INT NOT NULL,
  `quantità` INT NOT NULL,
  `idingrediente` INT NOT NULL,
  `idordine` INT NOT NULL,
  PRIMARY KEY (`idrifornimento`),
  INDEX `idingrediente_idx` (`idingrediente` ASC) VISIBLE,
  INDEX `idordine_idx` (`idordine` ASC) VISIBLE,
  CONSTRAINT `idingrediente`
    FOREIGN KEY (`idingrediente`)
    REFERENCES `Cervecita`.`Ingredienti` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idordine`
    FOREIGN KEY (`idordine`)
    REFERENCES `Cervecita`.`OrdiniBirrai` (`idordine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`OrdiniClienti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`OrdiniClienti` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`OrdiniClienti` (
  `idordine` INT NOT NULL,
  `data_ordine` DATE NOT NULL,
  `prezzo_totale` INT GENERATED ALWAYS AS () VIRTUAL,
  `stato` ENUM("prenotato", "in preparazione", "spedito", "consegnato", "annullato") NOT NULL,
  `idcliente` INT NOT NULL,
  PRIMARY KEY (`idordine`),
  INDEX `idcliente_idx` (`idcliente` ASC) VISIBLE,
  CONSTRAINT `idcliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `Cervecita`.`Clienti` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Ricette`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Ricette` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Ricette` (
  `idricetta` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `istruzioni` VARCHAR(500) NOT NULL,
  `metodologie` ENUM("whole grain", "extract", "mixed") NOT NULL,
  `utilizzabile` BOOLEAN NOT NULL,
  `id_birraio` INT NOT NULL,
  PRIMARY KEY (`idricetta`),
  INDEX `idbirraio_idx` (`id_birraio` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  CONSTRAINT `idbirraio`
    FOREIGN KEY (`id_birraio`)
    REFERENCES `Cervecita`.`Birrai` (`idbirraio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Lotti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Lotti` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Lotti` (
  `idlotto` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(45) NULL,
  `inizio_produzione` DATE NOT NULL,
  `fine_produzione` DATE NULL,
  `scadenza` DATE NULL,
  `litri_prodotti` BIGINT NULL,
  `stato` ENUM("produzione", "vendita", "esaurito", "archiviato") NOT NULL,
  `pubblicazione` DATE NULL,
  `litri_residui` BIGINT NOT NULL,
  `prezzo_al_litro` INT NULL,
  `idricetta` INT NOT NULL,
  `idbirraio` INT NOT NULL,
  PRIMARY KEY (`idlotto`),
  INDEX `idricetta_idx` (`idricetta` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `idbirraio_idx` (`idbirraio` ASC) VISIBLE,
  CONSTRAINT `idricetta`
    FOREIGN KEY (`idricetta`)
    REFERENCES `Cervecita`.`Ricette` (`idricetta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idbirraio`
    FOREIGN KEY (`idbirraio`)
    REFERENCES `Cervecita`.`Birrai` (`idbirraio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Recensioni`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Recensioni` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Recensioni` (
  `idrecensione` INT NOT NULL,
  `recensione` VARCHAR(500) NOT NULL,
  `qualità` TINYINT(1) NOT NULL,
  `idcliente` INT NOT NULL,
  `idlotto` INT NOT NULL,
  PRIMARY KEY (`idrecensione`),
  INDEX `idcliente_idx` (`idcliente` ASC) VISIBLE,
  INDEX `idlotto_idx` (`idlotto` ASC) VISIBLE,
  CONSTRAINT `idcliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `Cervecita`.`Clienti` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idlotto`
    FOREIGN KEY (`idlotto`)
    REFERENCES `Cervecita`.`Lotti` (`idlotto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`Annotazioni`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`Annotazioni` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`Annotazioni` (
  `idannotazione` INT NOT NULL,
  `annotazione` VARCHAR(500) NOT NULL,
  `rilascio` DATE NOT NULL,
  `idbirraio` INT NOT NULL,
  `idlotto` INT NOT NULL,
  PRIMARY KEY (`idannotazione`),
  INDEX `idbirraio_idx` (`idbirraio` ASC) VISIBLE,
  INDEX `idlotto_idx` (`idlotto` ASC) VISIBLE,
  CONSTRAINT `idbirraio`
    FOREIGN KEY (`idbirraio`)
    REFERENCES `Cervecita`.`Birrai` (`idbirraio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idlotto`
    FOREIGN KEY (`idlotto`)
    REFERENCES `Cervecita`.`Lotti` (`idlotto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`IngredientiRicette`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`IngredientiRicette` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`IngredientiRicette` (
  `idingrediente` INT NOT NULL,
  `idricetta` INT NOT NULL,
  `quantità` DOUBLE NOT NULL,
  PRIMARY KEY (`idingrediente`, `idricetta`),
  INDEX `idricetta_idx` (`idricetta` ASC) VISIBLE,
  CONSTRAINT `idingrediente`
    FOREIGN KEY (`idingrediente`)
    REFERENCES `Cervecita`.`Ingredienti` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idricetta`
    FOREIGN KEY (`idricetta`)
    REFERENCES `Cervecita`.`Ricette` (`idricetta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`RicetteCondivise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`RicetteCondivise` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`RicetteCondivise` (
  `idricetta` INT NOT NULL,
  `idbirraio` INT NOT NULL,
  PRIMARY KEY (`idricetta`, `idbirraio`),
  INDEX `idbirraio_idx` (`idbirraio` ASC) VISIBLE,
  CONSTRAINT `idricetta`
    FOREIGN KEY (`idricetta`)
    REFERENCES `Cervecita`.`Ricette` (`idricetta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idbirraio`
    FOREIGN KEY (`idbirraio`)
    REFERENCES `Cervecita`.`Birrai` (`idbirraio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cervecita`.`OrdiniClientiLotti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cervecita`.`OrdiniClientiLotti` ;

CREATE TABLE IF NOT EXISTS `Cervecita`.`OrdiniClientiLotti` (
  `idordine` INT NOT NULL,
  `idlotto` INT NOT NULL,
  `numero_litri` BIGINT GENERATED ALWAYS AS () VIRTUAL,
  `prezzo_litro` INT NOT NULL,
  `pronto` TINYINT NOT NULL,
  PRIMARY KEY (`idordine`, `idlotto`),
  INDEX `idlotto_idx` (`idlotto` ASC) VISIBLE,
  CONSTRAINT `idordine`
    FOREIGN KEY (`idordine`)
    REFERENCES `Cervecita`.`OrdiniClienti` (`idordine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idlotto`
    FOREIGN KEY (`idlotto`)
    REFERENCES `Cervecita`.`Lotti` (`idlotto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
