<?php
    // $urlBase = rex_url::base();
    // Gibt eine URL im Ordner "theme/public/assets" zurück.
    // in contrast to yrewrite theme does not give trailing slash
    // $assetsUrlBase = theme_url::assets() .'/';
	// -- also there: theme_url::base()
	
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
	// - cool thing: rex_config is *cached*
	$detailsArticleId = rex_config::get('tth', 'article_entity_details');
	if (!$detailsArticleId) {
		$detailsArticleId = 6;
		rex_config::set('tth','article_entity_details',$detailsArticleId);
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
	$wSearch = rex_request('wordlistsearch', 'string');
	if ($wSearch) {
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

	?><!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <link rel="icon" type="image/png" sizes="32x32" href="<?=theme_url::assets('tth-logo.png')?>">
    
	<link rel="stylesheet" href="<?=theme_url::assets('vendor/jquery.auto-complete.css')?>">
	<link rel="stylesheet" href="<?=theme_url::assets('global.css')?>?v=1.2.01">

    <title>TTH - <?=$this->getValue('name')?></title>

	<?php // rex var for cookie gedoens:  
			// R E X _ I W C C[]
			?>

    <!-- Matomo -->
<!-- End Matomo -->
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

			
			<form class="form-inline my-2 my-lg-0" action="<?=rex_getUrl('')?>" method="get">
			<input id="wordlistsearch" class="form-control mr-sm-2" name="wordlistsearch" type="search" placeholder="Wort(teil)" aria-label="Wort">
			<input type="hidden" id="article_id" name="article_id" value="<?=rex_article::getCurrent()->getId()?>">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Suchen</button>
			</form>
		</div>
	</nav>


	<div class="header-login">
		<?php
			// ! use later again 
			if ($login):
				echo "eingeloggt als: $login";
			else:
			?>
				<a href="./redaxo/">Login</a>
			<?php endif; ?>
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
		if ($wSearch):
		?>
		<div class="jumbotron">
			<h3><?php echo $searchResultList ? '' : '<strong>Keine</strong> '?>Ergebnisse für "<?=$wSearch?>"</h3>
			<p><?=$searchResultList?></p>
		</div>
		<?php endif; ?>
		<h1><?php echo $this->getValue('name')?></h1>

		<?php // ! convention every module must be aware to be inside the main container and should always provide rows and cols
			if ($isBlog):
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
						erstellt am <?=$blogCreateDate?>
						<?php 
							if ($blogCreateDate !== $blogUpdateDate) {
								echo ', zuletzt geändert am '. $blogUpdateDate;
							}
							?>
					</p>
				</div>
			<?php endif;?>
        REX_ARTICLE[]
		<?php if ($isBlog): 

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
			

			$query = "SELECT * FROM rex_blog_reply WHERE articleID = " . $this->getValue('article_id') ." ORDER BY `createdate` ASC";
			// $comments = $sql->getArray($query);
			$sql->setQuery($query);

			// while ($s)$commentRows
			$comments = array(); // as long as debug
			if ($sql->hasNext()):
			?>
			<div class="blog-comments">
				<h2>Kommentare</h2>

				<!-- bootstrap box? -->
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

			<?php endif;?>

			<?php
			if (rex_request('comment-preview', 'string')):
				$previewName = rex_escape(rex_request('comment-name', 'string'));
				$previewMail = rex_escape(rex_request('comment-mail', 'string'));
				$previewBody = rex_escape(rex_request('comment-body', 'string'));
			?>
			<h3>Vorschau</h3>
			<div class="comment-entry">
				<div class="comment-entry-header">
					<?=$previewName?>
					schrieb am <?=date('d.m.Y')?>:
				</div>
				<?=$previewBody?>
			</div>
			
			<form action=<?=rex_getUrl('')?> method="POST">		
				<button id="comment-edit" name="comment-edit" type="submit" class="btn btn-success mb-2">Noch einmal bearbeiten</button>
				<input id="comment-name" name="comment-name" type="hidden" value="<?=$previewName?>">
				<input id="comment-mail" name="comment-mail" type="hidden" value="<?=$previewMail?>">
				<?php // important that rex_escape used, esp. for body
				?>
				<input id="comment-blog" name="comment-body" type="hidden" value="<?=$previewBody?>">
				<input id="comment_anonymous_submit" type="submit" name="comment-submit" value="Absenden"  class="btn btn-danger mb-2"/>
				<!-- <input id="comment_login" type="submit" name="action" value="Anmelden und kommentieren" />	 -->
			</form>

			<?php 
				// else for: if comment-preview, means when NO PREVIEW
				elseif (rex_request('comment-submit','string')):
					// echo 'submit: ';
					// echo '; name:'.rex_request('comment-name','string');
					// echo '; mail:'.rex_request('comment-mail','string');
					// echo '; post:'.rex_request('comment-body','string');

					$post = rex_yform_manager_dataset::create('rex_blog_reply');
					// $post->setValue('name',rex_escape(rex_request('comment-name','string')));
					// // !!! mail not yet defined as field
					// // $post->mail = rex_request('comment-name','string');
					// $post->setValue('comment',rex_escape(rex_request('comment-body','string')));
					// $post->setValue('ycomCreateUser',0);
					// $post->setValue('articleID',$this->getValue('article_id'));
					// $post->setValue('parentReplyID',0);
					
					$post->name = rex_escape(rex_request('comment-name','string'));
					$post->comment = rex_escape(rex_request('comment-body','string'));
					$post->ycomCreateUser = 0;
					$post->articleID = $this->getValue('article_id');
					$post->parentReplyID = 0;
					
					if ($post->save()) {
						?>
						<div class="alert alert-success">
							Neuer Kommentar wurde gespeichert.
						</div>
						<a href="<?=rex_getUrl('')?>" class="btn btn-primary">Weiter</a>
						<?php
					} else {
						?>
						<div class="alert alert-danger">
							<?php echo implode('<br>', $post->getMessages()); ?>
						</div>
						<?php
					}
					
				else: 
			?>

			<div class="blog-add-comment">
			<!--
				!!!
				- add hidden box which then explains what anonymous or registered comment means with privacy notes...
				- also explains tah register is needed if user wants to edit or delete comment
				- otherwise mail to tth@kuehne-webdienste.de
				- the box appears on button click
				- the box must be always there when no JS
				- use bootstrap form markup rules
				- nicer: 2 tabs (bootstrap), not appearing until general "kommentieren" clicked
			-->
			<div id="comment-container" class="collapse">
				<div  class="card">
					<div class="card-body">
						<h5 class="card-title">Neuer Kommentar</h5>
						<form action=<?=rex_getUrl('')?> method="POST">

							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="comment-name">Name (beliebig):</label>
									<input type="text" class="form-control" name="comment-name" id="comment-name"/>
								</div>
								<div class="form-group col-md-6">
									<label for="comment-mail">E-Mail (freiwillig):</label>
									<input type="mail" class="form-control" id="comment-mail" name="comment-mail">
								</div>
							</div>

							<div class="form-group">
								<label for="comment-body">Text:</label>
								<textarea class="form-control" id="comment-body" name="comment-body" rows="5"></textarea>
							</div>

							<input id="comment_anonymous_preview" type="submit" name="comment-preview" value="Vorschau"/>
							<!-- <input id="comment_login" type="submit" name="action" value="Anmelden und kommentieren" />	 -->
						</form>
					</div>
				</div>
				<p></p>
				<!-- card has no margin?? -->
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Erläuterung</h5>
						<p>
							blups di bla
						</p>
					</div>
				</div>
			</div>
			<p>
				<button id="btn-comment" type="button" class="btn btn-outline-success" data-toggle="collapse" data-target="#comment-container" aria-expanded="false" aria-controls="collapseExample">Kommentar hinzufügen</button>
			</p>

			<?php 
				endif; // if (comment-preview)
			?>
		</div>
		<?php endif; ?>
    </div>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>

	<script src="<?=theme_url::assets('vendor/jquery.auto-complete.min.js')?>"></script>
	<!-- !!! not efficient because template output differs each call while JS code always the same EXCEPT WORDLIST-->
	<script>
		$(document).ready(function() {
			$('#wordlistsearch').autoComplete({
				minChars: 1,
				delay : 50,
				source: function(term, suggest){
					term = term.toLowerCase();
					var choices = [<?=$completeWordList?>];
					var matches = [];
					for (i=0; i<choices.length; i++)
						if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
					suggest(matches);
				}
			});
		});
	</script>
  </body>
</html>
