<?php
	if (!isset($sql)) $sql = rex_sql::factory();
	if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl'); 

	$selected = 'REX_VALUE[1]';
	$x = explode('~',$selected);
	$subject = $x[0];
	$name = $x[1];

	echo "<h2>$name</h2>";

	$data = $vm->getTableManagerInstance()->getOuterRelationTableData($subject);

	$html = '';

	// !!! need options
	//     - define white-space: nowrap for some columns OR at least column id as CSS class for each cell
	//     - hide some cols
	//     - custom names for field names
	if (count($data)) {

		$html = '<table class="table table-responsive">';

		foreach($data[0] as $key => $value) {
			$html .= '<th>'.$key.'</th>';
		}

		foreach($data as $a) {
			$html .= "<tr>";
			
			foreach($a as $key => $value) {			
				$html .= '<td>'.$value.'</td>';
			}
			
			$html .= "</tr>\n";
		}

		$html .= '</table>';
	}

	echo $html;
?>