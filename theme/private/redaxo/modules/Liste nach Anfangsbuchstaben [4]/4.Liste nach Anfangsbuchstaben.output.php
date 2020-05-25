<p>
<a id="marker-letters"></a>
<?php
// - just hard code all you need for the list
// - even target page id
$targetArticleId = 6;
// !!! make things dynamic later (e.g. via rex_config)

for($i = 0; $i <= 25; $i++ ) {
	$letter = chr($i+65);
	echo '<a href="'.rex_getUrl('','',array( 'startletter' => $letter)).'#marker-letters" class="btn btn-primary">'.$letter.'</a> ';
}

$startLetter = rex_request('startletter');
if ($startLetter) {
	$startLetter = strtoupper($startLetter);
	// dump($startLetter);
	$sql = rex_sql::factory();

	$query = 'SELECT id, begriff FROM tth_wortliste WHERE begriff LIKE "'.$startLetter.'%" ORDER BY begriff ASC';
	// $query = 'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE "%;%"';
	$rows = $sql->getArray($query);
	$i = 1;
	$count = count($rows);
	foreach($rows as $r) {
		echo '<a href="'.rex_getUrl($targetArticleId,'',array( 'begriff_id' => $r['id'])).'">';
		echo $r['begriff'];
		echo '</a>';
		if ($i < $count) echo ', ';
		$i++;
	}
}
?>
</p>