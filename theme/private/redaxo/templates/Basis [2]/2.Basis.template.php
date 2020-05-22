<?php
    // $urlBase = rex_url::base();
    // Gibt eine URL im Ordner "theme/public/assets" zurück.
    // in contrast to yrewrite theme does not give trailing slash
    // $assetsUrlBase = theme_url::assets() .'/';
	// -- also there: theme_url::base()
	
	function convertGrobgliederungCallback($request) {
		$sourceField = 'grobgliederung';
		$sql = rex_sql::factory();
		$query = 'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE "%;%"';
		// $sql->setQuery($query);
		$rows = $sql->getArray($query);
		dump(count($rows));
		foreach($rows as $row) {
			echo '[' .$row['id'] . '] '.$row['begriff'] .': '.$row['grobgliederung'] .'<br>';
		}
	}	
	
	?><!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <link rel="icon" type="image/png" sizes="32x32" href="<?=theme_url::assets('mosaik_icon_32.png')?>">

    <title>LOCAL Demo MKB</title>

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
      <div class="container">
          <div class="header-login">
	    	</div>

        <div class="project-logo">
            <img class="logo-graphics" src="<?=theme_url::assets('tth-logo.png')?>" >
        </div>
        <div class="project-title">Technischer Thesaurus Holzbau (TTH)</div>

		<h1><?php echo $this->getValue('name')?></h1>
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
