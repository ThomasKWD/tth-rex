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

    $tm = $vm->getTableManagerInstance();
    $tagsArray = $tm->getOuterRelationTableData('tags');

    $tag = 'Schlagwort';

    if ($tagsArray && count($tagsArray)) {
        echo '<p>' . $vm->getLinkList($tagsArray, 'tag_id', 'name') .'</p>';
        // !!! make getLinkListBySubject('<subject>')
    }

    // tag_id is equal to field name in DB, but is not required, could also be different by convention
    if (rex_request('tag_id')) {
        $id = rex_escape(rex_request('tag_id','string'));
        // for($i=0; $<count($))
        // echo "id: $id";
        $tag = getFieldById($tagsArray, $id, 'name');

        $listHtml = $vm->getEntityLinkListForOuterRelation('tags', $id, "REX_LINK[id=1 output=id]");
        if ($listHtml) {
            // dump($entities);
            echo "<h3>Begriffe, die \"$tag\" enthalten</h3>";
            echo '<p>'.$listHtml.'</p>';
        }
        else {
            echo "<p>Keine Begriffe mit \"$tag\" gefunden.";
        }

        echo "<hr><p>Begriffe, bei denen \"Kategorie\" gesetzt ist</p>";
        echo '<p>'.$vm->getEntityLinkListByFieldValue('is_category', 'TRUE', "REX_LINK[id=1 output=id]").'</p>';
    }
  ?>