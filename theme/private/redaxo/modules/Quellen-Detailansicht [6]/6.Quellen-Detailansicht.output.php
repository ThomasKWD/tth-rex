<?php

if (!function_exists('makeRow')) {
	function makeRow($key,$value) {
		// return '|'.$key.'|'.$value."|\n";
		return '<tr><td>'.$key.'</td><td>'.$value."</td></tr>\n";
	}
}


$quelleId = rex_request('quelle_id','int'); // the param 'int' should prevent from dangerous inputs
// is_numeric is enough sanitize if we just need an id
if ($quelleId && is_numeric($quelleId)) {
	echo 'Zeige Quelle id '.$quelleId;
	$sql = rex_sql::factory();
	// $rows = $sql->getArray("SELECT q.*,a.* FROM tth_quellen q LEFT JOIN tth_autoren a ON a.id = q.autor_id WHERE q.id = $quelleId");
	$rows = $sql->getArray("SELECT q.* FROM tth_quellen q WHERE q.id = $quelleId");
	// don't know how to combine the queries
	// select all authors for this source, similar to code for relation in begriffe
	$query = "SELECT a.* ";
	$query.= "FROM tth_autoren a ";
	$query.= "JOIN tth_quellen_autoren g1 ON a.id = g1.autor_id ";
	$query.= "JOIN tth_quellen q ON q.id = g1.quelle_id ";
	$query.= "WHERE q.id=$quelleId ";

	$authors = $sql->getArray($query);

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
		$authorsHtml = '';
		foreach($authors as $a) {
			$authorsHtml .= "${a['vorname']} ${a['name']}";
			if ($a['gnd']) {
				// !!! make as config var or sprog/string replacement
				$authorsHtml .= " (GND: <a href='https://portal.dnb.de/opac.htm?query=${a['gnd']}'>${a['gnd']}</a>)";
			}
			$authorsHtml .= ", ";
		}
		$html .= makeRow('Autoren',$authorsHtml.'<small>alte Autor-IDs zum Abgleich: '.$r['autor_id'].'</small>');

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