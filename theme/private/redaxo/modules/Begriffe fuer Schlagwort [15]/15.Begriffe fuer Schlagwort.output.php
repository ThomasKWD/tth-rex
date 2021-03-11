<?php
    // !!! should go into my helper class
    if (!function_exists('getFieldById')) {
          // best array_find function better than using array_filter which can not stop on find!
        // function array_search_func(array $arr, $func) {
        //     foreach ($arr as $key => $v)
        //         if ($func($v))
        //             return $key;

        //     return false;
        // }
        function getFieldById(array $arr, $id, $fieldName) {
            foreach ($arr as $key => $v) {
                if ($v['id'] == $id)
                return $v[$fieldName];
            }

            return false;
        }
    }
    
    if (!isset($sql)) $sql = rex_sql::factory();
    if (!isset($vm)) $vm = new \kwd\tth\ViewFormatter($sql, 'rex_getUrl'); 

    // !!! put into tm/vm

    $tm = $vm->getTableManagerInstance();
    $tagsArray = $tm->getOuterRelationTableData('tags');

    // // !!! provide centralized name string base!
    // $tagsTable = 'tth_tags';
    // $tagsRelationTable = 'tth_begriff_tags';


    // $listQuery = "SELECT id, name FROM $tagsTable ORDER BY name ASC";
    // $tagsArray = $sql->getArray($listQuery);

    // // makes clickable List:
    // $tm = new \kwd\tth\TableManager();
    $tag = 'Schlagwort';

    if ($tagsArray && count($tagsArray)) {
        echo '<p>' . $vm->getLinkList($tagsArray, 'tag_id', 'name') .'</p>';
    }

    if (rex_request('tag_id')) {
        $id = rex_escape(rex_request('tag_id','string'));
        // for($i=0; $<count($))
        // echo "id: $id";
        $tag = getFieldById($tagsArray, $id, 'name');

        $tableEntities = 'tth_wortliste';
        $tableRelationTags = 'tth_begriff_tags';

        // !!! inner join of outer relation (just like in `DetailAnsicht`)
        //     should go into tablemanager!!
        // !!! could make "getOuterRelation in table manager
        $entitiesQuery = "SELECT r.tag_id, r.begriff_id, e.begriff, e.id "; // e.id for output below in makeLinkList
        $entitiesQuery.= "FROM $tableRelationTags r ";
        $entitiesQuery.= "JOIN $tableEntities e ON r.begriff_id = e.id ";
        $entitiesQuery.= "WHERE r.tag_id=$id ORDER BY e.begriff ASC";
        $entities = $sql->getArray($entitiesQuery);
        // dump($entities);
        if (count($entities)) {
            // dump($entities);
            echo "<h3>Begriffe, die \"$tag\" enthalten</h3>";
            echo '<p>'.$vm->getLinkList($entities, 'begriff_id', 'begriff',"REX_LINK[id=1 output=id]").'</p>';
        }
        else {
            echo "<p>Keine Begriffe mit \"$tag\" gefunden.";
        }

        echo "<hr><p>Begriffe, bei denen \"Kategorie\" gesetzt ist</p>";
        $katEntitiesQuery = "SELECT id, begriff FROM $tableEntities WHERE kategorie = 'TRUE' ORDER BY begriff ASC";
        $kats = $sql->getArray($katEntitiesQuery);
        echo '<p>'.$vm->getLinkList($kats, 'begriff_id', 'begriff',"REX_LINK[id=1 output=id]").'</p>';
    }
  ?>