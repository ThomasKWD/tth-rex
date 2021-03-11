<!-- you will need to use bootstrap rows/cols -->
<?php
	if (rex::isBackend()) {
		// !!! make general function for "backend-page link"
		?>
		<p>Ergebnisse nur im Frontend.</p>
		<p>Bei fehlender ID des Begriffs wird eine Warnung ausgegeben.</p>
		<p>Die Ziel-Seite der globalen Suche sollte dieses Modul enthalten. Da bei Suchmuster eine Auswahlliste erzeugt wird, wenn das Suchmuster auf mehrere Begriffe passt.</p>
		<p>Artikel für Quellen: <strong>REX_LINK[id=1 output=name]</strong> (ID: REX_LINK[id=1 output=id])</p>
		<p>Artikel für Schlagwörter:  <strong>REX_LINK[id=2 output=name]</strong> (ID: REX_LINK[id=2 output=id])</p>
		<?php
	}
	else {
		define("DETAIL_VIEW", "detail");

		?>
		<div class="row detailed-view">
		<div class="col">
		<?php

		// !!! how pack in function? not possible
		if (!isset($sql)) $sql = rex_sql::factory();
		if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, rex_getUrl); 

		$id = 0;
		// first check search results,
		// maybe an $id can be derived (only one word found)
		$wSearch = rex_escape(rex_request('wordlistsearch','string'));
		if ($wSearch) {
			$searchPattern = rex_escape($wSearch);
			if ($searchPattern) {
				// ! change pattern to always have PART of word when no *
				if (false === strpos($searchPattern,'*')) {
					$searchPattern = '*'.$searchPattern.'*';
				}
				
				$searchPattern = 
					str_replace("'","",
					str_replace("`","",
					str_replace('"','',
					str_replace("\n",'',
					str_replace(';','',
					$searchPattern
				)))));

				$query = "SELECT id,begriff from tth_wortliste WHERE begriff LIKE ".str_replace('*','%',$sql->escape($searchPattern));
				
				$rows = $sql->getArray($query);
				
				$searchResultList = '';
				if (count($rows)) {
					if(count($rows) === 1) {
						$id = $rows[0]['id'];
						$searchResultList = 'found exactly one begriff: '.$rows[0]['begriff'];
					}
					$searchResultList = $vm->getLinkList($rows, 'begriff_id', 'begriff', '');
				}
			}
		}

		if (!$id) $id = rex_request('begriff_id','int');
		if ($id) {
			$sourcesArticleId = 'REX_LINK[id=1 output=id]';
			$tagsArticleId = 'REX_LINK[id=2 output=id]';
			if (!$sourcesArticleId) $sourcesArticleId = 'REX_ARTICLE_ID';
			$tableEntities = 'tth_wortliste';
			$tableAuthors = 'tth_autoren';
			$tableStati = 'tth_begriffsstati';
			$tableLanguage = 'tth_sprachen';
			$tableRegions = 'tth_regionen';
			$tableStyles = 'tth_sprachstile';
			$tableTags = 'tth_tags';
			$tableSources = 'tth_quellen'; // needed for resolving names in $tableReferences
			// $tableRelationSources = 'tth_begriff_quellen';
			$tableReferences = 'tth_quellenangaben';
			$tableRelationTags = 'tth_begriff_tags';

			// $sql = rex_sql::factory();
			// !!! test relations with yform functions, so that no own queries needed
			
			// ! synonyms found can not be generated by $tm->getInnerRelations() because we want to find
			//   all enities which point to the current one
			$synonymsQuery = "SELECT t1.id,t1.begriff from $tableEntities t1 WHERE t1.benutze=$id";
			$synonyms = $sql->getArray($synonymsQuery);
			
			// references list
			$query = "SELECT r.id, r.quelle_id, r.seitenzahl, r.bevorzugt, s.kurz "; //s.kurz
			$query.= "FROM $tableReferences r ";
			$query.= "JOIN $tableSources s ON r.quelle_id = s.id ";
			// $query.= "JOIN $tableSources ON $tableSources.id = $tableRelationSources.quelle_id ";
			$query.= "WHERE r.begriff_id=$id ORDER BY r.id ASC";
			$sourcesArray = $sql->getArray($query);
			
			// tags
			// !!! could make "getOuterRelation in table manager
			$tagsQuery = "SELECT r.tag_id, r.begriff_id, s.name ";
			$tagsQuery.= "FROM $tableRelationTags r ";
			$tagsQuery.= "JOIN $tableTags s ON r.tag_id = s.id ";
			$tagsQuery.= "WHERE r.begriff_id=$id ORDER BY s.name ASC";
			$tags = $sql->getArray($tagsQuery);
			
			// ! b is first alias for $tableEntities, b2 is the second for benutze
			$query = "SELECT b.begriff,b.id,$tableAuthors.gnd,b.quelle_seite,b.code,b.definition,b.bild,b.begriffsstatus_id,$tableStati.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,";
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
				$r = $rows[0]; // because selected by ID, there can only be 1 row

				// stuff needed for Details AND grid view:

				// !!! need method for this code synonyms + tags
				//     (code DRY)
				$tagList = '';
				foreach($tags as $s) {
					$tagList .= $vm->getLink('tag_id', $s['tag_id'],$s['name'], $tagsArticleId.', ');
				}
				$tagList = rtrim($tagList,',');
				
				$detailView = rex_escape(rex_request('view','string'));
				if (DETAIL_VIEW === $detailView) {
				
					$html = "<h2>${r["begriff"]}</h2>\n";
					
					// !!! type check!
					if ($r['begriffsstatus_id'] == 8) {
						echo rex_view::warning('Dies ist eine "Facette". Es ist somit ein Oberbegriff der höchsten Hierarchieebene und kann nicht als normale Entität behandelt werden.');
					}

					$html .= '<table class="table table-responsive">';
					
					// make header line of table
					// $html .= '<thead><tr><th>Feld</th><th>Inhalt</th></thead>';
					
					// !!! show when logged in
					// $html .= $vm->getRow('ID', $r['id']);

					$html .= $vm->getRow('Definition', $vm->getMarkDownText('markitup::parseOutput',rex_addon::get('markitup'), $r['definition']));
			
					$html .= $vm->getRow('Sprache', $r['sprache']);
					$html .= $vm->getRow('Sprachstil', $r['sprachstil']);
					$html .= $vm->getRow('Region', ($r['region']) ? $r['region'] : "");
					$html .= $vm->getRow('Begriffcode', $r['code']);
					$html .= $vm->getRow('Begriffs-Status',$r['status']);
					// ! redaxo file list is *comma* separated
					if ($r['bild']) {
						// ! separator ',' is determined by redaxo
						$images = explode(',',$r['bild']);
						$imgHTML = '';
						foreach ($images as $img) {
							$imgHTML .= '<img src="index.php?rex_media_type=tth_horizontal_list&rex_media_file='.$img.'">';
						}
						$html .= $vm->getRow('Bilder',$imgHTML);
					}
					
					// !!! how make view DONT know model?
					$html .= $vm->getRow(
						'Grobgliederung',
						$vm->getRelationLinkList('structuring', $id)
					);

					$html .= $vm->getRow(
						'Begriffe, bei denen Grobgliederung auf diesen Begriff verweist',
						$vm->getReverseRelationLinkList('structuring', $id)
					);
										
					// !!! use small def from Bootstrap
					$html .= $vm->getRow('Schlagwörter',$tagList.'<br><small></small>');
					
					// ! first link
					$html .= $vm->getRow('Synonym von (Benutze)',$vm->getLink('begriff_id', $r['benutze'], $r['benutze_begriff']).'<br><small>dies ist der Desriptor und damit Name der <em>Äquivalenzklasse</em></small>');
						
						// !!! use small def from Bootstrap
						$syns = $vm->getLinkList($synonyms, 'begriff_id', 'begriff');
						$html .= $vm->getRow('Deskriptor von (Benutzt für)',$syns.'<br><small>diese sind zusammen mit dem Begriff "'.$r['begriff'].'" selbst die <em>Äquivalenzklasse</em></small>');
						
						// !!! rule: 'supers' produces {{supers}} or ###supers### which then can be turned to Oberbegriffe in sprog
						// !!! view should not know about begriff_id, begriff 

						$html .= $vm->getRow(
							'Oberbegriffe',
							// relation list always return entities
							$vm->getRelationLinkList('supers', $id)
						);

						// ! must be "unterbegriffe" reverse to show generated "oberbegriffe"
						$html .= $vm->getRow(
							'',
							$vm->getReverseRelationLinkList('subs', $id)
						);
						
						$html .= $vm->getRow(
							'Unterbegriffe',
							$vm->getRelationLinkList('subs', $id)
						);

						// ! must be "oberbegriffe" reverse to show generated "unterbegriffe"
						$html .= $vm->getRow(
							'',
							$vm->getReverseRelationLinkList('supers', $id)
						);
							
						$html .= $vm->getRow(
							'Äquivalente Begriffe',
							$vm->getRelationLinkList('equivalents', $id)
						);
						
						$html .= $vm->getRow(
							'Verwandte Begriffe',
							$vm->getRelationLinkList('relatives', $id)
						);
						
						if ($r['quelle_seite']) $html .= $vm->getRow('Seite in Quelle',$r['quelle_seite']);
						
						$tm = $vm->getTableManagerInstance();
						$html .= $vm->getRow('Scoped Notes',$r['notes']);
						$html .= $vm->getRow('Kategorie',$tm->checkTruthyWord($r['kategorie']));
						$html .= $vm->getRow('Veröffentlichen?',$tm->checkTruthyWord($r['veroeffentlichen']));
						$html .= $vm->getRow('Noch bearbeiten',$tm->checkTruthyWord($r['bearbeiten']));
						
						$authorText = '';
						// ! the `if` is important because the SQL may still returen the first entry of tth_autoren for some reason when autor_id=''  ! whole data set not returned when no author; need 0 clause in inner join
						if ($r['autor']) { // is a generated value; and is NULL when not set
							$authorText .= $r['autor'];
							// !!! provide link for GND (see code in details of "Quelle")
							if (trim($r['gnd'])) $authorText .= ' (GND: '.$r['gnd'].')';
						}
						$html .= $vm->getRow('Autor',$authorText);
						$html .= '</table>';
						echo $html;
					}
					else {
						$html = '<table class="table table-responsive">';

						// row 1
						$html .= '<tr>';
						$html .= '<td>Facette: ?</td>';
						$html .= '<td>';
						$html .= $vm->getRelationLinkList('supers', $id);
// 						Ein weiterer Vorteil ist, dass die Platzhalter wiederholt werden können, ohne mehr Argumente im Code hinzufügen zu müssen.

// <?php
// $format = 'Der %2$s enthält %1$d Affen.
//            %1$d Affen sind ziemlich viel für einen %2$s.';
						// ! must be "unterbegriffe" reverse to show generated "oberbegriffe"
						$html .= '<br>'.$vm->getReverseRelationLinkList('subs', $id);
						$html .= '</td>';
						$html .= '<td></td>';
						$html .= '</tr>';

						// row 2
						$html .= '<tr>';
						$html .= '<td>Deskriptor:<br>Synonyme<br>:';
						$html .= $vm->getRelationLinkList('equivalents', $id);
						// !!! cool would be 'br' only when needed -> make sub function for all reverse addition
						// !!! idea for getBidirectionalRelationLinkList see `table_manager.php`
						$html .= '<br>'.$vm->getReverseRelationLinkList('equivalents', $id);
						$html .'</td>';
						$html .= '<td class="entity-center"><h2>'.$r["begriff"].'</h2>';

						$html .= $vm->getMarkDownText('markitup::parseOutput',rex_addon::get('markitup'), $r['definition']);
						
						$html .= '</td>';

						$html .= '<td>Verwandte:<br>';
						$html .= $vm->getRelationLinkList('relatives', $id);
						$html .= '<br>'.$vm->getReverseRelationLinkList('relatives', $id);
						$html .= '</td>';
						$html .= '</tr>';

						// row 3
						$html .= '<tr>';
						$html .= '<td></td>';
						$html .= '<td>';
						$html .= $vm->getRelationLinkList('subs', $id);
						// ! must be "unterbegriffe" reverse to show generated "oberbegriffe"
						$html .= '<br>'.$vm->getReverseRelationLinkList('supers', $id);
						$html .= '</td>';
						$html .= '<td>Schlagwörter:<br>';
						$html .= $tagList;
						$html .= '</td>';
						$html .= '</tr>';

						$html .= '</table>';
						echo $html;

						$detailUrl = rex_getUrl('','', array ('begriff_id' => $id, 'view' => 'detail'));
						?>
						<p><a href="<?=$detailUrl?>">Details und Zusatzinformationen anzeigen.</a></p>
						<?php
					}
						
					// dump($rows[0]);
					// begin new table for Sources-Entries:
						$html = '<hr><table class="table table-responsive">';
						// make header line of table
						$html .= "<thead><tr><th>#</th><th>Quelle</th><th>Seitenzahl</th><th>Bevorzugt?</th></thead>\n";
						$i = 1;
						foreach($sourcesArray as $s) {
							$html .= "<tr>\n";
							$html .= "<td>$i</td> ";
							$html .= "<td>".$vm->getLink('quelle_id',$s['quelle_id'], '<div class="author-name">'.$s['kurz'].'</div>', $sourcesArticleId)."</td> ";
							// check for any truthy value
							$html .= "<td>".($s['seitenzahl'] ? $s['seitenzahl'] : '')."</td> ";
							// check for any truthy value
							$html .= "<td>".($s['bevorzugt'] ? 'bevorzugt' : '')."</td> ";
							// $html .= "<td>${s['bevorzugt']}</td> ";
							$html .= "</tr>\n";
							$i++;
						}
						echo $html.'</table>';
					
						// write a string with begriff
						echo '{{{'.$r['begriff'].'}}}';
						// rex_config::set('tth','current_entity',$r['begriff']);
					}
					else {
						echo rex_view::warning('Eintrag für ID = '.$id.' nicht gefunden.');
					}

				}

				// !!! check: remove this if when hierarchy is always on other page 
				else if (!rex_request('facette_id')) {
					if ($wSearch) {
						echo '<div class="card"><div class="card-body"><h5 class="card-title">'.($searchResultList ? '' : '<strong>Keine</strong> ').'Ergebnisse für "'.$wSearch.'":</h5><p>'.$searchResultList.'</p></div></div>';
					}
					else if (!$id) {
						// !!! make text editable in module input
						echo rex_view::warning('Kein Begriff ausgewählt.');
					}
				}
			?>
	</div>
</div>
				<?php
			}
			?>
