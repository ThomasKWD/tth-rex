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
		?>
		<div class="row detailed-view">
		<div class="col">
		<?php

		// !!! how pack in function? not possible
		if (!isset($sql)) $sql = rex_sql::factory();
		if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl'); 
		$tm = $vm->getTableManagerInstance();
		// get this from TableManager, not from rex_config because is DB related, not page structure related
		$descriptorId = $tm->getDescriptorId();
		$facetteId = $tm->getFacetteId();
		
		$glossarArticleId = rex_config::get('tth', 'article_glossar');
		// ! localhost = 21, on kwd = 20 
		if (!$glossarArticleId) {
			$glossarArticleId = 20;
			rex_config::set('tth', 'article_glossar', $glossarArticleId);
		}

		$filterArticleId = rex_config::get('tth', 'article_filter');
		// ! localhost = ?, on kwd = 5 
		if (!$filterArticleId) {
			$filterArticleId = 5;
			rex_config::set('tth', 'article_filter', $filterArticleId);
		}
		
		$searchResultList = '';
		$id = 0;

		// first check search results,
		// maybe an $id can be derived (only one word found)
		$wSearch = rex_escape(rex_request('wordlistsearch','string'));
		if ($wSearch) {
			$searchPattern = rex_escape($wSearch);
			if ($searchPattern) {
				// !!! Problem wenn Anf[hrungsyeichen in search]
				$searchPattern = 
					str_replace("'","",
					str_replace("`","",
					str_replace('"','',
					str_replace("\n",'',
					str_replace(';','',
					$searchPattern
				)))));

				if (false === strpos($searchPattern,'*')) {
					// search for word as is 
					$query = "SELECT id, begriff from tth_wortliste WHERE begriff = :wordsearch";
					$singleEntities = $sql->getArray($query, ['wordsearch' => $searchPattern]);
					if (1 === count($singleEntities)) {
						// redirect is cleaner (HTTP url consistency) and easier to understand for user
						rex_redirect('','',['begriff_id' => $singleEntities[0]['id']]);
					}
					else {
						// ! change pattern to always have PART of word when no *
						$searchPattern = '*'.$searchPattern.'*';
					}
				}

				$query = "SELECT id,begriff from tth_wortliste WHERE begriff LIKE :wordsearch";
				$rows = $sql->getArray($query, ['wordsearch' => str_replace('*','%',$searchPattern)]);
				
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
			$query = "SELECT b.begriff,b.id,$tableAuthors.gnd,b.quelle_seite,b.code,b.definition,b.bild,b.begriffsstatus_id,$tableStati.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,b.sprache_id,b.sprachstil_id,b.region_id,";
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

				$html = '';

				if ($tm->checkTruthyWord($r['bearbeiten']) == 'ja') {
					$html .= rex_view::warning('Dieser Eintrag (ID: '.$r['id'].') muss noch überarbeitet werden.');
				}

				$html .= '<table class="table table-responsive">';

				// row 1
				$html .= '<tr>';
				$html .= '<td>';
				if ($r['begriffsstatus_id'] == $facetteId) {
					$html .= '<strong>Facette!</strong>';
				}
				else {
					// !!! join in SQL, see above for 'sprache', 'region', etc.
					$html .= 'Facette: [facette_id]';
					
				}

				// ! depending on anchor correctly set in DB  (glossar entry)
				// !!! should read all anchors from DB 
				$html .= '  <a href="'.rex_getUrl($glossarArticleId).'#facette">(?)</a></td>';
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
				$html .= '<td>';
				
				// !!! list facettes when current is facette
				if ($r['begriffsstatus_id'] == $facetteId) {
					$facettes = str_replace('a>, ','a><br>',$vm->getEntityLinkListByFieldValue('state',$facetteId));
					if ($facettes) {
						$html .= 'Facetten:<br>'.$facettes;
					}
				}
				else {
					// ! we must check $r['benutze'] because benutze==0 also produces link
					$benutzeBegriff = '';
					if ($r['benutze']) $benutzeBegriff = trim($vm->getLink('begriff_id', $r['benutze'], $r['benutze_begriff']));
					
					$descriptorLink = '  <a href="'.rex_getUrl($glossarArticleId).'#deskriptor">(?)</a>';
					
					if ($r['begriffsstatus_id'] == $descriptorId) {
						
						$html .= '<strong>Deskriptor!</strong>'.$descriptorLink.'<br>';
						if ($benutzeBegriff) {
							$html .= '<em>Fehler: Deskriptor verweist auf Deskriptor.<br>';
						}
					}
					else {
						$html .= 'Deskriptor:'.$descriptorLink.'<br>';
						if (!trim($benutzeBegriff)) {
							$html .= '(nicht gesetzt!)';
						}
					}
					
					// ! depending on anchor correctly set in DB  (glossar entry)
					// !!! should read all anchors from DB 
					
					$html .= $benutzeBegriff.'<br>'; // ! always
					
					// !!! make $vm->setGlossarArticleId()
					$html .= 'Äquivalenzklasse: (manuell) '.$vm->getGlossarLink('aequivalenzklasse',$glossarArticleId).'<br>';
					
					$html .= $vm->getLinkList($synonyms, 'begriff_id', 'begriff');
				}
					
				$html .'</td>';

				$html .= '<td class="entity-center"><h2>'.$r["begriff"].'</h2>';

				$html .= $vm->getMarkDownText('markitup::parseOutput',rex_addon::get('markitup'), $r['definition']);
				$html .= '<hr>';

				// !!! $html .= 'Sprache: '.$vm->getFilterCrossLink($r['sprache'], 'sprache_id', $r['sprache_id']).', ';
				$html .= 'Sprache: <a href="'.rex_getUrl($filterArticleId,'',['sprache_id'=>$r['sprache_id']]).'">'.$r['sprache'].'</a>, ';
				$html .= 'Sprachstil: <a href="'.rex_getUrl($filterArticleId,'',['sprachstil_id'=>$r['sprachstil_id']]).'">'.$r['sprachstil'].'</a>, ';
				$html .= 'Sprachregion: <a href="'.rex_getUrl($filterArticleId,'',['region_id'=>$r['region_id']]).'">'.$r['region'].'</a>';


				$html .= '</td>';
				$html .= '<td>';

				$html .= 'Äquivalente (manuell):';
				$html .= $vm->getRelationLinkList('equivalents', $id);
				// !!! cool would be 'br' only when needed -> make sub function for all reverse addition
				// !!! idea for getBidirectionalRelationLinkList see `table_manager.php`
				$html .= '<br>'.$vm->getReverseRelationLinkList('equivalents', $id);

				$html .= 'Verwandte:<br>';
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

				// !!! type check!
				if ($r['begriffsstatus_id'] == $facetteId) {
					echo rex_view::warning('Dies ist eine "Facette". Es ist somit ein Oberbegriff der höchsten Hierarchieebene und kann nicht als normale Entität behandelt werden.');
				}

				$html = '<table class="table table-responsive">';
				
				// $html .= $vm->getRow('Sprache', $r['sprache']);
				// $html .= $vm->getRow('Sprachstil', $r['sprachstil']);
				// $html .= $vm->getRow('Region', ($r['region']) ? $r['region'] : "");
				$html .= $vm->getRow('ID', $r['id']);
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
				// $html .= $vm->getRow('Schlagwörter',$tagList.'<br><small></small>');
				
				// ! first link
				// $html .= $vm->getRow('Synonym von (Benutze)',$vm->getLink('begriff_id', $r['benutze'], $r['benutze_begriff']).'<br><small>dies ist der Desriptor und damit Name der <em>Äquivalenzklasse</em></small>');
					
				// !!! use small def from Bootstrap
				// $syns = $vm->getLinkList($synonyms, 'begriff_id', 'begriff');
				// $html .= $vm->getRow('Deskriptor von (Benutzt für)',$syns.'<br><small>diese sind zusammen mit dem Begriff "'.$r['begriff'].'" selbst die <em>Äquivalenzklasse</em></small>');
				
				// if ($r['quelle_seite']) $html .= $vm->getRow('Seite in Quelle',$r['quelle_seite']);
				
				$html .= $vm->getRow('Scoped Notes',$r['notes']);
				$html .= $vm->getRow('Kategorie', '<a href="'.rex_getUrl($filterArticleId,'',['category_value'=>$r['kategorie']]).'">'.$tm->checkTruthyWord($r['kategorie']).'</a>');
				// ;
				$html .= $vm->getRow('Veröffentlichen?',$tm->checkTruthyWord($r['veroeffentlichen']));
				$html .= $vm->getRow('Noch bearbeiten','<a href="'.rex_getUrl($filterArticleId,'',['edit_value'=>$r['bearbeiten']]).'">'.$tm->checkTruthyWord($r['bearbeiten']).'</a>');
				
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
			} // if rex::isBackend()
			?>
