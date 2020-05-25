<!-- you will need to use bootstrap rows/cols -->
<div class="detailed-view">
<?php
	if (!function_exists('makeRow')) {
		function makeRow($key,$value) {
			return '|'.$key.'|'.$value."|\n";
		}
	}

	if (!function_exists('getEntityLink')) {
		function getEntityLink($article_id,$id,$name) {
			return '<a href="'.rex_getUrl($article_id, '', array('begriff_id' => $id)).'">'.$name.'</a>';
		}
	}

	$id = rex_request('begriff_id');
	if ($id) {		
		$tableEntities = 'tth_wortliste';
		$tableAuthors = 'tth_autoren';
		$tableStati = 'tth_begriffsstati';
		$tableLanguage = 'tth_sprachen';
		$tableRelationOberbegriffe = 'tth_begriff_oberbegriffe';
		
		$sql = rex_sql::factory();

		// idea: make combi-query via alias names for other self-relations of tth_wortlise
		// or maybe using other join commands here
		$synonymsQuery = "SELECT t1.id,t1.begriff from $tableEntities t1 WHERE t1.benutze=$id";
		$synonyms = $sql->getArray($synonymsQuery);
		// dump($synonyms);

		// !!! table names as config or get from YForm or better: use Yorm

		// SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
		// FROM Orders
		// INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;
		// ! note that '*' works for joined tabled too, that means you will get all fields from tth_autoren either
		// ! you cannot distinguish between 'id' from tth_wortliste and 'id' from 'tth_autoren' unless you 
		//   don't use the the '*' and name all fields needed

		// ! b is first alias for $tableEntities, b2 is the second for benutze
		// $query = "SELECT begriff,b.id,autor_id,vorname,$tableAuthors.name,$tableAuthors.gnd,quelle_seite,`code`,`definition`,quellen_idlist,bild,begriffsstatus_id,`status`,notes,benutze FROM $tableEntities b LEFT JOIN $tableAuthors ON b.autor_id = $tableAuthors.id LEFT JOIN $tableStati ON b.begriffsstatus_id = $tableStati.id LEFT JOIN $tableEntities b2 ON b2.benutze = b.id WHERE b.id=$id";

		// ! some fields are still selected for debug 
		$query = "SELECT b.begriff,b.id,$tableAuthors.gnd,b.quelle_seite,b.code,b.definition,b.quellen_idlist,b.bild,$tableStati.status,b.notes,b.benutze,b2.begriff AS benutze_begriff,CONCAT($tableAuthors.vorname, ' ', $tableAuthors.name) AS autor,$tableLanguage.sprache AS sprache FROM $tableEntities b LEFT JOIN $tableAuthors ON b.autor_id = $tableAuthors.id LEFT JOIN $tableStati ON b.begriffsstatus_id = $tableStati.id LEFT JOIN $tableLanguage ON b.sprache_id = $tableLanguage.id LEFT JOIN $tableEntities b2 ON b2.id = b.benutze WHERE b.id=$id";
		// !!! add more left joins for fields of foreign tables which could be empty
		// CONCAT(m.lastname, ', ', m.firstname),
		// 'Top Manager') AS 'Manager',

		$rows = $sql->getArray($query);
		if ($rows && count($rows)) {
			$r = $rows[0];
		
			$mdOutput = "h2. ${r["begriff"]}\n\n|ID|$id|\n";
			$mdOutput .= makeRow('Sprache', $r['sprache']);
			$mdOutput .= "|Autor|";
			
			// ! the `if` is important because the SQL may still returen the first entry of tth_autoren for some reason when autor_id=''  ! whole data set not returned when no author; need 0 clause in inner join

			if ($r['autor']) { // is a generated value; and is NULL when not set
				// !!! use makeRow
				$mdOutput .= $r['autor'];
				if (trim($r['gnd'])) $mdOutput .= ' (GND: '.$r['gnd'].')';
			}
			$mdOutput .= "|\n";
			if ($r['quelle_seite']) $mdOutput .= makeRow('Seite in Quelle',$r['quelle_seite']);

			$mdOutput .= "|\n";
			$mdOutput .= makeRow('Begriffcode', $r['code']);
			$mdOutput .= "|Definition|${r['definition']}|\n";
			$mdOutput .= makeRow('Scoped Notes',$r['notes']);
			$mdOutput .= makeRow('Begriffs-Status',$r['status']);
			// ! redaxo file list is *comma* separated
			if ($r['bild']) {
				$images = explode(',',$r['bild']);
				$imgHTML = '';
				foreach ($images as $img) {
					// !!! make real html for classes needed
					// the class call adds a stupid './' which breaks the url
					// $imgHTML .= '!'.rex_media_manager::getUrl('tth_horizontal_list',$img).'!';
					$imgHTML .= '!index.php?rex_media_type=tth_horizontal_list&rex_media_file='.$img.'!';
				}
				$mdOutput .= makeRow('Bilder',$imgHTML);
			}

			// ! first link
			// !!! make sub function because links often needed (even same as in list views -> make class with helper methods)
			$mdOutput .= makeRow(
				'Deskriptor (Benutze)',
				getEntityLink('', $r['benutze'], $r['benutze_begriff'])
			);

			// ! needs 5/6 extra queries because of n:m-self relations
			// !!! try to make list by sql (join, group concat etc.) 
			$syns = '';
			foreach($synonyms as $s) {
				$syns .= getEntityLink('',$s['id'],$s['begriff']).', ';
			}

			$mdOutput .= makeRow(
				'Synonyme (Benutzt von)',
				$syns
			);

			// !!! MD discard! because we need bootstrap responsive table and later cols/rows
			echo markitup::parseOutput ('textile', $mdOutput);

			dump($rows[0]);
		} 
		else {
			echo rex_view::warning('Eintrag für ID = '.$id.' nicht gefunden.');
		}
	}
	else {
		echo rex_view::warning('Eine Detailansicht benötigt die ID als GET-Parameter "begriff_id"');
	}
?>
</div>