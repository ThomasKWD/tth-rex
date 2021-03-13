<?php

use PHPUnit\Framework\TestCase;

// phpunit does not find relative parent path
require_once(realpath(dirname(dirname(__FILE__))).'/table_manager.php');
require_once(realpath(dirname(dirname(__FILE__))).'/view_formatter.php');

use kwd\tth\TableManager as TableManager;
use kwd\tth\ViewFormatter as ViewFormatter;

class mock_rex_sql {

}

function mock_rex_getUrl($articleId = '', $cLang = '', $params = []) {
	$str = '/abfragen/';

	switch ($articleId) {
		case 5 : $str.='quellen/'; break;
		case 6 : $str.='quarks/'; break;
		case 7 : $str.='filter/'; break; 
		default: $str .= 'details/'; // assumed current page
	}

	if ($cLang) $str .= '/'.$cLang.'/';
	if (count($params)) {
		$str .= '?';
		foreach($params as $key => $val) {
			$str .= $key . '='.$val.'&';
		}
		$str = rtrim($str,'&');
	}

	return $str;
}

/**
*	@test
*/
class ViewFormatterTest extends TestCase {

	/**
	*	@test
	*   @covers prove of phpunit
	* 
	* !!! Not clear if init of objects can work because of inner dependencies
	*
	*
	*
	*
	*/
	public function testGetEntityFields() {
		$sql = new mock_rex_sql();
		$vm = new ViewFormatter($sql, 'mock_rex_getUrl');

		$checkEntityFields = $vm->getEntityFields();
		$this->assertArrayHasKey('entity_id', $checkEntityFields);
		$this->assertArrayHasKey('entity_name', $checkEntityFields);
		
		// !!! check depends on current implementation of TableManager:
		$this->assertEquals('begriff_id',$checkEntityFields['entity_id']);
		$this->assertEquals('begriff',$checkEntityFields['entity_name']);
	}

	public function testGetEntityLinkList() {
		// now mock_rex_getUrl must work correctly!
		$sql = new mock_rex_sql();
		$vm = new ViewFormatter($sql, 'mock_rex_getUrl');

		$data = [];
		// test empty array, should produce *empty* string, no accidental white space allowed.
		$this->assertSame('', $vm->getEntityLinkList($data));
		$this->assertSame('', $vm->getEntityLinkList($data, '5')); // not important whether articleId set, bot test both
		
		// need an array like it would be produced by TableManager
		// we add an 'begriff_id' to check that the function doesn't get confused, although not needed for main purpose
		$data = [
			[
				'id' => 645,
				'begriff_id' => 100,
				'begriff' => 'Abbund'
			],
			[
				'id' => 647,
				'begriff_id' => 200,
				'begriff' => 'Abbundzeichen'
			],
			[
				'id' => '1850',
				'begriff_id' => 42,
				'begriff' => 'Zusatzzeichen'
				]
		];
			
			
		$this->assertSame('<a href="/abfragen/details/?begriff_id=645">Abbund</a>, <a href="/abfragen/details/?begriff_id=647">Abbundzeichen</a>, <a href="/abfragen/details/?begriff_id=1850">Zusatzzeichen</a>', $vm->getEntityLinkList($data));
		
		// - test articleId as string AND int
		$this->assertSame('<a href="/abfragen/quarks/?begriff_id=645">Abbund</a>, <a href="/abfragen/quarks/?begriff_id=647">Abbundzeichen</a>, <a href="/abfragen/quarks/?begriff_id=1850">Zusatzzeichen</a>', $vm->getEntityLinkList($data, 6));
		$this->assertSame('<a href="/abfragen/filter/?begriff_id=645">Abbund</a>, <a href="/abfragen/filter/?begriff_id=647">Abbundzeichen</a>, <a href="/abfragen/filter/?begriff_id=1850">Zusatzzeichen</a>', $vm->getEntityLinkList($data, '7'));

		// we also add invalid keys here
		$data = [
			[
				'begriff_id' => 23,
				'sprache_id' => 67,
				'begriff' => 'Peter'
			],
			[
				'id' => 1,
				'sprache_id' => 3,
				'begriff' => 'Abbund'
			],
			[
				'id' => 901,
				'begriff_id' => 342,
				'stil' => 'Allgemein'
			],
			[
				'id' => 4902,
				'sprach_id' => '2',
				'sprache' => 'Englisch'
			]
		];

		// hence swallows all entries but the 2nd one
		$this->assertSame('<a href="/abfragen/details/?begriff_id=1">Abbund</a>', $vm->getEntityLinkList($data));
	}
}