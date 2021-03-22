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

		// !!! how pack in function?
		if (!isset($sql)) $sql = rex_sql::factory();
		if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl'); 
		$tm = $vm->getTableManagerInstance();
		$descriptorId = $tm->getDescriptorId();
		$facetteId = $tm->getFacetId();
		
		
		// !!! why not settable in module INPUT?
		// ! localhost = 21, on kwd = 20 
		$glossarArticleId = rex_config::get('tth', 'article_glossar');
		if (!$glossarArticleId) {
			$glossarArticleId = 20;
			rex_config::set('tth', 'article_glossar', $glossarArticleId);
		}
		// !!! make $vm->setGlossarArticleId()

		$filterArticleId = rex_config::get('tth', 'article_filter');
		// ! localhost = ?, on kwd = 5 
		if (!$filterArticleId) {
			$filterArticleId = 5;
			rex_config::set('tth', 'article_filter', $filterArticleId);
		}
		
		$searchResultList = '';
		$id = 0;

		// first check search results,
		$wSearch = rex_escape(rex_request('wordlistsearch','string'));
		if ($wSearch) {
			$searchPattern = rex_escape($wSearch);
			if ($searchPattern) {
				// !!! Problem wenn Anfuehrungszeichen in gespeichertem Wort
				
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
					// ! note that can still be more than 1 because of possible entities with exact same name
					$singleEntities= $tm->findEntities($searchPattern, true); // true means strictly the word/pattern
					if (1 === count($singleEntities)) {
						// redirect is cleaner (HTTP url consistency)
						rex_redirect('','',['begriff_id' => $singleEntities[0]['id']]);
					}
					else {
						// ! change pattern to always have PART of word when no *
						$searchPattern = '*'.$searchPattern.'*';
					}
				}
				
				$entities = $tm->findEntities($searchPattern);
				if ($entities) {
					$searchResultList = $vm->getEntityLinkList($entities);
				}
			}
		}

		if (!$id) $id = rex_request('begriff_id','int');
		if ($id) {
			$sourcesArticleId = 'REX_LINK[id=1 output=id]';
			$tagsArticleId = 'REX_LINK[id=2 output=id]';
			if (!$sourcesArticleId) $sourcesArticleId = 'REX_ARTICLE_ID';
									
			$r = $tm->getSingleEntity($id); // getSingleEntity returns empty array when not found
			if ($r) { 
				$html = '';

				if ($tm->checkTruthyWord($r['bearbeiten'])) {
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

					// !!! check if is descriptor,
					//     if not, get class of descriptor id,
					//     in both cases we should get data about begriffsstatus of each entity in list to mark 
					//     linking errors.
					$html .= 'Äquivalenzklasse:'.$vm->getGlossarLink('aequivalenzklasse',$glossarArticleId).'<br>';		
					$html .= $vm->getEntityLinkListByFieldValue('descriptor',$id);
					if ($r['benutze']) {
						$html .= $vm->getEntityLinkListByFieldValue('descriptor',$r['benutze']);
						$html .= '<br><span class="small"><em>(falls hier Dopplungen auftreten, sind unzulässigerweise Deskriptoren verkettet.)</em></span>';
					}

					if ($r['benutzt_fuer']) {
						// make the whole logic in TableManager
						$ids = $r['benutzt_fuer'];
						if (false !== strpos($ids, ',')) $rawIds = explode(',', $ids);
						else if (false !== strpos($ids, ';')) $rawIds = explode(';', $ids);						
						$html .= '<hr><span class="small">Manuelle Synonyme ("benutzt_fuer"): '
							.$vm->getEntityLinkList($tm->getEntitiesFromIdList($rawIds))
							.'</span>';
					}
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
				$html .= $vm->getForeignEntriesLinkList('tags', $id, $tagsArticleId);
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
				$html .= $vm->getRow('Begriffs-Status','<a href="'
				.rex_getUrl(
					$filterArticleId,
					'',
					[ 'begriffsstatus_id' => $r['begriffsstatus_id'] ]
				)
				.'">'.$r['status']).'</a>';
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
				$html .= $vm->getRow('Kategorie', '<a href="'.rex_getUrl($filterArticleId,'',['category_value'=>$r['kategorie']]).'">'.$vm->getTruthyWord($r['kategorie']).'</a>');
				// ;
				$html .= $vm->getRow('Veröffentlichen?',$vm->getTruthyWord($r['veroeffentlichen']));
				$html .= $vm->getRow('Noch bearbeiten','<a href="'.rex_getUrl($filterArticleId,'',['edit_value'=>$r['bearbeiten']]).'">'.$vm->getTruthyWord($r['bearbeiten']).'</a>');
				
				$authorText = '';
				// ! the `if` is important because the SQL may still returen the first entry of tth_autoren for some reason when autor_id=''  ! whole data set not returned when no author; need 0 clause in inner join
				// !!! link to author with autor_id
				if ($r['autor']) { // is a generated value; and is NULL when not set
					$authorText .= $r['autor'];
					// !!! provide link for GND (see code in details of "Quelle")
					if (trim($r['gnd'])) $authorText .= ' (GND: '.$r['gnd'].')';
				}
				$html .= $vm->getRow('Autor',$authorText);
				$html .= '</table>';
				echo $html;
					
				// !!! remove after tests because unnessecary doubled sql query
				// !!! or refactor by using getLinkList directly, but then you'll need to query names from TableManager
				// echo '<p>new code list of sources: '.$vm->getForeignEntriesLinkList('references', $id, $sourcesArticleId). '</p>';
				
				$sourcesArray = $tm->getForeignEntries('references', $id);
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
