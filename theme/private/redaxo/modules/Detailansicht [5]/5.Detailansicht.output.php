<!-- you will need to use bootstrap rows/cols -->
<div class="row detailed-view">
	<div class="col">
<?php
	/// !!! please put into class into theme!

	if (!function_exists('makeRow')) {
		function makeRow($key,$value) {
			// return '|'.$key.'|'.$value."|\n";
			return '<tr><td>'.$key.'</td><td>'.$value."</td></tr>\n";
		}
	}

	if (!function_exists('getLink')) {
		function getLink($idName, $id, $desc, $article_id = '') {
			// return '<a href="'.rex_getUrl($article_id, '', array('begriff_id' => $id)).'">'.$name.'</a>';
			return '<a href="'.rex_getUrl($article_id, '', array($idName => $id)).'">'.$desc.'</a>';
		}
	}

	if (!function_exists('makeLinkList')) {
		function makeLinkList($array, $linkUrlId, $linkName, $articleId = '') {
			$str = '';
			foreach ($array as $s) {
				$str .= getLink($linkUrlId, $s['id'], $s[$linkName], $articleId) . ', ';
			}
			return $str;
		}
	}

		if (!function_exists('checkTruthyWord')) {
		function checkTruthyWord($word) {
			if ($word) {
				$word = strtoupper($word);
				if($word === 'WAHR' || $word === 'TRUE'){					
					return 'ja';
				}
			}

			return 'nein';
		}
	}

	$id = rex_request('begriff_id');
	if ($id) {
		$sourcesArticleId = 'REX_LINK[id=1 output=id]';
		if (!$sourcesArticleId) $sourcesArticleId = 'REX_ARTICLE_ID';

		$tableEntities = 'tth_wortliste';
		$tableAuthors = 'tth_autoren';
		$tableStati = 'tth_begriffsstati';
		$tableLanguage = 'tth_sprachen';
		$tableRegions = 'tth_regionen';
		$tableStyles = 'tth_sprachstile';

		$tableSources = 'tth_quellen';
		$tableRelationSources = 'tth_begriff_quellen';
		
		$tableRelationGrobgliederung = 'tth_begriff_grobgliederung';
		$tableRelationOberbegriffe = 'tth_begriff_oberbegriffe';
		$tableRelationUnterbegriffe = 'tth_begriff_unterbegriffe';
		$tableRelationAequivalents = 'tth_begriff_aequivalente';
		$tableRelationRelatives = 'tth_begriff_verwandte';
		
		$sql = rex_sql::factory();

		// idea: make combi-query via alias names for other self-relations of tth_wortlise
		// or maybe using other join commands here
		$synonymsQuery = "SELECT t1.id,t1.begriff from $tableEntities t1 WHERE t1.benutze=$id";
		$synonyms = $sql->getArray($synonymsQuery);
		// dump($synonyms);

		// relation table join (comma separated entries)
		// $query = "SELECT GROUP_CONCAT(CONCAT($tableSources.id,'~',$tableSources.kurz) SEPARATOR \", \" ) AS sources ";
		// $query.= "FROM $tableEntities ";
		// $query.= "JOIN $tableRelationSources ON $tableEntities.id = $tableRelationSources.begriff_id ";
		// $query.= "JOIN $tableSources ON $tableSources.id = $tableRelationSources.quelle_id ";
		// $query.= "WHERE $tableEntities.id=$id ";
		// $query.= "GROUP BY $tableEntities.id";

		// !!! can i combine several joins?
		// ??? or at least sub function for repetition
		// ??? write other join n:m and combine later
		$query = "SELECT $tableSources.id, $tableSources.kurz ";
		$query.= "FROM $tableEntities ";
		$query.= "JOIN $tableRelationSources ON $tableEntities.id = $tableRelationSources.begriff_id ";
		$query.= "JOIN $tableSources ON $tableSources.id = $tableRelationSources.quelle_id ";
		$query.= "WHERE $tableEntities.id=$id ";
		// $query.= "GROUP BY $tableEntities.id";
		$sourcesArray = $sql->getArray($query);
		// dump($sourcesArray);

		$query = "SELECT e2.id, e2.begriff ";
		$query.= "FROM $tableEntities e1 ";
		$query.= "JOIN $tableRelationGrobgliederung g1 ON e1.id = g1.begriff_id ";
		$query.= "JOIN $tableEntities e2 ON e2.id = g1.grobgliederung_id ";
		$query.= "WHERE e1.id=$id ";
		// test debug
		// $query = "SELECT id, begriff, grobgliederung FROM $tableEntities WHERE grobgliederung LIKE '%;%'";
		$grobgliederungArray = $sql->getArray($query);

		$query = "SELECT e2.id, e2.begriff ";
		$query.= "FROM $tableEntities e1 ";
		$query.= "JOIN $tableRelationOberbegriffe g1 ON e1.id = g1.begriff_id ";
		$query.= "JOIN $tableEntities e2 ON e2.id = g1.oberbegriff_id ";
		$query.= "WHERE e1.id=$id ";
		$oberbegriffeArray = $sql->getArray($query);

		$query = "SELECT e2.id, e2.begriff ";
		$query.= "FROM $tableEntities e1 ";
		$query.= "JOIN $tableRelationUnterbegriffe g1 ON e1.id = g1.begriff_id ";
		$query.= "JOIN $tableEntities e2 ON e2.id = g1.unterbegriff_id ";
		$query.= "WHERE e1.id=$id ";
		$unterbegriffeArray = $sql->getArray($query);

		$query = "SELECT e2.id, e2.begriff ";
		$query.= "FROM $tableEntities e1 ";
		$query.= "JOIN $tableRelationAequivalents g1 ON e1.id = g1.begriff_id ";
		$query.= "JOIN $tableEntities e2 ON e2.id = g1.aequivalent_id ";
		$query.= "WHERE e1.id=$id ";
		$aequivalentsArray = $sql->getArray($query);

		$query = "SELECT e2.id, e2.begriff ";
		$query.= "FROM $tableEntities e1 ";
		$query.= "JOIN $tableRelationRelatives g1 ON e1.id = g1.begriff_id ";
		$query.= "JOIN $tableEntities e2 ON e2.id = g1.verwandter_id ";
		$query.= "WHERE e1.id=$id ";
		$relativesArray = $sql->getArray($query);

		// don't use the '*' and name all fields needed

		// ! b is first alias for $tableEntities, b2 is the second for benutze

		$query = "SELECT b.begriff,b.id,$tableAuthors.gnd,b.quelle_seite,b.code,b.definition,b.bild,$tableStati.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,";
		$query .= "b2.begriff AS benutze_begriff,CONCAT($tableAuthors.vorname, ' ', $tableAuthors.name) AS autor,";
		$query .= "$tableLanguage.sprache AS sprache,";
		$query .= "$tableRegions.region AS region, ";
		$query .= "$tableStyles.stil AS sprachstil ";
		$query .= "FROM $tableEntities b ";
		$query .= "LEFT JOIN $tableAuthors ON b.autor_id = $tableAuthors.id ";
		$query .= "LEFT JOIN $tableStati ON b.begriffsstatus_id = $tableStati.id ";
		$query .= "LEFT JOIN $tableLanguage ON b.sprache_id = $tableLanguage.id ";
		$query .= "LEFT JOIN $tableRegions ON b.region_id = $tableRegions.id ";
		$query .= "LEFT JOIN $tableStyles ON b.sprachstil_id = $tableStyles.id ";
		$query .= "LEFT JOIN $tableEntities b2 ON b2.id = b.benutze WHERE b.id=$id";
		
		$rows = $sql->getArray($query);
		if ($rows && count($rows)) {
			$r = $rows[0];
			
			$html = "<h2>${r["begriff"]}</h2>\n";

			$html .= '<table class="table table-responsive">';

			// make header line of table
			$html .= '<thead><tr><th>Feld</th><th>Inhalt</th></thead>';
			
			$html .= makeRow('ID', $r['id']);
			$html .= makeRow('Definition', $r['definition']);
			
			$html .= makeRow('Sprache', $r['sprache']);
			$html .= makeRow('Sprachstil', $r['sprachstil']);
			$html .= makeRow('Region', ($r['region']) ? $r['region'] : "");
			$html .= makeRow('Begriffcode', $r['code']);
			$html .= makeRow('Begriffs-Status',$r['status']);
			// ! redaxo file list is *comma* separated
			if ($r['bild']) {
				// ! separator ',' is determined by redaxo
				$images = explode(',',$r['bild']);
				$imgHTML = '';
				foreach ($images as $img) {
					$imgHTML .= '<img src="index.php?rex_media_type=tth_horizontal_list&rex_media_file='.$img.'">';
				}
				$html .= makeRow('Bilder',$imgHTML);
			}
			
			$html .= makeRow('Grobgliederung',makeLinkList($grobgliederungArray,'begriff_id','begriff'));

			// ! first link
			// !!! make sub function because links often needed (even same as in list views -> make class with helper methods)
			$html .= makeRow('Synonym von (Benutze)',getLink('begriff_id', $r['benutze'], $r['benutze_begriff']).'<br><small>dies ist der Desriptor und damit Name der <em>Äquivalenzklasse</em></small>');


			// ! needs 5/6 extra queries because of n:m-self relations
			// !!! use function
			$syns = '';
			foreach($synonyms as $s) {
				$syns .= getLink('begriff_id', $s['id'],$s['begriff']).', ';
			}

			// !!! use small def from Bootstrap
			$html .= makeRow('Deskriptor von (Benutzt für)',$syns.'<br><small>diese sind zusammen mit dem Begriff "'.$r['begriff'].'" selbst die <em>Äquivalenzklasse</em></small>');

			// !!! make function in function to DRY the 'begriff_id','begriff'
			$html .= makeRow('Oberbegriffe',makeLinkList($oberbegriffeArray,'begriff_id','begriff'));
			$html .= makeRow('Unterbegriffe',makeLinkList($unterbegriffeArray,'begriff_id','begriff'));
			$html .= makeRow('Äquivalente Begriffe',makeLinkList($aequivalentsArray,'begriff_id','begriff'));
			$html .= makeRow('Verwandte Begriffe',makeLinkList($relativesArray,'begriff_id','begriff'));

			$authorText = '';
			// ! the `if` is important because the SQL may still returen the first entry of tth_autoren for some reason when autor_id=''  ! whole data set not returned when no author; need 0 clause in inner join
			if ($r['autor']) { // is a generated value; and is NULL when not set
				// !!! use makeRow
				$authorText .= $r['autor'];
				if (trim($r['gnd'])) $authorText .= ' (GND: '.$r['gnd'].')';
			}
			$html .= makeRow('Autor',$authorText);

			if ($r['quelle_seite']) $html .= makeRow('Seite in Quelle',$r['quelle_seite']);
			
			$html .= makeRow('Quellen',makeLinkList($sourcesArray, 'quelle_id', 'kurz', $sourcesArticleId));

			$html .= makeRow('Scoped Notes',$r['notes']);
			$html .= makeRow('Kategorie',checkTruthyWord($r['kategorie']));
			$html .= makeRow('Veröffentlichen?',checkTruthyWord($r['veroeffentlichen']));
			$html .= makeRow('Noch bearbeiten',checkTruthyWord($r['bearbeiten']));
						
			// !!! MD discard! because we need bootstrap responsive table and later cols/rows
			// echo markitup::parseOutput ('textile', $html);
			echo $html.'</table>';
			
			echo '<tr><td></td><td>';
			dump($rows[0]);
			echo '</td></tr>';
		} 
		else {
			echo rex_view::warning('Eintrag für ID = '.$id.' nicht gefunden.');
		}
	}
	else {
		// !!! make text editable in module input
		echo rex_view::warning('Eine Detailansicht benötigt die ID als GET-Parameter "begriff_id". Beginne am besten mit der alphabetischen Übersicht!');
	}
?>
	</div>
</div>