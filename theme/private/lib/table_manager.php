<?php
// IDEA: 
//  - build queries
//  - manage outputs
//  - manage names
//  - DON'T use redaxo classes like rex_sql directly (pass or wrap)
//  - OR pass the needed classes/methods/information from Redaxo as reference
//  - *cache* DB output, esp. for detailed view and hierarchy because ALL entities (id, name) need to be read anyway

// !!! only module related code
//     - no formatting, no views
//     - formatting must go to viewmodel/view functions
//     - which are direct data, which are formatted data (viewmodel)?? 


namespace kwd\tth;

class TableManager {
	const TABLE_PREFIX = 'tth_';
	const DESCRIPTOR_ID = 2; // !!! logic to read it from DB, maybe we need an extra config table
	const FACETTE_ID = 8; // !!! logic to read it from DB, maybe we need an extra config table

	// !!! how can $tableNames and $tableIdFields be generated??
	// !!! could be generated in construct by reading DB or at least composed from strings
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
		'tags' => self::TABLE_PREFIX .'tags',
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
		'state' => 'begriffsstatus_id',//  state singular because 1:n
		'tags' => 'tag_id',
	);
	
	protected $tableFields = array(
		'name' => 'name',
		'entity' => 'begriff',
		'is_category' => 'kategorie',
		'edit' => 'bearbeiten'
	);

	// combines: tableName, idField, readableNameField(for output)
	// of tables with 1:n relations to $tableNames['entities']
	protected $outerRelations = [];

	protected $sqlObject = null;

	function __construct(&$sql) {
		// check why i need to re-configure prefix and table names
		// initTableNames()
		$this->sqlObject = $sql; // does this pass reference?

		// !!! how write on init or more automated? maybe more consistent naming
		$this->outerRelations = array(			
			'authors' => [
				'table' => $this->tableNames['authors'],
				'id' => 'autor_id', // used in ttq_quellen, tth_quellenangaben, not in tth_wortlise
				'name' => 'name', 
			],
			'languages' => [
				'table' => $this->tableNames['languages'],
				'id' => 'sprache_id', // id used in $tableNames['entities']
				'name' => 'sprache', // name field used in tableNames['languages']
			],
			'languagestyles' => [
				'table' => $this->tableNames['languagestyles'],
				'id' => 'sprachstil_id', // id used in $tableNames['entities']
				'name' => 'stil', 
			],
			'regions' => [
				'table' => $this->tableNames['regions'],
				'id' => 'region_id', // id used in $tableNames['entities']
				'name' => 'region', 
			],
			'states' => [
				'table' => $this->tableNames['entitystates'],
				'id' => 'begriffsstatus_id', //$this->getTableIdField['state'], // !!! access like this also the others...
				'name' => 'status', 
			],
			'sources' => [
				'table' => $this->tableNames['sources'],
				'id' => 'id', // invalid/obsolete, because must be put to entities n:m via tth_quellenangaben
				'name' => 'kurz' // only for easy listing/sorting
			],
			'tags' => [
				'table' => $this->tableNames['tags'],
				'id' => 'tag_id', // used for query for n:m relation table (tth_begriff_tags)
				'name' => 'name', // only for easy listing/sorting
				'relationTable' => $this->tableNames['entity_tags']
			]
		);
	}

	/**
	 * Produces id which must be present in table tth_begriffsstati and is currently used for "facettes"
	 * 
	 * @return int id 
	 */
	public function getFacetteId() {
		return (self::FACETTE_ID);
	}

	/**
	 * Produces id which must be present in table tth_begriffsstati and is currently used for "Descriptors"
	 * 
	 * @return int id 
	 */
	public function getDescriptorId() {
		return (self::DESCRIPTOR_ID);
	}

	

	public function getOuterRelationTableInfo($subject) {
		if (array_key_exists($subject, $this->outerRelations)) {
			return $this->outerRelations[$subject];
		}

		return [];
	}

	/**
	 * returns only name of outer relation table defined by id
	 * 
	 * @param subject key of my internal naming of data tables or inner relations (see above in this class)
	 * @param id entry in outer relation table, e.g. id of a language in the table of languages
	 */
	public function getOuterRelationName($subject, $id) {
		$outerTable = $this->getOuterRelationTableInfo($subject);
		if (count($outerTable)) {
			$query = "SELECT ${outerTable['name']} from ${outerTable['table']} WHERE id = :subjectId";
			$nameArray = $this->sqlObject->getArray($query, ['subjectId'=>$id]);
			if (count($nameArray)) {
				return $nameArray[0][$outerTable['name']];
			}
		}

		return '';
	}

	/**
	 * get all data from a "outer relation table"
	 * 
	 * These are tables which define own things which can be bound to entities (of tth_wortliste)
	 * by any relation (1:n, n:m)
	 */
	public function getOuterRelationTableData($subject) {
		$outerTable = $this->getOuterRelationTableInfo($subject);
		if (count($outerTable)) {

			$query = "SELECT * FROM ${outerTable['table']} WHERE 1 ORDER BY ${outerTable['name']} ASC";
			return $this->sqlObject->getArray($query);
		}

		return [];
	}

	/**
	 * returns entities which match the id pointer of a field or entries in a relation table
	 * 
	 * - decides on existence of relation table in info whether simple relation (tth_wortliste contains id)
	 *   OR n:m relation (relation table required)
	 */
	public function getEntitiesForOuterRelation($subject, $id) {
		$outerTable = $this->getOuterRelationTableInfo($subject);
		if (count($outerTable)) {
			if (array_key_exists('relationTable',$outerTable)) {
				$query = "SELECT r.tag_id, r.begriff_id, e.begriff, e.id ";
				 // e.id for output getLinkList
				$query.= "FROM ".$outerTable['relationTable']." r ";
				$query.= "JOIN ".$this->tableNames['entities']." e ON r.begriff_id = e.id ";
				$query.= "WHERE r.".$outerTable['id']."=:idForSubject ORDER BY e.begriff ASC";
			}
			else {
				$query = "SELECT id, begriff FROM ".$this->tableNames['entities']." WHERE ${outerTable['id']} = :idForSubject ORDER BY begriff ASC";
			}
			
			return $this->sqlObject->getArray($query,['idForSubject' => $id]);
		}

		return [];
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
	 */
	public function getInnerRelations($type, $id) {
		return $this->sqlObject->getArray($this->buildInnerRelationQuery($type, $id));
	}

	/** queries rows from SQL and produced markup for link list
	 *  
	 */
	public function getInnerReverseRelations($type, $id) {
		return $this->sqlObject->getArray($this->buildInnerReverseRelationQuery($type, $id));
	}

	public function getTableNames() {
		return $this->tableNames; // ! makes copy
	}

	public function getTablePrefix() {
		return self::TABLE_PREFIX;
	}

	
	/** reads table names from DB and checks if set variables are ok
	 * - checks if each is exactly *once* in array!
	 */
	public function verifyTableNames() {
	}

	/**
	 * filter entities by a certain 1:n field of tth_wortliste
	 */
	public function getEntitiesByField($subject, $value) {
		$field = $this->tableIdFields[$subject];
		if (!isset($field)){
			$field = $this->getTableField($subject);
		}

		if (isset($field)) {
			$query = "SELECT id, begriff FROM ".$this->tableNames['entities']." WHERE $field = :value ORDER BY begriff ASC";
			return $this->sqlObject->getArray($query, ['value' => $value]);
		}

		return [];
	}

	public function getTableField($id) {
		return $this->tableFields[$id];
	}

	public function getTableIdField($id) {
		return $this->tableIdFields[$id];
	}
}