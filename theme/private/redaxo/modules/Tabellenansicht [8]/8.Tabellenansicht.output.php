<?php

function makeFullLineTablle($array) {
	$html = '';
	foreach($array as $a) {
		foreach($a as $key => $value) {
			$html .= "$key : $value, ";
		}
	}

	return $html;
}

$prefix = 'tth_';
$table = '';

switch('REX_VALUE[1]') {
	case 'Autoren' : 
		$table = $prefix.'autoren';
		// !!! adjustable by in put later
		$order = 'name';
	break;
	case 'Begriffsstati' : 
		$table = $prefix.'begriffstati';
		// !!! adjustable by in put later
		$order = 'status';
	break;
	case 'Quellen' : 
		$table = $prefix.'quellen';
		// !!! adjustable by in put later
		$order = 'kurz';
	break;
}

if ($table) {
	echo '<h2>REX_VALUE[1]</h2>';
	$sql = rex_sql::factory();
	$query = "SELECT * FROM $table WHERE 1 ORDER BY $order ASC";
	$rows = $sql->getArray($query);
	// dump($rows);

	$html = '';
	$html .= makeFullLineTablle($rows);
	echo $html;
}
else {
	echo rex_view::warning('Keine gültige Tabelle ausgewählt.');
}
?>