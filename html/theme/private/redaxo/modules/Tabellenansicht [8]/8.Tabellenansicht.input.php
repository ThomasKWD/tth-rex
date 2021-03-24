Tabelle anzeigen:
<div class="rex-select-style">
<select id="REX_INPUT_VALUE[1]" name="REX_INPUT_VALUE[1]" class="form-control">
<?php

// ! key is convention of TableManager (= meta names as "subject" which are mapped to actual DB tables)
$tables = array(
	'authors' => 'Autoren',
	'states' => 'Begriffsstati',
	'sources' => 'Quellen',
	'regions' => 'Regionen',
	'languages' => 'Sprachen',
	'languagestyles' => 'Sprachstile'
);

$preSelected = 'REX_VALUE[1]';

foreach($tables as $key => $value) {
	echo "<option value='$key~$value' ".($preSelected == $key.'~'.$value ? " selected='selected'":"").">$value</option>\n";
}
?>
</select>
</div>