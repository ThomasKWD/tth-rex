<?php
    // !!! provide centralized name string base!
    $tagsTable = 'tth_tags';
    $tagsRelationTable = 'tth_begriff_tags';

    $sql = rex_sql::factory();

    $listQuery = "SELECT id, name FROM $tagsTable ORDER BY name ASC";
    $tagsArray = $sql->getArray($listQuery);

    // makes clickable List:
    $tm = new \kwd\tth\TableManager();

    if ($tagsArray && count($tagsArray)) {
        $html = $tm->makeLinkList($tagsArray, 'tag_id', 'name');
        echo $html;
    }

    if (rex_request('tag_id')) {
        $id = rex_escape(rex_request('tag_id','string'));
        // for($i=0; $<count($))
    }

    // best array_find function better than using array_filter which can not stop on find!
    //     function array_search_func(array $arr, $func)
    // {
    //     foreach ($arr as $key => $v)
    //         if ($func($v))
    //             return $key;

    //     return false;
    // }
?>