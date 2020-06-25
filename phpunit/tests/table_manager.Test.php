<?php
use PHPUnit\Framework\TestCase;

require_once('../../theme/private/lib/table_manager.php');

use kwd\tth\TableManager as TableManager;

// stubs:

// ! always returns article_id=1 when not set because we don't have context of current page
function rex_getUrl($article_id = '', $clang = '', $params = array()) {
	if (!$article_id) $article_id = '1';
	if ($clang) {
		$c = intval($clang);
	}
	else {
		$c = '';
	}
	if ($c) $c = '&amp;clang='.$c;

	$p = '';
	if (is_array($params)) {
		foreach($params as $key => $value) {
			$p .= "&amp;$key=$value";
		}
	}
	
	return "./index.php?article_id=$article_id$c$p";
}

/**
*	@test
*/
class DataSetQuellenTest extends TestCase {

	/**
	*	@test
	*   @covers getTableNames
	*/
	public function testGetTableNames() {
		$tm = new TableManager();

		$prefix = $tm->getTablePrefix();
		$this->assertSame($prefix,'tth_');
		
		$tables = $tm->getTableNames();
		// $this->assertIsArray($tables);
		// $this->assertEquals(18, count($tables));
		$this->assertSame($tables['entities'], $prefix.'wortliste');
		$this->assertSame($tables['sources'], $prefix.'quellen');
		$this->assertSame($tables['sources_authors'], $prefix.'quellen_autoren');
		$this->assertSame($tables['authors'], $prefix.'autoren');
		$this->assertSame($tables['languages'], $prefix.'sprachen');
		$this->assertSame($tables['regions'], $prefix.'regionen');
		$this->assertSame($tables['entitystates'], $prefix.'begriffsstati');
		$this->assertSame($tables['languagestyles'], $prefix.'sprachstile');
		$this->assertSame($tables['metaentities'], $prefix.'metabegriffe');
		$this->assertSame($tables['entity_relatives'], $prefix.'begriff_verwandte');
		$this->assertSame($tables['entity_supers'], $prefix.'begriff_oberbegriffe');
		$this->assertSame($tables['entity_subs'], $prefix.'begriff_unterbegriffe');
		$this->assertSame($tables['entity_subs'], $prefix.'begriff_unterbegriffe');
		// ! not used anymore
		// $this->assertSame($tables['entity_sources'], $prefix.'begriff_quellen');
		$this->assertSame($tables['entity_equivalent'], $prefix.'begriff_aequivalente');
		$this->assertSame($tables['references'], $prefix.'quellenangaben');
		$this->assertSame($tables['references_fields'], $prefix.'quellenangaben_felder');
		$this->assertSame($tables['tablenames'], $prefix.'tabellennamen');
	}

	/**
	 * @test
	 * @covers getLink
	 * 
	 * public function getLink($idName, $id, $desc, $article_id = '') {
	 * 
	 * <a href="./index.php?article_id=6&amp;begriff_id=1410"
	 */
	function testGetLink() {
		$tm = new TableManager();

		$str = $tm->getLink('begriff_id',1410,'Katzenpfette',6);
		$this->assertEquals('<a href="./index.php?article_id=6&amp;begriff_id=1410">Katzenpfette</a>',$str);
		// test without article id
		$str = $tm->getLink('begriff_id',1726,'Einstemmtreppe');
		// result article_id=1 is correct "stub return value" 
		$this->assertEquals('<a href="./index.php?article_id=1&amp;begriff_id=1726">Einstemmtreppe</a>',$str);
	}

	/**
	 * @test
	 * @covers makeLinkList
	 * 
	 * public function getLink($idName, $id, $desc, $article_id = '') {
	 * 
	 * <a href="./index.php?article_id=6&amp;begriff_id=1410"
	 */
	function testMakeLinkList() {
		$tm = new TableManager();

		$data = array();
		$data[0]['id'] = '1';
		$data[0]['sprache'] = 'Deutsch';
		$data[1]['id'] = '2';
		$data[1]['sprache'] = 'Englisch';
		$data[2]['id'] = '3';
		$data[2]['sprache'] = 'Tschechisch';
		
		$str = $tm->makeLinkList($data, 'begriff_id', 'sprache'); // string 'sprache' must be key in sub arrays
		$this->assertSame('<a href="./index.php?article_id=1&amp;begriff_id=1">Deutsch</a>, <a href="./index.php?article_id=1&amp;begriff_id=2">Englisch</a>, <a href="./index.php?article_id=1&amp;begriff_id=3">Tschechisch</a>',$str);

		// with article_id
		$str = $tm->makeLinkList($data, 'begriff_id', 'sprache', 7); // string 'sprache' must be key in sub arrays
		$this->assertSame('<a href="./index.php?article_id=7&amp;begriff_id=1">Deutsch</a>, <a href="./index.php?article_id=7&amp;begriff_id=2">Englisch</a>, <a href="./index.php?article_id=7&amp;begriff_id=3">Tschechisch</a>',$str);
	}
}
