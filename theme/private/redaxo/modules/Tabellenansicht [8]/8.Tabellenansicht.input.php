Tabelle anzeigen:
<div class="rex-select-style">
<select id="REX_INPUT_VALUE[1]" name="REX_INPUT_VALUE[1]" class="form-control">
<?php
// ... don't like rex_select of MForm anymore

$tables = array(
	'Autoren',
	'Begriffsstati',
	'Quellen',
	'Regionen',
	'Sprachen',
	'Sprachstile'
);

$preSelected = 'REX_VALUE[1]';

foreach($tables as $t) {
	echo "<option value='$t' ".($preSelected == $t ? " selected='selected'":"").">$t</option>\n";
}
?>
</select>
</div>