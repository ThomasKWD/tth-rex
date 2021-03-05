<?php
    // $urlBase = rex_url::base();
    // Gibt eine URL im Ordner "theme/public/assets" zurück.
    // in contrast to yrewrite theme does not give trailing slash
    // $assetsUrlBase = theme_url::assets() .'/';
	// -- also there: theme_url::base()

	// if (!function_exists('getPosted')) {
	// 	function getPosted($name) {
	// 		return rex_escape(rex_request($name,'string'));
	// 	}
	// }
	
	// !!! put into module or class, like callback for sources
	function convertCallback($request) {
		
		$formData = rex_request('FORM');
		$fieldFromForm = strtolower($formData['formular'][0]);
		
		switch ($fieldFromForm) {
			case 'nd_beleg quellen':
				$sourceField = 'quellen_idlist';
				$targetTable = 'tth_begriff_quellen';
				$targetIdField = 'quelle_id';
				break;
			case 'oberbegriffe':
				$sourceField = 'oberbegriffe';
				$targetTable = 'tth_begriff_oberbegriffe';
				$targetIdField = 'oberbegriff_id';
				break;
			case 'unterbegriffe':
				$sourceField = 'unterbegriffe';
				$targetTable = 'tth_begriff_unterbegriffe';
				$targetIdField = 'unterbegriff_id';
				break;
			case 'aequivalente begriffe':
				$sourceField = 'aequivalent';
				$targetTable = 'tth_begriff_aequivalente';
				$targetIdField = 'aequivalent_id';
				break;
			case 'verwandte begriffe':
				$sourceField = 'verwandte_begriffe';
				$targetTable = 'tth_begriff_verwandte';
				$targetIdField = 'verwandter_id';
				break;
			case 'grobgliederung':
				$sourceField = 'grobgliederung';
				$targetTable = 'tth_begriff_grobgliederung';
				$targetIdField = 'grobgliederung_id';
				break;
			default:
				$sourceField = '';
				$targetTable = '';
				$targetIdField = '';
			break;
		}
	
		// when 'default' -- can easily happen when form changed in structure content form module
		if ($sourceField) {
			// dump($sourceField);
			// dump($targetTable);
			// dump($targetIdField);

			// $sourceField = 'grobgliederung';
			// $sourceField = 'quellen_idlist';
			// $sourceField = 'oberbegriffe';
			// $targetTable = 'tth_begriff_grobgliederung';
			// $targetTable = 'tth_begriff_quellen';
			// $targetTable = 'tth_begriff_oberbegriffe';
			// $targetIdField = 'oberbegriff_id';
			$sql = rex_sql::factory();

				// $query = 'TRUNCATE '.$targetTable;
				// $sql->setQuery($query);
			
			// !!! for a new operation you must be sure the last one is ready (maybe asynch!!)

			// - begriff field only for control outputs
			$query = 'SELECT id,begriff,'.$sourceField.' FROM tth_wortliste WHERE 1';
			// $query = 'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE "%;%"';
			$rows = $sql->getArray($query);
			
			$insertList = '';
			$count = 0;
			$insertCount = 0;
			foreach($rows as $row) {
				if(trim($row[$sourceField])) {
					$count++;
					$nodes = explode(';',$row[$sourceField]);
					// - don't need NULL check for $nodes
					foreach($nodes as $node) {
						if (trim($node)) {
							$insertList .= '('.$row['id'].','.$node."),\n";
							$insertCount++;
						}
					}
				}
			}

			// remove last comma!
			$insertList = substr($insertList,0,strrpos($insertList,','));
			// dump($insertList);
			// echo $insertList;
			$query = 'INSERT INTO '.$targetTable.' (begriff_id, '.$targetIdField.') VALUES '.$insertList;
			echo '<h3>SQL-Befehl</h3><p>'.$query.'</p>';

			// $sql->setQuery($query);

			echo '<div class="alert alert-success" role="alert">
				<p>
				Quell-Feld: '.$fieldFromForm.'<br>
				Ziel-ID-Feld: '.$targetIdField.'<br>
				Betroffene Datensätze: '.$count.' von '.count($rows).'</p>
				<p>'.$insertCount.' Einträge in Tabelle <strong>'.$targetTable.'</strong> neu geschrieben (vorige Einträge bestehen weiterhin zusätzlich!).</p>
				</div>';
			echo '<div class="alert alert-warning" role="alert">
			<p>
			Der eigentliche Schreibvorgang ist aus Sicherheitsgründen <em>deaktiviert</em>. Die DB wurde nicht verändert.
			</p></div>';
		}
		else {
			echo '<div class="alert alert-primary" role="alert">
				<p>Ungültige Auswahl. Überprüfe das Eingabe-Formular!</p>
				</div>';
		}
	}

	
	// setup
	///////////////////////////////////////////////////////////////////////////////

	// ! sets 6 as default only if no config found
	// - will be stored and restored with DB export/import
	// - can be adjusted in installation (but where communicated to ther admins?)
	// - cool thing: rex_config is *cached*
	// !!! make utility function in theme lib
	// !!! make *module* "system settings" which can be used to adjust values (which are put to config on save)
	// !!! check how or if theme addon can produce backend pages for settings
	//     !!! easier to use project addon then! 
	$detailsArticleId = rex_config::get('tth', 'article_entity_details');
	if (!$detailsArticleId) {
		$detailsArticleId = 6;
		rex_config::set('tth','article_entity_details',$detailsArticleId);
	}

	$imprintArticleId = rex_config::get('tth', 'article_imprint');
	if (!$imprintArticleId) {
		$imprintArticleId = 19;
		rex_config::set('tth','article_imprint',$imprintArticleId);
	}

	// central search form PRE-send
	///////////////////////////////////////////////////////////////////////////////

	$sql = rex_sql::factory();
	$query = "SELECT begriff from tth_wortliste WHERE 1 ORDER BY begriff ASC";
	$rows = $sql->getArray($query);
	
	$completeWordList = '';
	foreach($rows as $k => $v) {
		$completeWordList .= '"'. $v['begriff'] .'", ';
	}

	// echo $completeWordList;

	// central search form EVALUATE-received
	///////////////////////////////////////////////////////////////////////////////

	// !!! go directly to details
	//     you can achieve this by sending ids? read more in autocomplete docs!!!
	// !!! just get action from searchfield *without YForm*	
	$wSearch = rex_escape(rex_request('wordlistsearch','string'));
	// *** disabled because testing code in module
	if ($wSearch && 0) {
		$searchPattern = rex_escape($wSearch);
		if ($searchPattern) {

			// !!! sanitize (e.g. only letters, underscore, space and *)

			// ! change pattern to always have PART of word when no *
			if (false === strpos($searchPattern,'*')) {
				$searchPattern = '*'.$searchPattern.'*';
			}
			
			$searchPattern = 
				str_replace("'","",
				str_replace("`","",
				str_replace('"','',
				str_replace("\n",'',
				str_replace(';','',
				$searchPattern
			)))));

			// !!! set article id by module param
			// $sql = rex_sql::factory();
			$query = "SELECT id,begriff from tth_wortliste WHERE begriff LIKE ".str_replace('*','%',$sql->escape($searchPattern));
			$rows = $sql->getArray($query);
			if ($rows && count($rows)) {
				$tm = new \kwd\tth\TableManager();
				$searchResultList = $tm->makeLinkList($rows, 'begriff_id', 'begriff', $detailsArticleId);
			}
			else {
				$searchResultList = '';
			}
		}
	}

	if (rex_backend_login::createUser()) {
		$user =  rex::getuser();
		$login = $user->getValue("login");
		if ($user->isAdmin()) {
			$userLevel = 3;
		}
		else {
			$userLevel = 2;
		}
	}
	else {
		$login = '';
		$user = null;
		$userLevel = 1;
	}

	function my_title_filter($ep) {
        // den aktuellen Inhalt auslesen
        $subject = $ep->getSubject();
		// // find "entity marker" (first match)
		if (preg_match('#{{{(.*?)}}}#u',$subject, $matches)) {
			// dump($matches);
		}

		if (isset( $matches[1]) && $matches[1]) {
			// not modifier 'U' but always '?' for ungreedy!
			return preg_replace('#<title>.*?</title>#iu','<title>'.$matches[1].' - TTH</title>',$subject);
		}
		else return $subject;
	}

	// FILTER
	// - currently title for entities
	rex_extension::register('OUTPUT_FILTER', 'my_title_filter', rex_extension::NORMAL);    

	?><!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<?php // tailwind cannot bring benefit to th styling in this project!
	// <!-- <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet"> -->
	?>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous"> -->

    <link rel="icon" type="image/png" sizes="32x32" href="<?=theme_url::assets('tth-logo.png')?>">
    
	<link rel="stylesheet" href="<?=theme_url::assets('vendor/jquery.auto-complete.css')?>">
	<link rel="stylesheet" href="<?=theme_url::assets('global.css')?>?v=1.3.01">

    <title><?=$this->getValue('name')?> - TTH</title>

  </head>
  <body>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<?php if(rex_article::getSiteStartArticle()->getId() !== rex_article::getCurrent()->getId()): ?>
			<a class="navbar-brand" href="<?=rex_getUrl(rex_article::getSiteStartArticle()->getId())?>"><img class="logo-graphics" src="<?=theme_url::assets('tth-logo.png')?>" alt="Logo mit übereinanderliegenden Buchstaben TTH, in Braun und Schwarz" width="55" height="55" > {{ProjektTitel}}</a>
			<?php endif; ?>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		    	<span class="navbar-toggler-icon"></span>
  			</button>

		  <div class="collapse navbar-collapse" id="navbarSupportedContent">

			<ul class="navbar-nav ml-auto">

				<?php
				$path = rex_article::getCurrent()->getPathAsArray();
				$path1 = ((!empty($path[0])) ? $path[0] : '');
				$path2 = ((!empty($path[1])) ? $path[1] : '');
				
					foreach (rex_category::getRootCategories() as $lev1) {
						if ($lev1->isOnline(true) && intval($lev1->getValue('cat_backenduser')) <= $userLevel) {
				
							// zweite Ebene, muss man schon fuer li wissen
							$lev1Size = sizeof($lev1->getChildren());

							$active = ($lev1->getId() == $path1) ? 'active' : '';
							$dropdown = ($lev1Size != "0") ? 'dropdown' : '';
							echo '<li class="nav-item '.$active.' '.$dropdown.'">';
							if ($dropdown) {
								echo '<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'.htmlspecialchars($lev1->getValue('catname')).'</a>';
							}
							else {
								echo '<a class="nav-link" href="'.$lev1->getUrl().'">'.htmlspecialchars($lev1->getValue('catname')).'</a>';
							}
				
							// Soll nur der jeweils aktive Kategoriebaum erscheinen?
							// Dann die folgende Zeile auskommentieren:
							// if ($lev1->getId() == $path1) {
				
							if ($lev1Size != "0") {
				
								// echo '<ul>';
								echo '<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">';
				
									foreach ($lev1->getChildren() as $lev2) {
										// !!! make function `checkUser($lev2->getValue('cat_backenduser'))`
										if ($lev2->isOnline(true)  && intval($lev2->getValue('cat_backenduser')) <= $userLevel ) {
				
											$active = ($lev2->getId() == $path2) ? 'active' : '';
											echo '<a class="dropdown-item '.$active.'" href="'.$lev2->getUrl().'">'.htmlspecialchars($lev2->getValue('catname')).'</a>';
										}
									}
				
								// echo '</ul>';
								echo '</div>';
				
							}
				
							// Soll nur der jeweils aktive Kategoriebaum erscheinen?
							// Dann die folgende Zeile auskommentieren:
							// }
				
							echo '</li>';
						}
					}
				

				// $nav = rex_navigation::factory();
				// // public function show($category_id = 0, $depth = 3, $open = false, $ignore_offlines = false)
				// $nav->show(0,3,true,true);
				?>
			</ul>

			
			<form name="searchForm" class="form-inline my-2 my-lg-0" action="<?=rex_getUrl($detailsArticleId)?>" method="get">
			<input id="wordlistsearch" class="form-control mr-sm-2" name="wordlistsearch" type="search" placeholder="Wort(teil)" aria-label="Wort">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Suchen</button>
			</form>
		</div>
	</nav>


	<div class="header-login">
		<?php
			// ! use later again 
			if ($login):
				echo "im Backend eingeloggt als: $login";

			// ! no else branch => redaxo login invisible
			// else:
			// 	<!-- <a href="/redaxo/">Login</a> -->
			endif;
		?>
	</div>

	<div class="container main-container">

		<!-- this only start page -->
		<?php 
		if (rex_article::getSiteStartArticle()->getId() === rex_article::getCurrent()->getId()): ?>
		<div class="project-logo">
			<!-- <a href="<?=rex_getUrl(rex_article::getSiteStartArticle()->getId())?>"> -->
				<img class="logo-graphics" src="<?=theme_url::assets('tth-logo.png')?>" >
				<span class="project-title">{{ProjektTitel}}</span>
			<!-- </a> -->
		</div>
		<?php endif; ?>

		<?php 
		// think about redirecting to a certain search page
		if ($wSearch && 0):
		?>
		<div class="jumbotron">
			<h3><?php echo $searchResultList ? '' : '<strong>Keine</strong> '?>Ergebnisse für "<?=$wSearch?>"</h3>
			<p><?=$searchResultList?></p>
		</div>
		<?php endif; ?>
		<h1><?php echo $this->getValue('name')?></h1>

		<?php 
			// ! convention every module must be aware to be inside the main container and should always provide rows and cols
			if ($isBlog):
				
				// !!! better compose template like in community demo or other modern redaxo demos
				//     - header + default content
				//     - blog stuff (commenting)
				//     - footer

				$art = rex_article::getCurrent();
				$sql = rex_sql::factory();
				$query = "SELECT id,name,login FROM rex_user WHERE login = \"" . $art->getValue('createuser') ."\"";
				$users = $sql->getArray($query);
				$blogUserName = rex_escape($users[0]['name']);
				$blogImgSrc = rex_media_manager::getUrl('blog_author','blogautor_'.strtolower($art->getValue('createuser')).'.jpg');
				// dump($blogImgSrc);

				setlocale(LC_TIME,'de_DE.utf8', 'de_DE@euro.utf8', 'de_DE.utf8', 'de.utf8','ge.utf8','german.utf8','German.utf8');
				$blogCreateDate = strftime("%e. %b. %Y", $art->getValue('createdate'));
				$blogUpdateDate = strftime("%e. %b. %Y", $art->getValue('updatedate') + 40);

				// !!! markup: use bootstrap media or box content styling for header or at least row/col so that 
				//             img floats as expected!
				//             -> also needed for name versus date because of mobile devices
				?>
				<div class="blog-header">
					<p>
						<img src="<?=$blogImgSrc?>">
						von <?=$blogUserName?>
					</p>
					<p class="blog-date">
						erstellt am <?php 
							echo $blogCreateDate;
							if ($blogCreateDate !== $blogUpdateDate) {
								echo ', zuletzt geändert am '. $blogUpdateDate;
							}
							?>
					</p>
				</div>
			<?php endif ?>

        REX_ARTICLE[]
		<a id="comment-success"></a>
		<?php 
		// !!! show comment function if admin logged in because not ready yet !!!
		if ($isBlog && ($userLevel >= 2)):
			// *** ! first init yform THEN show list
			$yform = new rex_yform();
			$yform->setObjectparams('form_name', 'table-rex_blog_reply');
			$yform->setObjectparams('form_action',rex_getUrl('REX_ARTICLE_ID'));
			$yform->setObjectparams('form_ytemplate', 'bootstrap');
			$yform->setObjectparams('form_showformafterupdate', 0);
			$yform->setObjectparams('real_field_names', true);

			// $yform->setObjectparams('getdata',1);
			// $yform->setObjectparams('main_where','id=3');
			$yform->setObjectparams('main_table','rex_blog_reply');

			$yform->setValueField('text', ['name','Name','','0','','']);
			$yform->setValueField('textarea', ['comment','Antworttext','','0','','']);
			// $yform->setValueField('email', ['mail','Email-Adresse von "anonymem" Nutzer','','0','','Freiwillig, Vorteile siehe in den <a href="#description-text" class="description-link">Erläuterungen</a>.']);

			// make it hidden fild works like this:
			$yform->setValueField('hidden', ['articleID','REX_ARTICLE_ID']); // ! value must be string here, else error, important when hard coded id used
			// ! and *NOT* like this:
			// $yform->setHiddenField('articleID','REX_ARTICLE_ID'); // ! is NOT dispatched to DB save but put into form

			$yform->setValueField('hidden', ['parentReplyID',0]);
			// $yform->setHiddenField('parentReplyID',123);

			// !!! must be set when yco mlogin possible in frontend
			// $yform->setValueField('be_manager_relation', ['ycomCreateUser','Benutzer (yCom)','rex_ycom_user','login, \', \',email','0','1','','1','','','','Es ist geplant, nur den Ersteller ändern zu lassen. (Kein extra "update user"), anonym=0 oder emptystring']);

			$yform->setValueField('datestamp', ['updatedate','Änderungsdatum','d.m.Y. H:i:s','0','0','1']);
			$yform->setValueField('datestamp', ['createdate','Erstellungsdatum','d.m.Y H:i:s','0','1','1']);
			// $yform->setValueField('hidden', array("createdate", 'datesstamp'));
			// $yform->setValueField('hidden', array("updatedate", "Max Muster"));

			$yform->setValueField('ip', ['createIP','IP-Adresse (eigene Routine besser)','0']);
			$yform->setValidateField('empty', ['name','Sie müssen einen Namen eingeben!!']);
			// $yform->setValueField('mediafile', ['portrait','Avatar','7000','.png,.jpg,.jpeg','','','0','3','Timm','Lade ein Bild von dir hoch']);

			// ! obviously you can define the validate fields here *without* having it selected in the yForm-backend-fields list
			$yform->setValidateField('empty', ['comment','Sie müssen einen Text eingeben!!']);

			// $yform->setActionField('tpl2email', ['emailtemplate', 'emaillabel', 'tth@kuehne-webdienste.de']);
			// action|db|tblname|[where(id=2)/main_where]
			$yform->setActionField('db',['rex_blog_reply']);

			$yform->setObjectparams('submit_btn_label','Kommentar hinzufügen');
			$yform->setObjectparams('form_action',rex_getUrl('') . '#comment-form');

			
			$yform->setValueField('checkbox', ['conditions_read','Ich habe die <a class="description-link" href="#description-text">Nutzungsbedingungen und Datenschutzhinweise</a> gelesen','0','0','','','no,yes']); // the no/yes has no effect...
			$yform->setValidateField('empty', ['conditions_read','Sie müssen bestätigen, dass Sie die Hinweise zur Kenntnis genommen haben.']);

			// ! the dummy parameter in URL causes page reload 
			//   - needed for form to display again
			//   - not invoked when URL just contains same page with jump marker
			$yform->setActionField('html',['<div class="alert alert-success">Ihr Kommentar wurde gespeichert.<br><a href="'.rex_getUrl('').'?d=1#comment-form">Noch ein Kommentar...</a></div>']);
			$formHtml = $yform->getForm();

			// !!! make styling via adding classes *template*
			//     e.g. margin bottom

			// *** end yform init 
			
			// if ($isBlog): 1

			// echo 'yorm test: ';
			// $items = rex_yform_manager_table::get('rex_blog_reply')->query()->find();
			// dump($items);
			// $testId = 2;
			// echo 'yorm auto save: (set url param "save" to 1!), for id: '. $testId;
			// if (rex_request('save','string') !== '') {
			// 	echo 'perform save... ';
			// 	$post = rex_yform_manager_dataset::get($testId, 'rex_blog_reply');
			// 	echo 'name: ' . $post->name;
			// 	echo ' nothing changed but updatedate!!';
			// 	// $post->text = '...';

			// 	if ($post->save()) { 
			// 		echo 'Gespeichert!';
			// 	} else {
			// 		echo implode('<br>', $post->getMessages());
			// 	}
			// }
			// !!! use class or fragment for *comment list code*
			//     - group by comment
			//     - make tree after fetch
			

			$query = "SELECT * FROM rex_blog_reply WHERE articleID = REX_ARTICLE_ID ORDER BY `createdate` ASC";
			// $comments = $sql->getArray($query);
			$sql->setQuery($query);

			// while ($s)$commentRows
			$comments = array(); // as long as debug
			if ($sql->hasNext()):
			?>
			<div class="blog-comments">
				<h2>Kommentare</h2>
				<?php
					$user_sql = rex_sql::factory();
					// foreach ($comments as $reply):
					while ($sql->hasNext()):
				?>
					<div class="comment-entry">
						<div class="comment-entry-header">
							<?php
							// get chosen name
							// $chosenName = trim(rex_escape($reply['name']));
							$chosenName = trim(rex_escape($sql->getValue('name')));
							if (!strlen($chosenName)) {
								// get name from ycom user when set
								// if ($reply['ycomCreateUser']) {
								if ($sql->getValue('ycomCreateUser')) {
									// !!! is result of user get in redaxo tricks easier (because only 1 row expected?)
									// Neue rex_sql Instanz
									// $user_sql->setQuery("SELECT name,firstname FROM " . rex::getTable('ycom_user') . " WHERE id = :id",  array(":id" => $reply['ycomCreateUser']));
									$user_sql->setQuery("SELECT name,firstname FROM " . rex::getTable('ycom_user') . " WHERE id = :id",  array(":id" => $sql->getValue('ycomCreateUser')));
									// Übergabe
									$chosenName = 
										rex_escape($user_sql->getValue('firstname')) . ' ' .
										rex_escape($user_sql->getValue('name'));
								}
							}
							echo $chosenName;
							?>
							schrieb am <?=date('d.m.Y', $sql->getDateTimeValue('createdate'))?>:
						</div>
						<?=rex_escape($sql->getValue('comment'))?>
					</div>
				<?php $sql->next(); endwhile; ?>
			</div>

			<?php endif; // has next
			?> 
			<a id="comment-form"></a>
			
			<h2>Kommentar hinzufügen</h2>

			<?php
				// ! the order of init and output is important to get 
				//   latest DB changes into list above
				echo $formHtml;
			?>
			<p>&nbsp;</p>
			<p><a class="description-link description-link-2 initially-hidden" href="#description-text">Hinweise anzeigen</a></p>
			<!-- card has no margin?? -->
			<!-- !!! must be shown on preview too -->
			<div class="card description-card">
				<a id="description-text"></a>
				<div class="card-body">
					<h5 class="card-title">Erläuterungen</h5>
					<p>
						Ihre IP-Adresse wird gespeichert.
					</p>
				</div>
			</div>
		</div>
				
		</div>
		<?php endif; // $isBlog???? ?>
    </div>

	<footer class="footer">
      <div class="container">
        <span class="footer-item text-muted"> 
		<?php 
			$mailAddress =  rex_config::get('phpmailer', 'from');
		?>
		<a href="mailto:<?=$mailAddress?>"><?=$mailAddress?></a></span>
        <span class="footer-item text-muted"><a href="<?=rex_getUrl($imprintArticleId)?>">Impressum</a></span>
      </div>
    </footer>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
	<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script> -->

	<script src="<?=theme_url::assets('vendor/jquery.auto-complete.min.js')?>"></script>
	<script>
		$(document).ready(function() {
			$('#wordlistsearch').autoComplete({
				minChars: 1,
				delay : 100,
				source: function(term, suggest){
					term = term.toLowerCase();
					var choices = [<?=$completeWordList?>];
					var matches = [];
					for (i=0; i<choices.length; i++)
						if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
					suggest(matches);
				},
				onSelect: function(event) {
					// !!! check if compat issues, then use document.getElementById('searchForm').submit();
					document.searchForm.submit();
				}
			});

			$('.description-link')
				.removeClass('initially-hidden')
				.click(function() {
					$('.description-card').show();
					$('.description-link-2').hide(); // don't want to hide all of them
					// return false;
				});

			$('.description-card').hide();
		});
	</script>
  </body>
</html>
