<?php

// require_once('test_init.php');
use PHPUnit\Framework\TestCase;

/**
*	@test
*/
class SqlConnectionTest extends TestCase {
	function setUp() {
	}

    function testSqlConnected() {
        // $dbh = new PDO('mysql:host=localhost;dbname=test', $user, $pass);
        $dbh = new PDO('mysql:dbname=redaxo;host=db', 'root', 'knaeckebrot25');
        $sql = "SELECT * FROM tth_wortliste WHERE id = '645'";
        $sth = $dbh->query($sql, PDO::FETCH_ASSOC);
        $rows = $sth->fetchAll();
        $this->assertEquals(1, count($rows));
        $this->assertEquals('ljw', $rows[0]['begriff']);
    }
}