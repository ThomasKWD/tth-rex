<?php
// - put all tth_view_list* together for less modules
// - set params ins module instead for start view
// - control output by params from url


$detailsArticleId = 'REX_LINK[id=1 output=id]';

$tm = new \kwd\tth\TableManager();

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
		<div class="link-list"><?=$tm->makeLinkList($sql->getArray($query), 'begriff_id', 'begriff', $detailsArticleId);?></div>
		<?php
	}
}
else {
	$lang = rex_request('sprache_id');
	$region = rex_request('region_id');
	$style = rex_request('sprachstil_id');
	$source = rex_request('quelle_id');

	if ($lang || 0 === $lang || '0' === $lang) {
		$sql = rex_sql::factory();
		// !!! need select of language again to gain name (or pass it in URL!)
		// !!! more verbose: check if null result
		?>
		<p><strong>Begriffe nach Sprache <?=$lang?>:</strong> <?=$tm->makeLinkList($sql->getArray("SELECT id,begriff FROM tth_wortliste WHERE sprache_id=$lang"), 'begriff_id', 'begriff',  'REX_LINK[id=1 output=id]')?></p>
		<?php
	}
	else if ($region || 0 === $region || '0' === $region) {
		$sql = rex_sql::factory();
		// !!! need select of region again to gain name (or pass it in URL!)
		// !!! more verbose: check if null result
		?>
		<p><strong>Begriffe nach Region <?=$region?>:</strong> <?=$tm->makeLinkList($sql->getArray("SELECT id,begriff FROM tth_wortliste WHERE region_id=$region"), 'begriff_id', 'begriff', 'REX_LINK[id=1 output=id]')?></p>
		<?php	
	}
	else if ($style || 0 === $style || '0' === $style) {
		$sql = rex_sql::factory();
		?>
		<p><strong>Begriffe nach Sprachstil <?=$style?>:</strong> <?=$tm->makeLinkList($sql->getArray("SELECT id,begriff FROM tth_wortliste WHERE sprachstil_id=$style"), 'begriff_id', 'begriff', 'REX_LINK[id=1 output=id]')?></p>
		<?php	
	}
	else if ($source || 0 === $source || '0' === $source) {
		$sql = rex_sql::factory();

		// !!! you'll need to find another way for "not set"
		//     - need extra treatment for $source === 0

		$tableEntities = 'tth_wortliste';
		$tableRelationSources = 'tth_begriff_quellen';
		$tableSources = 'tth_quellen';

		if ($source) {

			$query = "SELECT $tableEntities.id,$tableEntities.begriff
			FROM $tableRelationSources
			INNER JOIN $tableEntities
			ON $tableRelationSources.begriff_id = $tableEntities.id
			INNER JOIN $tableSources
			ON $tableRelationSources.quelle_id = $tableSources.id
			WHERE $tableSources.id = $source";
		}
		else {
			$query = "SELECT $tableEntities.id,$tableEntities.begriff
			FROM   $tableEntities
			WHERE  NOT EXISTS
			  (SELECT *
			   FROM   $tableRelationSources
			   WHERE  $tableRelationSources.begriff_id = $tableEntities.id)";
		}
			
		$rows = $sql->getArray($query);
		
		// !!! again: provide texts by input value or by SPROG replacement
		?><p><strong>Begriffe nach Quelle (<?=($source ? 'ID='.$source : 'nicht gesetzt')?>, <?=count($rows)?> Einträge):</strong> <?=$tm->makeLinkList($rows, 'begriff_id', 'begriff', 'REX_LINK[id=1 output=id]')?></p>
		<?php	
	}
	else {
		// !!! output only depending on param in module input because sometimes not wanted
		$sql = rex_sql::factory();

		// !!! make functions for the array selects
		$languages = $sql->getArray("SELECT id,sprache FROM tth_sprachen WHERE 1");
		// id = 0 automatically causes SQL to find unset entries
		array_push($languages, array( 'id' => 0, 'sprache' => 'nicht gesetzt'));
		?>
		<p><strong>Sprache:</strong> <?=$tm->makeLinkList($languages, 'sprache_id', 'sprache')?></p>
		<?php

		$regions = $sql->getArray("SELECT id,region FROM tth_regionen WHERE 1");
		array_push($regions, array( 'id' => 0, 'region' => 'nicht gesetzt'));
		?>
		<p><strong>Region:</strong> <?=$tm->makeLinkList($regions, 'region_id', 'region')?></p>
		<?php

		$styles = $sql->getArray("SELECT id,stil FROM tth_sprachstile WHERE 1");
		array_push($styles, array( 'id' => 0, 'stil' => 'nicht gesetzt'));
		?>
		<p><strong>Sprachstil:</strong> <?=$tm->makeLinkList($styles, 'sprachstil_id', 'stil')?></p>
		<?php

		$quellen = $sql->getArray("SELECT id,kurz FROM tth_quellen WHERE 1");
		// ! you'll need to find another way for "not set"
		array_push($quellen, array( 'id' => 0, 'kurz' => 'nicht gesetzt'));
		?>
		<p><strong>Quelle:</strong> <?=$tm->makeLinkList($quellen, 'quelle_id', 'kurz')?></p>
		<?php
	}
}
?>