<?php
// error_reporting(0);
error_reporting(E_ALL);
// Error report should only be active during development. Deavtivate (0) on a live website

$page_is_visible = true;

// Is current article offline?
if (rex_article::getCurrent()->isOnline() == 0) {
	$page_is_visible = false;
}

// is online_from_date newer than actual date?
if (rex_article::getCurrent()->getValue('art_online_from') && rex_article::getCurrent()->getValue('art_online_from') > time()) {
	$page_is_visible = false;
}

// is online_from_date older than actual date
if (rex_article::getCurrent()->getValue('art_online_to') && rex_article::getCurrent()->getValue('art_online_to') < time()) {
	$page_is_visible = false;
}


// Is User not logged in?
if (!rex_backend_login::hasSession()) {
	if ($page_is_visible == false) {
		// redirect to 404 page
		header ('HTTP/1.1 301 Moved Permanently');
		header('Location: '.rex_getUrl(rex_article::getNotFoundArticleId(), rex_clang::getCurrentId()));
		exit();
	}
}

// Necessary for input and output of module "Tabs und Akkordions"
rex::setProperty('tabs', new ArrayIterator());

// set charset to utf8
header('Content-Type: text/html; charset=utf-8');

// setLocale is a language meta field, set your individual locale informations per language
setlocale (LC_ALL, rex_clang::getCurrent()->getValue('clang_setlocale'));

?><!DOCTYPE html>
<html lang="<?php echo rex_clang::getCurrent()->getCode(); ?>">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<?php
	// Use article title as title-Tag, unless a custom title-tag is set
    if ($this->hasValue("art_title") && $this->getValue("art_title") != "") {
		$title = htmlspecialchars($this->getValue('art_title'));
	} else {
		$title = htmlspecialchars($this->getValue('name'));
	}

	echo '
	<title>'.$title.'</title>';

	// Keywords and description
	// If current article does not have keywords and description, take them from start article
	$keywords = "";
    if ($this->hasValue("art_keywords") && $this->getValue("art_keywords") != "") {
        $keywords = $this->getValue("art_keywords");
    } else {
        $home = new rex_article_content(rex_article::getSiteStartArticleId());
        if ($home->hasValue("art_keywords")) {
            $keywords = $home->getValue('art_keywords');
        }
    }

    $description = "";
    if ($this->hasValue("art_description") && $this->getValue("art_description") != "") {
        $description = $this->getValue("art_description");
    } else {
        $home = new rex_article_content(rex_article::getSiteStartArticleId());
        if ($home->hasValue("art_description")) {
            $description = $home->getValue('art_description');
        }
    }

	echo '
	<meta name="keywords" content="'.htmlspecialchars($keywords).'">';

	echo '
	<meta name="description" content="'.htmlspecialchars($description).'">';
	?>

	<link rel="stylesheet" href="<?= rex_url::base('resources/css/bootstrap.css') ?>">
	<link rel="stylesheet" href="<?= rex_url::base('resources/css/redaxo-demo.css') ?>">
	<link rel="stylesheet" href="<?= rex_url::base('resources/css/font-awesome.min.css') ?>">
	<link rel="stylesheet" href="<?= rex_url::base('resources/css/flexslider.css') ?>">
	<link rel="stylesheet" href="<?= rex_url::base('resources/css/menu.css') ?>">
	<link rel="stylesheet" href="<?= rex_url::base('resources/css/forms.css') ?>">
	<link rel="stylesheet" href="<?= rex_url::base('resources/css/prettify.css') ?>">

    <link rel="apple-touch-icon" sizes="180x180" href="<?= rex_url::base('resources/favicons/apple-touch-icon.png') ?>">
    <link rel="icon" type="image/png" sizes="32x32" href="<?= rex_url::base('resources/favicons/favicon-32x32.png') ?>">
    <link rel="icon" type="image/png" sizes="16x16" href="<?= rex_url::base('resources/favicons/favicon-16x16.png') ?>">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
