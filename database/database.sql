
-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuarios` (
  `cedula` VARCHAR(20) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(10) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `ciudad` CHAR(5) NOT NULL,
  `fechanac` DATE NOT NULL,
  `usuario` VARCHAR(15) NOT NULL,
  `clave` VARCHAR(16) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cedula`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(15) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detallesrol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `detallesrol` (
  `cedula` VARCHAR(20) NOT NULL,
  `rol` INT NOT NULL,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`cedula`, `rol`),
  INDEX `fk_detallesrol_usuarios_idx` (`cedula` ASC),
  INDEX `fk_detallesrol_roles1_idx` (`rol` ASC),
  CONSTRAINT `fk_detallesrol_usuarios`
    FOREIGN KEY (`cedula`)
    REFERENCES `usuarios` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallesrol_roles1`
    FOREIGN KEY (`rol`)
    REFERENCES `roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `especialidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `especialidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `especialidad` VARCHAR(20) NOT NULL,
  `estado` INT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empleados` (
  `cedula` VARCHAR(20) NOT NULL,
  `fechaingreso` DATE NOT NULL,
  `sueldo` INT NOT NULL DEFAULT 0,
  `especialidad` INT(2) NOT NULL,
  INDEX `fk_empleado_usuarios1_idx` (`cedula` ASC),
  PRIMARY KEY (`cedula`, `especialidad`),
  INDEX `fk_empleados_especialidades1_idx` (`especialidad` ASC),
  CONSTRAINT `fk_empleado_usuarios1`
    FOREIGN KEY (`cedula`)
    REFERENCES `usuarios` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_especialidades1`
    FOREIGN KEY (`especialidad`)
    REFERENCES `especialidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes` (
  `cedula` VARCHAR(20) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(10) NOT NULL,
  `email` VARCHAR(50) NULL,
  `ciudad` CHAR(5) NOT NULL,
  `fechanac` DATE NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cedula`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiposvehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiposvehiculos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipovehiculo` VARCHAR(20) NOT NULL,
  `estado` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehiculos` (
  `placa` VARCHAR(7) NOT NULL,
  `modelo` VARCHAR(20) NOT NULL,
  `color` VARCHAR(20) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `observacion` TEXT(1000) NULL,
  `estado` INT(1) NULL DEFAULT 1,
  `propierario` VARCHAR(20) NOT NULL,
  `tipovehiculo` INT NOT NULL,
  PRIMARY KEY (`placa`),
  INDEX `fk_vehiculos_clientes1_idx` (`propierario` ASC),
  INDEX `fk_vehiculos_tiposvehiculos1_idx` (`tipovehiculo` ASC),
  CONSTRAINT `fk_vehiculos_clientes1`
    FOREIGN KEY (`propierario`)
    REFERENCES `clientes` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehiculos_tiposvehiculos1`
    FOREIGN KEY (`tipovehiculo`)
    REFERENCES `tiposvehiculos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cat_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cat_producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(20) NOT NULL,
  `eatado` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productos` (
  `codigo` CHAR(5) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `categoria` INT NOT NULL,
  `fechaingreso` DATE NOT NULL,
  `preciocompra` INT NOT NULL,
  `precioventa` INT NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`codigo`),
  INDEX `fk_productos_cat_producto1_idx` (`categoria` ASC),
  CONSTRAINT `fk_productos_cat_producto1`
    FOREIGN KEY (`categoria`)
    REFERENCES `cat_producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tipostrabajos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipostrabajos` (
  `id` INT NOT NULL,
  `tipotrabajo` VARCHAR(20) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planillaingresos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planillaingresos` (
  `id` INT NOT NULL,
  `cliente` VARCHAR(20) NOT NULL,
  `fechaingreso` DATE NOT NULL,
  `fechaentrega` DATE NOT NULL,
  `placavehiculo` VARCHAR(7) NOT NULL,
  `descripciontrabajo` VARCHAR(45) NOT NULL,
  `observacion` TEXT(1000) NULL,
  `empleado` VARCHAR(20) NOT NULL,
  `tipotrabajo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_plantillaingresos_clientes1_idx` (`cliente` ASC),
  INDEX `fk_planillaingresos_empleados1_idx` (`empleado` ASC),
  INDEX `fk_planillaingresos_tipostrabajos1_idx` (`tipotrabajo` ASC),
  CONSTRAINT `fk_plantillaingresos_clientes1`
    FOREIGN KEY (`cliente`)
    REFERENCES `clientes` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planillaingresos_empleados1`
    FOREIGN KEY (`empleado`)
    REFERENCES `empleados` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planillaingresos_tipostrabajos1`
    FOREIGN KEY (`tipotrabajo`)
    REFERENCES `tipostrabajos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formaspago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formaspago` (
  `id` INT NOT NULL,
  `formapago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `facturas` (
  `numfactura` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `cajero` VARCHAR(20) NOT NULL,
  `planilla` INT NOT NULL,
  `totalapagar` FLOAT(11,2) NOT NULL,
  `descuentos` FLOAT(11,2) NOT NULL,
  `observacion` TEXT(1000) NULL,
  `formadepago` INT NOT NULL,
  PRIMARY KEY (`numfactura`),
  INDEX `fk_facturas_usuarios1_idx` (`cajero` ASC),
  INDEX `fk_facturas_planillaingresos1_idx` (`planilla` ASC),
  INDEX `fk_facturas_formaspago1_idx` (`formadepago` ASC),
  CONSTRAINT `fk_facturas_usuarios1`
    FOREIGN KEY (`cajero`)
    REFERENCES `usuarios` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_planillaingresos1`
    FOREIGN KEY (`planilla`)
    REFERENCES `planillaingresos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_formaspago1`
    FOREIGN KEY (`formadepago`)
    REFERENCES `formaspago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `facturacionproductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `facturacionproductos` (
  `codigoproducto` CHAR(5) NOT NULL,
  `numfactura` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`codigoproducto`, `numfactura`),
  INDEX `fk_cantidadproductos_productos1_idx` (`codigoproducto` ASC),
  INDEX `fk_facturacionproductos_facturas1_idx` (`numfactura` ASC),
  CONSTRAINT `fk_cantidadproductos_productos1`
    FOREIGN KEY (`codigoproducto`)
    REFERENCES `productos` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturacionproductos_facturas1`
    FOREIGN KEY (`numfactura`)
    REFERENCES `facturas` (`numfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `facturacioncredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `facturacioncredito` (
  `numfactura` INT NOT NULL,
  `tiempofinanciacion` INT NOT NULL,
  `tasainteres` INT NOT NULL,
  `interes` FLOAT(3,2) NOT NULL,
  PRIMARY KEY (`numfactura`),
  INDEX `fk_facturacioncredito_facturas1_idx` (`numfactura` ASC),
  CONSTRAINT `fk_facturacioncredito_facturas1`
    FOREIGN KEY (`numfactura`)
    REFERENCES `facturas` (`numfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

