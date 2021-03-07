<?php
// !!! maybe need 3rd party (viewmodel) which brings model and view together and is called by MODULE code

namespace kwd\tth;

// !!! check if the closure in method working, else make own array_filter!!!

class ViewFormatter {
    protected $model = null;
    protected $getUrlFunction = null;

	function __construct($model, $getUrlFunction) {
        $this->model = $model;
        $this->getUrlFunction = $getUrlFunction;
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
			$str .= $this->getLink($linkUrlId, $s['id'], $s[$linkName], $articleId) . ',';
		}
		return trim($str,',');
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
	 * @param table name of table
	 * @param idField name of field for referenced id in tth_wortliste
	 * @param nameField name of field for readable name of referenced table
	 * @param id selected id to filter for, 0 allowed  
	 */
	public function getFilteredEntities(&$sql, $table, $idField, $nameField, $id, $articleId)
	{
		// if ($id || 0 === $id || '0' === $id) {
		// 	$id = intval($id);
		// 	$nameArray = $sql->getArray("SELECT `$nameField` from $table WHERE id=$id");
		// 	if (count($nameArray)) $name = $nameArray[0][$nameField];
		// 	else $name = 'nicht gesetzt';
			
		// 	$html = $this->makeLinkList($sql->getArray("SELECT id,begriff FROM tth_wortliste WHERE $idField=$id ORDER BY begriff ASC"), 'begriff_id', 'begriff',  $articleId)
		// 	;

		// 	if (!$html) $html = "(Keine Einträge gefunden.)";
			
		// 	return "<p><strong>Begriffe nach \"$name\"</strong>: $html </p>";
		// }
		// return '';
	}

}
