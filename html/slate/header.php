<?php
session_start();

// Load variables from .env file
require_once("assets/utility/dotenv.php");
use ft\DotEnv;
(new DotEnv(__DIR__ . '/.env'))->load();

// Name of the website
define("NAME", getenv("NAME"));

// Message max length
define("MSG_MAX_LEN",getenv("MSG_MAX_LEN"));

// File containing all notes
define("DATA", getenv("DATA_PATH"));

// Switch between development/production
define("DEV", 0);
define("PROD", 1);
define("DEV_OR_PROD", DEV);

if (DEV_OR_PROD == PROD)
{ // If development, enter data from your local settings
    // Show all PHP errors
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
}
else
{ // If production, enter data from your host settings
    // Hide all PHP errors
    ini_set('display_errors', 0);
}