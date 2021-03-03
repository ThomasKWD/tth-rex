<?php
    $sql = rex_sql::factory();
    $query = "SELECT * from tth_glossar WHERE 1 ORDER BY wort ASC";
    $entries = $sql->getArray($query);
?>

<table class="table table-responsive">
    <?php
    foreach($entries as $e):
    ?>
    <tr>
        <td>
            <a id="<?=rex_escape($e['Anker'])?>"></a>
            <h4><?=$e['wort']?></h4>
        </td>
        <td>
            <p><?=$e['beschreibung']?></p>
        </td>
    </tr>
    <?php endforeach; ?>
</table>