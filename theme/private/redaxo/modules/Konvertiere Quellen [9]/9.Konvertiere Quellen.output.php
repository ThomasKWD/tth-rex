<?php if (rex::isBackend()) : ?>
Der Callback heißt 'convertSourcesCallback'. Du brauchst einen YForm-Block zum Starten.
<?php endif; 

// !!! remove code, probably not needed again
if (!function_exists('convertSourcesCallback')) {
	function convertSourcesCallback($request) {
		// echo 'absenden erkannt';
		// - convert from quellen_idlist and quelle_seite; easier than from created relations table
		// - preserve order in list
		// - assume page number to belong to first quelle
		// - assume first quelle to be "preferred"
		$sql = rex_sql::factory();
		$query = "SELECT id,quelle_seite,quellen_idlist FROM tth_wortliste WHERE quellen_idlist != ''";
		$rows=$sql->getArray($query);
		echo count($rows) ." Einträge mit Quellen.\n";

		$insertList = '';
		foreach($rows as $r) {
			$sources = explode(';',$r['quellen_idlist']);
			// echo ', '.count($sources);
			$i = 0;
			$seite = $r['quelle_seite'];
			if (!$seite) $seite = "''";

			foreach($sources as $s) {
				if (trim($s)) {
					// echo '.';
					// order: quelle_id, seitenzahl, bevorzugt, begriff_id
					// $insertList .= "('.$s.','.$node."),\n"; check if \n needed!
					$insertList .= "($s, ".($i === 0 ? $seite : "''").", ".($i === 0 ? "'TRUE'" : "''").", ${r['id']}), ";
					$i++;
				}
			}
		}

		// remove last comma!
		$insertList = substr($insertList,0,strrpos($insertList,','));
		$query = 'INSERT INTO tth_quellenangaben (quelle_id, seitenzahl, bevorzugt, begriff_id) VALUES '.$insertList;
		echo '<h3>SQL-Befehl</h3><p>'.$query.'</p>';
		
		// disabled for security
		// $sql->setQuery($query);
	}
}

if (rex_post('FORM')) {
}
else {
	$sql = rex_sql::factory();
	// "SUM" can be passed a simpler expression than "COUNT"
	$query = "SELECT COUNT(id) AS numEntities, SUM(quellen_idlist != '') AS numSources, SUM(quellen_idlist LIKE '%;%') AS numMultipleSources, SUM(quelle_seite != '') AS numPageNumbers FROM tth_wortliste";
	$sql->setQuery($query);
	$rows=$sql->getArray();
	$d = $rows[0]
?>
<p>
	Einträge: <?=$d['numEntities']?><br>
	Einträge mit Quellen: <?=$d['numSources']?><br>
	Einträge mit mehreren Quellen: <?=$d['numMultipleSources']?><br>
	Einträge mit Seitenzahlen: <?=$d['numPageNumbers']?>
</p>

<?php } ?>