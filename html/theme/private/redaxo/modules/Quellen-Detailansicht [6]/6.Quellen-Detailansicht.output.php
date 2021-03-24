<?php

$quelleId = rex_escape(rex_request('quelle_id','int')); // the param 'int' should prevent from dangerous inputs
// is_numeric is enough sanitize if we just need an id
if ($quelleId && is_numeric($quelleId)) {

	// !!! how pack in function? not possible
	if (!isset($sql)) $sql = rex_sql::factory();
	if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl'); 

	echo 'Zeige Quelle id '.$quelleId;
	$tm = $vm->getTableManagerInstance();
	$r = $tm->getSingleDataSet('sources', $quelleId);
	$authors = $tm->getAuthorsForSource($quelleId);

	if ($r) {
		echo "<h2>${r['kurz']}</h2>";
		?>
		<table class="table table-responsive">
		<?php
		$html = '';
		$html .= $vm->getRow('Titel',$r['titel']);
		$html .= $vm->getRow('Jahr',$r['jahr']);
		$html .= $vm->getRow('ISBN',$r['isbn']);
		$html .= $vm->getRow('Kurzform',$r['kurz']);
		// !!! make link to details for author table (or general link to table with all authors, still not many)
		$authorsHtml = '';
		foreach($authors as $a) {
			$authorsHtml .= "${a['vorname']} ${a['name']}";
			if ($a['gnd']) {
				// !!! make as config var or sprog/string replacement
				$authorsHtml .= " (GND: <a href='https://portal.dnb.de/opac.htm?query=${a['gnd']}'>${a['gnd']}</a>)";
			}
			$authorsHtml .= ", ";
		}
		$html .= $vm->getRow('Autoren',$authorsHtml.' <small>(ID in altem System: '.$r['autor_id'].')</small>');

		echo $html;
		?>
		</table>
		<?php
	}
	else {
		// !!! again use module vars for text template
		echo rex_view::warning('Kein Datensatz gefunden für ID='.$quelleId);
	}
}
?>