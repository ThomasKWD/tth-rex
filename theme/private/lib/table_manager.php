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
		'states' => self::TABLE_PREFIX .'begriffsstati',
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
		'glossar' => self::TABLE_PREFIX.'glossar',
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
		'edit' => 'bearbeiten',
		'synonyms' => 'benutzt_fuer', // ! 
		'descriptor' => 'benutze',
		'description' => 'beschreibung'
	);

	// combines: tableName, idField, readableNameField(for output)
	// of tables with 1:n relations to $tableNames['entities']
	protected $outerRelations = [];

	protected $sqlObject = null;

	/**
	 * inits instance of TableManager.
	 * 
	 * @param sql rex_sql object, (don't need to pass by reference objects!) 
	 */
	function __construct($sql) {
		// check why i need to re-configure prefix and table names
		// initTableNames()
		$this->sqlObject = $sql; // does this pass reference?

		// !!! how write on init or more automated? maybe more consistent naming
		// !!! rename because entities are here too, needed to prevent get all fields in some situations
		$this->outerRelations = array(			
			'entities' => [
				'table' => $this->tableNames['entities'],
				'id' => 'begriff_id', // useful in relation contexts
				'name' => 'begriff', 
			],
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
				'table' => $this->tableNames['states'],
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
			],
			'references' => [
				'table' => $this->tableNames['sources'],
				'id' => 'quelle_id', // used for query for n:m relation table (tth_quellenangaben)
				'name' => 'kurz', // only for easy listing/sorting
				'relationTable' => $this->tableNames['references']
			],
			'glossar' => [
				'table' => $this->tableNames['glossar'],
				'id' => 'id', // actually unused
				'name' => 'wort'
			]
		);
	}

	/**
	 * Produces id which must be present in table tth_begriffsstati and is currently used for "facettes"
	 * 
	 * @return int id 
	 */
	public function getFacetId() {
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
	 * returns only name of outer relation table *entry* defined by idate
	 * 
	 * Reads actual name determined by id from DB
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
				$query = "SELECT r.{$outerTable['id']}, r.begriff_id, e.begriff, e.id ";
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
	 * queries entities which don't provide relation to a n:m relation table 
	 * 
	 * - must use OUTER join, see: https://www.xaprb.com/blog/2005/09/23/how-to-write-a-sql-exclusion-join/
	 * - can easily be used for oberbegriffe/unterbegriffe as well! use `entity_supers` and `entity_subs`
	 * ! only work because all relation tables use the same field name `begriff_id`
	 */
	public function buildUnsetRelationQuery($subject) {
		$table = $this->getTableName($subject);
		if ($table) {
			return "SELECT b.id, b.{$this->tableFields['entity']} FROM {$this->tableNames['entities']} b LEFT OUTER JOIN $table o ON o.{$this->tableIdFields['entity']} = b.id WHERE o.begriff_id is NULL ORDER BY b.begriff ASC";
		}
		return '';
	}

	/**
	 * returns array of entities which are *not* found in thes specified in the inner or foreign n:m relation
	 * 
	 * @param subject is used to select the correct relation table, same naming schema as for `outerRelations` data
	 */
	public function getEntitiesForUnsetRelation($subject): array {
		$query = $this->buildUnsetRelationQuery($subject);
		if ($query) {
			return $this->sqlObject->getArray($query);
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
	 * Finds entities by search pattern
	 *  Returns a single entity OR all entities which are named exactly the same
	 * 
	 * That's why we still need to return array
	 * ! searchPattern must be correctly inserted by fetch function
	 * 
	 * @param strict makes `=` when true, else `LIKE` keyword for SQL
	 */
	public function buildSearchEntitiesQuery($strict = false) {
		return "SELECT id, {$this->tableFields['entity']} from {$this->tableNames['entities']} WHERE {$this->tableFields['entity']} ".($strict ? '=' : "LIKE")." :wordsearch ORDER BY {$this->getTableField('entity')} ASC";
	}

	/**
	 * returns entities for search
	 * 
	 * details see: buildSearchEntitiesQuery
	 */
	public function findEntities($searchPattern, $strict = false) {
		return $this->sqlObject->getArray(
			$this->buildSearchEntitiesQuery($strict),
			['wordsearch' => str_replace('*','%',$searchPattern)]
		);
	}

	/**
	 * check a boolean field expressed by a word (string) as provided by YForm or Access
	 * 
	 * ! returns `NULL` when is real `false` because this is considered empty
	 * ! returns `true` on real boolean `true`
	 * 
	 * @param word string as found in DB field
	 * @return boolean OR null when word itself is falsy/empty
	 */
	public function checkTruthyWord($word) {
		if (true === $word) return true;
		if (!$word) return null; // also '', 0, false, unset
		$word = strtoupper(strval($word));
		if($word === 'WAHR' || $word === 'TRUE'){					
			return true;
		}
		return false;
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

	public function getTableName($subject) {
		if (array_key_exists($subject, $this->tableNames)) {
			return $this->tableNames[$subject];
		}
		return '';
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
		$field = $this->getTableIdField($subject);
		if (!$field) $field = $this->getTableField($subject);
		if ($field) {
			$query = "SELECT id, begriff FROM ".$this->tableNames['entities']." WHERE $field = :value ORDER BY begriff ASC";
			return $this->sqlObject->getArray($query, ['value' => $value]);
		}
		return [];
	}

	/**
	 * generates query for getting names of foreign n:m table
	 * 
	 * e.g. 'tags', 'references'
	 * 
	 * reads table name and required name fields form subjects table `outerRelations`
	 * an empty info field means invalid subject
	 * 
	 * returns *all* fields from the relation table (not the joined table!)
	 */
	public function buildForeignEntriesQuery($subject, $idValueName) {
		
		$info = $this->getOuterRelationTableInfo($subject);
		if (count($info)) {
			// $query = "SELECT r.{$info['id']}, r.begriff_id, s.* "; // would return whole row data from *joined* table
			$query = "SELECT r.*, s.{$info['name']} ";
			$query.= "FROM {$info['relationTable']} r ";
			$query.= "JOIN {$info['table']} s ON r.{$info['id']} = s.id ";
			$query.= "WHERE r.begriff_id = :$idValueName ORDER BY s.{$info['name']} ASC";
			return $query;
		}

		return '';
	}

	/**
	 * returns entry names + ids of a foreign table which is n:m related to "entities"
	 * 
	 * Currently these can only be the 'tags', 'references', 'tth_begriff_quellen'(not even subject name defined!)
	 * empty query due to invalid `subject` should lead to doing nothing
	 */
	public function getForeignEntries($subject, $id) {
		$queryVarName = 'entity_id';
		$query = $this->buildForeignEntriesQuery($subject, $queryVarName); 
		if ($query) return $this->sqlObject->getArray($query, [ $queryVarName  => $id ]);
		return [];
	}

	/** returns all entries from a table
	 * 
	 * only returns short info (id and a name)
	 * 
	 * for return *all* data for *all* entries make separate function or parameter when needed
	 */
	public function getAllEntries($subject, $sortAlphabetical = true, $fullData = false) : array{
		$info = $this->getOuterRelationTableInfo($subject);
		if (count($info)) {
			// "SELECT id,region FROM tth_regionen WHERE 1");
			// ! implicitly assuming id is always present
			$query = "SELECT ";
			$query .= ($fullData ? "* " : "id, {$info['name']} ");
			$query .= "FROM {$info['table']} WHERE 1";
			if ($sortAlphabetical) $query .= " ORDER BY {$info['name']} ASC";
			return $this->sqlObject->getArray($query);
		}
		return [];
	}

	public function buildSingleEntityQuery() {
		$tableAuthors = $this->getTableName('authors');
		$tableStati = $this->getTableName('states');
		$tableLanguage = $this->getTableName('languages');
		$tableRegions = $this->getTableName('regions');
		$tableStyles = $this->getTableName('languagestyles');
		$tableEntities = $this->getTableName('entities');
		
		// ! b is first alias for $tableEntities, b2 is the second for benutze
		$query = "SELECT b.begriff,b.id,b.autor_id,$tableAuthors.gnd,b.quelle_seite,b.code,b.definition,b.bild,b.begriffsstatus_id,$tableStati.status,b.notes,b.benutze,b.benutzt_fuer,b.kategorie,b.veroeffentlichen,b.bearbeiten,b.sprache_id,b.sprachstil_id,b.region_id,";
		$query .= "b2.begriff AS benutze_begriff,CONCAT($tableAuthors.vorname, ' ', $tableAuthors.name) AS autor,";
		$query .= "$tableLanguage.sprache AS sprache,";
		$query .= "$tableRegions.region AS region, ";
		$query .= "$tableStyles.stil AS sprachstil ";
		$query .= "FROM $tableEntities b ";
		$query .= "LEFT JOIN $tableAuthors ON b.autor_id = $tableAuthors.id ";
		$query .= "LEFT JOIN $tableStati ON b.begriffsstatus_id = $tableStati.id ";
		$query .= "LEFT JOIN $tableLanguage ON b.sprache_id = $tableLanguage.id ";
		$query .= "LEFT JOIN $tableRegions ON b.region_id = $tableRegions.id ";
		$query .= "LEFT JOIN $tableStyles ON b.sprachstil_id = $tableStyles.id ";
		$query .= "LEFT JOIN $tableEntities b2 ON b2.id = b.benutze WHERE b.id = :entityId";

		return $query;
	}

	/** returns data of an entity specified by id
	 * 
	 * Some id relations are resolved to readable names (sql joins)
	 */
	public function getSingleEntity($id) {
		$rows = $this->sqlObject->getArray($this->buildSingleEntityQuery(), [ 'entityId' => $id]);
		// return first, assuming there is just 1
		if (count($rows)) {
			return $rows[0];
		}
		return [];
	}

	/** returns data of an entity specified by id
	 * 
	 * Some id relations are resolved to readable names (sql joins)
	 */
	public function getSingleDataSet($subject, $id) {
		$table = $this->getTableName($subject);
		if ($table) {
			$query = "SELECT * FROM $table WHERE id = :dataSetId";
			$rows = $this->sqlObject->getArray($query, [ 'dataSetId' => $id]);
			// return first, assuming there is just 1
			if (count($rows)) {
				return $rows[0];
			}
		}

		return [];
	}

	/**
	 * build the query for better unit testing
	 * 
	 * !!!  use vars from field names
	 */
	public function buildAuthorsForSourceQuery() {
		// select all authors for this source, similar to code for relation in begriffe
		$query = "SELECT a.* ";
		$query.= "FROM {$this->getTableName('authors')} a ";
		$query.= "JOIN {$this->getTableName('sources_authors')} g1 ON a.id = g1.autor_id ";
		$query.= "JOIN {$this->getTableName('sources')} q ON q.id = g1.quelle_id ";
		$query.= "WHERE q.id = :sourceId ORDER BY a.name ASC";
		return $query;
	}

	/**
	 * specialized search for "authors" of a "source" via n:m relation table
	 * 
	 * ! There has not been found a more general function for that purpose yet
	 */
	public function getAuthorsForSource($id) {
		return $this->sqlObject->getArray(
			$this->buildAuthorsForSourceQuery(),
			[ 'sourceId' => $id]
		);
	}

	public function getTableField($id) {
		if (array_key_exists($id, $this->tableFields)) {
			return $this->tableFields[$id];
		}
		return '';
	}

	public function getTableIdField($id) {
		if (array_key_exists($id, $this->tableIdFields)) {
			return $this->tableIdFields[$id];
		}
		return '';
	}

	/**
	 * converts 1 or more old tables to new entries in n:m relations with relation tables
	 * 
	 * ! does *not* CREATE any missing table.
	 * ! existing entries are not overwritten 
	 * 
	 * @param request assoc array which comes from YForm formdata (POST)
	 */
	public function convertRelationTable($request, $performWrite = false) {
		
		switch ($request) {
			case 'nd_beleg quellen':
				$sourceField = 'quellen_idlist';
				$targetTable = 'tth_begriff_quellen';
				$targetIdField = 'quelle_id';
				break;
			case 'oberbegriffe':
				$sourceField = 'oberbegriffe';
				$targetTable = 'tth_begriff_oberbegriffe';
				$targetIdField = 'oberbegriff_id';
				break;
			case 'unterbegriffe':
				$sourceField = 'unterbegriffe';
				$targetTable = 'tth_begriff_unterbegriffe';
				$targetIdField = 'unterbegriff_id';
				break;
			case 'aequivalente begriffe':
				$sourceField = 'aequivalent';
				$targetTable = 'tth_begriff_aequivalente';
				$targetIdField = 'aequivalent_id';
				break;
			case 'verwandte begriffe':
				$sourceField = 'verwandte_begriffe';
				$targetTable = 'tth_begriff_verwandte';
				$targetIdField = 'verwandter_id';
				break;
			case 'grobgliederung':
				$sourceField = 'grobgliederung';
				$targetTable = 'tth_begriff_grobgliederung';
				$targetIdField = 'grobgliederung_id';
				break;
			default:
				$sourceField = '';
				$targetTable = '';
				$targetIdField = '';
			break;
		}
	
		$resultInfo = [];

		// when 'default' -- can easily happen when form changed in structure content form module
		if ($sourceField) {
			// $query = 'TRUNCATE '.$targetTable;
			// $sql->setQuery($query);
		
			// !!! for a new operation you must be sure the last one is ready (maybe asynch!!)

			// - begriff field only for control outputs
			$query = 'SELECT id,begriff,'.$sourceField.' FROM tth_wortliste WHERE 1';
			// $query = 'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE "%;%"';
			$rows = $this->sqlObject->getArray($query);
			
			$insertList = '';
			$count = 0;
			$insertCount = 0;
			foreach($rows as $row) {
				if(trim($row[$sourceField])) {
					$count++;
					$nodes = explode(';',$row[$sourceField]);
					// - don't need NULL check for $nodes
					foreach($nodes as $node) {
						if (trim($node)) {
							$insertList .= '('.$row['id'].','.$node."),\n";
							$insertCount++;
						}
					}
				}
			}

			// remove last comma!
			$insertList = rtrim($insertList,',');
			// dump($insertList);
			// echo $insertList;
			$query = 'INSERT INTO '.$targetTable.' (begriff_id, '.$targetIdField.') VALUES '.$insertList;

			// uncomment this when like to really WRITE
			if ($performWrite) {
				$this->sqlObject->setQuery($query);
			}

			$resultInfo = [
				'request' => $request,
				'target_id_field' => $targetIdField,
				'affected_rows' => $count,
				'found_rows' => count($rows),
				'written_rows' => $insertCount,
				'target_table' => $targetTable,
				'error_message' => ''
			];
		}
		else {
			$resultInfo['error_message'] = 'invalid_selection';
		}

		return $resultInfo;	
	}

	/**
	 * produces list of entities (short info) from list of ids
	 * 
	 * !!! vars for field names
	 */
	public function getEntitiesFromIdList($idList) {
		$query = "SELECT id,begriff from tth_wortliste WHERE ";
		for($i = count($idList) - 1; $i >= 0; $i--) {
			$query .= "id = ".$idList[$i];
			if ($i) $query .= " OR ";
		} 
		$query .= " ORDER BY begriff ASC";
		// dump($query);
		return $this->sqlObject->getArray($query);
	}
}