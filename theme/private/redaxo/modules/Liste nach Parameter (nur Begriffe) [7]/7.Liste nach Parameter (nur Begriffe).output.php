<?php
// - put all tth_view_list* together for less modules
// - set params ins module instead for start view
// - control output by params from url

if (!function_exists('printCardWithList')) {
		// printCard($vm->getFilteredLinks('languages', rex_vewescape(rex_request('sprache_id')), 'REX_LINK[id=1 output=id]'));

	function printCardWithList(&$view, $subject, $idName) {
		$html = $view->getFilteredLinks($subject, rex_escape(rex_request($idName)), 'REX_LINK[id=1 output=id]');
		if (trim($html)) {
			$heading = substr($html, 0, strpos($html, ':'));
			$list = substr($html, strpos($html, ':')+1);
			// count entries because not returned by getFilteredLinks
			$count = substr_count($list, '<a ');
			?>
			<div class="card">
				<div class="card-header"><?=$heading?> (<?=$count?>):</div>
				<div class="card-body"><?=$list?></div>
			</div>
			<?php
		}
	}
}

$detailsArticleId = 'REX_LINK[id=1 output=id]';

if (!isset($sql)) $sql = rex_sql::factory();
if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl'); 

	$source = rex_request('quelle_id');

	// ! we don't read "id names" from tableManager because can also be different from DB (convention of MODULE code)
	printCardWithList($vm, 'languages', 'sprache_id');
	printCardWithList($vm, 'languagestyles', 'sprachstil_id');
	printCardWithList($vm, 'regions', 'region_id');
	printCardWithList($vm, 'states', 'begriffsstatus_id');
	printCardWithList($vm, 'edit', 'edit_value'); 
	printCardWithList($vm, 'is_category', 'category_value'); 

	if ($source || 0 === $source || '0' === $source) {
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
		?><p><strong>Begriffe nach Quelle (<?=($source ? 'ID='.$source : 'nicht gesetzt')?>, <?=count($rows)?> Einträge):</strong> <?=$vm->getLinkList($rows, 'begriff_id', 'begriff', 'REX_LINK[id=1 output=id]')?></p>
		<?php	
	}
	
	echo '<hr>';

	// !!! make functions for the array selects
	$languages = $sql->getArray("SELECT id,sprache FROM tth_sprachen WHERE 1");
	// id = 0 automatically causes SQL to find unset entries
	array_push($languages, array( 'id' => 0, 'sprache' => 'nicht gesetzt'));
	?>
	<p><strong>Sprache:</strong> <?=$vm->getLinkList($languages, 'sprache_id', 'sprache')?></p>
	<?php

	$regions = $sql->getArray("SELECT id,region FROM tth_regionen WHERE 1");
	array_push($regions, array( 'id' => 0, 'region' => 'nicht gesetzt'));
	?>
	<p><strong>Region:</strong> <?=$vm->getLinkList($regions, 'region_id', 'region')?></p>
	<?php

	$styles = $sql->getArray("SELECT id,stil FROM tth_sprachstile WHERE 1");
	array_push($styles, array( 'id' => 0, 'stil' => 'nicht gesetzt'));
	?>
	<p><strong>Sprachstil:</strong> <?=$vm->getLinkList($styles, 'sprachstil_id', 'stil')?></p>
	<?php

	$stati = $sql->getArray("SELECT id,`status` FROM tth_begriffsstati WHERE 1 ORDER BY id ASC");
	array_push($stati, array( 'id' => 0, 'status' => 'nicht gesetzt'));
	?>
	<p><strong>Begriffsstatus:</strong> <?=$vm->getLinkList($stati, 'begriffsstatus_id', 'status')?></p>
	<?php

	$edit = [
		[
			'id' => 'FALSE',
			'edit' => 'nein'
		],
		[
			'id' => 'TRUE',
			'edit' => 'ja'
		],
		[
			'id' => '0',
			'edit' => 'nicht gesetzt'
		]
	];
	?>
	<p><strong>Noch bearbeiten:</strong> <?=$vm->getLinkList($edit, 'edit_value', 'edit')?></p>
	<?php

	// !!! also put in function or method!
	$isCat = [
		[
			'id' => 'FALSE',
			'is_category' => 'nein'
		],
		[
			'id' => 'TRUE',
			'is_category' => 'ja'
		],
		[
			'id' => '0',
			'is_category' => 'nicht gesetzt'
		]
	];
	?>
	<p><strong>Kategorie:</strong> <?=$vm->getLinkList($isCat, 'category_value', 'is_category')?></p>
	<?php

	$quellen = $sql->getArray("SELECT id,kurz FROM tth_quellen WHERE 1");
	// ! you'll need to find another way for "not set"
	array_push($quellen, array( 'id' => 0, 'kurz' => 'nicht gesetzt'));
	?>
	<p><strong>Quelle:</strong> <?=$vm->getLinkList($quellen, 'quelle_id', 'kurz')?></p>
	<?php

?>