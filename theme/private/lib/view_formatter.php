<?php
// !!! maybe need 3rd class (viewmodel) which brings model and view together and is called by MODULE code

namespace kwd\tth;

class ViewFormatter {
    protected $model = null;
    protected $getUrlFunction = null;

	function __construct($sqlObject, $getUrlFunction) {
		$this->model = new TableManager($sqlObject);
        $this->getUrlFunction = $getUrlFunction;
    }

	public function &getTableManagerInstance() {
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
		return '<a href="'.rex_getUrl($article_id, '', array($idName => $id)).'">'.$desc.'</a>';
	}

	public function getLinkList($array, $linkUrlId, $linkName, $articleId = '') {
		$str = '';
		foreach($array as $s) {
			$str .= $this->getLink($linkUrlId, $s['id'], $s[$linkName], $articleId) . ', ';
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
		return $this->getLinkList($data, 'begriff_id', 'begriff', $articleId);
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
     * MUST extract out DB related stuff (which must return arrays)
     * 
	 * e.g. language, region
	 * 
	 * @param sql reference to rex_sql object
	 * 
	 * // !!! these 3 must be read!!!
	 * 
	 * @param table name of table
	 * @param idField name of field for referenced id in tth_wortliste
	 * @param nameField name of field for readable name of referenced table
	 * 
	 * @param id selected id to filter for, 0 allowed, e.g. of 1 language when demanding language table  
	 * @param articleId destination article for link
	 */
	public function getFilteredLinks($table, $id, $articleId = '')
	{
		if ($id || 0 === $id || '0' === $id) {

			$data = [];
			
			$name = $this->model->getOuterRelationName($table, $id);
			
			if (!$name) {
				$data = $this->model->getEntitiesByField($table, $id); // $id is used as a value
				// when inner field we set readable name *here* 	
				if (count($data)) {
					// getting here means $table value valid and was subject for inner field
					switch ($table) {
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
			else {
				$data = $this->model->getEntitiesForOuterRelation($table, intval($id));
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
	 * e.g. all entities for a certain tag_id
	 */
	public function getEntityLinkListForOuterRelation($subject, $outerId, $articleId = '') {
		return $this->getEntityLinkList($this->model->getEntitiesForOuterRelation($subject, $outerId), $articleId);
	}

	/**
	 * returns markdown parsed string
	 * 
	 * Depends on Redaxo objects
	 * But all objects are passed and can easily be stubbed.
	 * 
	 */
	public function getMarkDownText($parseFunction, &$addonObject, $text)
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
}
