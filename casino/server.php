<?php

// Turn on error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/**
 * Laravel - A PHP Framework For Web Artisans
 */

if (file_exists(__DIR__.'/vendor/autoload.php')) {
    require_once __DIR__.'/vendor/autoload.php';
}

$uri = urldecode(
    parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH)
);

if ($uri !== '/' && file_exists(__DIR__.$uri)) {
    return false;
}

if (file_exists(__DIR__.'/index.php')) {
    require_once __DIR__.'/index.php';
} else {
    require_once __DIR__.'/bootstrap/app.php';
}
