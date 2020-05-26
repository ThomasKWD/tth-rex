<?php

if (!function_exists('makeRow')) {
	function makeRow($key,$value) {
		// return '|'.$key.'|'.$value."|\n";
		return '<tr><td>'.$key.'</td><td>'.$value."</td></tr>\n";
	}
}


$quelleId = rex_request('quelle_id');
// is_numeric is enough sanitize if we just need an id
if ($quelleId && is_numeric($quelleId)) {
	echo 'Zeige Quelle id '.$quelleId;
	$sql = rex_sql::factory();
	// ! query works until both tables have doubled field names - hope SQL will complain
	$rows = $sql->getArray("SELECT q.*,a.* from tth_quellen q LEFT JOIN tth_autoren a ON a.id = q.autor_id WHERE q.id = $quelleId");
	// dump($rows);
	if (count($rows)) {
		$r = $rows[0];
		echo "<h2>${r['kurz']}</h2>";
		?>
		<table class="table table-responsive">
		<?php	
		$html = '';
		$html .= makeRow('Titel',$r['titel']);
		$html .= makeRow('Jahr',$r['jahr']);
		$html .= makeRow('ISBN',$r['isbn']);
		$html .= makeRow('Kurzform',$r['kurz']);
		// !!! make link to details for author table (or general link to table with all authors, still not many)
		$html .= makeRow('Autor', $r['vorname'].' '.$r['name'].($r['gnd'] ? ', GND: '.$r['gnd'] : '').', Autor ID: '.$r['autor_id']);

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