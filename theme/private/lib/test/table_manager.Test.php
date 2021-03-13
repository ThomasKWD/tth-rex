<?php

require_once('test_init.php');
use PHPUnit\Framework\TestCase;

/**
*	@test
*/
class TableManagerTest extends TestCase {

	/**
	*	@test
	*   @covers prove of phpunit
	*/
	public function testGetTableFields() {
        $tm = initTableManager(initViewFormatter()); // recommended way to use TableManager
        self::assertEquals('begriff', $tm->getTableField('entity'));
	}

    public function testGetFacetId(Type $var = null)
    {
        $tm = initTableManager(initViewFormatter());
        self::assertEquals(8, $tm->getFacetId());
    }
}