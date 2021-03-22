<?php
declare(strict_types = 1);
// !!! maybe need 3rd class (viewmodel) which brings model and view together and is called by MODULE code

namespace kwd\tth;

class ViewFormatter {

	const entityIdForUrl = 'begriff_id';
	const tagsIdForUrl = 'begriff_id';

    protected $model = null;
    protected $getUrlFunction = '';
	protected $entityFields = [];

	function __construct($sqlObject, $getUrlFunction) {
		$this->model = new TableManager($sqlObject);
        $this->getUrlFunction = $getUrlFunction;
		// !!! must be used for more fields in this class (prevent hard coded field names from/for db)
		// $this->entityFields['entity_id'] = $this->model->getTableIdField('entity'); // results in 'begriff_id'; //! currently not used
		$this->entityFields['entity_name'] = $this->model->getTableField('entity'); // results in 'begriff' 
    }

	/** Get field names for entity access
	 * 
	 * also needed in view because sometimes view gets assoc arrays with keys as described here.
	 * These keys should not be hard coded in view to allow later changes.
	*/
	public function getEntityFields() {
		return $this->entityFields;
	}

	public function getTableManagerInstance() {
		return $this->model;
	}

    public function getUrl($articleId, $cLang = '', $params = []) {
        if (is_callable($this->getUrlFunction)) {
            return call_user_func($this->getUrlFunction, $articleId, $cLang, $params); 
        }
        return '';
    }

	/** generates <a> markup for given parameters.
	 *  
	 * uses *predefined* `rex_getUrl` stub
	 */
	public function getLink($idName, $id, $desc, $article_id = '') {
		return '<a href="'.$this->getUrl($article_id, '', array($idName => $id)).'">'.$desc.'</a>';
	}

	public function getLinkList(&$array, $linkUrlId, $linkName, $articleId = '', $idName = 'id') {
		$str = '';
		foreach($array as $s) {
			// ! silently omitting errors
			if (isset($s[$idName]) && isset($s[$linkName])) {
				$str .= $this->getLink($linkUrlId, $s[$idName], $s[$linkName], $articleId) . ', ';
			}
		}
		return trim($str,', ');
	}
    
    /**
     * !!! how read field names from model
     * !!! how check model valid object 
     */
    public function getRelationLinkList($type, $id, $articleId = '') {
        // 
        return $this->getEntityLinkList($this->model->getInnerRelations($type, $id), $articleId);
    }
  
    /**
     * !!! we want automatically combine indirect dependencies when supers/subs : make getBidirectionalRelationLinkList
     * !!! how read field names from model
     * !!! how check model valid object 
     */
    public function getReverseRelationLinkList($type, $id, $articleId = '') {
        return $this->getEntityLinkList($this->model->getInnerReverseRelations($type, $id), $articleId);
    }

	/**
	 * returns link list for entities
	 * 
	 * ! `begriff_id` here is a view convention for url params in this project (for internal links)
	 *   it can be defined different from actual field name in DB
	 * 
	 * ! `begriff` on the other hand is an actual DB field returned by queries
	 * 
	 */
	public function getEntityLinkList($data, $articleId = '') {
		return $this->getLinkList($data, self::entityIdForUrl, $this->entityFields['entity_name'], $articleId);
	}
	
	/**
	 * returns link list for entities queried by value in entities (1:n)
	 */
	public function getEntityLinkListByFieldValue($subject, $value, $articleId = '') {
		return $this->getEntityLinkList(
			$this->model->getEntitiesByField($subject, $value),
			$articleId
		);
	}

	/**
	 * generate simple "key-value-table row"
	 */
	function getRow($key, $value) {
		return '<tr><td>'.$key.'</td><td>'.$value."</td></tr>\n";
	}

	/**
	 * returns all entities which are related to another 1:n table
	 * 
	 * e.g. language, region
	 * 
	 * @param subject name to map on table or relation type 
	 * @param idField name of field for referenced id in tth_wortliste
	 * @param nameField name of field for readable name of referenced table
	 * 
	 * @param id selected id to filter for, 0 allowed, e.g. of 1 language when demanding language table  
	 * @param articleId destination article for link
	 */
	public function getFilteredLinks($subject, $id, $articleId = '')
	{
		if ($id || 0 === $id || '0' === $id) {
			$data = [];			
			$name = $this->model->getOuterRelationName($subject, $id);
			
			if (!$name) {
				$data = $this->model->getEntitiesByField($subject, $id); // $id is used as a value
				// when inner field we set readable name *here* 	
				if (count($data)) {
					// getting here means $table value valid and was subject for inner field
					switch ($subject) {
						case 'edit':
						case 'is_category':
							$name = ($id == 'TRUE' ? 'ja' : 'nein');
							break;
					}
				}
				else {
					$name = 'nicht gesetzt';
				}
			}

			if (!count($data)) {
				$data = $this->model->getEntitiesForOuterRelation($subject, intval($id));
			}
			
			$html = $this->getEntityLinkList($data, $articleId);
			
			if (!$html) $html = "(Keine Einträge gefunden.)";
			
			return '<p><strong>Begriffe in "%s" nach "'.$name.'"</strong>: '.$html.' </p>';
		}

		return '';
	}

