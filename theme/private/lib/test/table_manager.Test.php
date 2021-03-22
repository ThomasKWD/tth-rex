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
            'SELECT id, begriff from tth_wortliste WHERE begriff LIKE :wordsearch ORDER BY begriff ASC',
            $tm->buildSearchEntitiesQuery()
        );
        // set $strict == `true`
        $this->assertSame(
            'SELECT id, begriff from tth_wortliste WHERE begriff = :wordsearch ORDER BY begriff ASC',
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
        $this->assertEquals(
            "SELECT b.id, b.begriff FROM tth_wortliste b LEFT OUTER JOIN tth_begriff_oberbegriffe o ON o.begriff_id = b.id WHERE o.begriff_id is NULL ORDER BY b.begriff ASC",
            $this->tm->buildUnsetRelationQuery('entity_supers')
        );
        $this->assertEquals(
            "SELECT b.id, b.begriff FROM tth_wortliste b LEFT OUTER JOIN tth_begriff_unterbegriffe o ON o.begriff_id = b.id WHERE o.begriff_id is NULL ORDER BY b.begriff ASC",
            $this->tm->buildUnsetRelationQuery('entity_subs')
        );
    }

	/**
	*	@test
	*   @covers buildSingleEntityQuery
	*/
    public function testBuildSingleEntityQuery() {
      	// ! b is first alias for $tableEntities, b2 is the second for benutze
		$query = "SELECT b.begriff,b.id,b.autor_id,tth_autoren.gnd,b.quelle_seite,b.code,b.definition,b.bild,b.begriffsstatus_id,tth_begriffsstati.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,b.sprache_id,b.sprachstil_id,b.region_id,";
		$query .= "b2.begriff AS benutze_begriff,CONCAT(tth_autoren.vorname, ' ', tth_autoren.name) AS autor,";
		$query .= "tth_sprachen.sprache AS sprache,";
		$query .= "tth_regionen.region AS region, ";
		$query .= "tth_sprachstile.stil AS sprachstil ";
		$query .= "FROM tth_wortliste b ";
		$query .= "LEFT JOIN tth_autoren ON b.autor_id = tth_autoren.id ";
		$query .= "LEFT JOIN tth_begriffsstati ON b.begriffsstatus_id = tth_begriffsstati.id ";
		$query .= "LEFT JOIN tth_sprachen ON b.sprache_id = tth_sprachen.id ";
		$query .= "LEFT JOIN tth_regionen ON b.region_id = tth_regionen.id ";
		$query .= "LEFT JOIN tth_sprachstile ON b.sprachstil_id = tth_sprachstile.id ";
		$query .= "LEFT JOIN tth_wortliste b2 ON b2.id = b.benutze ";
        $query .= "WHERE b.id = :entityId";

        $this->assertEquals($query, $this->tm->buildSingleEntityQuery());

        // expected
        // SELECT b.begriff,b.id,b.autor_id,tth_autoren.gnd,b.quelle_seite,b.code,b.definition,b.bild,b.begriffsstatus_id,tth_begriffsstatus.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,b.sprache_id,b.sprachstil_id,b.region_id,b2.begriff AS benutze_begriff,CONCAT(tth_autoren.vorname, ' ', tth_autoren.name) AS autor,tth_sprachen.sprache AS sprache,tth_regionen.region AS region, tth_sprachstile.stil AS sprachstil FROM tth_wortliste b LEFT JOIN tth_autoren ON b.autor_id = tth_autoren.id LEFT JOIN tth_begriffsstatus ON b.begriffsstatus_id = tth_begriffsstatus.id LEFT JOIN tth_sprachen ON b.sprache_id = tth_sprachen.id LEFT JOIN tth_regionen ON b.region_id = tth_regionen.id LEFT JOIN tth_sprachstile ON b.sprachstil_id = tth_sprachstile.id LEFT JOIN tth_wortliste b2 ON b2.id = b.benutze WHERE b.id = :entityId
        // actual
        // SELECT b.begriff,b.id,b.autor_id,tth_autoren.gnd,b.quelle_seite,b.code,b.definition,b.bild,b.begriffsstatus_id,tth_begriffsstati.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,b.sprache_id,b.sprachstil_id,b.region_id,b2.begriff AS benutze_begriff,CONCAT(tth_autoren.vorname, ' ', tth_autoren.name) AS autor,tth_sprachen.sprache AS sprache,tth_regionen.region AS region, tth_sprachstile.stil AS sprachstil FROM tth_wortliste b LEFT JOIN tth_autoren ON b.autor_id = tth_autoren.id LEFT JOIN tth_begriffsstati ON b.begriffsstatus_id = tth_begriffsstati.id LEFT JOIN tth_sprachen ON b.sprache_id = tth_sprachen.id LEFT JOIN tth_regionen ON b.region_id = tth_regionen.id LEFT JOIN tth_sprachstile ON b.sprachstil_id = tth_sprachstile.id LEFT JOIN tth_wortliste b2 ON b2.id = b.benutze WHERE b.id = :entityId
    }

   	/**
	*	@test
	*   @covers buildAuthorsForSourceQuery
	 */
	public function buildAuthorsForSourceQuery() {
		// select all authors for this source, similar to code for relation in begriffe
		$query = "SELECT a.* ";
		$query.= "FROM tth_autoren a ";
		$query.= "JOIN tth_quellen_autoren g1 ON a.id = g1.autor_id ";
		$query.= "JOIN tth_quellen q ON q.id = g1.quelle_id ";
		$query.= "WHERE q.id = :sourceId ORDER BY a.name ASC";
        $this->assertEquals(
            $query,
            $this->tm->buildAuthorsForSourceQuery()
        );
	}

}