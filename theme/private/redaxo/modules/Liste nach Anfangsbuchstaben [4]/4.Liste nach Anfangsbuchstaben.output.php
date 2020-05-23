<p>
<?php
// - just hard code all you need for the list

for($i = 0; $i <= 25; $i++ ) {
	$letter = chr($i+65);
	echo '<a href="'.rex_getUrl('','',array( 'startletter' => $letter)).'" class="btn btn-primary">'.$letter.'</a> ';
}



$startLetter = rex_request('startletter');
if ($startLetter) {
	$startLetter = strtoupper($startLetter);
	// dump($startLetter);
	$sql = rex_sql::factory();

	$query = 'SELECT begriff FROM tth_wortliste WHERE begriff LIKE "'.$startLetter.'%" ORDER BY begriff';
	// $query = 'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE "%;%"';
	$rows = $sql->getArray($query);
	$i = 1;
	$count = count($rows);
	foreach($rows as $r) {
		echo $r['begriff'];
		if ($i < $count) echo ', ';
		$i++;
	}
}
?>
</p>