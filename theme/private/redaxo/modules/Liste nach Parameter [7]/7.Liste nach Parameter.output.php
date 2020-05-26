<?php
// - put all tth_view_list* together for less modules
// - set params ins module instead for start view
// - control output by params from url

if (!function_exists('getLink')) {
	function getLink($idName, $id, $desc, $article_id = '') {
		// return '<a href="'.rex_getUrl($article_id, '', array('begriff_id' => $id)).'">'.$name.'</a>';
		return '<a href="'.rex_getUrl($article_id, '', array($idName => $id)).'">'.$desc.'</a>';
	}
}

if (!function_exists('makeLinkList')) {
	function makeLinkList($array, $linkUrlId, $linkName, $articleId = '') {
		$str = '';
		foreach ($array as $s) {
			$str .= getLink($linkUrlId, $s['id'], $s[$linkName], $articleId) . ', ';
		}
		return $str;
	}
}

// !!! probably you should use PHP classes/methods to evaluate it(?)
$search = rex_request('FORM');
if ($search) {
	$searchPattern = $search['formular'][0];
	if ($searchPattern) {

		?><p>Suchmuster: <strong><?=$searchPattern?></strong>
		<?php		
		// !!! sanitize (e.g. only letters, underscore, space and *)

		// ! change pattern to always have PART of word when no *
		if (false === strpos($searchPattern,'*')) {
			$searchPattern = '*'.$searchPattern.'*';
		}
		
		// !!! set article id by module param
		$sql = rex_sql::factory();
		$query = "SELECT id,begriff from tth_wortliste WHERE begriff LIKE '".str_replace('*','%',$searchPattern)."'";
		?>
		<div class="link-list"><?=makeLinkList($sql->getArray($query), 'begriff_id', 'begriff', 6);?></div>
		<?php
	}
}
?>