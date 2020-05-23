<?php
// - just hard code all you need for the list
// - use rex_pager

$sql = rex_sql::factory();

// !!! set offset and limit by pager (depends on usage of pager, if i had an own pager i would store the last if of the last query??)

// ! you must not rely on order in DB even if currently ordered alphabetically in table
// ! the idea is that there never be more than about 3000 entries (because older versions of begriff (modification history) are seldom used in overview
$query = 'SELECT begriff FROM tth_wortliste WHERE 1 ORDER BY begriff';
// $query = 'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE "%;%"';
$rows = $sql->getArray($query);
$i = 1;
$count = count($rows);
foreach($rows as $r) {
	echo $r['begriff'];
	if ($i < $count) echo ', ';
	$i++;
}
?>.