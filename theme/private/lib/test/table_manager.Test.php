<?php

require_once('test_init.php');
use PHPUnit\Framework\TestCase;

/**
*	@test
*/
class TableManagerTest extends TestCase {
    protected $tm;

    function setUp() {
        // recommended way to use TableManager
        $this->tm = initTableManager(initViewFormatter());
    }
	/**
	*	@test
	*   @covers prove of phpunit
	*/
	public function testGetTableFields() {
        self::assertEquals('begriff', $this->tm->getTableField('entity'));
	}

	/**
	*	@test
	*   @covers prove of phpunit
	*/
    public function testGetFacetId(Type $var = null)
    {
        self::assertEquals(8, $this->tm->getFacetId());
    }


	/**
	*	@test
	*   @covers prove of phpunit
    * 
	*/
	public function testCheckTruthyWord() {
        $tm = $this->tm;
        $this->assertSame(true, $tm->checkTruthyWord('true'));
        $this->assertSame(true, $tm->checkTruthyWord('TRUE'));
        $this->assertSame(true, $tm->checkTruthyWord('True'));
        $this->assertSame(false, $tm->checkTruthyWord('false'));
        $this->assertSame(false, $tm->checkTruthyWord('FALSE'));
        $this->assertSame(false, $tm->checkTruthyWord('falSE'));
        // concept of unset/empty
        $this->assertSame(null, $tm->checkTruthyWord(false)); 
        $this->assertSame(null, $tm->checkTruthyWord(''));
        $this->assertSame(null, $tm->checkTruthyWord(0));
	}
}