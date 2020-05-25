<!-- you will need to use bootstrap rows/cols -->
<div class="detailed-view">
<?php
	if (!function_exists('makeRow')) {
		function makeRow($key,$value) {
			return '|'.$key.'|'.$value."|\n";
		}
	}

	if (!function_exists('getEntityLink')) {
		function getEntityLink($id, $name, $article_id = '') {
			return '<a href="'.rex_getUrl($article_id, '', array('begriff_id' => $id)).'">'.$name.'</a>';
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
		$sourcesArticleId = 6;

		$tableEntities = 'tth_wortliste';
		$tableAuthors = 'tth_autoren';
		$tableStati = 'tth_begriffsstati';
		$tableLanguage = 'tth_sprachen';
		$tableRegions = 'tth_regionen';
		$tableStyles = 'tth_sprachstile';

		$tableSources = 'tth_quellen';
		$tableRelationSources = 'tth_begriff_quellen';
		
		$tableRelationOberbegriffe = 'tth_begriff_oberbegriffe';
		
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
		$query = "SELECT $tableSources.id, $tableSources.kurz ";
		$query.= "FROM $tableEntities ";
		$query.= "JOIN $tableRelationSources ON $tableEntities.id = $tableRelationSources.begriff_id ";
		$query.= "JOIN $tableSources ON $tableSources.id = $tableRelationSources.quelle_id ";
		$query.= "WHERE $tableEntities.id=$id ";
		// $query.= "GROUP BY $tableEntities.id";
		$sourcesArray = $sql->getArray($query);
		// dump($sourcesArray);

		// don't use the '*' and name all fields needed

		// ! b is first alias for $tableEntities, b2 is the second for benutze

		// ! some fields are selected for debug only
		$query = "SELECT b.begriff,b.id,$tableAuthors.gnd,b.quelle_seite,b.code,b.definition,b.quellen_idlist,b.bild,$tableStati.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,";
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
		
			$mdOutput = "h2. ${r["begriff"]}\n\n|ID|$id|\n";
			
			$mdOutput .= "|Definition|${r['definition']}|\n";
			
			$mdOutput .= makeRow('Sprache', $r['sprache']);
			$mdOutput .= makeRow('Sprachstil', $r['sprachstil']);
			$mdOutput .= makeRow('Region', ($r['region']) ? $r['region'] : "");
			$mdOutput .= makeRow('Begriffcode', $r['code']);
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
				getEntityLink($r['benutze'], $r['benutze_begriff'])
			);
			
			// ! needs 5/6 extra queries because of n:m-self relations
			// !!! try to make list by sql (join, group concat etc.) 
			$syns = '';
			foreach($synonyms as $s) {
				$syns .= getEntityLink($s['id'],$s['begriff']).', ';
			}
			
			$mdOutput .= makeRow('Synonyme (Benutzt von)',$syns);

			
			$mdOutput .= "|Autor|";
			// ! the `if` is important because the SQL may still returen the first entry of tth_autoren for some reason when autor_id=''  ! whole data set not returned when no author; need 0 clause in inner join
			if ($r['autor']) { // is a generated value; and is NULL when not set
				// !!! use makeRow
				$mdOutput .= $r['autor'];
				if (trim($r['gnd'])) $mdOutput .= ' (GND: '.$r['gnd'].')';
			}
			$mdOutput .= "|\n";
			if ($r['quelle_seite']) $mdOutput .= makeRow('Seite in Quelle',$r['quelle_seite']);

			$sourcesStr = '';
			foreach ($sourcesArray as $s) {
				$sourcesStr .= getEntityLink($s['id'], $s['kurz'], $sourcesArticleId) . ', ';
			}
			$mdOutput .= makeRow('Quellen',$sourcesStr);

			$mdOutput .= makeRow('Scoped Notes',$r['notes']);
			$mdOutput .= makeRow('Kategorie',checkTruthyWord($r['kategorie']));
			$mdOutput .= makeRow('Veröffentlichen?',checkTruthyWord($r['veroeffentlichen']));
			$mdOutput .= makeRow('Noch bearbeiten',checkTruthyWord($r['bearbeiten']));
						
			// !!! MD discard! because we need bootstrap responsive table and later cols/rows
			echo markitup::parseOutput ('textile', $mdOutput);
			
			dump($rows[0]);
		} 
		else {
			echo rex_view::warning('Eintrag für ID = '.$id.' nicht gefunden.');
		}
	}
	else {
		echo rex_view::warning('Eine Detailansicht benötigt die ID als GET-Parameter "begriff_id". Beginne am besten mit der alphabetichen Übersicht!');
	}
?>
</div>