<?php
// IDEA: 
//  - build queries
//  - manage outputs
//  - manage names
//  - DON'T use redaxo classes like rex_sql directly 
//  - OR pass the needed classes/methods/information from Redaxo as reference

namespace kwd\tth;

class TableManager {
	const TABLE_PREFIX = 'tth_';

	protected $_tableNames = array(
		'entities' => self::TABLE_PREFIX . 'wortliste',
		'sources' => self::TABLE_PREFIX . 'quellen',
		'sources_authors' => self::TABLE_PREFIX . 'quellen_autoren',
		'authors' => self::TABLE_PREFIX . 'autoren',
		'languages' => self::TABLE_PREFIX .'sprachen',
		'regions' => self::TABLE_PREFIX .'regionen',
		'entitystates' => self::TABLE_PREFIX .'begriffsstati',
		'languagestyles' => self::TABLE_PREFIX .'sprachstile',
		'metaentities' => self::TABLE_PREFIX .'metabegriffe',
		'entity_relatives' => self::TABLE_PREFIX .'begriff_verwandte',
		'entity_supers' => self::TABLE_PREFIX .'begriff_oberbegriffe',
		'entity_subs' => self::TABLE_PREFIX .'begriff_unterbegriffe',
		'entity_subs' => self::TABLE_PREFIX .'begriff_unterbegriffe',
		'entity_equivalent' => self::TABLE_PREFIX .'begriff_aequivalente',
		'references' => self::TABLE_PREFIX .'quellenangaben',
		'references_fields' => self::TABLE_PREFIX .'quellenangaben_felder',
		'tablenames' => self::TABLE_PREFIX .'tabellennamen'
	);

	function __construct() {
		// check why i need to re-configure prefix and table names
		// initTableNames()
	}

	/**
	 * check a boolean field expressed by a word (string) as provided by YForm or Access
	 * 
	 * !!! language independent
	 * 
	 * @param word string as found in DB field
	 * @return string in German which expresses true ("ja") or false ("nein")
	 */
	function checkTruthyWord($word) {
		if ($word) {
			if ($word !== true) $word = strtoupper($word);
			if($word === true || $word === 'WAHR' || $word === 'TRUE'){					
				return 'ja';
			}
		}

		return 'nein';
	}

	/** generates <a> markup for given parameters.
	 *  
	 * ??? uses *predefined* `rex_getUrl`
	 */
	public function getLink($idName, $id, $desc, $article_id = '') {
		return '<a href="'.rex_getUrl($article_id, '', array($idName => $id)).'">'.$desc.'</a>';
	}

	function makeLinkList($array, $linkUrlId, $linkName, $articleId = '') {
		$str = '';
		$length = count($array);
		for($i = 0; $i < $length; $i++) {
			$s = $array[$i];
			$str .= $this->getLink($linkUrlId, $s['id'], $s[$linkName], $articleId) . ($i < $length - 1 ? ', ' : '');
		}
		return $str;
	}
	
	public function getTableNames() {
		return $this->_tableNames; // ! makes copy
	}

	public function getTablePrefix() {
		return self::TABLE_PREFIX;
	}

	/** reads table names from DB and checks if set variables are ok
	 * - checks if each is exactly *once* in array!
	 */
	public function verifyTableNames() {
	}
}