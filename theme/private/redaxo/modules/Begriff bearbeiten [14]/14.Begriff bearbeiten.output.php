<?php
// - check backend login
// - can be informed by template?

$yform = new rex_yform();
$yform->setObjectparams('form_name', 'table-tth_wortliste');
$yform->setObjectparams('form_action',rex_getUrl('REX_ARTICLE_ID'));
$yform->setObjectparams('form_ytemplate', 'bootstrap');
$yform->setObjectparams('form_showformafterupdate', 0);
$yform->setObjectparams('real_field_names', true);

$yform->setValueField('text', ['begriff','Begriff']);
$yform->setValueField('textarea', ['definition','Begriffsdefinition']);
$yform->setValueField('text', ['gnd','GND (Gemeinsame Normdatei)']);
$yform->setValueField('be_manager_relation', ['grobgliederung_beziehung','Beziehung Grobgliederung','tth_wortliste','begriff','3','1','','5','','tth_begriff_grobgliederung','','(PLUS öffnet ein neues Browser-Fenster, dort können mehrere Einträge übernommen werden) ']);
$yform->setValueField('be_manager_relation', ['tag_fuer_begriff','Schlagwörter','tth_tags','name','3','0','','3','','tth_begriff_tags']);
$yform->setValueField('be_manager_relation', ['autor_id','Autor','tth_autoren','vorname, \' \', name','0','0','Du musst einen Autor definieren!']);
$yform->setValueField('text', ['code','Begriffscode']);
$yform->setValueField('be_manager_relation', ['begriffsstatus_id','Begriffsstatus','tth_begriffsstati','status','0','1']);
$yform->setValueField('textarea', ['notes','Scope Notes']);
$yform->setValueField('be_media', ['bild','Bild(er) aus Medienpool','1','1','1']);
$yform->setValueField('be_manager_relation', ['benutze','Beziehung Benutze','tth_wortliste','begriff','2','1','','','','','','(PLUS öffnet ein neues Browser-Fenster, dort 1 Eintrag übernehmen) ']);
$yform->setValueField('be_manager_relation', ['beziehung_oberbegriffe','Oberbegriffe','tth_wortliste','begriff','3','1','','3','','tth_begriff_oberbegriffe','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)']);
$yform->setValueField('be_manager_relation', ['beziehung_unterbegriffe','Unterbegriffe','tth_wortliste','begriff','3','1','','7','','tth_begriff_unterbegriffe','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)']);
$yform->setValueField('be_manager_relation', ['beziehung_verwandte','Verwandte Begriffe','tth_wortliste','begriff','3','1','','5','','tth_begriff_verwandte','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)']);
$yform->setValueField('be_manager_relation', ['beziehung_aequivalente','Äquivalente Begriffe','tth_wortliste','begriff','3','1','','5','','tth_begriff_aequivalente','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)']);
$yform->setValueField('text', ['datierung','Datierung']);
$yform->setValueField('text', ['historischer_hintergrund','Historischer Hintergrund']);
$yform->setValueField('be_manager_relation', ['sprache_id','Sprache','tth_sprachen','sprache','0','0','Bitte eine Sprache auswählen!']);
$yform->setValueField('be_manager_relation', ['region_id','Region','tth_regionen','region','0','1']);
$yform->setValueField('be_manager_relation', ['sprachstil_id','Sprachstil','tth_sprachstile','stil','0','1']);
$yform->setValueField('choice', ['kategorie','Eigenschaft Kategorie','ja=TRUE,nein=FALSE','0','0','FALSE']);
$yform->setValueField('choice', ['veroeffentlichen','Veröffentlichen?','ja=TRUE,nein=FALSE','0','0','FALSE']);
$yform->setValueField('choice', ['bearbeiten','Noch Bearbeiten','ja=TRUE,nein=FALSE','0','0','FALSE']);

$yform->setActionField('tpl2email', ['emailtemplate', 'emaillabel', 'email@domain.de']);
echo $yform->getForm();