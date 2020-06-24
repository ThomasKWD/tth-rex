<?php
use PHPUnit\Framework\TestCase;

require_once('../../theme/private/lib/table_manager.php');

use kwd\tth\TableManager as TableManager;

/**
*	@test
*/
class DataSetQuellenTest extends TestCase {

	/**
	*	@test
	*   
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
}
