<?php
	if (!isset($sql)) $sql = rex_sql::factory();
	if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl'); 
	$entries = $vm->getTableManagerInstance()->getAllEntries('glossar', true, true);
?>

<?php 
	// !!! even better: output in grid system: only stacked when small screens - also better to prevent huge text lines in large screens

	// !!! how request field names from TableManager?
?> 
<?php foreach($entries as $e): ?>
	<hr>
	<a id="<?=rex_escape($e['Anker'])?>"></a>
	<h4><?=$e['wort']?></h4>
	<p>
	<?php
		// ! different to implementation used at definition
		if (!rex_addon::get('markitup')->isAvailable()) {
			echo $e['beschreibung'];
		}
		else {
			// !
			$firstStage = str_replace("\n",'<br>',markitup::parseOutput ('markdown', htmlspecialchars($e['beschreibung'])));
			echo str_replace('<br><','<',$firstStage);
		}
	?>
	</p>
<?php endforeach; ?>