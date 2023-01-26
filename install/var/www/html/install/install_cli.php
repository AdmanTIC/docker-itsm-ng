<?php
define('GLPI_ROOT', realpath('..'));

include_once (GLPI_ROOT . "/inc/based_config.php");
include_once (GLPI_ROOT . "/inc/db.function.php");

$GLPI = new GLPI();
$GLPI->initLogger();
$GLPI->initErrorHandler();

Config::detectRootDoc();

$glpikey = new GLPIKey();
$secured = $glpikey->keyExists();
if (!$secured) {
   $secured = $glpikey->generate();
}

Toolbox::createSchema();