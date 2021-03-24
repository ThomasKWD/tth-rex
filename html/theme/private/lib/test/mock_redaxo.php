<?php

class mock_rex_sql {

}

function mock_rex_getUrl($articleId = '', $cLang = '', $params = []) {
	$str = '/abfragen/';

	switch ($articleId) {
		case 5 : $str.='quellen/'; break;
		case 6 : $str.='quarks/'; break;
		case 7 : $str.='filter/'; break; 
		default: $str .= 'details/'; // assumed current page
	}

	if ($cLang) $str .= '/'.$cLang.'/';
	if (count($params)) {
		$str .= '?';
		foreach($params as $key => $val) {
			$str .= $key . '='.$val.'&';
		}
		$str = rtrim($str,'&');
	}

	return $str;
}