	/**
	 * returns a list with all entities which satisfy an outer relation
	 * 
	 * e.g. all entities for a certain tag_id (but NOT vice versa, see: getForeignEntriesLinkList )
	 */
	public function getEntityLinkListForOuterRelation($subject, $outerId, $articleId = '') {
		return $this->getEntityLinkList($this->model->getEntitiesForOuterRelation($subject, $outerId), $articleId);
	}

	/**
	 * returns a list with all entities where inner or outer relation not found
	 * 
	 * works for inner AND outer (foreign) relations because of definitions in `tableNames` in TableManager
	 * 
	 * e.g. all entities which have no definition for supers ("tth_begriff_oberbegriffe"), or references ("tth_quellenangaben")
	 */
	public function getEntityLinkListForUnsetRelation($subject, $articleId = '') {
		return $this->getEntityLinkList($this->model->getEntitiesForUnsetRelation($subject), $articleId);
	}
	
	/**
	 * returns markdown parsed string
	 * 
	 * Depends on Redaxo objects
	 * But all objects are passed and can easily be stubbed.
	 * 
	 */
	public function getMarkDownText($parseFunction, $addonObject, $text)
	{
		// !!! make surrounding p when none inside
		$parsedHtml = '';

		if ($addonObject->isAvailable()) {
			// ! prevents html tags - in contrast to original Markdown specification
			$parsedHtml = 
				str_replace(
					"\n",
					'<br>',
					call_user_func($parseFunction, 'markdown', htmlspecialchars($text))
					// markitup::parseOutput ('markdown', htmlspecialchars($r['definition']))
				);
		}
		else {
			$parsedHtml = $text;
		}

		return $parsedHtml;
	}

	/**
	 * generates link to glossarPage
	 * 
	 * !!! idea: set article Ids in this class 
	 */
	public function getGlossarLink($anchor, $articleId = '') {
		// $descriptorLink = '  <a href="'.rex_getUrl($glossarArticleId).'#deskriptor">(?)</a>';
		return ('<a href="'. $this->getUrl($articleId) .'#'.$anchor.'">(?)</a>');
	}

	/**
	 * Uses checkTruthyWord and answer in a language, currently German
	 * 
	 * !!! a better naming would be "getBooleanWord"
	 */
	public function getTruthyWord($word) {
		$result = $this->model->checkTruthyWord($word);
		
		if ($result) return 'ja';
		if (false === $result) return 'nein';
		return '(nicht gesetzt)'; // $result === null
	}

	/**
	 * gets names of foreign table which is related n:m to entities
	 * 	 
	 * Need name field read from tableManager
	 * @param subject project internal name which maps to actual DB table (see: tableNames, tableIdFields in TableManager)
	 * @param id current entity for which the foreign linked entries are searched
	 */
	public function getForeignEntriesLinkList($subject, $id, $articleId = '') : string {
		$entries = $this->model->getForeignEntries($subject, $id);
		$info = $this->model->getOuterRelationTableInfo($subject);
		if (count($info)) { // can be empty array due to wrong subject
			// ! note that idName is view related (will be used for URL) and not DB related
			// ! must request matching idName and name field
			//   hence is requested from a list *of this class*
			// ! only convention to take actual db field as url name, could also be anything
			return $this->getLinkList($entries, $info['id'], $info['name'], $articleId, $info['id']);
		}

		return '';
	}

	/**
	 * returns link list for *all* entries of a table != entities
	 * 
	 * - needs to lookup id and name fields from TableManager
	 */
	public function getAllEntriesLinkList(string $subject, $alphabetical = true, $addUnsetLink = false, $articleId = '') : string {
		$tableInfo = $this->model->getOuterRelationTableInfo($subject);
		if (count($tableInfo)) {
			$entries = $this->model->getAllEntries($subject, $alphabetical);
			if ($addUnsetLink) {
				array_push($entries, array( 'id' => 0, $tableInfo['name'] => 'nicht gesetzt'));
			}
			if (count($entries)) {
				// ! only convention to take actual db field $tableInfo['id'] as url name, could also be anything
				return $this->getLinkList($entries, $tableInfo['id'], $tableInfo['name'], $articleId);
			}
		}
		return '';
	}
}
