<?php

// ! only for unit test suite
require_once('mock_redaxo.php');
// phpunit does not find relative parent path
require_once(realpath(dirname(dirname(__FILE__))).'/table_manager.php');
require_once(realpath(dirname(dirname(__FILE__))).'/view_formatter.php');

use kwd\tth\TableManager as TableManager;
use kwd\tth\ViewFormatter as ViewFormatter;

function initViewFormatter() {
    $sql = new mock_rex_sql();
    $vm = new ViewFormatter($sql, 'mock_rex_getUrl');
    return $vm;
}

function initTableManager($vm) {
    return $vm->getTableManagerInstance();
}