<?php
$articleId = $class = $articleName =  $artOutput = "";

// Aktuelle Kategorie ermitteln und Artikel auslesen
$articles = rex_category::getCurrent()->getArticles();

// Prüfen ob das Ergebnis gefüllt ist
if (is_array($articles) && count($articles) > 0) {

    // Einzelne Artikel auslesen
    foreach ($articles as $article) {

        if ($article->isOnline()) {

            // Überspringen wenn aktueller Artikel gefunden. (auskommentieren)
            // if ( $article->getId() == 'REX_ARTICLE_ID') continue;

            // Aktive CSS-Classe festlegen
            $class = '';
            if ($article->getId() == 'REX_ARTICLE_ID') {
                $class = "active";
            }

            // Überspringen wenn Startartikel gefunden
            if ($article->isStartArticle()) continue;

            // ID des Artikels ermitteln
            $articleId = $article->getId();

            // Name des Artikels ermitteln
            $articleName = $article->getName();

            // Weitere Daten  der Metainfos können wie folgt abgerufen werden:
            // Beispiel für eine Meta-Info art_Image
            // $articleImage = $article->getValue("art_Image");

			// Ausgabe erstellen
			// !!! style not yet cool
            $artOutput .= '<li class="list-group-item ' . $class . '"><a class="list-group-item-action ' . $class . '" href="' . rex_getUrl($articleId) . '">' . $articleName . '</a></li>' . "\n";
            // $artOutput .= '<a class="list-group-item list-group-item-action ' . $class . '" href="' . rex_getUrl($articleId) . '">' . $articleName . '</a>' . "\n";
        }
    }

	// Ausgabe
	// !!! verwende bootstrap `list-group`, but don't forget `list-group-item` and `list-group-item-action`
	//     for the elements
    // echo '<ul class="catlist">' . $artOutput . '</ul>';
    echo '<ul class="list-group">' . $artOutput . '</ul>';
    unset($articles);
}