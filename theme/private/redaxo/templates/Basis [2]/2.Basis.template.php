<?php
    // $urlBase = rex_url::base();
    // Gibt eine URL im Ordner "theme/public/assets" zurück.
    // in contrast to yrewrite theme does not give trailing slash
    // $assetsUrlBase = theme_url::assets() .'/';
	// -- also there: theme_url::base()
	
	// !!! put into module or class, like callback for sources
	function convertCallback($request) {
		
		// !!! maybe better to use request and methods of objects inside
		// dump($request);

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
	
	?><!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <link rel="icon" type="image/png" sizes="32x32" href="<?=theme_url::assets('tth-icon-32.png')?>">
    
	<link rel="stylesheet" href="<?=theme_url::assets('global.css')?>">

    <title>TTH - <?=$this->getValue('name')?></title>

    <style>
        .header-login {
            text-align: right;
        }

    </style>
	<?php // rex var for cookie gedoens:  
			// R E X _ I W C C[]
			?>

    <!-- Matomo -->
<!-- End Matomo -->
  </head>
  <body>
		<nav class="main-nav">
			<?php
			$nav = rex_navigation::factory();
			// public function show($category_id = 0, $depth = 3, $open = false, $ignore_offlines = false)
			$nav->show(0,3,true,true);
			?>
		</nav>


      <div class="container main-container">
          <div class="header-login">
	    	</div>

        <div class="project-logo">
			<a href="<?=rex_getUrl(rex_article::getSiteStartArticle()->getId())?>">
				<img class="logo-graphics" src="<?=theme_url::assets('tth-logo.png')?>" >
				<span class="project-title">{{ProjektTitel}}</span>
			</a>
		</div>

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
  </body>
</html>
