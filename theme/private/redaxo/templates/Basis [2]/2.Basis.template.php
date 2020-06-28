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

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

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
		?>
        REX_ARTICLE[]
		<?php 
		 ?>
    </div>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="<?=theme_url::assets('vendor/jquery.auto-complete.min.js')?>"></script>
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
