<?php
    $sql = rex_sql::factory();
    $query = "SELECT * from tth_glossar WHERE 1 ORDER BY wort ASC";
    $entries = $sql->getArray($query);
?>

<?php 
	// !!! even better: output in grid system: only stacked when small screens - also better to prevent huge text lines in large screens
?> 
<?php foreach($entries as $e): ?>
	<hr>
	<a id="<?=rex_escape($e['Anker'])?>"></a>
	<h4><?=$e['wort']?></h4>
	<p>
	<?php
		if (!rex_addon::get('markitup')->isAvailable()) {
			echo $r['beschreibung'];
		}
		else {
			// !!! prevent html tags
			$firstStage = str_replace("\n",'<br>',markitup::parseOutput ('markdown', htmlspecialchars($e['beschreibung'])));
			echo str_replace('<br><','<',$firstStage);
		}
	?>
	</p>
<?php endforeach; ?>