<h2>Hierarchie</h2>

<?php
    // !!! i    ea for table-names: search in config, when not found load from db
    //     Katze, die sich in den Schwanz beißt

    $sql = rex_sql::factory();
    // !!! how to store facet id in DB as value, maybe we need a "config table"
    $facetArray = $sql->getArray("SELECT id, begriff FROM tth_wortliste WHERE begriffsstatus_id = 8");
    $num = count($facetArray);
    if (!$num) $num = 0; // in case $facetArray === false;

    $tm = new \kwd\tth\TableManager();
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
            echo $tm->makeLinkList($allOberbegriffeDirectly,'begriff_id', 'begriff');
        }
        else {
            echo "Keine direkten Nachfahren für Facette \"<strong>$facetName</strong>\".";
        }

        // works:
            // $allOberbegriffe = $sql->getArray("SELECT begriff_id, oberbegriff_id FROM tth_begriff_oberbegriffe");
            // $allUnterBegriffe = $sql->getArray("SELECT begriff_id, unterbegriff_id FROM tth_begriff_unterbegriffe");

            // !!! plans:
        //     - only use oberbegriffe, 
        //     - join the relations by auto-reverse-finding + removing redundants
        //     - 
        //       ! get all "begriffe" where either oberbegriffe or unterbegriffe set (possible to have 2 joins??)

        // for compare first find all where nothing set! MUST use OUTER join, wonder why works? see: https://www.xaprb.com/blog/2005/09/23/how-to-write-a-sql-exclusion-join/
        // ! problem: lots of root parents because oberbegriffe *very often* not defined
        $allRootParents = $sql->getArray("SELECT b.id, b.begriff FROM tth_wortliste b LEFT OUTER JOIN tth_begriff_oberbegriffe o ON o.begriff_id = b.id WHERE o.begriff_id is NULL");
        $warnText = '<p>Es wurden '.count($allRootParents).' Entitäten ohne Oberbegriff gefunden.</p>';

        $allDeadEnds = $sql->getArray("SELECT b.id, b.begriff FROM tth_wortliste b LEFT OUTER JOIN tth_begriff_unterbegriffe u ON u.begriff_id = b.id WHERE u.begriff_id is NULL");
        $warnText .= '<p>Es wurden '.count($allDeadEnds).' Entitäten ohne Unterbegriff gefunden.</p>';
        
        $warnText .= '<p>Die 2. Zahl ist weniger aussagekräftig, da es mehr Unterbegriff-Beziehungen gibt, die bereits durch Oberbegriff-Beziehungen indirekt ausgedrückt sind.</p>';
        // dump($allRootParents);
        echo rex_view::warning($warnText);
    }
    else {
        echo "<b>Facetten</b> ($num):<br>";
        echo $tm->makeLinkList($facetArray, 'facette_id','begriff');  
    
    }
?>
