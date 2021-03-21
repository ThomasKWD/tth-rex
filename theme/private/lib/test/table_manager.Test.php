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
	*   @covers checkTruthyWord
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

    

	/**
	*	@test
	*   @covers buildSearchEntitiesQuery
    * 
	*/
	public function testBuildSearchEntitiesQuery() {
        $tm = $this->tm;
        $this->assertSame(
            'SELECT id, begriff from tth_wortliste WHERE begriff LIKE :wordsearch',
            $tm->buildSearchEntitiesQuery()
        );
        // set $strict == `true`
        $this->assertSame(
            'SELECT id, begriff from tth_wortliste WHERE begriff = :wordsearch',
            $tm->buildSearchEntitiesQuery(true)
        );
    }

    
	/**
	*	@test
	*   @covers getEntitiesByField
    * 
	*/
    // public function testGetEntitiesByField() {
    //     $tm = $this->tm;
    //     // !!! mock of rex_sql needed
    //     $entities = $tm->getEntitiesByField();
    //     $this->assertEquals(['peter'], $entities); // hier weiter
    // }

	/**
	*	@test
	*   @covers buildForeignEntriesQuery 
	*/
    public function testBuildForeignEntriesQuery() {
        $this->assertEquals(
            'SELECT r.*, s.name FROM tth_begriff_tags r JOIN tth_tags s ON r.tag_id = s.id WHERE r.begriff_id = :entity_id ORDER BY s.name ASC',
            $this->tm->buildForeignEntriesQuery('tags', 'entity_id')
        );
        $this->assertEquals(
            'SELECT r.*, s.kurz FROM tth_quellenangaben r JOIN tth_quellen s ON r.quelle_id = s.id WHERE r.begriff_id = :entity_id ORDER BY s.kurz ASC',
            $this->tm->buildForeignEntriesQuery('references','entity_id')
        );
    }

	/**
	*	@test
	*   @covers buildUnsetRelationQuery
	*/
    public function testBuildUnsetRelationQuery() {
        $this->assertEquals(
            'SELECT b.id, b.begriff FROM tth_wortliste b LEFT OUTER JOIN tth_quellenangaben o ON o.begriff_id = b.id WHERE o.begriff_id is NULL ORDER BY b.begriff ASC',
            $this->tm->buildUnsetRelationQuery('references')
        );
    }
}