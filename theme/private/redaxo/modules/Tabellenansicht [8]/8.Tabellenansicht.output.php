<?php
$tm = new \kwd\tth\TableManager();

$prefix = $tm->getTablePrefix();
$table = '';

// !!! centralized object which contains all information about table schemas and addtional infos such as custom field description names
//     - should use information from YFORM!! (because you have almost all the info there, additionals could go into rex-config)
switch('REX_VALUE[1]') {
	case 'Autoren' : 
		// /// try to get around without using table name strings directly 
		$table = $prefix.'autoren';
		// !!! adjustable by input later
		$order = 'name';
	break;
	case 'Begriffsstati' : 
		$table = $prefix.'begriffsstati';
		// !!! adjustable by input later
		$order = 'status';
	break;
	case 'Quellen' : 
		$table = $prefix.'quellen';
		// !!! adjustable by input later
		$order = 'kurz';
	break;
	case 'Sprachen' : 
		$table = $prefix.'sprachen';
		// !!! adjustable by input later
		$order = 'sprache';
	break;
	case 'Regionen' : 
		$table = $prefix.'regionen';
		// !!! adjustable by input later
		$order = 'region';
	break;
	case 'Sprachstile' : 
		$table = $prefix.'sprachstile';
		$order = 'stil';
	break;
}

if ($table) {
	echo '<h2>REX_VALUE[1]</h2>';
	$sql = rex_sql::factory();
	$query = "SELECT * FROM $table WHERE 1 ORDER BY $order ASC";
	$rows = $sql->getArray($query);
	// dump($rows);

	$html = '';

	// !!! need options
	//     - define white-space: nowrap for some columns OR at least column id as CSS class for each cell
	//     - hide some cols
	//     - custom names for field names
	if (count($rows)) {

		$html = '<table class="table table-responsive">';

		foreach($rows[0] as $key => $value) {
			$html .= '<th>'.$key.'</th>';
		}

		foreach($rows as $a) {
			$html .= "<tr>";
			
			foreach($a as $key => $value) {			
				$html .= '<td>'.$value.'</td>';
			}
			
			$html .= "</tr>\n";
		}

		$html .= '</table>';
	}

	echo $html;
}
else {
	echo rex_view::warning('Keine gültige Tabelle ausgewählt.');
}
?>