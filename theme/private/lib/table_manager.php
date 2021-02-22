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

	// !!! how can $tableNames and $tableIdFields be generated??

	protected $tableNames = array(
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
		'entity_structuring' => self::TABLE_PREFIX .'begriff_grobgliederung',
		'entity_supers' => self::TABLE_PREFIX .'begriff_oberbegriffe',
		'entity_subs' => self::TABLE_PREFIX .'begriff_unterbegriffe',
		'entity_equivalents' => self::TABLE_PREFIX .'begriff_aequivalente',
		'entity_tags' => self::TABLE_PREFIX .'begriff_tags',
		'references' => self::TABLE_PREFIX .'quellenangaben',
		'references_fields' => self::TABLE_PREFIX .'quellenangaben_felder',
		'tablenames' => self::TABLE_PREFIX .'tabellennamen'
	);


	protected $tableIdFields = array(
		'entity' => 'begriff_id',
		'structuring' => 'grobgliederung_id',
		'supers' => 'oberbegriff_id',
		'subs' => 'unterbegriff_id',
		'relatives' => 'verwandter_id',
		'equivalents' => 'aequivalent_id',
		'tags' => 'tag_id'
	);

	protected $tableFields = array(
		'name' => 'name',
		'entity' => 'begriff'
	);

	function __construct() {
		// check why i need to re-configure prefix and table names
		// initTableNames()
	}

	/**
	 * make a SQL query from known tablenames and a certain inner relation of entities and an id.
	 * 		
	 */
	function buildInnerRelationQuery($relationType, $id) {
		$query = "SELECT e2.id, e2.{$this->tableFields['entity']} ";
		$query.= "FROM {$this->tableNames['entities']} e1 ";
		// ! next line gives SQL exception on wrong value in $relationType
		$query.= "JOIN {$this->tableNames['entity_'.$relationType]} g1 ON e1.id = g1.{$this->tableIdFields['entity']} ";
		$query.= "JOIN {$this->tableNames['entities']} e2 ON e2.id = g1.{$this->tableIdFields[$relationType]} ";
		$query.= "WHERE e1.id=$id ";
		return $query;
	}

	/**
	 * make a SQL query from known tablenames and a certain inner relation of entities and an id.
	 * 		
	 * in this case we handle it differently:
	 * - get all from entities (tth_wortliste) which point to current ($id) by its entity field (begriff_id)
	 */
	function buildInnerReverseRelationQuery($relationType, $id) {
		$query = "SELECT e2.id, e2.{$this->tableFields['entity']} ";
		$query.= "FROM {$this->tableNames['entities']} e1 ";
		// ! next line gives SQL exception on wrong value in $relationType
		$query.= "JOIN {$this->tableNames['entity_'.$relationType]} g1 ON e1.id = g1.{$this->tableIdFields[$relationType]} ";
		$query.= "JOIN {$this->tableNames['entities']} e2 ON e2.id = g1.{$this->tableIdFields['entity']} ";
		$query.= "WHERE e1.id=$id ";
		return $query;
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

	/** queries rows from SQL and produced markup for link list
	 *  
	 * This is a helper for DRYing code
	 * @param sql object of type rex_sql needing method `getArray`
	 */
	public function getInnerRelationLinkList(&$sql, $type, $id) {		
		return $this->makeLinkList(
			$sql->getArray($this->buildInnerRelationQuery($type, $id)),
			'begriff_id',
			'begriff'
		);
	}

	
	/** queries rows from SQL and produced markup for link list
	 *  
	 * This is a helper for DRYing code
	 * @param sql object of type rex_sql needing method `getArray`
	 */
	public function getInnerReverseRelationLinkList(&$sql, $type, $id) {		
		return $this->makeLinkList(
			$sql->getArray($this->buildInnerReverseRelationQuery($type, $id)),
			'begriff_id',
			'begriff'
		);
	}

	/** generates <a> markup for given parameters.
	 *  
	 * uses *predefined* `rex_getUrl` stub
	 */
	public function getLink($idName, $id, $desc, $article_id = '') {
		return '<a href="'.rex_getUrl($article_id, '', array($idName => $id)).'">'.$desc.'</a>';
	}

	public function getTableNames() {
		return $this->tableNames; // ! makes copy
	}

	public function getTablePrefix() {
		return self::TABLE_PREFIX;
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
	
	/**
	 * generate simple "key-value-table row"
	 */
	function makeRow($key, $value) {
		return '<tr><td>'.$key.'</td><td>'.$value."</td></tr>\n";
	}

	/** reads table names from DB and checks if set variables are ok
	 * - checks if each is exactly *once* in array!
	 */
	public function verifyTableNames() {
	}

	/**
	 * returns all entities which are related to another 1:n table
	 * 
	 * e.g. language, region
	 * 
	 * @param sql reference to rex_sql object
	 * @param table name of table
	 * @param idField name of field for referenced id in tth_wortliste
	 * @param nameField name of field for readable name of referenced table
	 * @param id selected id to filter for, 0 allowed  
	 */
	public function getFilteredEntities(&$sql, $table, $idField, $nameField, $id, $articleId)
	{
		if ($id || 0 === $id || '0' === $id) {
			$id = intval($id);
			$nameArray = $sql->getArray("SELECT `$nameField` from $table WHERE id=$id");
			if (count($nameArray)) $name = $nameArray[0][$nameField];
			else $name = 'nicht gesetzt';
			
			$html = $this->makeLinkList($sql->getArray("SELECT id,begriff FROM tth_wortliste WHERE $idField=$id ORDER BY begriff ASC"), 'begriff_id', 'begriff',  $articleId)
			;

			if (!$html) $html = "(Keine Einträge gefunden.)";
			
			return "<p><strong>Begriffe nach \"$name\":</strong> $html </p>";
		}
		return '';
	}
}