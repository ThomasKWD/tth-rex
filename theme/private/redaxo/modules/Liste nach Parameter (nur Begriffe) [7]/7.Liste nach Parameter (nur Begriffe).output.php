<?php
// - put all tth_view_list* together for less modules
// - set params ins module instead for start view
// - control output by params from url

if (!function_exists('printCardWithList')) {
		// printCard($vm->getFilteredLinks('languages', rex_vewescape(rex_request('sprache_id')), 'REX_LINK[id=1 output=id]'));

	function printCardWithList(&$view, $subject, $idName, $displayedFilter = 'Suchwort') {
		$html = $view->getFilteredLinks($subject, rex_escape(rex_request($idName)), 'REX_LINK[id=1 output=id]');
		if (trim($html)) {
			$heading = sprintf(substr($html, 0, strpos($html, ':')), $displayedFilter); 
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


// ! we don't read "id names" from tableManager because can also be different from DB (convention of MODULE code)
printCardWithList($vm, 'languages', 'sprache_id', 'Sprache'); // could get easier with SPROG + i18n
printCardWithList($vm, 'languagestyles', 'sprachstil_id', 'Sprachstil');
printCardWithList($vm, 'regions', 'region_id', 'Region'); 
printCardWithList($vm, 'states', 'begriffsstatus_id', 'Begriffsstatus');
printCardWithList($vm, 'edit', 'edit_value', 'Noch bearbeiten'); 
printCardWithList($vm, 'is_category', 'category_value', 'Kategorie'); 

$quellen = $vm->getTableManagerInstance()->getAllEntries('sources', true);
array_push($quellen, array( 'id' => 0, 'kurz' => 'nicht gesetzt'));

$source = rex_request('quelle_id');

if ($source || 0 === $source || '0' === $source) {
	$referencesLinkList = '';
	if ($source) {
		$referencesLinkList = $vm->getEntityLinkListForOuterRelation('references', $source, $detailsArticleId);
	}
	else {
		$referencesLinkList = $vm->getEntityLinkListForUnsetRelation('references', $detailsArticleId);
	}
		
	$sourceName = '??';
	foreach ($quellen as $q) {
		if ($source == $q['id']) {
			$sourceName = $q['kurz'];
		}
	}
	
	?>
	<p><strong>Begriffe nach Quelle "<?=$sourceName?>"</strong> (<?=substr_count($referencesLinkList, '<a ')?> Einträge):</strong> <?=$referencesLinkList?></p>
	<?php	
}
?>
<hr>
<p><strong>Sprache:</strong> <?=$vm->getAllEntriesLinkList('languages', true, true)?></p>
<p><strong>Region:</strong> <?=$vm->getAllEntriesLinkList('regions', true, true)?></p>
<p><strong>Sprachstil:</strong> <?=$vm->getAllEntriesLinkList('languagestyles', true, true)?></p>
<p><strong>Begriffsstatus:</strong> <?=$vm->getAllEntriesLinkList('states', true, true)?></p>
<?php

// !!! also put in function or method!
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
<p><strong>Quelle:</strong> <?=$vm->getLinkList($quellen, 'quelle_id', 'kurz')?></p>
<?php

?>