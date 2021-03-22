<?php
if (rex::isBackend()) {
	?>
	<p>Artikel für Begriffe: <strong>REX_LINK[id=1 output=name]</strong> (ID: REX_LINK[id=1 output=id])</p>
	<?php
}
?>

<p>
<a id="marker-letters"></a>
<?php

$targetArticleId = 'REX_LINK[id=1 output=id]';

for($i = 0; $i <= 25; $i++ ) {
	$letter = chr($i+65);
	if (23 !== $i && 24 !== $i) {
		echo '<a href="'.rex_getUrl('','',array( 'startletter' => $letter)).'#marker-letters" class="btn btn-primary">'.$letter.'</a> ';
	}
}

$startLetter = rex_request('startletter');
if ($startLetter) {
	$startLetter = strtoupper($startLetter);
	if (!isset($sql)) $sql = rex_sql::factory();
	if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl');

	$entities = $vm->getTableManagerInstance()->findEntities($startLetter.'*');
	if ($entities) {
		echo '<hr>'.$vm->getEntityLinkList($entities, $targetArticleId);
	}
	else {
		echo 'Keine Begriffe gefunden';
	}
}
?>
</p>