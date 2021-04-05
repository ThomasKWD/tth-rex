<?php
	// !!! all functions into model/viewmodel classes

	if (!function_exists('addNewPathElement')) {
		function addNewPathElement($id, $path, &$paths) {
			$paths[] = array( 'id' => $id, 'path' => $path);
		}
	}
	
	if(!function_exists('tth_foundInUnterbegriffe')) {
		function tth_foundInUnterbegriffe($id, &$subs) {
			// ! don't use foreach due to return in loop
			for($i = count($subs) - 1; $i >= 0; $i--) {
				$s = $subs[$i];
				if ($s['unterbegriff_id'] == $id) {
					return true;
				}
			}

			return false;
		}
	}

	if (!function_exists('tth_getEntity')) {
		function tth_getEntity($id, &$entities) {
			// ! don't use foreach due to return in loop
			for($i = 0; $i < count($entities); $i++) {
				$e = $entities[$i];
				if ($id == $e['id']) {
					return array('id' => $id, 'begriff' => $e['begriff']);
				}
			}

			return array (0 => '(Fehler: id #'.$id.' nicht gefunden) ');
		}
	}

	if (!function_exists('sortEntities')) {
		function sortEntities($a, $b) {
			if ($a['begriff'] == $b['begriff']) return 0;
			if ($a['begriff'] > $b['begriff']) return 1;
			return -1;
		}
	}

	// would be cleaner to return array!
	if (!function_exists('tth_getSubs')) {
		function tth_getSubs($id, &$supers, &$subs, &$entities, &$paths, $path, $detailsId, $iteration) {
			$ret = '';

			// !!! make max. possible depth *editable*
			if ($iteration > 10) {
				return 'Fehler: Zirkuläre Beziehung';
			}

			$iteration += 1;
			$children = array();

			// direct ones:
			foreach($subs as $sub) {
				if ($id == $sub['begriff_id']) {
					$children[] = tth_getEntity($sub['unterbegriff_id'], $entities); 
				}
			}

			// indirect ones: 			
			foreach($supers as $super) {
				if ($id == $super['oberbegriff_id']) {
					$children[] = tth_getEntity($super['begriff_id'], $entities); 
				}
			}

			// store path
			// !!! problem: multiple set of entries - only because multiple "oberbegriffe" or inherent problem?
			if ($path) {
				$path .= ',' . $id;
				// we set only those who have path > 1
				addNewPathElement($id, $path, $paths);
			}
			else {
				$path = strval($id);
			}

			if (count($children)) {
				$checkArray = array();
				$cleanedChildren = array();
				foreach($children as $c) {
					if (false === array_search($c['id'], $checkArray)) {
						$checkArray[] = $c['id'];
						$cleanedChildren[] = $c;
					}
				}

				$ret .= '<ul>';				
				// ! benefit of recursive iterator only when need to do more complex array/iteration functionality
				// uasort($cleanedChildren,'sortEntities');
				$ccObject = new ArrayObject($cleanedChildren);
				$ccObject->uasort('sortEntities');
				foreach($ccObject as $child) {
					if ($child['id'] == $id) {
						$ret .= 'Fehler: Selbstbezug';
					}
					else {
						$ret .= '<li><a href="'.rex_getUrl($detailsId,'', array('begriff_id' => $child['id'])).'">'.$child['begriff'].'</a></li>';
						
						// ! recursion
						// !!! we must count iterations for break if circular dependency!!!
						$ret .= tth_getSubs($child['id'], $supers, $subs, $entities, $paths, $path, $detailsId, $iteration);
					}
				}
				
				$ret .= '</ul>';
			}

			return $ret;
		}
	}

	$detailsArticleId = 'REX_LINK[id=1 output=id]';
	if (!$detailsArticleId) $detailsArticleId = rex_article::getSiteStartArticle()->getId();

	if (rex::isBackend()) {
		// !!! make general function for "backend-page link"
		?>
		<p>Ziel-Artikel für Detailansicht: <strong>REX_LINK[id=1 output=name]</strong> (ID REX_LINK[id=1 output=id])</p>
		<?php
	}

	// !!! how pack in function? not possible
    if (!isset($sql)) $sql = rex_sql::factory();
	if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl');

    // !!! how to store facet id in DB as value, maybe we need a "config table"
    $facetArray = $sql->getArray("SELECT id, begriff FROM tth_wortliste WHERE begriffsstatus_id = 8");
    $num = count($facetArray);
    if (!$num) $num = 0; // in case $facetArray === false;

    // !!! since *all* entities follow the hierarchy we could load ALL entities,
    //     and all oberbegriffe/unterbegriffe relations to have it 
    $facetId = rex_escape(rex_request('facette_id', 'integer'));
    if ($facetId) {
        $facetName = '';
        foreach($facetArray as $f) {
            if ($f['id'] == $facetId) {
                $facetName = $f['begriff'];
                break;
            }
        }

        $allOberbegriffeDirectly = $sql->getArray(
            "SELECT b.begriff,b.id FROM tth_begriff_oberbegriffe o JOIN tth_wortliste b ON b.id = o.begriff_id WHERE oberbegriff_id = $facetId"
        );

        if (count($allOberbegriffeDirectly)) {
            echo "Begriffe für Facette (direkte Nachfahren) \"<strong>$facetName</strong>\":<br>";
            echo $vm->getLinkList($allOberbegriffeDirectly,'begriff_id', 'begriff', $detailsArticleId);
        }
        else {
            echo "Keine direkten Nachfahren für Facette \"<strong>$facetName</strong>\".";
        }

    }
    else {
        echo "<b>Facetten</b> ($num):<br>";
        echo $vm->getLinkList($facetArray, 'facette_id','begriff');
    }

	?>
	<hr>
	<?php
	// !!! directly write select results as other table entries (inside SQL) for building tree
	//     - too complicated without logic in PHP

	// works:
	// $allOberbegriffe = $sql->getArray("SELECT begriff_id, oberbegriff_id FROM tth_begriff_oberbegriffe");
	// $allUnterBegriffe = $sql->getArray("SELECT begriff_id, unterbegriff_id FROM tth_begriff_unterbegriffe");

	// entities which have no "oberbegriffe", needed later 
	$allRootParents = $vm->getTableManagerInstance()->getEntitiesForUnsetRelation('entity_supers');

	$warnText = '<p>Es wurden '.count($allRootParents).' Entitäten ohne Oberbegriff gefunden.</p>';	
	$warnText .= '<p>Es  wurden'.count($vm->getTableManagerInstance()->getEntitiesForUnsetRelation('entity_subs')).' Entitäten ohne Unterbegriff gefunden.</p>';
	$warnText .= '<p>Die 2. Zahl ist weniger aussagekräftig, da es mehr Unterbegriff-Beziehungen gibt, die bereits durch Oberbegriff-Beziehungen indirekt ausgedrückt sind.</p>';

	echo rex_view::warning($warnText);

	// ! need all because eventually all entities are in hierarchy
	$alleBegriffe = $sql->getArray("SELECT id, begriff FROM tth_wortliste WHERE 1");
	$oberbegriffe = $sql->getArray("SELECT * FROM tth_begriff_oberbegriffe WHERE 1 ORDER BY begriff_id");
	$unterbegriffe = $sql->getArray("SELECT * FROM tth_begriff_unterbegriffe WHERE 1 ORDER BY begriff_id");
	$paths = array();

	// must build all as arrays of arrays 
	$entry = [
		'id' => 645,
		'begriff' => 'Abbund',
		'children' => [], // array of entries
		'message' => '' // for error messages e.g. Selbstbezug
	];

	$html = '<ul>';	
	foreach($allRootParents as $parent) {
		// - remove those which have been detected to be a unterbegriff of something
		if (!tth_foundInUnterbegriffe($parent['id'], $unterbegriffe)) {
			$subs = tth_getSubs($parent['id'], $oberbegriffe, $unterbegriffe, $alleBegriffe, $paths, '', $detailsArticleId, 0);
			if ($subs) {
				$html .= '<li><a href="'.rex_getUrl($detailsArticleId, '', array ('begriff_id' => $parent['id'])).'">'.$parent['begriff'];
				// $html .= ' (in unterbegriffen gefunden)';
				$html .= '</a>';
				$html .= $subs;
				$html .= '</li>';
			}
		}
	}
	$html .= '</ul>';

	echo $html;

	// dump(count($paths));
	// !!! multiple path are a problem of multiple oberbegriffe per entity
	//     - and not of paths algo
	
	// ! check $paths for multiple entries
	// $checkPaths = array();
	// $cleanedPaths = array();
	// foreach($paths as $p) {
	// 	if (false === array_search($p['id'], $checkPaths)) {
	// 		$checkPaths[] = $p['id'];
	// 		$cleanedPaths[] = $p;
	// 	}
	// 	else {
	// 		// echo "found multiple entry: ".$p['id']."<br>";
	// 	}
	// }
	// dump(count($cleanedPaths));
	// $searchEntity = 651;
	// !!! can only be written inside class??
	// !!! or simply make filter function for your own
	if (!function_exists('filter_tthBegriffe')) {
		function filter_tthBegriff($e) {
			// global $searchEntity;
			if ($e['id'] == 651) return true;
			return false;
		}
	}

	// test filter:
	$filterPaths = array_filter($paths, 'filter_tthBegriff');
	// dump($filterPaths);

	// calculate path when begriff_id given:
	$currentId = rex_escape(rex_request('begriff_id'));
	if ($currentId) {
		echo "akt Begriff: $currentId";
	}
?>
