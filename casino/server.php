<?php

/**
 * Laravel - A PHP Framework For Web Artisans
 *
 * @package  Laravel
 * @author   Taylor Otwell <taylor@laravel.com>
 */

$uri = urldecode(
    parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH)
);

// This file allows us to emulate Apache's "mod_rewrite" functionality from the
// built-in PHP web server.
if ($uri !== '/' && file_exists(__DIR__.$uri)) {
    return false;
}

// Check index.php in current directory, otherwise load bootstrap
if (file_exists(__DIR__.'/index.php')) {
    require_once __DIR__.'/index.php';
} else {
    require_once __DIR__.'/bootstrap/app.php';
}
