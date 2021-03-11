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

    public function getUrl($articleId, $cLang, $params) {
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
    public function getRelationLinkList($type, $id) {
        // 
        return $this->getLinkList($this->model->getInnerRelations($type, $id), 'begriff_id', 'begriff');
    }
  
    /**
     * !!! we want automatically combine indirect dependencies when supers/subs : make getBidirectionalRelationLinkList
     * !!! how read field names from model
     * !!! how check model valid object 
     */
    public function getReverseRelationLinkList($type, $id) {
        // 
        return $this->getLinkList($this->model->getInnerReverseRelations($type, $id), 'begriff_id', 'begriff');
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
			$id = intval($id);

			$name = $this->model->getOuterRelationName($table, $id);
			if(!$name) $name = 'nicht gesetzt';

			$html = $this->getLinkList($this->model->getEntitiesForOuterRelation($table, $id), 'begriff_id', 'begriff',  $articleId);
			;
			
			if (!$html) $html = "(Keine Einträge gefunden.)";
			
			return "<p><strong>Begriffe nach \"$name\"</strong>: $html </p>";
		}

		return '';
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
}
