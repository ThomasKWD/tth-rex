<?php

require_once('test_init.php');
use PHPUnit\Framework\TestCase;

/**
*	@test
*/
class ViewFormatterTest extends TestCase {

	protected $vm = null;

	function setUp() {
		$this->vm = initViewFormatter();
	}

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
		$checkEntityFields = $this->vm->getEntityFields();
		// $this->assertArrayHasKey('entity_id', $checkEntityFields); // currently not used
		$this->assertArrayHasKey('entity_name', $checkEntityFields);
		
		// !!! check depends on current implementation of TableManager:
		// $this->assertEquals('begriff_id',$checkEntityFields['entity_id']);
		$this->assertEquals('begriff',$checkEntityFields['entity_name']);
	}

	public function testGetEntityLinkList() {
		$data = [];
		// test empty array, should produce *empty* string, no accidental white space allowed.
		$this->assertSame('', $this->vm->getEntityLinkList($data));
		$this->assertSame('', $this->vm->getEntityLinkList($data, '5')); // not important whether articleId set, bot test both
		
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
			
			
		$this->assertSame('<a href="/abfragen/details/?begriff_id=645">Abbund</a>, <a href="/abfragen/details/?begriff_id=647">Abbundzeichen</a>, <a href="/abfragen/details/?begriff_id=1850">Zusatzzeichen</a>', $this->vm->getEntityLinkList($data));
		
		// - test articleId as string AND int
		$this->assertSame('<a href="/abfragen/quarks/?begriff_id=645">Abbund</a>, <a href="/abfragen/quarks/?begriff_id=647">Abbundzeichen</a>, <a href="/abfragen/quarks/?begriff_id=1850">Zusatzzeichen</a>', $this->vm->getEntityLinkList($data, 6));
		$this->assertSame('<a href="/abfragen/filter/?begriff_id=645">Abbund</a>, <a href="/abfragen/filter/?begriff_id=647">Abbundzeichen</a>, <a href="/abfragen/filter/?begriff_id=1850">Zusatzzeichen</a>', $this->vm->getEntityLinkList($data, '7'));

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
		$this->assertSame('<a href="/abfragen/details/?begriff_id=1">Abbund</a>', $this->vm->getEntityLinkList($data));
	}
	
	/**
	*	@test
	*   @covers getTruthyWord
	* 
	* !!! Not clear if init of objects can work because of inner dependencies
	*
	*
	*
	*
	*/
	public function testGetTruthyWord() {
		$vm = $this->vm;
        $this->assertSame('ja', $vm->getTruthyWord('true'));
        $this->assertSame('ja', $vm->getTruthyWord('TRUE'));
        $this->assertSame('ja', $vm->getTruthyWord('True'));
        $this->assertSame('nein', $vm->getTruthyWord('false'));
        $this->assertSame('nein', $vm->getTruthyWord('FALSE'));
        $this->assertSame('nein', $vm->getTruthyWord('falSE'));	
		// concept of unset/empty
		$this->assertSame('(nicht gesetzt)', $vm->getTruthyWord(false)); 
		$this->assertSame('(nicht gesetzt)', $vm->getTruthyWord(''));
		$this->assertSame('(nicht gesetzt)', $vm->getTruthyWord(0));
	}
}