<?php

// require_once('test_init.php');
use PHPUnit\Framework\TestCase;

/**
 *  @test
 *  @covers SQL connection
 * 
 *  the connection will be to any db service
 *  in this case the actual DEV db used for the "TTH + Redaxo" project
*/
class SqlConnectionTest extends TestCase {
	function setUp() {
	}

    function testSqlConnected() {
        // $dbh = new PDO('mysql:host=localhost;dbname=test', $user, $pass);
        $dbh = new PDO('mysql:dbname=redaxo;host=db', 'root', 'knaeckebrot25');
        $sql = "SELECT * FROM tth_wortliste WHERE 1 ORDER BY id ASC";
        $sth = $dbh->query($sql, PDO::FETCH_ASSOC);
        $rows = $sth->fetchAll();
        $this->assertEquals(1246, count($rows));
        $this->assertEquals('Abbund', $rows[0]['begriff']);
    }
}