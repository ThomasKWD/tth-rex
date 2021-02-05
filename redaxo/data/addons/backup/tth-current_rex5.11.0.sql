## Redaxo Database Dump Version 5
## Prefix rex_
## charset utf8mb4

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `rex_action`;
CREATE TABLE `rex_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preview` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `presave` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postsave` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previewmode` tinyint(4) DEFAULT NULL,
  `presavemode` tinyint(4) DEFAULT NULL,
  `postsavemode` tinyint(4) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revision` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_article`;
CREATE TABLE `rex_article` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catpriority` int(10) unsigned NOT NULL,
  `startarticle` tinyint(1) NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `clang_id` int(10) unsigned NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revision` int(10) unsigned NOT NULL,
  `cat_backenduser` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `yrewrite_url_type` enum('AUTO','CUSTOM','REDIRECTION_INTERNAL','REDIRECTION_EXTERNAL') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AUTO',
  `yrewrite_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `yrewrite_redirection` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `yrewrite_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `yrewrite_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `yrewrite_changefreq` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `yrewrite_priority` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `yrewrite_index` tinyint(1) NOT NULL,
  `yrewrite_canonical_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ycom_auth_type` int(11) NOT NULL,
  `ycom_group_type` int(11) NOT NULL,
  `ycom_groups` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `find_articles` (`id`,`clang_id`),
  KEY `id` (`id`),
  KEY `clang_id` (`clang_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_article` WRITE;
/*!40000 ALTER TABLE `rex_article` DISABLE KEYS */;
INSERT INTO `rex_article` VALUES 
  (1,1,0,'Willkommen bei TTH','Start',1,1,1,'|',1,1,1,'2020-05-23 09:13:37','Thomas','2020-06-11 10:13:26','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (2,2,0,'Werkzeuge','Werkzeuge',3,1,1,'|',1,1,1,'2020-05-23 09:13:39','Thomas','2020-06-16 17:37:29','Thomas',0,'2','AUTO','','','','','','',0,'',0,0,''),
  (3,3,2,'Beziehungen neu konvertieren','Beziehungen',1,1,1,'|2|',1,1,1,'2020-05-23 09:13:45','Thomas','2020-05-23 16:42:00','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (4,4,0,'Abfragen','Abfragen',2,1,1,'|',1,1,1,'2020-05-23 19:57:49','Thomas','2020-05-25 11:49:35','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (5,5,4,'Wortteil suchen','Wortteil suchen',1,1,1,'|4|',1,1,1,'2020-05-23 21:25:14','Thomas','2020-06-26 15:16:37','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (6,6,4,'Detailansicht','Detailansicht',2,1,1,'|4|',1,1,1,'2020-05-23 21:25:15','Thomas','2020-05-26 11:05:31','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (7,7,4,'Alle Begriffe','Alle Begriffe',3,1,1,'|4|',1,1,1,'2020-05-25 11:48:10','Thomas','2020-06-13 17:46:31','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (8,8,4,'Quelle','Quelle',4,1,1,'|4|',1,1,1,'2020-06-04 11:33:07','Thomas','2020-06-11 11:46:04','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (9,9,4,'Übersichten','Übersichten',5,1,1,'|4|',1,1,1,'2020-06-04 11:36:44','Thomas','2020-05-28 10:52:54','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (10,10,2,'Quellen konvertieren','Quellen konvertieren',2,1,1,'|2|',1,1,1,'2020-06-10 22:29:38','Thomas','2020-06-16 17:31:19','Thomas',0,'3','AUTO','','','','','','',0,'',0,0,''),
  (11,11,4,'Neue Suche','Neue Suche',6,1,1,'|4|',0,1,1,'2020-06-12 12:06:13','Thomas','2020-06-12 12:06:13','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (12,12,0,'Tests','Tests',4,1,1,'|',0,1,1,'2020-10-22 19:29:48','Thomas','2020-06-24 22:01:51','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (13,13,0,'Blog','Blog',5,1,1,'|',1,1,1,'2020-10-22 19:18:26','Thomas','2020-10-23 13:40:16','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (15,15,13,'Wissensdatenbank ins Leben gerufen','Blog',0,0,2,'|13|',1,3,1,'2020-10-22 20:46:15','Thomas','2020-10-26 11:33:58','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (16,16,13,'2','Blog',0,0,3,'|13|',1,3,1,'2020-10-22 20:46:33','Thomas','2020-10-23 15:02:31','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (17,17,13,'4','Blog',0,0,4,'|13|',1,3,1,'2020-10-22 20:48:37','Thomas','2020-10-23 16:55:26','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (18,18,13,'Der Grundgedanke','Blog',0,0,5,'|13|',1,3,1,'2020-10-23 21:23:38','Timm','2020-10-23 21:24:22','Timm',0,'1','AUTO','','','','','','',0,'',0,0,''),
  (19,19,0,'Impressum','Impressum',6,1,1,'|',0,1,1,'2020-10-29 16:26:24','Thomas','2020-10-29 16:34:17','Thomas',0,'1','AUTO','','','','','','',0,'',0,0,'');
/*!40000 ALTER TABLE `rex_article` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_article_slice`;
CREATE TABLE `rex_article_slice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(10) unsigned NOT NULL,
  `clang_id` int(10) unsigned NOT NULL,
  `ctype_id` int(10) unsigned NOT NULL,
  `module_id` int(10) unsigned NOT NULL,
  `revision` int(11) NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `value1` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value2` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value3` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value4` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value5` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value6` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value7` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value8` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value9` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value10` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value11` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value12` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value13` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value14` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value15` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value16` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value17` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value18` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value19` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value20` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media5` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media6` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media7` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media8` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media9` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media10` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist1` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist2` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist3` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist4` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist5` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist6` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist7` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist8` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist9` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medialist10` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link1` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link2` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link3` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link4` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link5` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link6` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link7` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link8` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link9` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link10` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist1` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist2` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist3` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist4` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist5` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist6` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist7` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist8` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist9` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linklist10` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `slice_priority` (`article_id`,`priority`,`module_id`),
  KEY `clang_id` (`clang_id`),
  KEY `article_id` (`article_id`),
  KEY `find_slices` (`clang_id`,`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_article_slice` WRITE;
/*!40000 ALTER TABLE `rex_article_slice` DISABLE KEYS */;
INSERT INTO `rex_article_slice` VALUES 
  (1,1,1,1,2,0,2,1,'Dies ist ein internes Demo-Projekt. Für die Domain \"tth.kuehne-webdienste.de\" und alle hier sichtbaren Inhalte gelten [Impressum](https://www.kuehne-webdienste.de/index.php?article_id=2) und [Datenschutzerklärung](https://www.kuehne-webdienste.de/index.php?article_id=68) von KÜHNE-Webdienste.de.\r\n',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-22 16:42:21','Thomas','2020-05-22 16:46:01','Thomas'),
  (3,3,1,1,2,0,1,1,'Beziehungstabelle neu schreiben. Es kann nur eine Beziehung gleichzeitig konvertiert werden.\r\n',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-22 18:06:34','Thomas','2020-05-23 16:12:15','Thomas'),
  (4,3,1,1,1,0,3,1,'','','choice|fieldtype|zu konvertierende Spalte|Grobgliederung,ND_Beleg Quellen,Oberbegriffe,Unterbegriffe,Aequivalente Begriffe,Verwandte Begriffe\r\nsubmit|startconvert|Starte Konvertieren| convertnow\r\naction|callback|convertCallback','','','','0','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-22 18:13:33','Thomas','2020-05-23 16:27:31','Thomas'),
  (5,1,1,1,2,0,4,1,'## Ideen für Abfragen\r\n\r\n* [Alle Begriffe alphabetisch nach Anfangsbuchstaben gruppiert](redaxo://4)\r\n* [Suchfeld](redaxo://5)\r\n* [Ein Begriff alle Infos (IDs der Beziehungen müssen als Namen aufgelöst werden)](redaxo://6)\r\n* Ein Begriff alle Infos *mit Links*\r\n* Alle Begriffe für Kriterium aus anderer Tabelle z.B. alle eines Autors\r\n* Alle Begriffe für Beziehung, z.B. alle für eine Begriff, der eine bestimmte Grobgliederung ist\r\n\r\n## Werkzeuge\r\n\r\n* [Konvertieren einzelne n:m-Tabelle](redaxo://3)\r\n\r\n\r\n\r\n\r\n\r\n',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-23 08:56:13','Thomas','2020-05-25 21:12:18','Thomas'),
  (6,1,1,1,2,0,3,1,'Du musst dich [im Backend Redaxo einloggen](redaxo/), um Tabellen bearbeiten zu können.\r\n\r\nHier im Frontend gibt es nur die Ansichten und \"Abfragen\", die beliebig gestaltet werden können. Allerdings muss ich diese Ansichten programmieren und einrichten. Du kannst sie nicht selbst zusammenstellen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-23 08:58:35','Thomas','2020-05-23 08:58:35','Thomas'),
  (7,3,1,1,2,0,2,1,'<div class=\"alert alert-danger\" role=\"alert\">\r\n\r\nAlle  (semikolongetrennten) Originaldaten werden **hinzugefügt**. Das bedeutet, dass dadurch Dopplungen mit bereits eingegebenen und früheren Konvertierungen auftreten können. Dies wird im Gegensatz zu Datenverlust jedoch als das geringere Übel angesehen. \r\n\r\nBitte erstelle vorher ein Backup der DB!\r\n\r\n</div>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-23 16:15:44','Thomas','2020-05-23 16:42:00','Thomas'),
  (10,4,1,1,4,0,2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-23 20:28:07','Thomas','2020-05-23 20:28:07','Thomas'),
  (11,4,1,1,2,0,1,1,'Das sind besonders einfache Beispiele. Du musst dir vorstellen, dass hier \"alles\" möglich ist. Tabellen, Listen, laufende Texte, ...\r\n\r\nNur der Zeit-Aufwand und unsere Kreativität begrenzen es.\r\n\r\n## Nach Anfangsbuchstaben\r\n\r\nBis jetzt wird nicht vorab erkannt ob ein Buchstabe nicht vertreten ist. Ä,Ö,Ü und ß sind bei A,O,U und S eingeordnet (wobei es keinen Begriff mit ß am Anfang geben wird ;-)\r\n',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-23 20:28:22','Thomas','2020-05-25 11:40:34','Thomas'),
  (12,6,1,1,5,0,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-25 10:53:54','Thomas','2020-05-26 11:05:31','Thomas'),
  (14,7,1,1,3,0,3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-25 11:48:20','Thomas','2020-05-25 11:48:20','Thomas'),
  (15,7,1,1,2,0,1,1,'Alphabetische Gesamtliste. Auf Verlinkung habe ich aus Gründen der Übersicht verzichtet. Als Startpunkt eignet sich am besten die [Buchstabenliste](redaxo://4).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-25 11:48:58','Thomas','2020-05-25 21:10:18','Thomas'),
  (16,1,1,1,2,0,1,1,'<div class=\"alert alert-danger\">Artikelinhalte HIER nicht mehr editieren, nur noch online!!</div>\r\n<div class=\"alert alert-info\">Außer die tth_*-Tabellen. Sie werden noch einmal oder mehrmals übertragen.</div>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-26 10:48:43','Thomas','2020-06-11 10:13:26','Thomas'),
  (18,8,1,1,6,0,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-26 11:04:04','Thomas','2020-05-26 11:04:04','Thomas'),
  (21,5,1,1,7,0,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-26 14:45:02','Thomas','2020-05-26 15:20:34','Thomas'),
  (22,5,1,1,2,0,2,1,'Einfach in tth_view_list_param rein:\r\n\r\n* Liste nach Asuwahl\r\n* dabei alle M;glichkeiten einfach auflisten, erstmal ohne Dropdown\r\n* Trenne von View wo Eingabe eines Begriffes erforderlich (innere Beziehungen), dies koennte man in Detailansicht integrieren\r\n\r\nBsp:\r\n\r\nSprache: Deutsch | English | ... | nicht gesetzt\r\nSprachstil: Allgemein | ... | nicht gesetzt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-26 15:28:42','Thomas','2020-05-26 15:38:32','Thomas'),
  (23,9,1,1,8,0,3,1,'Quellen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-26 20:24:50','Thomas','2020-05-26 20:35:14','Thomas'),
  (24,9,1,1,8,0,2,1,'Autoren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-28 10:51:29','Thomas','2020-05-28 10:51:29','Thomas'),
  (25,9,1,1,8,0,4,1,'Sprachen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-28 10:51:43','Thomas','2020-05-28 10:52:23','Thomas'),
  (26,9,1,1,8,0,5,1,'Sprachstile',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-28 10:52:35','Thomas','2020-05-28 10:52:35','Thomas'),
  (27,9,1,1,8,0,6,1,'Regionen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-28 10:52:41','Thomas','2020-05-28 10:52:41','Thomas'),
  (28,9,1,1,8,0,1,1,'Begriffsstati',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-05-28 10:52:54','Thomas','2020-05-28 10:54:02','Thomas'),
  (29,10,1,1,9,0,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-06-10 22:24:33','Thomas','2020-06-10 22:24:33','Thomas'),
  (30,10,1,1,1,0,2,1,'','','submit|startconvert|Starte Quellen Konvertieren| convertnow\r\naction|callback|convertSourcesCallback','','','','0','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-06-10 22:29:17','Thomas','2020-06-10 22:29:17','Thomas'),
  (31,7,1,1,4,0,2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-06-13 17:46:31','Thomas','2020-06-13 17:46:31','Thomas'),
  (32,12,1,1,2,0,1,1,'Hier werden Teile getestet, welche nicht oder nur sehr umständlich durch user-sichtbare Ausgaben verifiziert werden können.\r\n\r\nCypress überprüft die Ausgaben.\r\n\r\nWenn nötig, wird ein eigenes Template dafür angelegt, um zu vermeiden, dass nur für die Tests weitere Module angelegt werden müssen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-06-24 22:00:38','Thomas','2020-06-24 22:01:51','Thomas'),
  (33,13,1,1,12,0,2,1,'Blog Startseite sollte nicht verändert werden!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-10-22 19:19:04','Thomas','2020-10-22 19:19:04','Thomas'),
  (34,13,1,1,13,0,3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-10-22 19:29:40','Thomas','2020-10-22 19:29:40','Thomas'),
  (36,15,1,1,2,0,1,1,'Die Idee zu diesem Projekt entstand durch die Bachelor-Arbeit *\"Erstellen eines\r\nkontrollierten Vokabulars in der Form eines Thesaurus zum Thema\r\n„Traditioneller Holzbau“\"* von Timm Miersch.\r\n\r\nDie dargestellten Begriffe und Definitionen stammen zunächst aus Fachbüchern über den Holzbau.\r\n\r\nDazu wurde eine grundlegende Datenbank für die Darstellung des Materials zunächst in \"Microsoft Access\", dann mit dem wissenschaftlichen Thesaurus-Werkzeug \"x-tree\" erstellt.\r\n\r\nSchon von Anfang an stand die zum wissenschaftlichen Thesaurus parallele Entwicklung einer öffentlichen verfügbaren Datenbank im Fokus des Autors, welche es einer breiten (Fach-)Öffentlichkeit erlauben soll, nicht nur Begriffe und Definitionen nachzuschlagen sondern auch die Inhalte bearbeiten zu können, ähnlich einem Wiki.\r\n\r\nSo soll durch die \"Schwarm-Intelligenz\" vieler Beitragenden das Wissen um die Begriffe des Holzbaus erweitert und aus ihrer wissenschaftlichen Abgeschlossenheit herausgelöst werden, um umgekehrt den Thesaurus selbst mit Wissen aus der (handwerklichen) Praxis zu ergänzen bzw. zu korrigieren.\r\n\r\nBei diesem Vorgang soll nicht zuletzt die Bewahrung von möglicherweise bald verlorenem, traditionellem Wissen im Vordgergrund stehen.\r\n\r\nDie öffentlichen Änderungen werden der redaktionellen Nacharbeit bedürfen.\r\n\r\nDie vorliegende Website erlaubt bis jetzt nur eine Ansicht der bestehenden Datenbank. Diese wurde dazu im SQL-Format neu erstellt und liegt somit in einem für weitere Systeme verarbeitbaren System vor. \r\n\r\nDazu wurden auch Werkzeuge für die Übertragung der Daten aus einfachen Tabellen oder CSV-Dateien erstellt.\r\n\r\nWerkzeuge für den automatischen Austausch zwischen dieser SQL-Datenbank und \"x-tree\" gibt es noch nicht. Sie bedürfen weiterer theoretischer Vorarbeit.\r\n\r\n***\r\nplane wie weiterführende Links und Quellenangaben angezeigt werden sollten. \r\n\r\nEs sollte wie bei \"Wikipedia\" eine festgelegte Struktur geben.\r\n\r\n*** \r\nverlinkung von Timm Miersch wenn online yrewrite installiert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-10-22 21:06:59','Thomas','2020-10-26 11:33:58','Thomas'),
  (37,13,1,1,12,0,1,1,'Blog test user:\r\nTomkien\r\nkuehnewebdienste@gmail.com\r\nCnbHwNsl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-10-23 13:40:16','Thomas','2020-10-23 13:40:16','Thomas'),
  (38,17,1,1,2,0,1,1,'sag bloß!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-10-23 16:55:26','Thomas','2020-10-23 16:55:26','Thomas'),
  (39,18,1,1,2,0,1,1,'Was ich dayu schon immer sagen wollte: Es geht los.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-10-23 21:24:17','Timm','2020-10-23 21:24:17','Timm');
/*!40000 ALTER TABLE `rex_article_slice` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_blog_reply`;
CREATE TABLE `rex_blog_reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `articleID` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `parentReplyID` int(11) DEFAULT NULL,
  `ycomCreateUser` int(11) NOT NULL,
  `updatedate` datetime NOT NULL,
  `createdate` datetime NOT NULL,
  `createIP` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `portrait` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_blog_reply` WRITE;
/*!40000 ALTER TABLE `rex_blog_reply` DISABLE KEYS */;
INSERT INTO `rex_blog_reply` VALUES 
  (1,'','Ich finde die Idee des Projektes toll!','','15',0,1,'2020-10-23 15:51:14','2020-10-23 00:00:00','',''),
  (3,'Frany Eising','Da bin ich aber gespannt. Glaube _nicht_, dass das eine *große* Sache wird.','','15',0,0,'2020-10-24 20:47:19','2020-10-24 19:39:17','',''),
  (19,'Conchita','Geht doch. Sag ich!','','15',0,0,'2020-10-25 21:48:40','2020-10-25 21:48:40','::1',''),
  (33,'ohne login','komm rein','','15',0,0,'2020-10-28 14:37:30','2020-10-28 14:37:18','::1',''),
  (34,'Easy Speedometer','eee','','15',0,0,'2020-10-28 14:45:20','2020-10-28 14:44:54','::1','localhost_5000__browser_debug_premium_galaxy_s5_.png');
/*!40000 ALTER TABLE `rex_blog_reply` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_clang`;
CREATE TABLE `rex_clang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL,
  `revision` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_clang` WRITE;
/*!40000 ALTER TABLE `rex_clang` DISABLE KEYS */;
INSERT INTO `rex_clang` VALUES 
  (1,'de','deutsch',1,1,0);
/*!40000 ALTER TABLE `rex_clang` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_config`;
CREATE TABLE `rex_config` (
  `namespace` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`namespace`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_config` WRITE;
/*!40000 ALTER TABLE `rex_config` DISABLE KEYS */;
INSERT INTO `rex_config` VALUES 
  ('be_style/customizer','codemirror','1'),
  ('be_style/customizer','codemirror_theme','\"eclipse\"'),
  ('be_style/customizer','codemirror-langs','0'),
  ('be_style/customizer','codemirror-selectors','\"\"'),
  ('be_style/customizer','codemirror-tools','0'),
  ('be_style/customizer','labelcolor','\"#3bb594\"'),
  ('be_style/customizer','showlink','1'),
  ('core','package-config','{\"backup\":{\"install\":true,\"status\":true},\"be_style\":{\"install\":true,\"status\":true,\"plugins\":{\"customizer\":{\"install\":true,\"status\":true},\"redaxo\":{\"install\":true,\"status\":true}}},\"cronjob\":{\"install\":true,\"status\":true,\"plugins\":{\"article_status\":{\"install\":false,\"status\":false},\"optimize_tables\":{\"install\":false,\"status\":false}}},\"debug\":{\"install\":false,\"status\":false},\"developer\":{\"install\":true,\"status\":true},\"install\":{\"install\":true,\"status\":true},\"markitup\":{\"install\":true,\"status\":true,\"plugins\":{\"documentation\":{\"install\":false,\"status\":false}}},\"media_manager\":{\"install\":true,\"status\":true},\"mediapool\":{\"install\":true,\"status\":true},\"metainfo\":{\"install\":true,\"status\":true},\"phpmailer\":{\"install\":true,\"status\":true},\"project\":{\"install\":true,\"status\":true},\"structure\":{\"install\":true,\"status\":true,\"plugins\":{\"content\":{\"install\":true,\"status\":true},\"history\":{\"install\":false,\"status\":false},\"version\":{\"install\":false,\"status\":false}}},\"theme\":{\"install\":true,\"status\":true},\"users\":{\"install\":true,\"status\":true},\"ycom\":{\"install\":true,\"status\":true,\"plugins\":{\"auth\":{\"install\":true,\"status\":true},\"docs\":{\"install\":true,\"status\":true},\"group\":{\"install\":true,\"status\":true},\"media_auth\":{\"install\":false,\"status\":false}}},\"yform\":{\"install\":true,\"status\":true,\"plugins\":{\"docs\":{\"install\":true,\"status\":true},\"email\":{\"install\":true,\"status\":true},\"manager\":{\"install\":true,\"status\":true},\"rest\":{\"install\":false,\"status\":false},\"tools\":{\"install\":false,\"status\":false}}},\"yrewrite\":{\"install\":true,\"status\":true}}'),
  ('core','package-order','[\"be_style\",\"be_style\\/customizer\",\"be_style\\/redaxo\",\"users\",\"backup\",\"cronjob\",\"developer\",\"install\",\"markitup\",\"media_manager\",\"mediapool\",\"phpmailer\",\"structure\",\"metainfo\",\"structure\\/content\",\"theme\",\"yform\",\"yform\\/docs\",\"yform\\/email\",\"yform\\/manager\",\"yrewrite\",\"ycom\",\"ycom\\/auth\",\"ycom\\/docs\",\"ycom\\/group\",\"project\"]'),
  ('core','utf8mb4','true'),
  ('core','version','\"5.11.0\"'),
  ('cronjob','nexttime','1604012400'),
  ('developer','actions','true'),
  ('developer','delete','true'),
  ('developer','dir_suffix','true'),
  ('developer','items','{\"templates\":{\"1\":1589972162},\"modules\":{\"1\":1},\"theme\\/private\\/redaxo\\/templates\":{\"1\":1603985611,\"2\":1604003270,\"3\":1603985624},\"theme\\/private\\/redaxo\\/modules\":{\"1\":1,\"2\":1590158291,\"3\":1590258100,\"4\":1592063136,\"5\":1593165618,\"6\":1593366438,\"7\":1593366438,\"8\":1593165618,\"9\":1591827935,\"10\":1593366438,\"12\":1603387432,\"13\":1603983106}}'),
  ('developer','modules','false'),
  ('developer','prefix','true'),
  ('developer','rename','true'),
  ('developer','sync_backend','true'),
  ('developer','sync_frontend','true'),
  ('developer','templates','false'),
  ('developer','umlauts','false'),
  ('media_manager','interlace','[\"jpg\"]'),
  ('media_manager','jpg_quality','80'),
  ('media_manager','png_compression','5'),
  ('media_manager','webp_quality','85'),
  ('phpmailer','archive','false'),
  ('phpmailer','bcc','\"\"'),
  ('phpmailer','charset','\"utf-8\"'),
  ('phpmailer','confirmto','\"\"'),
  ('phpmailer','detour_mode','false'),
  ('phpmailer','encoding','\"8bit\"'),
  ('phpmailer','errormail','0'),
  ('phpmailer','from','\"thomas@kuehne-webdienste.de\"'),
  ('phpmailer','fromname','\"Mailer\"'),
  ('phpmailer','host','\"cyberwebserver-07.de \"'),
  ('phpmailer','logging','2'),
  ('phpmailer','mailer','\"smtp\"'),
  ('phpmailer','password','\"Xx98xr_5\"'),
  ('phpmailer','port','587'),
  ('phpmailer','priority','0'),
  ('phpmailer','security_mode','false'),
  ('phpmailer','smtp_debug','0'),
  ('phpmailer','smtpauth','true'),
  ('phpmailer','smtpsecure','\"tls\"'),
  ('phpmailer','test_address','\"tth@kuehne-webdienste.de\"'),
  ('phpmailer','username','\"tth@kuehne-webdienste.de\"'),
  ('phpmailer','wordwrap','120'),
  ('theme','include_be_files','false'),
  ('theme','synchronize_actions','false'),
  ('theme','synchronize_modules','true'),
  ('theme','synchronize_templates','true'),
  ('tth','article_entity_details','6'),
  ('tth','article_imprint','19'),
  ('ycom','auth_cookie_ttl','\"14\"'),
  ('ycom','login_field','\"email\"'),
  ('ycom/auth','article_id_jump_denied','0'),
  ('ycom/auth','article_id_jump_logout','0'),
  ('ycom/auth','article_id_jump_not_ok','0'),
  ('ycom/auth','article_id_jump_ok','0'),
  ('ycom/auth','article_id_jump_password','0'),
  ('ycom/auth','article_id_jump_termsofuse','0'),
  ('ycom/auth','article_id_login','0'),
  ('ycom/auth','article_id_logout','0'),
  ('ycom/auth','article_id_password','0'),
  ('ycom/auth','article_id_register','0'),
  ('ycom/auth','auth_cookie_ttl','7'),
  ('ycom/auth','auth_rule','\"login_try_10_pause\"'),
  ('ycom/auth','login_field','\"id\"'),
  ('yrewrite','unicode_urls','false'),
  ('yrewrite','yrewrite_hide_url_block','false');
/*!40000 ALTER TABLE `rex_config` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_cronjob`;
CREATE TABLE `rex_cronjob` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interval` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `nexttime` datetime DEFAULT NULL,
  `environment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `execution_moment` tinyint(1) NOT NULL,
  `execution_start` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_cronjob` WRITE;
/*!40000 ALTER TABLE `rex_cronjob` DISABLE KEYS */;
INSERT INTO `rex_cronjob` VALUES 
  (1,'Täglich 1x wenn eingeloggt','wird beim ersten Login des Tages ausgeführt','rex_cronjob_export','{\"rex_cronjob_export_filename\":\"%REX_SERVER_%Y%m%d_%H%M_rex%REX_VERSION\",\"rex_cronjob_export_blacklist_tables\":null,\"rex_cronjob_export_sendmail\":null,\"rex_cronjob_export_mailaddress\":\"\",\"rex_cronjob_export_delete_interval\":\"YW\"}','{\"minutes\":[0],\"hours\":[0],\"days\":\"all\",\"weekdays\":\"all\",\"months\":\"all\"}','2021-02-06 00:00:00','|backend|',0,'0000-00-00 00:00:00',1,'2020-05-20 12:58:22','Thomas','2020-05-20 12:58:22','Thomas');
/*!40000 ALTER TABLE `rex_cronjob` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_markitup_profiles`;
CREATE TABLE `rex_markitup_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `urltype` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `minheight` smallint(5) unsigned NOT NULL,
  `maxheight` smallint(5) unsigned NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `markitup_buttons` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_markitup_profiles` WRITE;
/*!40000 ALTER TABLE `rex_markitup_profiles` DISABLE KEYS */;
INSERT INTO `rex_markitup_profiles` VALUES 
  (1,'textile_full','Standard MarkItUp-Konfiguration','relative',300,800,'textile','bold,code,clips[Snippetname1=Snippettext1|Snippetname2=Snippettext2],deleted,emaillink,externallink,groupheading[1|2|3|4|5|6],grouplink[file|internal|external|mailto],heading1,heading2,heading3,heading4,heading5,heading6,internallink,italic,media,medialink,orderedlist,paragraph,quote,sub,sup,table,underline,unorderedlist'),
  (2,'markdown_full','Standard MarkItUp-Konfiguration','relative',300,800,'markdown','bold,code,clips[Snippetname1=Snippettext1|Snippetname2=Snippettext2],deleted,emaillink,externallink,groupheading[1|2|3|4|5|6],grouplink[file|internal|external|mailto],heading1,heading2,heading3,heading4,heading5,heading6,internallink,italic,media,medialink,orderedlist,paragraph,quote,sub,sup,table,underline,unorderedlist');
/*!40000 ALTER TABLE `rex_markitup_profiles` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_markitup_snippets`;
CREATE TABLE `rex_markitup_snippets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_media`;
CREATE TABLE `rex_media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `attributes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filetype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `originalname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filesize` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `width` int(10) unsigned DEFAULT NULL,
  `height` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revision` int(10) unsigned NOT NULL,
  `med_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_media` WRITE;
/*!40000 ALTER TABLE `rex_media` DISABLE KEYS */;
INSERT INTO `rex_media` VALUES 
  (1,0,NULL,'image/jpeg','values.jpg','values.jpg','379357',1920,1080,'Screenshot Werte','2020-05-23 21:08:53','Thomas','2020-05-23 21:08:53','Thomas',0,NULL),
  (3,2,NULL,'image/jpeg','blogautor_thomas.jpg','blogautor_thomas.jpg','122776',1044,1397,'Thomas Kühne','2020-10-23 10:42:08','Thomas','2020-10-23 10:42:08','Thomas',0,''),
  (4,2,NULL,'image/jpeg','blogautor_timm.jpg','blogautor_timm.jpg','323028',1445,1759,'Timm Miersch','2020-10-23 21:21:36','Thomas','2020-10-23 21:22:29','Thomas',0,''),
  (5,3,NULL,'image/png','localhost_5000__browser_debug_premium_galaxy_s5_.png','localhost_5000__browser&debug&premium(Galaxy S5).png','177029',1080,1920,'','2020-10-28 14:45:06','Timm','2020-10-28 14:45:06','Timm',0,NULL),
  (6,3,NULL,'image/jpeg','components-icon.jpg','components-icon.jpg','915',61,37,'','2020-10-28 14:48:48','Timm','2020-10-28 14:48:48','Timm',0,NULL),
  (7,3,NULL,'image/jpeg','alarm-edit.jpg','alarm-edit.jpg','27136',1080,507,'','2020-10-28 14:49:35','Timm','2020-10-28 14:49:35','Timm',0,NULL),
  (8,3,NULL,'image/jpeg','components-icon-lines.jpg','components-icon-lines.jpg','42509',538,455,'','2020-10-28 14:50:24','Timm','2020-10-28 14:50:24','Timm',0,NULL);
/*!40000 ALTER TABLE `rex_media` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_media_category`;
CREATE TABLE `rex_media_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revision` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_media_category` WRITE;
/*!40000 ALTER TABLE `rex_media_category` DISABLE KEYS */;
INSERT INTO `rex_media_category` VALUES 
  (1,'tth',0,'|','2020-05-23 21:08:08','Thomas','2020-05-23 21:08:08','Thomas',NULL,0),
  (2,'Blogautoren',0,'|','2020-10-23 10:38:36','Thomas','2020-10-23 10:38:36','Thomas',NULL,0),
  (3,'uploads',0,'|','2020-10-28 14:41:37','Thomas','2020-10-28 14:41:37','Thomas',NULL,0);
/*!40000 ALTER TABLE `rex_media_category` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_media_manager_type`;
CREATE TABLE `rex_media_manager_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_media_manager_type` WRITE;
/*!40000 ALTER TABLE `rex_media_manager_type` DISABLE KEYS */;
INSERT INTO `rex_media_manager_type` VALUES 
  (1,1,'rex_mediapool_detail','Zur Darstellung von Bildern in der Detailansicht im Medienpool','2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (2,1,'rex_mediapool_maximized','Zur Darstellung von Bildern im Medienpool wenn maximiert','2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (3,1,'rex_mediapool_preview','Zur Darstellung der Vorschaubilder im Medienpool','2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (4,1,'rex_mediabutton_preview','Zur Darstellung der Vorschaubilder in REX_MEDIA_BUTTON[]s','2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (5,1,'rex_medialistbutton_preview','Zur Darstellung der Vorschaubilder in REX_MEDIALIST_BUTTON[]s','2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (6,0,'tth_horizontal_list','preserves aspect ratio, keeps same height','2020-05-25 17:48:15','Thomas','2020-05-25 18:00:50','Thomas'),
  (7,0,'blog_author','Quadratisches profilebild (wird geschnitten)','2020-10-23 10:43:22','Thomas','2020-10-23 10:50:44','Thomas');
/*!40000 ALTER TABLE `rex_media_manager_type` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_media_manager_type_effect`;
CREATE TABLE `rex_media_manager_type_effect` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(10) unsigned NOT NULL,
  `effect` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_media_manager_type_effect` WRITE;
/*!40000 ALTER TABLE `rex_media_manager_type_effect` DISABLE KEYS */;
INSERT INTO `rex_media_manager_type_effect` VALUES 
  (1,1,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"200\",\"rex_effect_resize_height\":\"200\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (2,2,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"600\",\"rex_effect_resize_height\":\"600\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (3,3,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"80\",\"rex_effect_resize_height\":\"80\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (4,4,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"246\",\"rex_effect_resize_height\":\"246\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (5,5,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"246\",\"rex_effect_resize_height\":\"246\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2020-10-21 18:01:47','Thomas','2020-10-21 18:01:47','Thomas'),
  (6,6,'resize','{\"rex_effect_rounded_corners\":{\"rex_effect_rounded_corners_topleft\":\"\",\"rex_effect_rounded_corners_topright\":\"\",\"rex_effect_rounded_corners_bottomleft\":\"\",\"rex_effect_rounded_corners_bottomright\":\"\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"},\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_rotate\":{\"rex_effect_rotate_rotate\":\"0\"},\"rex_effect_filter_colorize\":{\"rex_effect_filter_colorize_filter_r\":\"\",\"rex_effect_filter_colorize_filter_g\":\"\",\"rex_effect_filter_colorize_filter_b\":\"\"},\"rex_effect_image_properties\":{\"rex_effect_image_properties_jpg_quality\":\"\",\"rex_effect_image_properties_png_compression\":\"\",\"rex_effect_image_properties_webp_quality\":\"\",\"rex_effect_image_properties_interlace\":null},\"rex_effect_filter_brightness\":{\"rex_effect_filter_brightness_brightness\":\"\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_filter_contrast\":{\"rex_effect_filter_contrast_contrast\":\"\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"\",\"rex_effect_resize_height\":\"100\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_repeats\":\"10\",\"rex_effect_filter_blur_type\":\"gaussian\",\"rex_effect_filter_blur_smoothit\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\",\"rex_effect_header_filename\":\"filename\"},\"rex_effect_convert2img\":{\"rex_effect_convert2img_convert_to\":\"jpg\",\"rex_effect_convert2img_density\":\"150\",\"rex_effect_convert2img_color\":\"\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"}}',1,'2020-05-25 17:48:40','Thomas','2020-05-25 18:00:50','Thomas'),
  (7,7,'resize','{\"rex_effect_rounded_corners\":{\"rex_effect_rounded_corners_topleft\":\"\",\"rex_effect_rounded_corners_topright\":\"\",\"rex_effect_rounded_corners_bottomleft\":\"\",\"rex_effect_rounded_corners_bottomright\":\"\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"},\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_rotate\":{\"rex_effect_rotate_rotate\":\"0\"},\"rex_effect_filter_colorize\":{\"rex_effect_filter_colorize_filter_r\":\"\",\"rex_effect_filter_colorize_filter_g\":\"\",\"rex_effect_filter_colorize_filter_b\":\"\"},\"rex_effect_image_properties\":{\"rex_effect_image_properties_jpg_quality\":\"\",\"rex_effect_image_properties_png_compression\":\"\",\"rex_effect_image_properties_webp_quality\":\"\",\"rex_effect_image_properties_interlace\":null},\"rex_effect_filter_brightness\":{\"rex_effect_filter_brightness_brightness\":\"\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_filter_contrast\":{\"rex_effect_filter_contrast_contrast\":\"\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"100\",\"rex_effect_resize_height\":\"100\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_repeats\":\"10\",\"rex_effect_filter_blur_type\":\"gaussian\",\"rex_effect_filter_blur_smoothit\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_opacity\":\"100\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\",\"rex_effect_header_filename\":\"filename\"},\"rex_effect_convert2img\":{\"rex_effect_convert2img_convert_to\":\"jpg\",\"rex_effect_convert2img_density\":\"150\",\"rex_effect_convert2img_color\":\"\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"}}',1,'2020-10-23 10:44:51','Thomas','2020-10-23 10:44:51','Thomas'),
  (8,7,'crop','{\"rex_effect_rounded_corners\":{\"rex_effect_rounded_corners_topleft\":\"\",\"rex_effect_rounded_corners_topright\":\"\",\"rex_effect_rounded_corners_bottomleft\":\"\",\"rex_effect_rounded_corners_bottomright\":\"\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"},\"rex_effect_crop\":{\"rex_effect_crop_width\":\"100\",\"rex_effect_crop_height\":\"100\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_rotate\":{\"rex_effect_rotate_rotate\":\"0\"},\"rex_effect_filter_colorize\":{\"rex_effect_filter_colorize_filter_r\":\"\",\"rex_effect_filter_colorize_filter_g\":\"\",\"rex_effect_filter_colorize_filter_b\":\"\"},\"rex_effect_image_properties\":{\"rex_effect_image_properties_jpg_quality\":\"\",\"rex_effect_image_properties_png_compression\":\"\",\"rex_effect_image_properties_webp_quality\":\"\",\"rex_effect_image_properties_interlace\":null},\"rex_effect_filter_brightness\":{\"rex_effect_filter_brightness_brightness\":\"\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_filter_contrast\":{\"rex_effect_filter_contrast_contrast\":\"\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_repeats\":\"10\",\"rex_effect_filter_blur_type\":\"gaussian\",\"rex_effect_filter_blur_smoothit\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_opacity\":\"100\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\",\"rex_effect_header_filename\":\"filename\"},\"rex_effect_convert2img\":{\"rex_effect_convert2img_convert_to\":\"jpg\",\"rex_effect_convert2img_density\":\"150\",\"rex_effect_convert2img_color\":\"\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"}}',2,'2020-10-23 10:45:05','Thomas','2020-10-23 10:45:05','Thomas');
/*!40000 ALTER TABLE `rex_media_manager_type_effect` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_metainfo_field`;
CREATE TABLE `rex_metainfo_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` int(10) unsigned NOT NULL,
  `attributes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  `default` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `params` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validate` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `callback` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `restrictions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `templates` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_metainfo_field` WRITE;
/*!40000 ALTER TABLE `rex_metainfo_field` DISABLE KEYS */;
INSERT INTO `rex_metainfo_field` VALUES 
  (1,'Beschreibung','med_description',1,'',2,'','height=5',NULL,'',NULL,NULL,'2020-06-16 17:23:25','Thomas','2020-06-16 17:24:17','Thomas'),
  (2,'Sichtbarkeit für','cat_backenduser',1,'',3,'1','1:Alle|2:Redakteur|3:Admin',NULL,'',NULL,NULL,'2020-06-16 17:27:47','Thomas','2020-06-16 17:27:47','Thomas');
/*!40000 ALTER TABLE `rex_metainfo_field` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_metainfo_type`;
CREATE TABLE `rex_metainfo_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dbtype` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dblength` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_metainfo_type` WRITE;
/*!40000 ALTER TABLE `rex_metainfo_type` DISABLE KEYS */;
INSERT INTO `rex_metainfo_type` VALUES 
  (1,'text','text',0),
  (2,'textarea','text',0),
  (3,'select','varchar',255),
  (4,'radio','varchar',255),
  (5,'checkbox','varchar',255),
  (6,'REX_MEDIA_WIDGET','varchar',255),
  (7,'REX_MEDIALIST_WIDGET','text',0),
  (8,'REX_LINK_WIDGET','varchar',255),
  (9,'REX_LINKLIST_WIDGET','text',0),
  (10,'date','text',0),
  (11,'datetime','text',0),
  (12,'legend','text',0),
  (13,'time','text',0);
/*!40000 ALTER TABLE `rex_metainfo_type` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_module`;
CREATE TABLE `rex_module` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `output` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `input` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revision` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_module` WRITE;
/*!40000 ALTER TABLE `rex_module` DISABLE KEYS */;
INSERT INTO `rex_module` VALUES 
  (1,NULL,'YForm Formbuilder','<?php\n\n/**\n * yform.\n *\n * @author jan.kristinus[at]redaxo[dot]org Jan Kristinus\n * @author <a href=\"http://www.yakamara.de\">www.yakamara.de</a>\n */\n\n// module:yform_basic_output\n// v1.1\n//--------------------------------------------------------------------------------\n\n$yform = new rex_yform();\nif (\'REX_VALUE[7]\' == 1) {\n    $yform->setDebug(true);\n}\n$form_data = \'REX_VALUE[id=3 output=html]\';\n$form_data = trim(rex_yform::unhtmlentities($form_data));\n$yform->setObjectparams(\'form_action\', rex_getUrl(REX_ARTICLE_ID, REX_CLANG_ID));\n$yform->setFormData($form_data);\n\n// action - showtext\nif (\'REX_VALUE[id=6]\' != \'\') {\n    $html = \'0\'; // plaintext\n    if (\'REX_VALUE[11]\' == 1) {\n        $html = \'1\'; // html\n    }\n\n    $e3 = \'\';\n    $e4 = \'\';\n    if ($html == \'0\') {\n        $e3 = \'<div class=\"alert alert-success\">\';\n        $e4 = \'</div>\';\n    }\n\n    $t = str_replace(\'<br />\', \'\', rex_yform::unhtmlentities(\'REX_VALUE[6]\'));\n    $yform->setActionField(\'showtext\', [$t, $e3, $e4, $html]);\n}\n\n$form_type = \'REX_VALUE[1]\';\n\n// action - email\nif ($form_type == \'1\' || $form_type == \'2\') {\n    $mail_from = (\'REX_VALUE[2]\' != \'\') ? \'REX_VALUE[2]\' : rex::getErrorEmail();\n    $mail_to = (\'REX_VALUE[12]\' != \'\') ? \'REX_VALUE[12]\' : rex::getErrorEmail();\n    $mail_subject = \'REX_VALUE[4]\';\n    $mail_body = str_replace(\'<br />\', \'\', rex_yform::unhtmlentities(\'REX_VALUE[5]\'));\n    $yform->setActionField(\'email\', [$mail_from, $mail_to, $mail_subject, $mail_body]);\n}\n\n// action - db\nif ($form_type == \'0\' || $form_type == \'2\') {\n    $yform->setObjectparams(\'main_table\', \'REX_VALUE[8]\');\n\n    if (\'REX_VALUE[10]\' != \'\') {\n        $yform->setObjectparams(\'getdata\', true);\n    }\n\n    $yform->setActionField(\'db\', [\'REX_VALUE[8]\', $yform->objparams[\'main_where\']]);\n}\n\necho $yform->getForm();\n','<?php\n\n/**\n * yform\n * @author jan.kristinus[at]redaxo[dot]org Jan Kristinus\n * @author <a href=\"http://www.yakamara.de\">www.yakamara.de</a>\n */\n\n// module:yform_basic_input\n// v1.1\n// --------------------------------------------------------------------------------\n\n// DEBUG SELECT\n////////////////////////////////////////////////////////////////////////////////\n$dbg_sel = new rex_select();\n$dbg_sel->setName(\'REX_INPUT_VALUE[7]\');\n$dbg_sel->setAttribute(\'class\', \'form-control\');\n$dbg_sel->addOption(\'inaktiv\',\'0\');\n$dbg_sel->addOption(\'aktiv\',\'1\');\n$dbg_sel->setSelected(\'REX_VALUE[7]\');\n$dbg_sel = $dbg_sel->get();\n\n\n// TABLE SELECT\n////////////////////////////////////////////////////////////////////////////////\n$gc = rex_sql::factory();\n$gc->setQuery(\'SHOW TABLES\');\n$tables = $gc->getArray();\n$tbl_sel = new rex_select();\n$tbl_sel->setName(\'REX_INPUT_VALUE[8]\');\n$tbl_sel->setAttribute(\'class\', \'form-control\');\n$tbl_sel->addOption(\'Keine Tabelle ausgewählt\', \'\');\nforeach ($tables as $key => $value) {\n  $tbl_sel->addOption(current($value), current($value));\n}\n$tbl_sel->setSelected(\'REX_VALUE[8]\');\n$tbl_sel = $tbl_sel->get();\n\n\n// PLACEHOLDERS\n////////////////////////////////////////////////////////////////////////////////\n$yform = new rex_yform;\n$form_data = \'REX_VALUE[3]\';\n$form_data = trim(str_replace(\'<br />\',\'\',rex_yform::unhtmlentities($form_data)));\n$yform->setFormData($form_data);\n$yform->setRedaxoVars(REX_ARTICLE_ID,REX_CLANG_ID);\n$placeholders = \'\';\nif(\'REX_VALUE[3]\'!=\'\') {\n  $ignores = array(\'html\',\'validate\',\'action\');\n  $placeholders .= \'\n        <div id=\"yform-js-formbuilder-placeholders\">\n            <h3>Platzhalter: <span>[<a href=\"#\" id=\"yform-js-formbuilder-placeholders-help-toggler\">?</a>]</span></h3>\'.PHP_EOL;\n  foreach($yform->objparams[\'form_elements\'] as $e) {\n    if(!in_array($e[0],$ignores) && isset($e[1])) {\n      $label = (isset($e[2]) && $e[2] != \'\') ? $e[2] . \': \' : \'\';\n      $placeholders .= \'<code>\' . $label . \'###\'.$e[1].\'###</code> \'.PHP_EOL;\n    }\n  }\n  $placeholders .= \'\n            <ul id=\"yform-js-formbuilder-placeholders-help\">\n                <li>Die Platzhalter ergeben sich aus den obenstehenden Felddefinitionen.</li>\n                <li>Per Klick können einzelne Platzhalter in den Mail-Body kopiert werden.</li>\n                <li>Aktualisierung der Platzhalter erfolgt über die Aktualisierung des Moduls.</li>\n            </ul>\n        </div>\'.PHP_EOL;\n}\n\n\n// OTHERS\n////////////////////////////////////////////////////////////////////////////////\n$row_pad = 1;\n\n$sel = \'REX_VALUE[1]\';\n$db_display   = ($sel==\'\' || $sel==1) ?\' style=\"display:none\"\':\'\';\n$mail_display = ($sel==\'\' || $sel==0) ?\' style=\"display:none\"\':\'\';\n\n?>\n\n<div id=\"yform-formbuilder\">\n  <fieldset class=\"form-horizontal\">\n    <legend>Formular</legend>\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label text-left\">Debug Modus</label>\n      <div class=\"col-md-10\">\n        <div class=\"yform-select-style\">\n          <?= $dbg_sel; ?>\n        </div>\n      </div>\n    </div>\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\" for=\"yform-formbuilder-definition\">Felddefinitionen</label>\n      <div class=\"col-md-10\">\n        <textarea class=\"form-control\" style=\"font-family: monospace;\" id=\"yform-formbuilder-definition\" name=\"REX_INPUT_VALUE[3]\" rows=\"<?php echo (count(explode(\"\\r\",\'REX_VALUE[3]\'))+$row_pad);?>\">REX_VALUE[3]</textarea>\n      </div>\n    </div>\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Verfügbare Feldklassen</label>\n      <div class=\"col-md-10\">\n        <div id=\"yform-formbuilder-classes-showhelp\"><?= rex_yform::showHelp(); ?></div>\n      </div>\n    </div>\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Meldung bei erfolgreichen Versand</label>\n      <div class=\"col-md-10\">\n        <label class=\"radio-inline\">\n          <input type=\"radio\" name=\"REX_INPUT_VALUE[11]\" value=\"0\"<?php if(\"REX_VALUE[11]\" == \'0\') echo \' checked\'; ?> /> Plaintext\n        </label>\n        <label class=\"radio-inline\">\n          <input type=\"radio\" name=\"REX_INPUT_VALUE[11]\" value=\"1\"<?php if(\"REX_VALUE[11]\" == \'1\') echo \' checked\'; ?> /> HTML\n        </label>\n      </div>\n      <div class=\"col-md-offset-2 col-md-10\">\n        <textarea class=\"form-control\" name=\"REX_INPUT_VALUE[6]\" rows=\"<?php echo (count(explode(\"\\r\",\'REX_VALUE[6]\'))+$row_pad);?>\">REX_VALUE[6]</textarea>\n      </div>\n    </div>\n  </fieldset>\n\n  <fieldset class=\"form-horizontal\">\n    <legend>Vordefinierte Aktionen</legend>\n\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Bei Submit</label>\n      <div class=\"col-md-10\">\n        <div class=\"yform-select-style\">\n          <select class=\"form-control\" id=\"yform-js-formbuilder-action-select\" name=\"REX_INPUT_VALUE[1]\" size=\"1\">\n            <option value=\"\"<?php if(\"REX_VALUE[1]\" == \"\")  echo \" selected \"; ?>>Nichts machen (actions im Formular definieren)</option>\n            <option value=\"0\"<?php if(\"REX_VALUE[1]\" == \"0\") echo \" selected \"; ?>>Nur in Datenbank speichern</option>\n            <option value=\"1\"<?php if(\"REX_VALUE[1]\" == \"1\") echo \" selected \"; ?>>Nur E-Mail versenden</option>\n            <option value=\"2\"<?php if(\"REX_VALUE[1]\" == \"2\") echo \" selected \"; ?>>E-Mail versenden und in Datenbank speichern</option>\n          </select>\n        </div>\n      </div>\n    </div>\n  </fieldset>\n\n  <fieldset class=\"form-horizontal\" id=\"yform-js-formbuilder-mail-fieldset\"<?php echo $mail_display;?> >\n    <legend>E-Mail-Versand:</legend>\n\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Absender</label>\n      <div class=\"col-md-10\">\n        <input class=\"form-control\" type=\"text\" name=\"REX_INPUT_VALUE[2]\" value=\"REX_VALUE[2]\" />\n      </div>\n    </div>\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Empfänger</label>\n      <div class=\"col-md-10\">\n        <input class=\"form-control\" type=\"text\" name=\"REX_INPUT_VALUE[12]\" value=\"REX_VALUE[12]\" />\n      </div>\n    </div>\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Subject</label>\n      <div class=\"col-md-10\">\n        <input class=\"form-control\" type=\"text\" name=\"REX_INPUT_VALUE[4]\" value=\"REX_VALUE[4]\" />\n      </div>\n    </div>\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Mailbody</label>\n      <div class=\"col-md-10\">\n        <textarea class=\"form-control\" id=\"yform-js-formbuilder-mail-body\" name=\"REX_INPUT_VALUE[5]\" rows=\"<?php echo (count(explode(\"\\r\",\'REX_VALUE[5]\'))+$row_pad);?>\">REX_VALUE[5]</textarea>\n        <div class=\"help-block\">\n          <?php echo $placeholders;?>\n        </div>\n      </div>\n    </div>\n\n  </fieldset>\n\n  <fieldset class=\"form-horizontal\" id=\"yform-js-formbuilder-db-fieldset\"<?php echo $db_display;?> >\n    <legend>Datenbank Einstellungen</legend>\n\n    <div class=\"form-group\">\n      <label class=\"col-md-2 control-label\">Tabelle wählen <span>[<a href=\"#\" id=\"yform-js-formbuilder-db-help-toggler\">?</a>]</span></label>\n      <div class=\"col-md-10\">\n        <div class=\"yform-select-style\">\n          <?= $tbl_sel; ?>\n        </div>\n        <div class=\"help-block\">\n          <ul id=\"yform-js-formbuilder-db-help\">\n            <li>Hier werden die Daten des Formular hineingespeichert</li>\n          </ul>\n        </div>\n      </div>\n    </div>\n  </fieldset>\n\n</div>\n\n<p id=\"yform-formbuilder-info\"><?=  rex_addon::get(\'yform\')->getName() . \' \' . rex_addon::get(\'yform\')->getVersion() ?></p>\n\n<script type=\"text/javascript\">\n  <!--\n  (function($){\n\n    // AUTOGROW BY ROWS\n    $(\'#yform-formbuilder textarea\').keyup(function(){\n      var rows = $(this).val().split(/\\r?\\n|\\r/).length + <?php echo $row_pad;?>;\n      $(this).attr(\'rows\',rows);\n    });\n\n    // TOGGLERS\n    $(\'#yform-js-formbuilder-placeholders-help-toggler\').click(function(e){\n      e.preventDefault();\n      $(\'#yform-js-formbuilder-placeholders-help\').toggle(50);return false;\n    });\n    $(\'#yform-js-formbuilder-where-help-toggler\').click(function(e){\n      e.preventDefault();\n      $(\'#yform-js-formbuilder-where-help\').toggle(50);return false;\n    });\n    $(\'#yform-js-formbuilder-db-help-toggler\').click(function(e){\n      e.preventDefault();\n      $(\'#yform-js-formbuilder-db-help\').toggle(50);return false;\n    });\n\n\n    // INSERT PLACEHOLDERS\n    $(\'#yform-js-formbuilder-placeholders code\').click(function(){\n      newval = $(\'#yform-js-formbuilder-mail-body\').val()+\' \'+$(this).html();\n      $(\'#yform-js-formbuilder-mail-body\').val(newval);\n      $(this).addClass(\'text-muted\');\n    });\n\n    // TOGGLE MAIL/DB PANELS\n    $(\'#yform-js-formbuilder-action-select\').change(function(){\n      switch($(this).val()){\n        case \'\':\n          $(\'#yform-js-formbuilder-db-fieldset\').hide(0);\n          $(\'#yform-js-formbuilder-mail-fieldset\').hide(0);\n          break;\n        case \'1\':\n          $(\'#yform-js-formbuilder-db-fieldset\').hide(0);\n          $(\'#yform-js-formbuilder-mail-fieldset\').show(0);\n          break;\n        case \'0\':\n          $(\'#yform-js-formbuilder-db-fieldset\').show(0);\n          $(\'#yform-js-formbuilder-mail-fieldset\').hide(0);\n          break;\n        case \'2\':\n        case \'3\':\n          $(\'#yform-js-formbuilder-db-fieldset\').show(0);\n          $(\'#yform-js-formbuilder-mail-fieldset\').show(0);\n          break;\n      }\n    });\n\n  })(jQuery)\n  //-->\n</script>\n','0000-00-00 00:00:00','','0000-00-00 00:00:00','',NULL,0),
  (2,'text_markdown','Textabschnitt','<?php\r\n  echo markitup::parseOutput (\'markdown\', \'REX_VALUE[id=1 output=\"html\"]\');\r\n?>','<fieldset class=\"form-horizontal\">\r\n  <div class=\"form-group\">\r\n    <label class=\"col-sm-2 control-label\" for=\"value-1\">VALUE 1</label>\r\n    <div class=\"col-sm-10\">\r\n      <textarea class=\"form-control markitupEditor-markdown_full\" id=\"value-1\" name=\"REX_INPUT_VALUE[1]\">REX_VALUE[1]</textarea>\r\n    </div>\r\n  </div>\r\n</fieldset>','2020-05-22 16:37:28','Thomas','2020-05-22 16:38:11','Thomas',NULL,0),
  (3,'tth_view_list','Listenausgabe','<?php\r\n// - just hard code all you need for the list\r\n// - use rex_pager\r\n\r\n$sql = rex_sql::factory();\r\n\r\n// !!! set offset and limit by pager (depends on usage of pager, if i had an own pager i would store the last if of the last query??)\r\n\r\n// ! you must not rely on order in DB even if currently ordered alphabetically in table\r\n// ! the idea is that there never be more than about 3000 entries (because older versions of begriff (modification history) are seldom used in overview\r\n$query = \'SELECT begriff FROM tth_wortliste WHERE 1 ORDER BY begriff\';\r\n// $query = \'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE \"%;%\"\';\r\n$rows = $sql->getArray($query);\r\n$i = 1;\r\n$count = count($rows);\r\nforeach($rows as $r) {\r\n	echo $r[\'begriff\'];\r\n	if ($i < $count) echo \', \';\r\n	$i++;\r\n}\r\n?>.','Keine Einstellungen. Einfach Hinzufügen','2020-05-23 19:21:51','Thomas','2020-05-23 20:21:40','Thomas',NULL,0),
  (4,'tth_view_list_letter','Liste nach Anfangsbuchstaben','<p>\r\n<a id=\"marker-letters\"></a>\r\n<?php\r\n// - just hard code all you need for the list\r\n// - even target page id\r\n$targetArticleId = 6;\r\n// !!! make things dynamic later (e.g. via rex_config)\r\n\r\nfor($i = 0; $i <= 25; $i++ ) {\r\n	$letter = chr($i+65);\r\n	if (23 !== $i && 24 !== $i) {\r\n		echo \'<a href=\"\'.rex_getUrl(\'\',\'\',array( \'startletter\' => $letter)).\'#marker-letters\" class=\"btn btn-primary\">\'.$letter.\'</a> \';\r\n	}\r\n}\r\n\r\n$startLetter = rex_request(\'startletter\');\r\nif ($startLetter) {\r\n	$startLetter = strtoupper($startLetter);\r\n	// dump($startLetter);\r\n	$sql = rex_sql::factory();\r\n\r\n	$query = \'SELECT id, begriff FROM tth_wortliste WHERE begriff LIKE \"\'.$startLetter.\'%\" ORDER BY begriff ASC\';\r\n	// $query = \'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE \"%;%\"\';\r\n	$rows = $sql->getArray($query);\r\n	$i = 1;\r\n	$count = count($rows);\r\n	foreach($rows as $r) {\r\n		echo \'<a href=\"\'.rex_getUrl($targetArticleId,\'\',array( \'begriff_id\' => $r[\'id\'])).\'\">\';\r\n		echo $r[\'begriff\'];\r\n		echo \'</a>\';\r\n		if ($i < $count) echo \', \';\r\n		$i++;\r\n	}\r\n}\r\n?>\r\n</p>','','2020-05-23 20:27:10','Thomas','2020-06-13 17:45:36','Thomas',NULL,0),
  (5,'tth_view_item','Detailansicht','<!-- you will need to use bootstrap rows/cols -->\r\n<div class=\"row detailed-view\">\r\n	<div class=\"col\">\r\n<?php\r\n	$tm = new \\kwd\\tth\\TableManager();\r\n\r\n	$id = rex_request(\'begriff_id\',\'int\');\r\n	if ($id) {\r\n		$sourcesArticleId = \'REX_LINK[id=1 output=id]\';\r\n		if (!$sourcesArticleId) $sourcesArticleId = \'REX_ARTICLE_ID\';\r\n\r\n		$tableEntities = \'tth_wortliste\';\r\n		$tableAuthors = \'tth_autoren\';\r\n		$tableStati = \'tth_begriffsstati\';\r\n		$tableLanguage = \'tth_sprachen\';\r\n		$tableRegions = \'tth_regionen\';\r\n		$tableStyles = \'tth_sprachstile\';\r\n\r\n		$tableSources = \'tth_quellen\'; // needed for resolving names in $tableReferences\r\n		// $tableRelationSources = \'tth_begriff_quellen\';\r\n		$tableReferences = \'tth_quellenangaben\';\r\n		\r\n		$sql = rex_sql::factory();\r\n\r\n		// idea: make combi-query via alias names for other self-relations of tth_wortlise\r\n		// or maybe using other join commands here\r\n		$synonymsQuery = \"SELECT t1.id,t1.begriff from $tableEntities t1 WHERE t1.benutze=$id\";\r\n		$synonyms = $sql->getArray($synonymsQuery);\r\n		// references list\r\n		$query = \"SELECT r.id, r.quelle_id, r.seitenzahl, r.bevorzugt, s.kurz \"; //s.kurz\r\n		$query.= \"FROM $tableReferences r \";\r\n		$query.= \"JOIN $tableSources s ON r.quelle_id = s.id \";\r\n		// $query.= \"JOIN $tableSources ON $tableSources.id = $tableRelationSources.quelle_id \";\r\n		$query.= \"WHERE r.begriff_id=$id ORDER BY r.id ASC\";\r\n\r\n		$sourcesArray = $sql->getArray($query);\r\n		\r\n		// ! b is first alias for $tableEntities, b2 is the second for benutze\r\n		$query = \"SELECT b.begriff,b.id,$tableAuthors.gnd,b.quelle_seite,b.code,b.definition,b.bild,$tableStati.status,b.notes,b.benutze,b.kategorie,b.veroeffentlichen,b.bearbeiten,\";\r\n		$query .= \"b2.begriff AS benutze_begriff,CONCAT($tableAuthors.vorname, \' \', $tableAuthors.name) AS autor,\";\r\n		$query .= \"$tableLanguage.sprache AS sprache,\";\r\n		$query .= \"$tableRegions.region AS region, \";\r\n		$query .= \"$tableStyles.stil AS sprachstil \";\r\n		$query .= \"FROM $tableEntities b \";\r\n		$query .= \"LEFT JOIN $tableAuthors ON b.autor_id = $tableAuthors.id \";\r\n		$query .= \"LEFT JOIN $tableStati ON b.begriffsstatus_id = $tableStati.id \";\r\n		$query .= \"LEFT JOIN $tableLanguage ON b.sprache_id = $tableLanguage.id \";\r\n		$query .= \"LEFT JOIN $tableRegions ON b.region_id = $tableRegions.id \";\r\n		$query .= \"LEFT JOIN $tableStyles ON b.sprachstil_id = $tableStyles.id \";\r\n		$query .= \"LEFT JOIN $tableEntities b2 ON b2.id = b.benutze WHERE b.id=$id\";\r\n		\r\n		$rows = $sql->getArray($query);\r\n		if ($rows && count($rows)) {\r\n			$r = $rows[0];\r\n			\r\n			$html = \"<h2>${r[\"begriff\"]}</h2>\\n\";\r\n\r\n			$html .= \'<table class=\"table table-responsive\">\';\r\n\r\n			// make header line of table\r\n			$html .= \'<thead><tr><th>Feld</th><th>Inhalt</th></thead>\';\r\n			\r\n			// $html .= $tm->makeRow(\'ID\', $r[\'id\']);\r\n			$html .= $tm->makeRow(\'Definition\', $r[\'definition\']);\r\n			\r\n			$html .= $tm->makeRow(\'Sprache\', $r[\'sprache\']);\r\n			$html .= $tm->makeRow(\'Sprachstil\', $r[\'sprachstil\']);\r\n			$html .= $tm->makeRow(\'Region\', ($r[\'region\']) ? $r[\'region\'] : \"\");\r\n			$html .= $tm->makeRow(\'Begriffcode\', $r[\'code\']);\r\n			$html .= $tm->makeRow(\'Begriffs-Status\',$r[\'status\']);\r\n			// ! redaxo file list is *comma* separated\r\n			if ($r[\'bild\']) {\r\n				// ! separator \',\' is determined by redaxo\r\n				$images = explode(\',\',$r[\'bild\']);\r\n				$imgHTML = \'\';\r\n				foreach ($images as $img) {\r\n					$imgHTML .= \'<img src=\"index.php?rex_media_type=tth_horizontal_list&rex_media_file=\'.$img.\'\">\';\r\n				}\r\n				$html .= $tm->makeRow(\'Bilder\',$imgHTML);\r\n			}\r\n			\r\n			$html .= $tm->makeRow(\r\n				\'Grobgliederung\',\r\n				$tm->getInnerRelationLinkList($sql, \'structuring\', $id)\r\n			);\r\n			\r\n			// ! first link\r\n			$html .= $tm->makeRow(\'Synonym von (Benutze)\',$tm->getLink(\'begriff_id\', $r[\'benutze\'], $r[\'benutze_begriff\']).\'<br><small>dies ist der Desriptor und damit Name der <em>Äquivalenzklasse</em></small>\');\r\n			\r\n			// ! needs 5/6 extra queries because of n:m-self relations\r\n			$syns = \'\';\r\n			foreach($synonyms as $s) {\r\n				$syns .= $tm->getLink(\'begriff_id\', $s[\'id\'],$s[\'begriff\']).\', \';\r\n			}\r\n			\r\n			// !!! use small def from Bootstrap\r\n			$html .= $tm->makeRow(\'Deskriptor von (Benutzt für)\',$syns.\'<br><small>diese sind zusammen mit dem Begriff \"\'.$r[\'begriff\'].\'\" selbst die <em>Äquivalenzklasse</em></small>\');\r\n			\r\n			$html .= $tm->makeRow(\r\n				\'Oberbegriffe\',\r\n				$tm->getInnerRelationLinkList($sql, \'supers\', $id)\r\n			);\r\n			\r\n			$html .= $tm->makeRow(\r\n				\'Unterbegriffe\',\r\n				$tm->getInnerRelationLinkList($sql, \'subs\', $id)\r\n			);\r\n			\r\n			$html .= $tm->makeRow(\r\n				\'Äquivalente Begriffe\',\r\n				$tm->getInnerRelationLinkList($sql, \'equivalents\', $id)\r\n			);\r\n			\r\n			$html .= $tm->makeRow(\r\n				\'Verwandte Begriffe\',\r\n				$tm->getInnerRelationLinkList($sql, \'relatives\', $id)\r\n			);\r\n\r\n			if ($r[\'quelle_seite\']) $html .= $tm->makeRow(\'Seite in Quelle\',$r[\'quelle_seite\']);\r\n			\r\n			// $html .= $tm->makeRow(\'Quellen\',$tm->makeLinkList($sourcesArray, \'quelle_id\', \'kurz\', $sourcesArticleId));\r\n\r\n			$html .= $tm->makeRow(\'Scoped Notes\',$r[\'notes\']);\r\n			$html .= $tm->makeRow(\'Kategorie\',$tm->checkTruthyWord($r[\'kategorie\']));\r\n			$html .= $tm->makeRow(\'Veröffentlichen?\',$tm->checkTruthyWord($r[\'veroeffentlichen\']));\r\n			$html .= $tm->makeRow(\'Noch bearbeiten\',$tm->checkTruthyWord($r[\'bearbeiten\']));\r\n	\r\n			$authorText = \'\';\r\n			// ! the `if` is important because the SQL may still returen the first entry of tth_autoren for some reason when autor_id=\'\'  ! whole data set not returned when no author; need 0 clause in inner join\r\n			if ($r[\'autor\']) { // is a generated value; and is NULL when not set\r\n				$authorText .= $r[\'autor\'];\r\n				// !!! provide link for GND (see code in details of \"Quelle\")\r\n				if (trim($r[\'gnd\'])) $authorText .= \' (GND: \'.$r[\'gnd\'].\')\';\r\n			}\r\n			$html .= $tm->makeRow(\'Autor\',$authorText);\r\n\r\n			echo $html.\'</table>\';\r\n			\r\n			// dump($rows[0]);\r\n			// begin new table for Sources-Entries:\r\n			$html = \'<table class=\"table table-responsive\">\';\r\n			// make header line of table\r\n			$html .= \"<thead><tr><th>#</th><th>Quelle</th><th>Seitenzahl</th><th>Bevorzugt?</th></thead>\\n\";\r\n			$i = 1;\r\n			foreach($sourcesArray as $s) {\r\n				$html .= \"<tr>\\n\";\r\n				$html .= \"<td>$i</td> \";\r\n				$html .= \"<td>\".$tm->getLink(\'quelle_id\',$s[\'quelle_id\'], \'<div class=\"author-name\">\'.$s[\'kurz\'].\'</div>\', $sourcesArticleId).\"</td> \";\r\n				// check for any truthy value\r\n				$html .= \"<td>\".($s[\'seitenzahl\'] ? $s[\'seitenzahl\'] : \'\').\"</td> \";\r\n				// check for any truthy value\r\n				$html .= \"<td>\".($s[\'bevorzugt\'] ? \'bevorzugt\' : \'\').\"</td> \";\r\n				// $html .= \"<td>${s[\'bevorzugt\']}</td> \";\r\n				$html .= \"</tr>\\n\";\r\n				$i++;\r\n			}\r\n			echo $html.\'</table>\';\r\n		} \r\n		else {\r\n			echo rex_view::warning(\'Eintrag für ID = \'.$id.\' nicht gefunden.\');\r\n		}\r\n	}\r\n	else {\r\n		// !!! make text editable in module input\r\n		echo rex_view::warning(\'Eine Detailansicht benötigt die ID als GET-Parameter \"begriff_id\". Beginne am besten mit der alphabetischen Übersicht!\');\r\n	}\r\n?>\r\n	</div>\r\n</div>','<p>Artikel, der Detailansicht der <em>Literatur-Quellen</em> enthält:</p>\r\nREX_LINK[id=1 widget=1]','2020-05-25 10:51:48','Thomas','2020-06-26 12:00:18','Thomas',NULL,0),
  (6,'tth_view_source','Quellen-Detailansicht','<?php\r\n	$tm = new \\kwd\\tth\\TableManager();\r\n\r\n$quelleId = rex_request(\'quelle_id\',\'int\'); // the param \'int\' should prevent from dangerous inputs\r\n// is_numeric is enough sanitize if we just need an id\r\nif ($quelleId && is_numeric($quelleId)) {\r\n	echo \'Zeige Quelle id \'.$quelleId;\r\n	$sql = rex_sql::factory();\r\n	// $rows = $sql->getArray(\"SELECT q.*,a.* FROM tth_quellen q LEFT JOIN tth_autoren a ON a.id = q.autor_id WHERE q.id = $quelleId\");\r\n	$rows = $sql->getArray(\"SELECT q.* FROM tth_quellen q WHERE q.id = $quelleId\");\r\n	// don\'t know how to combine the queries\r\n	// select all authors for this source, similar to code for relation in begriffe\r\n	$query = \"SELECT a.* \";\r\n	$query.= \"FROM tth_autoren a \";\r\n	$query.= \"JOIN tth_quellen_autoren g1 ON a.id = g1.autor_id \";\r\n	$query.= \"JOIN tth_quellen q ON q.id = g1.quelle_id \";\r\n	$query.= \"WHERE q.id=$quelleId \";\r\n\r\n	$authors = $sql->getArray($query);\r\n\r\n	if (count($rows)) {\r\n		$r = $rows[0];\r\n		echo \"<h2>${r[\'kurz\']}</h2>\";\r\n		?>\r\n		<table class=\"table table-responsive\">\r\n		<?php\r\n		$html = \'\';\r\n		$html .= $tm->makeRow(\'Titel\',$r[\'titel\']);\r\n		$html .= $tm->makeRow(\'Jahr\',$r[\'jahr\']);\r\n		$html .= $tm->makeRow(\'ISBN\',$r[\'isbn\']);\r\n		$html .= $tm->makeRow(\'Kurzform\',$r[\'kurz\']);\r\n		// !!! make link to details for author table (or general link to table with all authors, still not many)\r\n		$authorsHtml = \'\';\r\n		foreach($authors as $a) {\r\n			$authorsHtml .= \"${a[\'vorname\']} ${a[\'name\']}\";\r\n			if ($a[\'gnd\']) {\r\n				// !!! make as config var or sprog/string replacement\r\n				$authorsHtml .= \" (GND: <a href=\'https://portal.dnb.de/opac.htm?query=${a[\'gnd\']}\'>${a[\'gnd\']}</a>)\";\r\n			}\r\n			$authorsHtml .= \", \";\r\n		}\r\n		$html .= $tm->makeRow(\'Autoren\',$authorsHtml.\'<small>alte Autor-IDs zum Abgleich: \'.$r[\'autor_id\'].\'</small>\');\r\n\r\n		echo $html;\r\n		?>\r\n		</table>\r\n		<?php\r\n	}\r\n	else {\r\n		// !!! again use module vars for text template\r\n		echo rex_view::warning(\'Kein Datensatz gefunden für ID=\'.$quelleId);\r\n	}\r\n}\r\n?>','','2020-05-26 11:03:42','Thomas','2020-06-28 19:47:18','Thomas',NULL,0),
  (7,'tth_view_list_param','Liste nach Parameter (nur Begriffe)','<?php\r\n// - put all tth_view_list* together for less modules\r\n// - set params ins module instead for start view\r\n// - control output by params from url\r\n\r\n$detailsArticleId = \'REX_LINK[id=1 output=id]\';\r\n\r\n$tm = new \\kwd\\tth\\TableManager();\r\n\r\n// !!! probably you should use PHP classes/methods to evaluate it(?)\r\n$search = rex_request(\'FORM\');\r\nif ($search) {\r\n	$searchPattern = $search[\'formular\'][0];\r\n	if ($searchPattern) {\r\n\r\n		?><p>Suchmuster: <strong><?=$searchPattern?></strong>\r\n		<?php		\r\n		// !!! sanitize (e.g. only letters, underscore, space and *)\r\n\r\n		// ! change pattern to always have PART of word when no *\r\n		if (false === strpos($searchPattern,\'*\')) {\r\n			$searchPattern = \'*\'.$searchPattern.\'*\';\r\n		}\r\n		\r\n		// !!! set article id by module param\r\n		$sql = rex_sql::factory();\r\n		$query = \"SELECT id,begriff from tth_wortliste WHERE begriff LIKE \'\".str_replace(\'*\',\'%\',$searchPattern).\"\'\";\r\n		?>\r\n		<div class=\"link-list\"><?=$tm->makeLinkList($sql->getArray($query), \'begriff_id\', \'begriff\', $detailsArticleId);?></div>\r\n		<?php\r\n	}\r\n}\r\nelse {\r\n	$lang = rex_request(\'sprache_id\');\r\n	$region = rex_request(\'region_id\');\r\n	$style = rex_request(\'sprachstil_id\');\r\n	$source = rex_request(\'quelle_id\');\r\n\r\n	if ($lang || 0 === $lang || \'0\' === $lang) {\r\n		$sql = rex_sql::factory();\r\n		// !!! need select of language again to gain name (or pass it in URL!)\r\n		// !!! more verbose: check if null result\r\n		?>\r\n		<p><strong>Begriffe nach Sprache <?=$lang?>:</strong> <?=$tm->makeLinkList($sql->getArray(\"SELECT id,begriff FROM tth_wortliste WHERE sprache_id=$lang\"), \'begriff_id\', \'begriff\',  \'REX_LINK[id=1 output=id]\')?></p>\r\n		<?php\r\n	}\r\n	else if ($region || 0 === $region || \'0\' === $region) {\r\n		$sql = rex_sql::factory();\r\n		// !!! need select of region again to gain name (or pass it in URL!)\r\n		// !!! more verbose: check if null result\r\n		?>\r\n		<p><strong>Begriffe nach Region <?=$region?>:</strong> <?=$tm->makeLinkList($sql->getArray(\"SELECT id,begriff FROM tth_wortliste WHERE region_id=$region\"), \'begriff_id\', \'begriff\', \'REX_LINK[id=1 output=id]\')?></p>\r\n		<?php	\r\n	}\r\n	else if ($style || 0 === $style || \'0\' === $style) {\r\n		$sql = rex_sql::factory();\r\n		?>\r\n		<p><strong>Begriffe nach Sprachstil <?=$style?>:</strong> <?=$tm->makeLinkList($sql->getArray(\"SELECT id,begriff FROM tth_wortliste WHERE sprachstil_id=$style\"), \'begriff_id\', \'begriff\', \'REX_LINK[id=1 output=id]\')?></p>\r\n		<?php	\r\n	}\r\n	else if ($source || 0 === $source || \'0\' === $source) {\r\n		$sql = rex_sql::factory();\r\n\r\n		// !!! you\'ll need to find another way for \"not set\"\r\n		//     - need extra treatment for $source === 0\r\n\r\n		$tableEntities = \'tth_wortliste\';\r\n		$tableRelationSources = \'tth_begriff_quellen\';\r\n		$tableSources = \'tth_quellen\';\r\n\r\n		if ($source) {\r\n\r\n			$query = \"SELECT $tableEntities.id,$tableEntities.begriff\r\n			FROM $tableRelationSources\r\n			INNER JOIN $tableEntities\r\n			ON $tableRelationSources.begriff_id = $tableEntities.id\r\n			INNER JOIN $tableSources\r\n			ON $tableRelationSources.quelle_id = $tableSources.id\r\n			WHERE $tableSources.id = $source\";\r\n		}\r\n		else {\r\n			$query = \"SELECT $tableEntities.id,$tableEntities.begriff\r\n			FROM   $tableEntities\r\n			WHERE  NOT EXISTS\r\n			  (SELECT *\r\n			   FROM   $tableRelationSources\r\n			   WHERE  $tableRelationSources.begriff_id = $tableEntities.id)\";\r\n		}\r\n			\r\n		$rows = $sql->getArray($query);\r\n		\r\n		// !!! again: provide texts by input value or by SPROG replacement\r\n		?><p><strong>Begriffe nach Quelle (<?=($source ? \'ID=\'.$source : \'nicht gesetzt\')?>, <?=count($rows)?> Einträge):</strong> <?=$tm->makeLinkList($rows, \'begriff_id\', \'begriff\', \'REX_LINK[id=1 output=id]\')?></p>\r\n		<?php	\r\n	}\r\n	else {\r\n		// !!! output only depending on param in module input because sometimes not wanted\r\n		$sql = rex_sql::factory();\r\n\r\n		// !!! make functions for the array selects\r\n		$languages = $sql->getArray(\"SELECT id,sprache FROM tth_sprachen WHERE 1\");\r\n		// id = 0 automatically causes SQL to find unset entries\r\n		array_push($languages, array( \'id\' => 0, \'sprache\' => \'nicht gesetzt\'));\r\n		?>\r\n		<p><strong>Sprache:</strong> <?=$tm->makeLinkList($languages, \'sprache_id\', \'sprache\')?></p>\r\n		<?php\r\n\r\n		$regions = $sql->getArray(\"SELECT id,region FROM tth_regionen WHERE 1\");\r\n		array_push($regions, array( \'id\' => 0, \'region\' => \'nicht gesetzt\'));\r\n		?>\r\n		<p><strong>Region:</strong> <?=$tm->makeLinkList($regions, \'region_id\', \'region\')?></p>\r\n		<?php\r\n\r\n		$styles = $sql->getArray(\"SELECT id,stil FROM tth_sprachstile WHERE 1\");\r\n		array_push($styles, array( \'id\' => 0, \'stil\' => \'nicht gesetzt\'));\r\n		?>\r\n		<p><strong>Sprachstil:</strong> <?=$tm->makeLinkList($styles, \'sprachstil_id\', \'stil\')?></p>\r\n		<?php\r\n\r\n		$quellen = $sql->getArray(\"SELECT id,kurz FROM tth_quellen WHERE 1\");\r\n		// ! you\'ll need to find another way for \"not set\"\r\n		array_push($quellen, array( \'id\' => 0, \'kurz\' => \'nicht gesetzt\'));\r\n		?>\r\n		<p><strong>Quelle:</strong> <?=$tm->makeLinkList($quellen, \'quelle_id\', \'kurz\')?></p>\r\n		<?php\r\n	}\r\n}\r\n?>','<p>Artikel, der Detailansicht der <em>Begriffe</em> enthält:</p>\r\nREX_LINK[id=1 widget=1]','2020-05-26 14:44:42','Thomas','2020-06-28 19:47:18','Thomas',NULL,0),
  (8,'tth_view_table','Tabellenansicht','<?php\r\n$tm = new \\kwd\\tth\\TableManager();\r\n\r\n$prefix = $tm->getTablePrefix();\r\n$table = \'\';\r\n\r\n// !!! centralized object which contains all information about table schemas and addtional infos such as custom field description names\r\n//     - should use information from YFORM!! (because you have almost all the info there, additionals could go into rex-config)\r\nswitch(\'REX_VALUE[1]\') {\r\n	case \'Autoren\' : \r\n		// /// try to get around without using table name strings directly \r\n		$table = $prefix.\'autoren\';\r\n		// !!! adjustable by input later\r\n		$order = \'name\';\r\n	break;\r\n	case \'Begriffsstati\' : \r\n		$table = $prefix.\'begriffsstati\';\r\n		// !!! adjustable by input later\r\n		$order = \'status\';\r\n	break;\r\n	case \'Quellen\' : \r\n		$table = $prefix.\'quellen\';\r\n		// !!! adjustable by input later\r\n		$order = \'kurz\';\r\n	break;\r\n	case \'Sprachen\' : \r\n		$table = $prefix.\'sprachen\';\r\n		// !!! adjustable by input later\r\n		$order = \'sprache\';\r\n	break;\r\n	case \'Regionen\' : \r\n		$table = $prefix.\'regionen\';\r\n		// !!! adjustable by input later\r\n		$order = \'region\';\r\n	break;\r\n	case \'Sprachstile\' : \r\n		$table = $prefix.\'sprachstile\';\r\n		$order = \'stil\';\r\n	break;\r\n}\r\n\r\nif ($table) {\r\n	echo \'<h2>REX_VALUE[1]</h2>\';\r\n	$sql = rex_sql::factory();\r\n	$query = \"SELECT * FROM $table WHERE 1 ORDER BY $order ASC\";\r\n	$rows = $sql->getArray($query);\r\n	// dump($rows);\r\n\r\n	$html = \'\';\r\n\r\n	// !!! need options\r\n	//     - define white-space: nowrap for some columns OR at least column id as CSS class for each cell\r\n	//     - hide some cols\r\n	//     - custom names for field names\r\n	if (count($rows)) {\r\n\r\n		$html = \'<table class=\"table table-responsive\">\';\r\n\r\n		foreach($rows[0] as $key => $value) {\r\n			$html .= \'<th>\'.$key.\'</th>\';\r\n		}\r\n\r\n		foreach($rows as $a) {\r\n			$html .= \"<tr>\";\r\n			\r\n			foreach($a as $key => $value) {			\r\n				$html .= \'<td>\'.$value.\'</td>\';\r\n			}\r\n			\r\n			$html .= \"</tr>\\n\";\r\n		}\r\n\r\n		$html .= \'</table>\';\r\n	}\r\n\r\n	echo $html;\r\n}\r\nelse {\r\n	echo rex_view::warning(\'Keine gültige Tabelle ausgewählt.\');\r\n}\r\n?>','Tabelle anzeigen:\r\n<div class=\"rex-select-style\">\r\n<select id=\"REX_INPUT_VALUE[1]\" name=\"REX_INPUT_VALUE[1]\" class=\"form-control\">\r\n<?php\r\n// ... don\'t like rex_select of MForm anymore\r\n\r\n$tables = array(\r\n	\'Autoren\',\r\n	\'Begriffsstati\',\r\n	\'Quellen\',\r\n	\'Regionen\',\r\n	\'Sprachen\',\r\n	\'Sprachstile\'\r\n);\r\n\r\n$preSelected = \'REX_VALUE[1]\';\r\n\r\nforeach($tables as $t) {\r\n	echo \"<option value=\'$t\' \".($preSelected == $t ? \" selected=\'selected\'\":\"\").\">$t</option>\\n\";\r\n}\r\n?>\r\n</select>\r\n</div>','2020-05-26 20:08:16','Thomas','2020-06-26 12:00:18','Thomas',NULL,0),
  (9,'tth_convert_sources','Konvertiere Quellen','<?php if (rex::isBackend()) : ?>\r\nDer Callback heißt \'convertSourcesCallback\'. Du brauchst einen YForm-Block zum Starten.\r\n<?php endif; \r\n\r\nif (!function_exists(\'convertSourcesCallback\')) {\r\n	function convertSourcesCallback($request) {\r\n		// echo \'absenden erkannt\';\r\n		// - convert from quellen_idlist and quelle_seite; easier than from created relations table\r\n		// - preserve order in list\r\n		// - assume page number to belong to first quelle\r\n		// - assume first quelle to be \"preferred\"\r\n		$sql = rex_sql::factory();\r\n		$query = \"SELECT id,quelle_seite,quellen_idlist FROM tth_wortliste WHERE quellen_idlist != \'\'\";\r\n		$rows=$sql->getArray($query);\r\n		echo count($rows) .\" Einträge mit Quellen.\\n\";\r\n\r\n		$insertList = \'\';\r\n		foreach($rows as $r) {\r\n			$sources = explode(\';\',$r[\'quellen_idlist\']);\r\n			// echo \', \'.count($sources);\r\n			$i = 0;\r\n			$seite = $r[\'quelle_seite\'];\r\n			if (!$seite) $seite = \"\'\'\";\r\n\r\n			foreach($sources as $s) {\r\n				if (trim($s)) {\r\n					// echo \'.\';\r\n					// order: quelle_id, seitenzahl, bevorzugt, begriff_id\r\n					// $insertList .= \"(\'.$s.\',\'.$node.\"),\\n\"; check if \\n needed!\r\n					$insertList .= \"($s, \".($i === 0 ? $seite : \"\'\'\").\", \".($i === 0 ? \"\'TRUE\'\" : \"\'\'\").\", ${r[\'id\']}), \";\r\n					$i++;\r\n				}\r\n			}\r\n		}\r\n\r\n		// remove last comma!\r\n		$insertList = substr($insertList,0,strrpos($insertList,\',\'));\r\n		$query = \'INSERT INTO tth_quellenangaben (quelle_id, seitenzahl, bevorzugt, begriff_id) VALUES \'.$insertList;\r\n		echo \'<h3>SQL-Befehl</h3><p>\'.$query.\'</p>\';\r\n		\r\n		// disabled for security\r\n		// $sql->setQuery($query);\r\n	}\r\n}\r\n\r\nif (rex_post(\'FORM\')) {\r\n}\r\nelse {\r\n	$sql = rex_sql::factory();\r\n	// \"SUM\" can be passed a simpler expression than \"COUNT\"\r\n	$query = \"SELECT COUNT(id) AS numEntities, SUM(quellen_idlist != \'\') AS numSources, SUM(quellen_idlist LIKE \'%;%\') AS numMultipleSources, SUM(quelle_seite != \'\') AS numPageNumbers FROM tth_wortliste\";\r\n	$sql->setQuery($query);\r\n	$rows=$sql->getArray();\r\n	$d = $rows[0]\r\n?>\r\n<p>\r\n	Einträge: <?=$d[\'numEntities\']?><br>\r\n	Einträge mit Quellen: <?=$d[\'numSources\']?><br>\r\n	Einträge mit mehreren Quellen: <?=$d[\'numMultipleSources\']?><br>\r\n	Einträge mit Seitenzahlen: <?=$d[\'numPageNumbers\']?>\r\n</p>\r\n\r\n<?php } ?>','Keine Einstellungen einfach speichern.','2020-06-10 22:20:45','Thomas','2020-06-11 00:25:35','Thomas',NULL,0),
  (10,'tth_view_filter','Filterergebnisse','','','2020-06-26 13:01:07','Thomas','2020-06-28 19:47:18','Thomas',NULL,0),
  (12,'backend_note','Notiz (im Frontend nicht zu sehen)','<?php\r\n  if (rex::isBackend()):\r\n	  echo markitup::parseOutput (\'markdown\', \'REX_VALUE[id=1 output=\"html\"]\');\r\n?>\r\n<!-- <p><em>(Diese Notiz ist im Frontend niemals zu sehen.)</em></p> -->\r\n<?php endif;?>','<fieldset class=\"form-horizontal\">\r\n  <div class=\"form-group\">\r\n    <label class=\"col-sm-2 control-label\" for=\"value-1\">VALUE 1</label>\r\n    <div class=\"col-sm-10\">\r\n      <textarea class=\"form-control markitupEditor-markdown_full\" id=\"value-1\" name=\"REX_INPUT_VALUE[1]\">REX_VALUE[1]</textarea>\r\n    </div>\r\n  </div>\r\n</fieldset>','2020-10-22 19:15:22','Thomas','2020-10-22 19:23:52','Thomas',NULL,0),
  (13,NULL,'Artikelliste','<?php\r\n$articleId = $class = $articleName =  $artOutput = \"\";\r\n\r\n// Aktuelle Kategorie ermitteln und Artikel auslesen\r\n$articles = rex_category::getCurrent()->getArticles();\r\n\r\n// Prüfen ob das Ergebnis gefüllt ist\r\nif (is_array($articles) && count($articles) > 0) {\r\n\r\n    // Einzelne Artikel auslesen\r\n    foreach ($articles as $article) {\r\n\r\n        if ($article->isOnline()) {\r\n\r\n            // Überspringen wenn aktueller Artikel gefunden. (auskommentieren)\r\n            // if ( $article->getId() == \'REX_ARTICLE_ID\') continue;\r\n\r\n            // Aktive CSS-Classe festlegen\r\n            $class = \'\';\r\n            if ($article->getId() == \'REX_ARTICLE_ID\') {\r\n                $class = \"active\";\r\n            }\r\n\r\n            // Überspringen wenn Startartikel gefunden\r\n            if ($article->isStartArticle()) continue;\r\n\r\n            // ID des Artikels ermitteln\r\n            $articleId = $article->getId();\r\n\r\n            // Name des Artikels ermitteln\r\n            $articleName = $article->getName();\r\n\r\n            // Weitere Daten  der Metainfos können wie folgt abgerufen werden:\r\n            // Beispiel für eine Meta-Info art_Image\r\n            // $articleImage = $article->getValue(\"art_Image\");\r\n\r\n			// Ausgabe erstellen\r\n			// !!! style not yet cool\r\n            // $artOutput .= \'<a class=\"list-group-item list-group-item-action \' . $class . \'\" href=\"\' . rex_getUrl($articleId) . \'\">\' . $articleName . \'</a>\' . \"\\n\";\r\n			\r\n			// tailwind\r\n            $artOutput .= \'<li class=\"p-0 \' . $class . \'\"><a class=\"p-3 block \' . $class . \'\" href=\"\' . rex_getUrl($articleId) . \'\">\' . $articleName . \'</a></li>\' . \"\\n\";\r\n        }\r\n    }\r\n\r\n	// Ausgabe\r\n	// !!! verwende bootstrap `list-group`, but don\'t forget `list-group-item` and `list-group-item-action`\r\n	//     for the elements\r\n    echo \'<ul class=\"catlist bg-gray-100 rounded-md\">\' . $artOutput . \'</ul>\';\r\n    // echo \'<ul class=\"list-group\">\' . $artOutput . \'</ul>\';\r\n    unset($articles);\r\n}','Quellkategorie der Artikel, die aufgelistet werden sollen:\r\n\r\n<hr>\r\ngeplant: Einstellung ob Blog-Daten angezeigt werden sollen. Die Daten (wie Autor, Datum) sind ja immer vorhanden,\r\nwerden nur nicht angezeigt.','2020-10-22 19:29:05','Thomas','2020-10-29 15:51:46','Thomas',NULL,0);
/*!40000 ALTER TABLE `rex_module` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_module_action`;
CREATE TABLE `rex_module_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned NOT NULL,
  `action_id` int(10) unsigned NOT NULL,
  `revision` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_template`;
CREATE TABLE `rex_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revision` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_template` WRITE;
/*!40000 ALTER TABLE `rex_template` DISABLE KEYS */;
INSERT INTO `rex_template` VALUES 
  (1,NULL,'Default','<?php\r\n    // set var if user active\r\n    $templateAllowed = true;\r\n    // include bootstrap\r\n    // $navTemplate = new rex_template(\'mkb_basis\');  // id des Basis-Template hart codiert!\r\n	// include $navTemplate->getFile();\r\n	$isBlog = false;\r\n?>\r\nREX_TEMPLATE[key=tth_basis] ',1,'2020-10-29 16:33:31','Thomas','2020-10-29 16:33:31','Thomas','{\"ctype\":[],\"modules\":{\"1\":{\"all\":\"1\"}},\"categories\":{\"0\":\"1\",\"1\":\"4\",\"2\":\"5\",\"3\":\"6\",\"4\":\"7\",\"5\":\"8\",\"6\":\"9\",\"7\":\"11\",\"8\":\"2\",\"9\":\"3\",\"10\":\"10\",\"11\":\"12\",\"12\":\"19\",\"all\":0}}',0),
  (2,'tth_basis','Basis','<?php\r\n    // $urlBase = rex_url::base();\r\n    // Gibt eine URL im Ordner \"theme/public/assets\" zurück.\r\n    // in contrast to yrewrite theme does not give trailing slash\r\n    // $assetsUrlBase = theme_url::assets() .\'/\';\r\n	// -- also there: theme_url::base()\r\n\r\n	if (!function_exists(\'getPosted\')) {\r\n		function getPosted($name) {\r\n			return rex_escape(rex_request($name,\'string\'));\r\n		}\r\n	}\r\n\r\n	\r\n	// !!! put into module or class, like callback for sources\r\n	function convertCallback($request) {\r\n		\r\n		$formData = rex_request(\'FORM\');\r\n		$fieldFromForm = strtolower($formData[\'formular\'][0]);\r\n		\r\n		switch ($fieldFromForm) {\r\n			case \'nd_beleg quellen\':\r\n				$sourceField = \'quellen_idlist\';\r\n				$targetTable = \'tth_begriff_quellen\';\r\n				$targetIdField = \'quelle_id\';\r\n				break;\r\n			case \'oberbegriffe\':\r\n				$sourceField = \'oberbegriffe\';\r\n				$targetTable = \'tth_begriff_oberbegriffe\';\r\n				$targetIdField = \'oberbegriff_id\';\r\n				break;\r\n			case \'unterbegriffe\':\r\n				$sourceField = \'unterbegriffe\';\r\n				$targetTable = \'tth_begriff_unterbegriffe\';\r\n				$targetIdField = \'unterbegriff_id\';\r\n				break;\r\n			case \'aequivalente begriffe\':\r\n				$sourceField = \'aequivalent\';\r\n				$targetTable = \'tth_begriff_aequivalente\';\r\n				$targetIdField = \'aequivalent_id\';\r\n				break;\r\n			case \'verwandte begriffe\':\r\n				$sourceField = \'verwandte_begriffe\';\r\n				$targetTable = \'tth_begriff_verwandte\';\r\n				$targetIdField = \'verwandter_id\';\r\n				break;\r\n			case \'grobgliederung\':\r\n				$sourceField = \'grobgliederung\';\r\n				$targetTable = \'tth_begriff_grobgliederung\';\r\n				$targetIdField = \'grobgliederung_id\';\r\n				break;\r\n			default:\r\n				$sourceField = \'\';\r\n				$targetTable = \'\';\r\n				$targetIdField = \'\';\r\n			break;\r\n		}\r\n	\r\n		// when \'default\' -- can easily happen when form changed in structure content form module\r\n		if ($sourceField) {\r\n			// dump($sourceField);\r\n			// dump($targetTable);\r\n			// dump($targetIdField);\r\n\r\n			// $sourceField = \'grobgliederung\';\r\n			// $sourceField = \'quellen_idlist\';\r\n			// $sourceField = \'oberbegriffe\';\r\n			// $targetTable = \'tth_begriff_grobgliederung\';\r\n			// $targetTable = \'tth_begriff_quellen\';\r\n			// $targetTable = \'tth_begriff_oberbegriffe\';\r\n			// $targetIdField = \'oberbegriff_id\';\r\n			$sql = rex_sql::factory();\r\n\r\n				// $query = \'TRUNCATE \'.$targetTable;\r\n				// $sql->setQuery($query);\r\n			\r\n			// !!! for a new operation you must be sure the last one is ready (maybe asynch!!)\r\n\r\n			// - begriff field only for control outputs\r\n			$query = \'SELECT id,begriff,\'.$sourceField.\' FROM tth_wortliste WHERE 1\';\r\n			// $query = \'SELECT id,begriff,grobgliederung FROM tth_wortliste WHERE grobgliederung LIKE \"%;%\"\';\r\n			$rows = $sql->getArray($query);\r\n			\r\n			$insertList = \'\';\r\n			$count = 0;\r\n			$insertCount = 0;\r\n			foreach($rows as $row) {\r\n				if(trim($row[$sourceField])) {\r\n					$count++;\r\n					$nodes = explode(\';\',$row[$sourceField]);\r\n					// - don\'t need NULL check for $nodes\r\n					foreach($nodes as $node) {\r\n						if (trim($node)) {\r\n							$insertList .= \'(\'.$row[\'id\'].\',\'.$node.\"),\\n\";\r\n							$insertCount++;\r\n						}\r\n					}\r\n				}\r\n			}\r\n\r\n			// remove last comma!\r\n			$insertList = substr($insertList,0,strrpos($insertList,\',\'));\r\n			// dump($insertList);\r\n			// echo $insertList;\r\n			$query = \'INSERT INTO \'.$targetTable.\' (begriff_id, \'.$targetIdField.\') VALUES \'.$insertList;\r\n			echo \'<h3>SQL-Befehl</h3><p>\'.$query.\'</p>\';\r\n\r\n			// $sql->setQuery($query);\r\n\r\n			echo \'<div class=\"alert alert-success\" role=\"alert\">\r\n				<p>\r\n				Quell-Feld: \'.$fieldFromForm.\'<br>\r\n				Ziel-ID-Feld: \'.$targetIdField.\'<br>\r\n				Betroffene Datensätze: \'.$count.\' von \'.count($rows).\'</p>\r\n				<p>\'.$insertCount.\' Einträge in Tabelle <strong>\'.$targetTable.\'</strong> neu geschrieben (vorige Einträge bestehen weiterhin zusätzlich!).</p>\r\n				</div>\';\r\n			echo \'<div class=\"alert alert-warning\" role=\"alert\">\r\n			<p>\r\n			Der eigentliche Schreibvorgang ist aus Sicherheitsgründen <em>deaktiviert</em>. Die DB wurde nicht verändert.\r\n			</p></div>\';\r\n		}\r\n		else {\r\n			echo \'<div class=\"alert alert-primary\" role=\"alert\">\r\n				<p>Ungültige Auswahl. Überprüfe das Eingabe-Formular!</p>\r\n				</div>\';\r\n		}\r\n	}\r\n\r\n	\r\n	// setup\r\n	///////////////////////////////////////////////////////////////////////////////\r\n\r\n	// ! sets 6 as default only if no config found\r\n	// - will be stored and restored with DB export/import\r\n	// - can be adjusted in installation (but where communicated to ther admins?)\r\n	// - cool thing: rex_config is *cached*\r\n	// !!! make utility function in theme lib\r\n	// !!! make *module* \"system settings\" which can be used to adjust values (which are put to config on save)\r\n	// !!! check how or if theme addon can produce backend pages for settings\r\n	//     !!! easier to use project addon then! \r\n	$detailsArticleId = rex_config::get(\'tth\', \'article_entity_details\');\r\n	if (!$detailsArticleId) {\r\n		$detailsArticleId = 6;\r\n		rex_config::set(\'tth\',\'article_entity_details\',$detailsArticleId);\r\n	}\r\n\r\n	$imprintArticleId = rex_config::get(\'tth\', \'article_imprint\');\r\n	if (!$imprintArticleId) {\r\n		$imprintArticleId = 19;\r\n		rex_config::set(\'tth\',\'article_imprint\',$imprintArticleId);\r\n	}\r\n\r\n	// central search form PRE-send\r\n	///////////////////////////////////////////////////////////////////////////////\r\n\r\n	$sql = rex_sql::factory();\r\n	$query = \"SELECT begriff from tth_wortliste WHERE 1 ORDER BY begriff ASC\";\r\n	$rows = $sql->getArray($query);\r\n	\r\n	$completeWordList = \'\';\r\n	foreach($rows as $k => $v) {\r\n		$completeWordList .= \'\"\'. $v[\'begriff\'] .\'\", \';\r\n	}\r\n\r\n	// echo $completeWordList;\r\n\r\n	// central search form EVALUATE-received\r\n	///////////////////////////////////////////////////////////////////////////////\r\n\r\n	// !!! go directly to details\r\n	//     you can achieve this by sending ids? read more in autocomplete docs!!!\r\n\r\n	// !!! just get action from searchfield *without YForm*\r\n	$wSearch = getPosted(\'wordlistsearch\');\r\n	if ($wSearch) {\r\n		$searchPattern = rex_escape($wSearch);\r\n		if ($searchPattern) {\r\n\r\n			// !!! sanitize (e.g. only letters, underscore, space and *)\r\n\r\n			// ! change pattern to always have PART of word when no *\r\n			if (false === strpos($searchPattern,\'*\')) {\r\n				$searchPattern = \'*\'.$searchPattern.\'*\';\r\n			}\r\n			\r\n			$searchPattern = \r\n				str_replace(\"\'\",\"\",\r\n				str_replace(\"`\",\"\",\r\n				str_replace(\'\"\',\'\',\r\n				str_replace(\"\\n\",\'\',\r\n				str_replace(\';\',\'\',\r\n				$searchPattern\r\n			)))));\r\n\r\n			// !!! set article id by module param\r\n			// $sql = rex_sql::factory();\r\n			$query = \"SELECT id,begriff from tth_wortliste WHERE begriff LIKE \".str_replace(\'*\',\'%\',$sql->escape($searchPattern));\r\n			$rows = $sql->getArray($query);\r\n			if ($rows && count($rows)) {\r\n				$tm = new \\kwd\\tth\\TableManager();\r\n				$searchResultList = $tm->makeLinkList($rows, \'begriff_id\', \'begriff\', $detailsArticleId);\r\n			}\r\n			else {\r\n				$searchResultList = \'\';\r\n			}\r\n		}\r\n	}\r\n\r\n	if (rex_backend_login::createUser()) {\r\n		$user =  rex::getuser();\r\n		$login = $user->getValue(\"login\");\r\n		if ($user->isAdmin()) {\r\n			$userLevel = 3;\r\n		}\r\n		else {\r\n			$userLevel = 2;\r\n		}\r\n	}\r\n	else {\r\n		$login = \'\';\r\n		$user = null;\r\n		$userLevel = 1;\r\n	}\r\n\r\n	?><!doctype html>\r\n<html lang=\"en\">\r\n  <head>\r\n    <meta charset=\"utf-8\">\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\r\n\r\n	<?php // tailwind cannot bring benefit to th styling in this project!\r\n	// <!-- <link href=\"https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css\" rel=\"stylesheet\"> -->\r\n	?>\r\n	<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css\" integrity=\"sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2\" crossorigin=\"anonymous\">\r\n\r\n    <link rel=\"icon\" type=\"image/png\" sizes=\"32x32\" href=\"<?=theme_url::assets(\'tth-logo.png\')?>\">\r\n    \r\n	<link rel=\"stylesheet\" href=\"<?=theme_url::assets(\'vendor/jquery.auto-complete.css\')?>\">\r\n	<link rel=\"stylesheet\" href=\"<?=theme_url::assets(\'global.css\')?>?v=1.3.00\">\r\n\r\n    <title>TTH - <?=$this->getValue(\'name\')?></title>\r\n\r\n  </head>\r\n  <body>\r\n		<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\r\n			<?php if(rex_article::getSiteStartArticle()->getId() !== rex_article::getCurrent()->getId()): ?>\r\n			<a class=\"navbar-brand\" href=\"<?=rex_getUrl(rex_article::getSiteStartArticle()->getId())?>\"><img class=\"logo-graphics\" src=\"<?=theme_url::assets(\'tth-logo.png\')?>\" alt=\"Logo mit übereinanderliegenden Buchstaben TTH, in Braun und Schwarz\" width=\"55\" height=\"55\" > {{ProjektTitel}}</a>\r\n			<?php endif; ?>\r\n			<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarSupportedContent\" aria-controls=\"navbarSupportedContent\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n		    	<span class=\"navbar-toggler-icon\"></span>\r\n  			</button>\r\n\r\n		  <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\r\n\r\n			<ul class=\"navbar-nav ml-auto\">\r\n\r\n				<?php\r\n				$path = rex_article::getCurrent()->getPathAsArray();\r\n				$path1 = ((!empty($path[0])) ? $path[0] : \'\');\r\n				$path2 = ((!empty($path[1])) ? $path[1] : \'\');\r\n				\r\n					foreach (rex_category::getRootCategories() as $lev1) {\r\n						if ($lev1->isOnline(true) && intval($lev1->getValue(\'cat_backenduser\')) <= $userLevel) {\r\n				\r\n							// zweite Ebene, muss man schon fuer li wissen\r\n							$lev1Size = sizeof($lev1->getChildren());\r\n\r\n							$active = ($lev1->getId() == $path1) ? \'active\' : \'\';\r\n							$dropdown = ($lev1Size != \"0\") ? \'dropdown\' : \'\';\r\n							echo \'<li class=\"nav-item \'.$active.\' \'.$dropdown.\'\">\';\r\n							if ($dropdown) {\r\n								echo \'<a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\'.htmlspecialchars($lev1->getValue(\'catname\')).\'</a>\';\r\n							}\r\n							else {\r\n								echo \'<a class=\"nav-link\" href=\"\'.$lev1->getUrl().\'\">\'.htmlspecialchars($lev1->getValue(\'catname\')).\'</a>\';\r\n							}\r\n				\r\n							// Soll nur der jeweils aktive Kategoriebaum erscheinen?\r\n							// Dann die folgende Zeile auskommentieren:\r\n							// if ($lev1->getId() == $path1) {\r\n				\r\n							if ($lev1Size != \"0\") {\r\n				\r\n								// echo \'<ul>\';\r\n								echo \'<div class=\"dropdown-menu dropdown-menu-right\" aria-labelledby=\"navbarDropdown\">\';\r\n				\r\n									foreach ($lev1->getChildren() as $lev2) {\r\n										// !!! make function `checkUser($lev2->getValue(\'cat_backenduser\'))`\r\n										if ($lev2->isOnline(true)  && intval($lev2->getValue(\'cat_backenduser\')) <= $userLevel ) {\r\n				\r\n											$active = ($lev2->getId() == $path2) ? \'active\' : \'\';\r\n											echo \'<a class=\"dropdown-item \'.$active.\'\" href=\"\'.$lev2->getUrl().\'\">\'.htmlspecialchars($lev2->getValue(\'catname\')).\'</a>\';\r\n										}\r\n									}\r\n				\r\n								// echo \'</ul>\';\r\n								echo \'</div>\';\r\n				\r\n							}\r\n				\r\n							// Soll nur der jeweils aktive Kategoriebaum erscheinen?\r\n							// Dann die folgende Zeile auskommentieren:\r\n							// }\r\n				\r\n							echo \'</li>\';\r\n						}\r\n					}\r\n				\r\n\r\n				// $nav = rex_navigation::factory();\r\n				// // public function show($category_id = 0, $depth = 3, $open = false, $ignore_offlines = false)\r\n				// $nav->show(0,3,true,true);\r\n				?>\r\n			</ul>\r\n\r\n			\r\n			<form class=\"form-inline my-2 my-lg-0\" action=\"<?=rex_getUrl(\'\')?>\" method=\"get\">\r\n			<input id=\"wordlistsearch\" class=\"form-control mr-sm-2\" name=\"wordlistsearch\" type=\"search\" placeholder=\"Wort(teil)\" aria-label=\"Wort\">\r\n			<input type=\"hidden\" id=\"article_id\" name=\"article_id\" value=\"<?=rex_article::getCurrent()->getId()?>\">\r\n			<button class=\"btn btn-outline-success my-2 my-sm-0\" type=\"submit\">Suchen</button>\r\n			</form>\r\n		</div>\r\n	</nav>\r\n\r\n\r\n	<div class=\"header-login\">\r\n		<?php\r\n			// ! use later again \r\n			if ($login):\r\n				echo \"eingeloggt als: $login\";\r\n\r\n			// ! no else branch => redaxo login invisible\r\n			// else:\r\n			// 	<!-- <a href=\"/redaxo/\">Login</a> -->\r\n			endif;\r\n		?>\r\n	</div>\r\n\r\n	<div class=\"container main-container\">\r\n\r\n		<!-- this only start page -->\r\n		<?php \r\n		if (rex_article::getSiteStartArticle()->getId() === rex_article::getCurrent()->getId()): ?>\r\n		<div class=\"project-logo\">\r\n			<!-- <a href=\"<?=rex_getUrl(rex_article::getSiteStartArticle()->getId())?>\"> -->\r\n				<img class=\"logo-graphics\" src=\"<?=theme_url::assets(\'tth-logo.png\')?>\" >\r\n				<span class=\"project-title\">{{ProjektTitel}}</span>\r\n			<!-- </a> -->\r\n		</div>\r\n		<?php endif; ?>\r\n\r\n		<?php \r\n		// think about redirecting to a certain search page\r\n		if ($wSearch):\r\n		?>\r\n		<div class=\"jumbotron\">\r\n			<h3><?php echo $searchResultList ? \'\' : \'<strong>Keine</strong> \'?>Ergebnisse für \"<?=$wSearch?>\"</h3>\r\n			<p><?=$searchResultList?></p>\r\n		</div>\r\n		<?php endif; ?>\r\n		<h1><?php echo $this->getValue(\'name\')?></h1>\r\n\r\n		<?php \r\n		// ! convention every module must be aware to be inside the main container and should always provide rows and cols\r\n			if ($isBlog):\r\n				\r\n				// !!! better compose template like in community demo or other modern redaxo demos\r\n				//     - header + default content\r\n				//     - blog stuff (commenting)\r\n				//     - footer\r\n\r\n				$art = rex_article::getCurrent();\r\n				$sql = rex_sql::factory();\r\n				$query = \"SELECT id,name,login FROM rex_user WHERE login = \\\"\" . $art->getValue(\'createuser\') .\"\\\"\";\r\n				$users = $sql->getArray($query);\r\n				$blogUserName = rex_escape($users[0][\'name\']);\r\n				$blogImgSrc = rex_media_manager::getUrl(\'blog_author\',\'blogautor_\'.strtolower($art->getValue(\'createuser\')).\'.jpg\');\r\n				// dump($blogImgSrc);\r\n\r\n				setlocale(LC_TIME,\'de_DE.utf8\', \'de_DE@euro.utf8\', \'de_DE.utf8\', \'de.utf8\',\'ge.utf8\',\'german.utf8\',\'German.utf8\');\r\n				$blogCreateDate = strftime(\"%e. %b. %Y\", $art->getValue(\'createdate\'));\r\n				$blogUpdateDate = strftime(\"%e. %b. %Y\", $art->getValue(\'updatedate\') + 40);\r\n\r\n				// !!! markup: use bootstrap media or box content styling for header or at least row/col so that \r\n				//             img floats as expected!\r\n				//             -> also needed for name versus date because of mobile devices\r\n				?>\r\n				<div class=\"blog-header\">\r\n					<p>\r\n						<img src=\"<?=$blogImgSrc?>\">\r\n						von <?=$blogUserName?>\r\n					</p>\r\n					<p class=\"blog-date\">\r\n						erstellt am <?php \r\n							echo $blogCreateDate;\r\n							if ($blogCreateDate !== $blogUpdateDate) {\r\n								echo \', zuletzt geändert am \'. $blogUpdateDate;\r\n							}\r\n							?>\r\n					</p>\r\n				</div>\r\n			<?php endif;?>\r\n        REX_ARTICLE[]\r\n		<?php \r\n		// !!! show comment function if admin logged in because not ready yet !!!\r\n		if ($isBlog && ($userLevel === 3)): \r\n			// if ($isBlog): 1\r\n\r\n			// echo \'yorm test: \';\r\n			// $items = rex_yform_manager_table::get(\'rex_blog_reply\')->query()->find();\r\n			// dump($items);\r\n			// $testId = 2;\r\n			// echo \'yorm auto save: (set url param \"save\" to 1!), for id: \'. $testId;\r\n			// if (rex_request(\'save\',\'string\') !== \'\') {\r\n			// 	echo \'perform save... \';\r\n			// 	$post = rex_yform_manager_dataset::get($testId, \'rex_blog_reply\');\r\n			// 	echo \'name: \' . $post->name;\r\n			// 	echo \' nothing changed but updatedate!!\';\r\n			// 	// $post->text = \'...\';\r\n\r\n			// 	if ($post->save()) { \r\n			// 		echo \'Gespeichert!\';\r\n			// 	} else {\r\n			// 		echo implode(\'<br>\', $post->getMessages());\r\n			// 	}\r\n			// }\r\n			// !!! use class or fragment for *comment list code*\r\n			//     - group by comment\r\n			//     - make tree after fetch\r\n			\r\n\r\n			$query = \"SELECT * FROM rex_blog_reply WHERE articleID = REX_ARTICLE_ID ORDER BY `createdate` ASC\";\r\n			// $comments = $sql->getArray($query);\r\n			$sql->setQuery($query);\r\n\r\n			// while ($s)$commentRows\r\n			$comments = array(); // as long as debug\r\n			if ($sql->hasNext()):\r\n			?>\r\n			<div class=\"blog-comments\">\r\n				<h2>Kommentare</h2>\r\n\r\n				<!-- bootstrap box? -->\r\n				<?php\r\n				$user_sql = rex_sql::factory();\r\n				// foreach ($comments as $reply):\r\n				while ($sql->hasNext()):\r\n				?>\r\n					<div class=\"comment-entry\">\r\n						<div class=\"comment-entry-header\">\r\n							<?php\r\n							// get chosen name\r\n							// $chosenName = trim(rex_escape($reply[\'name\']));\r\n							$chosenName = trim(rex_escape($sql->getValue(\'name\')));\r\n							if (!strlen($chosenName)) {\r\n								// get name from ycom user when set\r\n								// if ($reply[\'ycomCreateUser\']) {\r\n								if ($sql->getValue(\'ycomCreateUser\')) {\r\n									// !!! is result of user get in redaxo tricks easier (because only 1 row expected?)\r\n									// Neue rex_sql Instanz\r\n									// $user_sql->setQuery(\"SELECT name,firstname FROM \" . rex::getTable(\'ycom_user\') . \" WHERE id = :id\",  array(\":id\" => $reply[\'ycomCreateUser\']));\r\n									$user_sql->setQuery(\"SELECT name,firstname FROM \" . rex::getTable(\'ycom_user\') . \" WHERE id = :id\",  array(\":id\" => $sql->getValue(\'ycomCreateUser\')));\r\n									// Übergabe\r\n									$chosenName = \r\n										rex_escape($user_sql->getValue(\'firstname\')) . \' \' .\r\n										rex_escape($user_sql->getValue(\'name\'));\r\n								}\r\n							}\r\n							echo $chosenName;\r\n							?>\r\n							schrieb am <?=date(\'d.m.Y\', $sql->getDateTimeValue(\'createdate\'))?>:\r\n						</div>\r\n						<?=rex_escape($sql->getValue(\'comment\'))?>\r\n					</div>\r\n				<?php $sql->next(); endwhile; ?>\r\n			</div>\r\n\r\n			<?php endif;?>\r\n\r\n			<?php\r\n			if (getPosted(\'comment_preview\')):\r\n				$previewName = getPosted(\'comment_name\');\r\n				$previewMail = getPosted(\'comment_mail\');\r\n				$previewBody = getPosted(\'comment_body\');\r\n			?>\r\n			<a id=\"preview-comment\"></a>\r\n			<h3>Vorschau</h3>\r\n			<div class=\"comment-entry\">\r\n				<div class=\"comment-entry-header\">\r\n					<?=$previewName?>\r\n					schrieb am <?=date(\'d.m.Y\')?>:\r\n				</div>\r\n				<?=$previewBody?>\r\n			</div>\r\n			\r\n			<form action=\"<?=rex_getUrl(\'\')?>#new-comment\" method=\"POST\">\r\n				<input id=\"comment_name\" name=\"comment_name\" type=\"hidden\" value=\"<?=$previewName?>\">\r\n				<input id=\"comment_mail\" name=\"comment_mail\" type=\"hidden\" value=\"<?=$previewMail?>\">\r\n				<input id=\"comment_body\" name=\"comment_body\" type=\"hidden\" value=\"<?=$previewBody?>\">\r\n				<div class=\"form-group form-check\">\r\n					<input type=\"checkbox\" class=\"form-check-input\" id=\"comment_conditions_read\" name=\"comment_conditions_read\" value=\"read\">\r\n					<label class=\"form-check-label\" for=\"comment_conditions_read\">Bedingungen gelesen und akzeptiert</label>\r\n				</div>\r\n				<input id=\"comment_edit\" name=\"comment_edit\" type=\"submit\" class=\"btn btn-success mb-2\" value=\"Noch einmal bearbeiten\"/>\r\n				<input id=\"comment_anonymous_submit\" type=\"submit\" name=\"comment_submit\" value=\"Absenden\"  class=\"btn btn-danger mb-2\"/>\r\n				<!-- <input id=\"comment_login\" type=\"submit\" name=\"action\" value=\"Anmelden und kommentieren\" />	 -->\r\n			</form>\r\n\r\n			<?php \r\n				// else for: if comment_preview, means when NO PREVIEW\r\n				elseif (\r\n					getPosted(\'comment_submit\') &&\r\n					getPosted(\'comment_conditions_read\') === \'read\'\r\n					):\r\n\r\n					$post = rex_yform_manager_dataset::create(\'rex_blog_reply\');\r\n					// $post->setValue(\'name\',rex_escape(rex_request(\'comment_name\',\'string\')));\r\n					// // !!! mail not yet defined as field\r\n					// // $post->mail = rex_request(\'comment_name\',\'string\');\r\n					// $post->setValue(\'comment\',rex_escape(rex_request(\'comment_body\',\'string\')));\r\n					// $post->setValue(\'ycomCreateUser\',0);\r\n					// $post->setValue(\'articleID\',$this->getValue(\'article_id\'));\r\n					// $post->setValue(\'parentReplyID\',0);\r\n					\r\n					$post->name = getPosted(\'comment_name\');\r\n					$post->mail = getPosted(\'comment_mail\');\r\n					$post->comment = getPosted(\'comment_body\');\r\n					$post->ycomCreateUser = 0;\r\n					$post->articleID = \'REX_ARTICLE_ID\';\r\n					$post->parentReplyID = 0;\r\n					\r\n					if ($post->save()) {\r\n						?>\r\n						<div class=\"alert alert-success\">\r\n							Neuer Kommentar wurde gespeichert.\r\n						</div>\r\n						<a href=\"<?=rex_getUrl(\'\')?>\" class=\"btn btn-primary\">Weiter</a>\r\n						<?php\r\n					} else {\r\n						?>\r\n						<div class=\"alert alert-danger\">\r\n							<?php echo implode(\'<br>\', $post->getMessages()); ?>\r\n						</div>\r\n						<?php\r\n					}\r\n					\r\n				else: // show initial view or re-edit\r\n					$isReEdit = false;\r\n					$reEditName = $reEditMail = $reEditBody = \'\';\r\n\r\n					if (getPosted(\'comment_edit\')) {\r\n						$isReEdit = true;\r\n						// !!! refactor: put together with vars of preview\r\n						$reEditName = getPosted(\'comment_name\');\r\n						$reEditMail = getPosted(\'comment_mail\');\r\n						$reEditBody = getPosted(\'comment_body\');\r\n					}\r\n\r\n					// ! here settings of all WRONG filled fields\r\n					// !!! should also be shown at preview already (make sub function)\r\n					// !!! again refactor: put together with vars of preview\r\n					if (getPosted(\'comment_submit\')) {\r\n						if (getPosted(\'comment_conditions_read\') !== \'read\') {\r\n							echo \'SIE MÜSSEN DEN BEDINGUNGEN ZUSTIMMEN.; \';\r\n						}\r\n						if (!trim(getPosted(\'comment_name\'))) {\r\n							echo \'KEIN NAME ANGEGEBEN (kann auch ein Fanatsie-Name sein).\';\r\n						}\r\n						if (!trim(getPosted(\'comment_body\'))) {\r\n							echo \'KEIN TEXT EINGEGEBEN.\';\r\n						}\r\n					}\r\n				?>\r\n\r\n			<div class=\"blog-add-comment\">\r\n			<?php \r\n			$yform = new rex_yform();\r\n$yform->setObjectparams(\'form_name\', \'table-rex_blog_reply\');\r\n$yform->setObjectparams(\'form_action\',rex_getUrl(\'REX_ARTICLE_ID\'));\r\n$yform->setObjectparams(\'form_ytemplate\', \'bootstrap\');\r\n$yform->setObjectparams(\'form_showformafterupdate\', 0);\r\n$yform->setObjectparams(\'real_field_names\', true);\r\n\r\n// $yform->setObjectparams(\'getdata\',1);\r\n// $yform->setObjectparams(\'main_where\',\'id=3\');\r\n$yform->setObjectparams(\'main_table\',\'rex_blog_reply\');\r\n\r\n$yform->setValueField(\'text\', [\'name\',\'Name\',\'\',\'0\',\'\',\'Pflichtfeld aber beliebig.\']);\r\n$yform->setValueField(\'textarea\', [\'comment\',\'Antworttext\',\'\',\'0\',\'\',\'Pflichfeld\']);\r\n$yform->setValueField(\'email\', [\'mail\',\'Email-Adresse von \"anonymem\" Nutzer\',\'\',\'0\',\'\',\'Freiwillig, Vorteile siehe in den Erläuterungen.\']);\r\n\r\n// make it hidden fild works like this:\r\n$yform->setValueField(\'hidden\', [\'articleID\',\'REX_ARTICLE_ID\']); // ! value must be string here, else error, important when hard coded id used\r\n// ! and *NOT* like this:\r\n// $yform->setHiddenField(\'articleID\',\'REX_ARTICLE_ID\'); // ! is NOT dispatched to DB save but put into form\r\n\r\n$yform->setValueField(\'hidden\', [\'parentReplyID\',0]);\r\n// $yform->setHiddenField(\'parentReplyID\',123);\r\n\r\n// !!! must be set when yco mlogin possible in frontend\r\n// $yform->setValueField(\'be_manager_relation\', [\'ycomCreateUser\',\'Benutzer (yCom)\',\'rex_ycom_user\',\'login, \\\', \\\',email\',\'0\',\'1\',\'\',\'1\',\'\',\'\',\'\',\'Es ist geplant, nur den Ersteller ändern zu lassen. (Kein extra \"update user\"), anonym=0 oder emptystring\']);\r\n\r\n$yform->setValueField(\'datestamp\', [\'updatedate\',\'Änderungsdatum\',\'d.m.Y. H:i:s\',\'0\',\'0\',\'1\']);\r\n$yform->setValueField(\'datestamp\', [\'createdate\',\'Erstellungsdatum\',\'d.m.Y H:i:s\',\'0\',\'1\',\'1\']);\r\n$yform->setValueField(\'ip\', [\'createIP\',\'IP-Adresse (eigene Routine besser)\',\'0\']);\r\n$yform->setValidateField(\'empty\', [\'name\',\'Sie müssen einen Namen eingeben!!\']);\r\n$yform->setValueField(\'mediafile\', [\'portrait\',\'Avatar\',\'7000\',\'.png,.jpg,.jpeg\',\'\',\'\',\'0\',\'3\',\'Timm\',\'Lade ein Bild von dir hoch\']);\r\n\r\n// ! obviously you can define the validate fields here *without* having it selected in the yForm-backend-fields list\r\n$yform->setValidateField(\'empty\', [\'comment\',\'Sie müssen einen Text eingeben!!\']);\r\n\r\n// $yform->setActionField(\'tpl2email\', [\'emailtemplate\', \'emaillabel\', \'tth@kuehne-webdienste.de\']);\r\n// action|db|tblname|[where(id=2)/main_where]\r\n$yform->setActionField(\'db\',[\'rex_blog_reply\']);\r\n$yform->setActionField(\'html\',[\'Ihr Kommentar wurde gespeichert.\']);\r\n\r\n// dump ($yform->objparams);\r\necho $yform->getForm();\r\n			?>\r\n			<!--\r\n				!!!\r\n				- add hidden box which then explains what anonymous or registered comment means with privacy notes...\r\n				- also explains tah register is needed if user wants to edit or delete comment\r\n				- otherwise mail to tth@kuehne-webdienste.de\r\n				- the box appears on button click\r\n				- the box must be always there when no JS\r\n				- nicer: 2 tabs (bootstrap), not appearing until general \"kommentieren\" clicked\r\n			-->\r\n			<a id=\"new-comment\"></a>\r\n			<div id=\"comment-container\" class=\"<?php echo $isReEdit ? \'\' : \'collapse\'?>\">\r\n				<div  class=\"card\">\r\n					<div class=\"card-body\">\r\n						<h5 class=\"card-title\">Neuer Kommentar</h5>\r\n						<form action=\"<?=rex_getUrl(\'\')?>#preview-comment\" method=\"POST\">\r\n\r\n							<div class=\"form-row\">\r\n								<div class=\"form-group col-md-6\">\r\n									<label for=\"comment_name\">Name (beliebig):</label>\r\n									<input type=\"text\" class=\"form-control\" name=\"comment_name\" id=\"comment_name\" value=\"<?=$reEditName?>\"/>\r\n								</div>\r\n								<div class=\"form-group col-md-6\">\r\n									<label for=\"comment_mail\">E-Mail (freiwillig):</label>\r\n									<input type=\"mail\" class=\"form-control\" id=\"comment_mail\" name=\"comment_mail\" value=\"<?=$reEditMail?>\"/>\r\n								</div>\r\n							</div>\r\n\r\n							<div class=\"form-group\">\r\n								<label for=\"comment_body\">Text:</label>\r\n								<textarea class=\"form-control\" id=\"comment_body\" name=\"comment_body\" rows=\"5\"><?=$reEditBody?></textarea>\r\n							</div>\r\n\r\n							<input id=\"comment_anonymous_preview\" type=\"submit\" name=\"comment_preview\" value=\"Vorschau\"/>\r\n							<!-- <input id=\"comment_login\" type=\"submit\" name=\"action\" value=\"Anmelden und kommentieren\" />	 -->\r\n						</form>\r\n					</div>\r\n				</div>\r\n				<p></p>\r\n				<!-- card has no margin?? -->\r\n				<!-- !!! must be shown on preview too -->\r\n				<div class=\"card\">\r\n					<div class=\"card-body\">\r\n						<h5 class=\"card-title\">Erläuterung</h5>\r\n						<p>\r\n							blups di bla\r\n						</p>\r\n					</div>\r\n				</div>\r\n			</div>\r\n				\r\n					<?php if (!$isReEdit): ?>\r\n					<p>\r\n						<button id=\"btn-comment\" type=\"button\" class=\"btn btn-outline-success\" data-toggle=\"collapse\" data-target=\"#comment-container\" aria-expanded=\"false\" aria-controls=\"collapseExample\">Kommentar hinzufügen</button>\r\n					</p>\r\n					<?php endif; ?>\r\n\r\n			<?php \r\n				endif; // if (comment_preview)\r\n			?>\r\n		</div>\r\n		<?php endif; ?>\r\n    </div>\r\n\r\n	<footer class=\"footer\">\r\n      <div class=\"container\">\r\n        <span class=\"footer-item text-muted\"><a href=\"mailto:tth@kuehne-webdienste.de\">tth@kuehne-webdienste.de</a></span>\r\n        <span class=\"footer-item text-muted\"><a href=\"<?=rex_getUrl($imprintArticleId)?>\">Impressum</a></span>\r\n      </div>\r\n    </footer>\r\n\r\n    <!-- jQuery first, then Popper.js, then Bootstrap JS -->\r\n	<script src=\"https://code.jquery.com/jquery-3.5.1.slim.min.js\" integrity=\"sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj\" crossorigin=\"anonymous\"></script>\r\n	<script src=\"https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js\" integrity=\"sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN\" crossorigin=\"anonymous\"></script>\r\n	<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js\" integrity=\"sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s\" crossorigin=\"anonymous\"></script>\r\n\r\n	<script src=\"<?=theme_url::assets(\'vendor/jquery.auto-complete.min.js\')?>\"></script>\r\n	<!-- !!! not efficient because template output differs each call while JS code always the same EXCEPT WORDLIST-->\r\n	<script>\r\n		$(document).ready(function() {\r\n			$(\'#wordlistsearch\').autoComplete({\r\n				minChars: 1,\r\n				delay : 50,\r\n				source: function(term, suggest){\r\n					term = term.toLowerCase();\r\n					var choices = [<?=$completeWordList?>];\r\n					var matches = [];\r\n					for (i=0; i<choices.length; i++)\r\n						if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);\r\n					suggest(matches);\r\n				}\r\n			});\r\n		});\r\n	</script>\r\n  </body>\r\n</html>\r\n',0,'2020-05-22 16:29:56','Thomas','2020-10-29 21:27:50','Thomas','{\"ctype\":[],\"modules\":{\"1\":{\"all\":\"1\"}},\"categories\":{\"all\":\"1\"}}',0),
  (3,NULL,'Blog-Artikel','<?php\r\n    // set var if user active\r\n    $templateAllowed = true;\r\n    // include bootstrap\r\n    // $navTemplate = new rex_template(\'mkb_basis\');  // id des Basis-Template hart codiert!\r\n	// include $navTemplate->getFile();\r\n	$isBlog = true;\r\n?>\r\nREX_TEMPLATE[key=tth_basis] ',1,'2020-10-29 16:33:44','Thomas','2020-10-29 16:33:44','Thomas','{\"ctype\":[],\"modules\":{\"1\":{\"all\":\"1\"}},\"categories\":{\"0\":\"13\",\"all\":0}}',0);
/*!40000 ALTER TABLE `rex_template` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_user`;
CREATE TABLE `rex_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `language` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `startpage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_tries` tinyint(4) NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_changed` datetime NOT NULL,
  `previous_passwords` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_change_required` tinyint(1) NOT NULL,
  `lasttrydate` datetime NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cookiekey` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revision` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_user` WRITE;
/*!40000 ALTER TABLE `rex_user` DISABLE KEYS */;
INSERT INTO `rex_user` VALUES 
  (1,'Thomas Kühne','','Thomas','$2y$10$n3yTvrBB4VCre4mGedpB.uQUXNVM7X9xrWblkXKIwu/5d35jV2aIq','',1,1,'','','',0,'2020-05-20 12:56:07','setup','2020-10-23 17:21:34','Thomas','0000-00-00 00:00:00','',0,'2021-02-05 14:48:24','2021-02-05 14:48:24','j1lq6jn555ravfn131r3fhqn8i','',0),
  (2,'Timm','','Timm','$2y$10$2R3VFl9vlSO5OlzCWgg0J.w7iGWsulz0mFTAJJLv7C2A585MB4O.S','',1,0,'','','1',0,'2020-05-23 21:12:41','Thomas','0000-00-00 00:00:00','','0000-00-00 00:00:00','',0,'2020-10-23 21:23:06','2020-10-23 21:23:06','6fr37h3n8tps89nvu9hjutjtb6','',0);
/*!40000 ALTER TABLE `rex_user` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_user_role`;
CREATE TABLE `rex_user_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perms` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revision` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_user_role` WRITE;
/*!40000 ALTER TABLE `rex_user_role` DISABLE KEYS */;
INSERT INTO `rex_user_role` VALUES 
  (1,'Chefredakteur','darf tth Tabellen und Inhalte ändern.','{\"general\":\"|backup[export]|markitup[]|media[sync]|\",\"options\":\"|addArticle[]|addCategory[]|article2category[]|article2startarticle[]|copyArticle[]|copyContent[]|deleteArticle[]|deleteCategory[]|editArticle[]|editCategory[]|moveArticle[]|moveCategory[]|moveSlice[]|publishArticle[]|publishCategory[]|publishSlice[]|\",\"extras\":null,\"clang\":\"all\",\"media\":\"all\",\"structure\":\"all\",\"modules\":\"|4|3|2|\",\"yform_manager_table\":\"all\"}','2020-05-23 21:11:11','Thomas','2020-05-23 21:11:11','Thomas',0);
/*!40000 ALTER TABLE `rex_user_role` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_ycom_group`;
CREATE TABLE `rex_ycom_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_ycom_group` WRITE;
/*!40000 ALTER TABLE `rex_ycom_group` DISABLE KEYS */;
INSERT INTO `rex_ycom_group` VALUES 
  (1,'Blog kommentieren');
/*!40000 ALTER TABLE `rex_ycom_group` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_ycom_user`;
CREATE TABLE `rex_ycom_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `activation_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `termsofuse_accepted` tinyint(1) NOT NULL,
  `new_password_required` tinyint(1) NOT NULL,
  `last_action_time` datetime NOT NULL,
  `last_login_time` datetime NOT NULL,
  `termination_time` datetime NOT NULL,
  `login_tries` int(11) DEFAULT NULL,
  `ycom_groups` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_ycom_user` WRITE;
/*!40000 ALTER TABLE `rex_ycom_user` DISABLE KEYS */;
INSERT INTO `rex_ycom_user` VALUES 
  (1,'Tomkien','kuehnewebdienste@gmail.com','$2y$10$mK6fsKdQLgQ0eJ/G2j3rrOvkabaESqGowjlNl/G80vTHKR7lhS2ay','Thomas','Kühne','2','f3bc62645ec205d1b4496fbb91084e92','2d97bc118526a10fea73a90df38f965f',0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0,'1');
/*!40000 ALTER TABLE `rex_ycom_user` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_yform_email_template`;
CREATE TABLE `rex_yform_email_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_from` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_from_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_reply_to` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_reply_to_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_html` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachments` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yform_field`;
CREATE TABLE `rex_yform_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prio` int(11) NOT NULL,
  `type_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `list_hidden` tinyint(1) NOT NULL,
  `search` tinyint(1) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `not_required` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `notice` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `choices` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiple` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expanded` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `default` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `placeholder` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `table` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `field` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `empty_option` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `relation_table` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `empty_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `preview` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `precision` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `scale` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_db` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `only_empty` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashname` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_label` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_size` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `types` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fields` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `width` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `show_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `html` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `regex` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `pattern` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_date` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `widget` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `query` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_start` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_end` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `values` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rules` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `nonce_key` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `nonce_referer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sizes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `messages` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rules_message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `script` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `max` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `infotext_1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `infotext_2` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `columns` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `googleapikey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `server_var` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_yform_field` WRITE;
/*!40000 ALTER TABLE `rex_yform_field` DISABLE KEYS */;
INSERT INTO `rex_yform_field` VALUES 
  (4,'tth_autoren',1,'value','text','varchar(191)',0,1,'name','AutorName','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (5,'tth_autoren',2,'value','text','varchar(191)',0,1,'vorname','AutorVorname','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (6,'tth_autoren',3,'value','text','varchar(191)',0,1,'gnd','GND','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (7,'tth_sprachen',1,'value','text','varchar(191)',0,1,'sprache','Sprache des Begriffs','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (8,'tth_sprachstile',1,'value','text','varchar(191)',0,1,'stil','Sprachstil','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (9,'tth_begriffsstati',1,'value','text','varchar(191)',0,1,'status','Status','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (11,'tth_quellen',1,'value','text','text',0,1,'titel','Titel','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (12,'tth_quellen',2,'value','text','varchar(191)',0,1,'isbn','ISBN','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (13,'tth_quellen',3,'value','integer','int',0,1,'jahr','Jahr','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (14,'tth_quellen',4,'value','text','varchar(191)',0,1,'kurz','Kurzform','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (15,'tth_regionen',1,'value','text','varchar(191)',0,1,'region','Region','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (19,'tth_wortliste',1,'value','text','varchar(191)',0,1,'begriff','Begriff','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (20,'tth_wortliste',2,'value','textarea','text',1,0,'definition','Begriffsdefinition','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (25,'tth_wortliste',6,'value','text','varchar(191)',1,0,'code','Begriffscode','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (27,'tth_wortliste',8,'value','textarea','text',1,0,'notes','Scope Notes','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (34,'tth_wortliste',15,'value','text','varchar(191)',1,0,'datierung','Datierung','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (35,'tth_wortliste',16,'value','text','text',1,0,'historischer_hintergrund','Historischer Hintergrund','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (43,'tth_wortliste',21,'value','choice','varchar(191)',1,1,'kategorie','Eigenschaft Kategorie','','','ja=TRUE,nein=FALSE','0','0','FALSE','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (46,'tth_wortliste',22,'value','choice','varchar(16)',1,1,'veroeffentlichen','Veröffentlichen?','','','ja=TRUE,nein=FALSE','0','0','FALSE','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (47,'tth_wortliste',23,'value','choice','varchar(16)',1,1,'bearbeiten','Noch Bearbeiten','','','ja=TRUE,nein=FALSE','0','0','FALSE','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (49,'tth_wortliste',10,'value','be_manager_relation','int',1,0,'benutze','Beziehung Benutze','','(PLUS öffnet ein neues Browser-Fenster, dort 1 Eintrag übernehmen) ','','','','','','tth_wortliste','begriff','2','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (50,'tth_wortliste',5,'value','be_manager_relation','int',1,0,'autor_id','Autor','','','','','','','','tth_autoren','vorname, \' \', name','0','0','','','Du musst einen Autor definieren!','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (51,'tth_wortliste',7,'value','be_manager_relation','int',1,1,'begriffsstatus_id','Begriffsstatus','','','','','','','','tth_begriffsstati','status','0','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (52,'tth_begriff_grobgliederung',1,'value','be_manager_relation','int',1,0,'begriff_id','Begriff','','','','','','','','tth_wortliste','id','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (53,'tth_begriff_grobgliederung',2,'value','be_manager_relation','int',1,0,'grobgliederung_id','Zugeordnete Grobgliederung','','','','','','','','tth_wortliste','id','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (54,'tth_wortliste',4,'value','be_manager_relation','text',1,0,'grobgliederung_beziehung','Beziehung Grobgliederung','','(PLUS öffnet ein neues Browser-Fenster, dort können mehrere Einträge übernommen werden) ','','','','','','tth_wortliste','begriff','3','1','5','tth_begriff_grobgliederung','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (55,'tth_begriff_quellen',1,'value','be_manager_relation','int',1,0,'begriff_id','ID des Begriffes','','','','','','','','tth_wortliste','id','0','0','','','Begriffs-id muss immer angegeben werden','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (56,'tth_begriff_quellen',2,'value','be_manager_relation','int',1,0,'quelle_id','ID der Quelle','','','','','','','','tth_quellen','id','0','0','','','Quellen-id muss immer angegeben werden','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (59,'tth_begriff_oberbegriffe',1,'value','be_manager_relation','int',1,0,'begriff_id','Begriff ID','','','','','','','','tth_wortliste','id','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (60,'tth_begriff_oberbegriffe',2,'value','be_manager_relation','int',1,0,'oberbegriff_id','Beziehung Oberbegriff Begriff ID','','','','','','','','tth_wortliste','id','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (62,'tth_wortliste',11,'value','be_manager_relation','int',1,0,'beziehung_oberbegriffe','Oberbegriffe','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)','','','','','','tth_wortliste','begriff','3','1','3','tth_begriff_oberbegriffe','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (63,'tth_begriff_unterbegriffe',1,'value','be_manager_relation','int',1,0,'begriff_id','Begriff ID','','','','','','','','tth_wortliste','begriff','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (64,'tth_begriff_unterbegriffe',2,'value','be_manager_relation','int',1,0,'unterbegriff_id','Unterbegriff Begriff ID','','','','','','','','tth_wortliste','begriff','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (65,'tth_wortliste',12,'value','be_manager_relation','text',1,0,'beziehung_unterbegriffe','Unterbegriffe','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)','','','','','','tth_wortliste','begriff','3','1','7','tth_begriff_unterbegriffe','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (66,'tth_begriff_verwandte',1,'value','be_manager_relation','int',1,0,'begriff_id','Begriff ID','','','','','','','','tth_wortliste','begriff','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (67,'tth_begriff_verwandte',2,'value','be_manager_relation','int',1,0,'verwandter_id','Verwandter Begriff ID','','','','','','','','tth_wortliste','begriff','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (68,'tth_begriff_aequivalente',1,'value','be_manager_relation','int',1,0,'begriff_id','Begriff ID','','','','','','','','tth_wortliste','begriff','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (69,'tth_begriff_aequivalente',2,'value','be_manager_relation','int',1,0,'aequivalent_id','Äquivalenter Begriff ID','','','','','','','','tth_wortliste','begriff','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (70,'tth_wortliste',13,'value','be_manager_relation','int',1,0,'beziehung_verwandte','Verwandte Begriffe','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)','','','','','','tth_wortliste','begriff','3','1','5','tth_begriff_verwandte','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (71,'tth_wortliste',14,'value','be_manager_relation','int',1,0,'beziehung_aequivalente','Äquivalente Begriffe','','(PLUS öffnet neues Browser-Fenster, dort kannst du mehrere Einträge übernehmen)','','','','','','tth_wortliste','begriff','3','1','5','tth_begriff_aequivalente','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (72,'tth_wortliste',17,'value','be_manager_relation','int',0,1,'sprache_id','Sprache','','','','','','','','tth_sprachen','sprache','0','0','','','Bitte eine Sprache auswählen!','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (73,'tth_wortliste',18,'value','be_manager_relation','int',1,0,'region_id','Region','','','','','','','','tth_regionen','region','0','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (74,'tth_wortliste',19,'value','be_manager_relation','int',1,0,'sprachstil_id','Sprachstil','','','','','','','','tth_sprachstile','stil','0','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (75,'tth_wortliste',9,'value','be_media','text',1,0,'bild','Bild(er) aus Medienpool','','','','1','','','','','','','','','','','1','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (76,'tth_wortliste',3,'value','text','varchar(191)',1,1,'gnd','GND (Gemeinsame Normdatei)','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (79,'tth_quellenangaben',2,'value','text','int',0,0,'seitenzahl','Seite','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (80,'tth_quellenangaben',1,'value','be_manager_relation','int',0,1,'quelle_id','Quelle','','','','','','','','tth_quellen','kurz','2','0','','','Es muss eine Quelle verlinkt werden.','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (81,'tth_quellenangaben',3,'value','choice','varchar(16)',0,0,'bevorzugt','Bevorzugt?','','','{\"bevorzugt\":\"TRUE\"}','1','1','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (82,'tth_quellenangaben',4,'value','be_manager_relation','int',0,1,'begriff_id','Wort, zu dem die Angabe gehört','','','','','','','','tth_wortliste','begriff','2','0','','','Es muss ein Begriff zugeordnet werden.','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (83,'tth_quellen_autoren',1,'value','be_manager_relation','int',1,0,'autor_id','Autor','','','','','','','','tth_autoren','name, \', \', vorname','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (84,'tth_quellen_autoren',2,'value','be_manager_relation','int',1,0,'quelle_id','Quelle','','','','','','','','tth_quellen','kurz','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (85,'tth_quellen',5,'value','be_manager_relation','text',1,0,'quelle_autor','Autoren der Quelle','','','','','','','','tth_autoren','name, \', \', vorname','3','0','','tth_quellen_autoren','Bitte min. 1 Autor zuordnen','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (86,'tth_quellenangaben_felder',1,'value','text','varchar(191)',0,1,'name','Feldname','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (87,'tth_quellenangaben_felder',2,'value','text','varchar(191)',1,0,'bezeichnung','Bezeichnung','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (89,'tth_tabellennamen',1,'value','text','varchar(191)',0,1,'name','Tabellenname','','Bitte immer mit Präfix \"tth_\" notieren','','','','tth_','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (90,'tth_tabellennamen',2,'value','text','varchar(191)',0,1,'alter_name','Ursprünglicher Name','','','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (91,'tth_tabellennamen',3,'value','textarea','text',1,0,'beschreibung','Beschreibung','','Bitte so ausführlich wie möglich den jetztigen, zukünftigen Zweck und früheren Zweck erläutern','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (92,'tth_tabellennamen',4,'value','be_manager_relation','text',0,0,'beziehungen','Verknüpfte Tabellen','','wird in DB als kommagetrennte Liste von IDs gespeichert','','','','','','tth_tabellennamen','name','3','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (93,'tth_metabegriffe',1,'value','choice','text',0,0,'typ','Begriffstyp','','','Facette=facette,Grob-Klassifikation=grobklassifikation','0','0','','kein Typ ausgewählt','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (94,'tth_metabegriffe',2,'value','be_manager_relation','text',0,0,'begriff_id','Begriff','','','','','','','','tth_wortliste','begriff','2','0','','','Es muss ein bestehender Begriff ausgewählt werden','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (96,'tth_metabegriffe',3,'value','textarea','text',0,0,'beschreibung','Beschreibung','','','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (97,'rex_ycom_user',1,'value','html','',0,0,'html1','html1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','<div class=\"row\"><div class=\"col-md-6\">','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (98,'rex_ycom_user',2,'value','text','',1,1,'login','translate:login','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (99,'rex_ycom_user',3,'validate','empty','',1,0,'login','','','','','','','','','','','','','','','','','','','','','','','translate:ycom_please_enter_login','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (100,'rex_ycom_user',4,'validate','unique','',1,0,'login','','','','','','','','','rex_ycom_user','','','','','','','','','','','','','','translate:ycom_this_login_exists_already','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (101,'rex_ycom_user',5,'value','text','',0,1,'email','translate:email','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (102,'rex_ycom_user',6,'validate','empty','',1,0,'email','','','','','','','','','','','','','','','','','','','','','','','translate:ycom_please_enter_email','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (103,'rex_ycom_user',7,'validate','email','',1,0,'email','','','','','','','','','','','','','','','','','','','','','','','translate:ycom_please_enter_email','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (104,'rex_ycom_user',8,'validate','unique','',1,0,'email','','','','','','','','','rex_ycom_user','','','','','','','','','','','','','','translate:ycom_this_email_exists_already','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (105,'rex_ycom_user',9,'value','ycom_auth_password','',1,1,'password','translate:password','','','','','','','','','','','','','','','','','','','','','','translate:ycom_validate_password_policy_rules_error','','','','','','','','','','','','','','','','','','','','','','','{\"length\":{\"min\":8},\"letter\":{\"min\":1},\"lowercase\":{\"min\":1},\"uppercase\":{\"min\":1}}','','','','','','1','','','','','','','','',''),
  (106,'rex_ycom_user',10,'value','text','',0,1,'firstname','translate:firstname','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (107,'rex_ycom_user',11,'value','text','',0,1,'name','translate:name','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (108,'rex_ycom_user',12,'value','html','',0,0,'html2','html2','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','</div><div class=\"col-md-6\">','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (109,'rex_ycom_user',13,'value','choice','',0,1,'status','translate:status','','','translate:ycom_account_inactive_termination=-3,translate:ycom_account_inactive_logins=-2,translate:ycom_account_inactive=-1,translate:ycom_account_requested=0,translate:ycom_account_confirm=1,translate:ycom_account_active=2','0','','-1','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (110,'rex_ycom_user',14,'value','generate_key','',1,1,'activation_key','translate:activation_key','','','','','','','','','','','','','','','','','','','','','1','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (111,'rex_ycom_user',15,'value','generate_key','',1,1,'session_key','translate:session_key','','','','','','','','','','','','','','','','','','','','','1','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (112,'rex_ycom_user',16,'value','checkbox','tinyint(1)',1,1,'termsofuse_accepted','translate:termsofuse_accepted','','','','','','0','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (113,'rex_ycom_user',17,'value','checkbox','tinyint(1)',1,1,'new_password_required','translate:new_password_required','','','','','','0','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (114,'rex_ycom_user',18,'value','datestamp','',1,1,'last_action_time','translate:last_action_time','','','','','','','','','','','','','','','','','','','','','2','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (115,'rex_ycom_user',19,'value','datestamp','',1,1,'last_login_time','translate:last_login_time','','','','','','','','','','','','','','','','','','','','','2','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (116,'rex_ycom_user',20,'value','datestamp','',1,1,'termination_time','translate:termination_time','','','','','','','','','','','','','','','','','','','','','2','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (117,'rex_ycom_user',21,'value','integer','',0,1,'login_tries','translate:login_tries','','translate:ycom_login_tries_info','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (118,'rex_ycom_user',22,'value','html','',0,0,'html3','html3','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','</div></div>','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (119,'rex_ycom_user',23,'value','be_manager_relation','',1,1,'ycom_groups','translate:ycom_groups','','','','1','','','','rex_ycom_group','name','1','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (120,'rex_ycom_group',1,'value','text','',0,1,'name','translate:name','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (121,'rex_ycom_group',2,'validate','empty','',1,0,'name','','','','','','','','','','','','','','','','','','','','','','','translate:ycom_group_yform_enter_name','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (123,'rex_blog_reply',5,'value','integer','int',0,1,'parentReplyID','Übergeordnete Antwort','','ist ID einer anderen extistierenden Antwort. Wenn 0 (nicht gesetzt), ist es ein Kommentar direkt auf den Blog Post (article_id) and keine Antwort auf einen Kommentar.','','','','0','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (124,'rex_blog_reply',4,'value','be_link','text',0,1,'articleID','Blog Post','','Ein Blog Blog kann jeder beliebige Redaxo-Artikel sein.','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (127,'rex_blog_reply',8,'value','datestamp','datetime',0,0,'createdate','Erstellungsdatum','','','','','','','','','','','','','','','','','','','0','','1','','','','','','','','','','','','1','','','','d.m.Y H:i:s','','','','','','','','','','','','','','','','','','','','','','',''),
  (128,'rex_blog_reply',7,'value','datestamp','datetime',0,0,'updatedate','Änderungsdatum','','','','','','','','','','','','','','','','','','','0','','0','','','','','','','','','','','','1','','','','d.m.Y. H:i:s','','','','','','','','','','','','','','','','','','','','','','',''),
  (129,'rex_blog_reply',6,'value','be_manager_relation','int',0,1,'ycomCreateUser','Benutzer (yCom)','','Es ist geplant, nur den Ersteller ändern zu lassen. (Kein extra \"update user\"), anonym=0 oder emptystring','','','','','','rex_ycom_user','login, \', \',email','0','1','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (130,'rex_blog_reply',2,'value','textarea','text',0,0,'comment','Antworttext','','','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (131,'rex_blog_reply',1,'value','text','varchar(191)',0,1,'name','Name','','Pflichtfeld aber beliebig. Überschreibt gespeicherten Namen, wenn Anmeldung existiert!','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (132,'rex_blog_reply',9,'value','ip','varchar(191)',0,0,'createIP','IP-Adresse (eigene Routine besser)','','','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (133,'rex_blog_reply',3,'value','email','varchar(191)',0,1,'mail','Email-Adresse von \"anonymem\" Nutzer','','Freiwillig, wird nur benötift, um User zuordnung des Eintrages zu erlauben oder über das Projekt zu informieren.','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (134,'rex_blog_reply',10,'validate','empty','',1,0,'name','','','','','','','','','','','','','','','','','','','','','','','Sie müssen einen Namen eingeben!!','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (135,'rex_blog_reply',11,'value','mediafile','text',1,0,'portrait','Avatar','','Lade ein BIld von dir hoch','','','','','','','','','','','','','','3','','','0','','','','','','','7000','.png,.jpg,.jpeg','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','Timm');
/*!40000 ALTER TABLE `rex_yform_field` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_yform_history`;
CREATE TABLE `rex_yform_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataset_id` int(11) NOT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dataset` (`table_name`,`dataset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_yform_history` WRITE;
/*!40000 ALTER TABLE `rex_yform_history` DISABLE KEYS */;
INSERT INTO `rex_yform_history` VALUES 
  (1,'tth_wortliste',645,'update','Thomas','2020-05-28 18:53:38'),
  (2,'tth_wortliste',645,'update','Thomas','2020-05-28 18:58:49'),
  (3,'tth_wortliste',1923,'create','Thomas','2020-06-03 21:18:50'),
  (4,'tth_wortliste',1923,'update','Thomas','2020-06-03 21:21:02'),
  (5,'tth_wortliste',1923,'delete','Thomas','2020-06-03 21:26:23'),
  (6,'tth_wortliste',1524,'update','Thomas','2020-06-11 11:43:48'),
  (7,'tth_wortliste',1924,'create','Thomas','2020-06-19 11:35:37'),
  (8,'tth_wortliste',645,'update','Thomas','2020-06-26 10:31:32');
/*!40000 ALTER TABLE `rex_yform_history` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_yform_history_field`;
CREATE TABLE `rex_yform_history_field` (
  `history_id` int(11) NOT NULL,
  `field` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`history_id`,`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_yform_history_field` WRITE;
/*!40000 ALTER TABLE `rex_yform_history_field` DISABLE KEYS */;
INSERT INTO `rex_yform_history_field` VALUES 
  (1,'aequivalent',''),
  (1,'autor_id','2'),
  (1,'bearbeiten','FALSE'),
  (1,'begriff','Abbund'),
  (1,'begriffsstatus_id','2'),
  (1,'benutze','659'),
  (1,'benutzt_fuer','1060;1305;1524'),
  (1,'bild','values.jpg'),
  (1,'code',''),
  (1,'datierung',''),
  (1,'definition','Der Abbund bzw. das Abbinden, ist das maßgerechte Anreißen, Bearbeiten, Zusammenpassen und Kennzeichnen von Schnitt- und Rundholz für Tragwerke, Bauteile und Einbauteile.'),
  (1,'grobgliederung','1059'),
  (1,'historischer_hintergrund',''),
  (1,'kategorie','TRUE'),
  (1,'notes',''),
  (1,'oberbegriffe','954'),
  (1,'quelle_seite','427'),
  (1,'quellen_idlist','2;4;5;7;8;11'),
  (1,'region_id','0'),
  (1,'sprache_id','1'),
  (1,'sprachstil_id',''),
  (1,'unterbegriffe','647'),
  (1,'veroeffentlichen','FALSE'),
  (1,'verwandte_begriffe',''),
  (2,'aequivalent',''),
  (2,'autor_id','2'),
  (2,'bearbeiten','FALSE'),
  (2,'begriff','Abbund'),
  (2,'begriffsstatus_id','2'),
  (2,'benutze','659'),
  (2,'benutzt_fuer','1060;1305;1524'),
  (2,'bild','values.jpg'),
  (2,'code',''),
  (2,'datierung',''),
  (2,'definition','bzw. das Abbinden, ist das maßgerechte Anreißen, Bearbeiten, Zusammenpassen und Kennzeichnen von Schnitt- und Rundholz für Tragwerke, Bauteile und Einbauteile.'),
  (2,'grobgliederung','1059'),
  (2,'historischer_hintergrund',''),
  (2,'kategorie','TRUE'),
  (2,'notes',''),
  (2,'oberbegriffe','954'),
  (2,'quelle_seite','427'),
  (2,'quellen_idlist','2;4;5;7;8;11'),
  (2,'region_id','0'),
  (2,'sprache_id','1'),
  (2,'sprachstil_id',''),
  (2,'unterbegriffe','647'),
  (2,'veroeffentlichen','FALSE'),
  (2,'verwandte_begriffe',''),
  (3,'aequivalent',''),
  (3,'autor_id','4'),
  (3,'bearbeiten','FALSE'),
  (3,'begriff','Thomasbalken'),
  (3,'begriffsstatus_id','7'),
  (3,'benutze',''),
  (3,'benutzt_fuer',''),
  (3,'bild',''),
  (3,'code',''),
  (3,'datierung',''),
  (3,'definition','Das ist ein ganz Besonderer.'),
  (3,'grobgliederung',''),
  (3,'historischer_hintergrund',''),
  (3,'kategorie','FALSE'),
  (3,'notes',''),
  (3,'oberbegriffe',''),
  (3,'quelle_seite',''),
  (3,'quellen_idlist',''),
  (3,'region_id','1'),
  (3,'sprache_id','1'),
  (3,'sprachstil_id','1'),
  (3,'unterbegriffe',''),
  (3,'veroeffentlichen','FALSE'),
  (3,'verwandte_begriffe',''),
  (4,'aequivalent',''),
  (4,'autor_id','4'),
  (4,'bearbeiten','FALSE'),
  (4,'begriff','Thomasbalken'),
  (4,'begriffsstatus_id','7'),
  (4,'benutze',''),
  (4,'benutzt_fuer',''),
  (4,'bild',''),
  (4,'code',''),
  (4,'datierung',''),
  (4,'definition','Das ist ein ganz Besonderer.'),
  (4,'grobgliederung',''),
  (4,'historischer_hintergrund',''),
  (4,'kategorie','FALSE'),
  (4,'notes',''),
  (4,'oberbegriffe',''),
  (4,'quelle_seite',''),
  (4,'quellen_idlist',''),
  (4,'region_id','1'),
  (4,'sprache_id','1'),
  (4,'sprachstil_id','1'),
  (4,'unterbegriffe',''),
  (4,'veroeffentlichen','FALSE'),
  (4,'verwandte_begriffe',''),
  (5,'aequivalent',''),
  (5,'autor_id','4'),
  (5,'bearbeiten','FALSE'),
  (5,'begriff','Thomasbalken'),
  (5,'begriffsstatus_id','7'),
  (5,'benutze',''),
  (5,'benutzt_fuer',''),
  (5,'bild',''),
  (5,'code',''),
  (5,'datierung',''),
  (5,'definition','Das ist ein ganz Besonderer.'),
  (5,'grobgliederung',''),
  (5,'historischer_hintergrund',''),
  (5,'kategorie','FALSE'),
  (5,'notes',''),
  (5,'oberbegriffe',''),
  (5,'quelle_seite',''),
  (5,'quellen_idlist',''),
  (5,'region_id','1'),
  (5,'sprache_id','1'),
  (5,'sprachstil_id','1'),
  (5,'unterbegriffe',''),
  (5,'veroeffentlichen','FALSE'),
  (5,'verwandte_begriffe',''),
  (6,'aequivalent',''),
  (6,'autor_id','8'),
  (6,'bearbeiten','FALSE'),
  (6,'begriff','Timber framing'),
  (6,'begriffsstatus_id','3'),
  (6,'benutze','645'),
  (6,'benutzt_fuer','645;1060;1305'),
  (6,'bild',''),
  (6,'code',''),
  (6,'datierung',''),
  (6,'definition','(Timber) framing / Abbund\r\nManufacturing of joints and assembly of converted timbers into a timber frame. After that the whole construction is usually taken apart and reassembled during the final raising of the building.\r\nHerstellung der Holzverbindungen und Zusammenfügen der in ihren Querschnitten fertig zugerichteten Hölzer. Danach wird die gesamte Konstruktion meist wieder zerlegt und erst bei der Aufrichtung des Baues endgültig zusammengefügt.'),
  (6,'gnd',''),
  (6,'grobgliederung','1058'),
  (6,'historischer_hintergrund',''),
  (6,'kategorie','FALSE'),
  (6,'liste_quellenangaben',''),
  (6,'notes',''),
  (6,'oberbegriffe',''),
  (6,'quelle_seite','411'),
  (6,'quellen_idlist','8'),
  (6,'region_id','0'),
  (6,'sprache_id','2'),
  (6,'sprachstil_id',''),
  (6,'unterbegriffe',''),
  (6,'veroeffentlichen','FALSE'),
  (6,'verwandte_begriffe',''),
  (7,'aequivalent',''),
  (7,'autor_id','1'),
  (7,'bearbeiten','FALSE'),
  (7,'begriff','Facette'),
  (7,'begriffsstatus_id','7'),
  (7,'benutze','0'),
  (7,'benutzt_fuer',''),
  (7,'bild',''),
  (7,'code',''),
  (7,'datierung',''),
  (7,'definition','Dies ist ein kategorischer Überbegriff auf der höchsten Stufe und dient der Strukturierung des Thesaurus. Somit ist sie selbst kein Begriff und keine Benennung aus dem Holzbau.'),
  (7,'gnd',''),
  (7,'grobgliederung',''),
  (7,'historischer_hintergrund',''),
  (7,'kategorie','FALSE'),
  (7,'liste_quellenangaben',''),
  (7,'notes',''),
  (7,'oberbegriffe',''),
  (7,'quelle_seite',''),
  (7,'quellen_idlist',''),
  (7,'region_id','0'),
  (7,'sprache_id','1'),
  (7,'sprachstil_id','0'),
  (7,'unterbegriffe',''),
  (7,'veroeffentlichen','FALSE'),
  (7,'verwandte_begriffe',''),
  (8,'aequivalent',''),
  (8,'autor_id','2'),
  (8,'bearbeiten','FALSE'),
  (8,'begriff','Abbund'),
  (8,'begriffsstatus_id','2'),
  (8,'benutze','0'),
  (8,'benutzt_fuer','1060;1305;1524'),
  (8,'bild','values.jpg'),
  (8,'code',''),
  (8,'datierung',''),
  (8,'definition','bzw. das Abbinden, ist das maßgerechte Anreißen, Bearbeiten, Zusammenpassen und Kennzeichnen von Schnitt- und Rundholz für Tragwerke, Bauteile und Einbauteile.'),
  (8,'gnd',''),
  (8,'grobgliederung','1059'),
  (8,'historischer_hintergrund',''),
  (8,'kategorie','TRUE'),
  (8,'liste_quellenangaben',''),
  (8,'notes',''),
  (8,'oberbegriffe','954'),
  (8,'quelle_seite','427'),
  (8,'quellen_idlist','2;4;5;7;8;11'),
  (8,'region_id','0'),
  (8,'sprache_id','1'),
  (8,'sprachstil_id','0'),
  (8,'unterbegriffe','647'),
  (8,'veroeffentlichen','FALSE'),
  (8,'verwandte_begriffe','');
/*!40000 ALTER TABLE `rex_yform_history_field` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_yform_table`;
CREATE TABLE `rex_yform_table` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL,
  `table_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `list_amount` int(11) NOT NULL DEFAULT 50,
  `list_sortfield` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'id',
  `list_sortorder` enum('ASC','DESC') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ASC',
  `prio` int(11) NOT NULL,
  `search` tinyint(1) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `export` tinyint(1) NOT NULL,
  `import` tinyint(1) NOT NULL,
  `mass_deletion` tinyint(1) NOT NULL,
  `mass_edit` tinyint(1) NOT NULL,
  `schema_overwrite` tinyint(1) NOT NULL DEFAULT 1,
  `history` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_name` (`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_yform_table` WRITE;
/*!40000 ALTER TABLE `rex_yform_table` DISABLE KEYS */;
INSERT INTO `rex_yform_table` VALUES 
  (1,1,'tth_autoren','Autoren','',50,'id','ASC',3,0,0,0,0,0,0,1,0),
  (2,1,'tth_sprachen','Sprachen','',50,'id','ASC',5,0,0,0,0,0,0,1,0),
  (3,1,'tth_sprachstile','Sprachstile','',50,'id','ASC',6,0,0,1,0,0,0,1,0),
  (4,1,'tth_begriffsstati','Begriffs-Stati','',50,'id','ASC',7,0,0,0,0,0,0,1,0),
  (5,1,'tth_quellen','Quellen','',50,'id','ASC',10,0,0,0,0,0,0,1,0),
  (6,1,'tth_regionen','Regionen','',50,'id','ASC',12,0,0,0,0,0,0,1,0),
  (7,1,'tth_wortliste','Begriffe','Haupttabelle der DB, enthält Referenzen auf andere Tabellen sowie auf eigene Einträge über Beziehungs-Auswahllisten. Einige der ursprünglichen Felder sind nur im \"Frontend\" sichtbar.',50,'id','ASC',1,1,0,1,1,0,0,1,1),
  (8,0,'tth_begriff_grobgliederung','Beziehung Begriff zu Grobgliederung','many-to-many',50,'id','ASC',13,0,0,0,0,0,0,0,0),
  (9,0,'tth_begriff_quellen','ND_Text Quellen','jedem Text können beliebig viele Quellen zugrordnet werden. Das Seitenzahl-Problem erfordert eigentlich ein 3-stufiges Konzept mit 1 Tabelle mehr.',50,'id','ASC',14,0,0,0,0,0,0,1,0),
  (10,0,'tth_begriff_oberbegriffe','Beziehung Begriff zu Oberbegriffen','',50,'id','ASC',15,0,0,0,0,0,0,1,0),
  (11,0,'tth_begriff_unterbegriffe','Beziehung Begriff zu Unterbegriffen','',50,'id','ASC',16,0,0,0,0,0,0,1,0),
  (12,0,'tth_begriff_verwandte','Beziehung Verwandte Begriffe','',50,'id','ASC',17,0,0,0,0,0,0,1,0),
  (13,0,'tth_begriff_aequivalente','Beziehung Begriff zu Äquivalenten','',50,'id','ASC',18,0,0,0,0,0,0,1,0),
  (14,1,'tth_quellenangaben','Quellenangaben','',50,'id','ASC',8,1,0,0,0,0,0,1,0),
  (15,0,'tth_quellen_autoren','Autoren für Quellen','',50,'id','ASC',11,0,1,0,0,0,0,1,0),
  (16,0,'tth_quellenangaben_felder','Felder für Quellenangaben','Feldtypen, auf die sich Quellenangaben beziehen können',50,'id','ASC',9,0,0,0,0,0,0,1,0),
  (17,1,'tth_tabellennamen','Tabellen-Benennung','Dient der Dokumentation des Tabellensystems. Wichtig!: Namen müssen exakt mit tatsächlich existierenden Tabellen übereinstimmen',50,'id','ASC',19,0,0,0,0,0,0,1,0),
  (18,1,'tth_metabegriffe','Meta-Begriffe','Definiert besondere Begriffe für die Verwendung als \"Grobgliederung\".',50,'id','ASC',20,0,0,0,0,0,0,1,0),
  (19,1,'rex_ycom_user','translate:rex_ycom_user','',100,'login','DESC',2,1,0,1,1,0,0,1,0),
  (20,1,'rex_ycom_group','translate:ycom_group_name','',200,'name','ASC',4,0,0,1,1,0,0,1,0),
  (21,1,'rex_blog_reply','Blog Reply','Each entry is a reply. An initial comment is as special reply with replyID=0. Otherwise replyID is ID of an existing reply which results in \"reply trees\" (matter of correct output format).',50,'id','ASC',21,0,0,1,0,1,1,1,0);
/*!40000 ALTER TABLE `rex_yform_table` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_yrewrite_alias`;
CREATE TABLE `rex_yrewrite_alias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alias_domain` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain_id` int(11) NOT NULL,
  `clang_start` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yrewrite_domain`;
CREATE TABLE `rex_yrewrite_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mount_id` int(11) NOT NULL,
  `start_id` int(11) NOT NULL,
  `notfound_id` int(11) NOT NULL,
  `clangs` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clang_start` int(11) NOT NULL,
  `clang_start_auto` tinyint(1) NOT NULL,
  `clang_start_hidden` tinyint(1) NOT NULL,
  `robots` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_scheme` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auto_redirect` tinyint(1) NOT NULL,
  `auto_redirect_days` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yrewrite_forward`;
CREATE TABLE `rex_yrewrite_forward` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `article_id` int(11) NOT NULL,
  `clang` int(11) NOT NULL,
  `extern` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `media` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `movetype` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
SET FOREIGN_KEY_CHECKS = 1;
