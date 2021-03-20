## Redaxo Database Dump Version 5
## Prefix rex_
## charset utf8

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `rex_action`;
CREATE TABLE `rex_action` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `preview` text COLLATE utf8_unicode_ci,
  `presave` text COLLATE utf8_unicode_ci,
  `postsave` text COLLATE utf8_unicode_ci,
  `previewmode` tinyint DEFAULT NULL,
  `presavemode` tinyint DEFAULT NULL,
  `postsavemode` tinyint DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `revision` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_article`;
CREATE TABLE `rex_article` (
  `pid` int unsigned NOT NULL AUTO_INCREMENT,
  `id` int unsigned NOT NULL,
  `parent_id` int unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `catname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `catpriority` int unsigned NOT NULL,
  `startarticle` tinyint(1) NOT NULL,
  `priority` int unsigned NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `template_id` int unsigned NOT NULL,
  `clang_id` int unsigned NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `revision` int unsigned NOT NULL,
  `art_online_from` text COLLATE utf8_unicode_ci,
  `art_online_to` text COLLATE utf8_unicode_ci,
  `art_file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `art_darken` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `art_gallery` text COLLATE utf8_unicode_ci,
  `cat_pic` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cat_description` text COLLATE utf8_unicode_ci,
  `cat_teaser_legend` text COLLATE utf8_unicode_ci,
  `art_description` text COLLATE utf8_unicode_ci,
  `art_keywords` text COLLATE utf8_unicode_ci,
  `art_title` text COLLATE utf8_unicode_ci,
  `yrewrite_url_type` enum('AUTO','CUSTOM','REDIRECTION_INTERNAL','REDIRECTION_EXTERNAL') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'AUTO',
  `yrewrite_url` text COLLATE utf8_unicode_ci NOT NULL,
  `yrewrite_redirection` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `yrewrite_title` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `yrewrite_description` text COLLATE utf8_unicode_ci NOT NULL,
  `yrewrite_changefreq` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `yrewrite_priority` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `yrewrite_index` tinyint(1) NOT NULL,
  `yrewrite_canonical_url` text COLLATE utf8_unicode_ci NOT NULL,
  `ycom_auth_type` int NOT NULL,
  `ycom_group_type` int NOT NULL,
  `ycom_groups` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `find_articles` (`id`,`clang_id`),
  KEY `id` (`id`),
  KEY `clang_id` (`clang_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_article_slice`;
CREATE TABLE `rex_article_slice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `clang_id` int unsigned NOT NULL,
  `ctype_id` int unsigned NOT NULL,
  `module_id` int unsigned NOT NULL,
  `revision` int NOT NULL,
  `priority` int unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `value1` mediumtext COLLATE utf8_unicode_ci,
  `value2` mediumtext COLLATE utf8_unicode_ci,
  `value3` mediumtext COLLATE utf8_unicode_ci,
  `value4` mediumtext COLLATE utf8_unicode_ci,
  `value5` mediumtext COLLATE utf8_unicode_ci,
  `value6` mediumtext COLLATE utf8_unicode_ci,
  `value7` mediumtext COLLATE utf8_unicode_ci,
  `value8` mediumtext COLLATE utf8_unicode_ci,
  `value9` mediumtext COLLATE utf8_unicode_ci,
  `value10` mediumtext COLLATE utf8_unicode_ci,
  `value11` mediumtext COLLATE utf8_unicode_ci,
  `value12` mediumtext COLLATE utf8_unicode_ci,
  `value13` mediumtext COLLATE utf8_unicode_ci,
  `value14` mediumtext COLLATE utf8_unicode_ci,
  `value15` mediumtext COLLATE utf8_unicode_ci,
  `value16` mediumtext COLLATE utf8_unicode_ci,
  `value17` mediumtext COLLATE utf8_unicode_ci,
  `value18` mediumtext COLLATE utf8_unicode_ci,
  `value19` mediumtext COLLATE utf8_unicode_ci,
  `value20` mediumtext COLLATE utf8_unicode_ci,
  `media1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media4` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media5` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media6` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media7` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media8` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media9` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media10` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `medialist1` text COLLATE utf8_unicode_ci,
  `medialist2` text COLLATE utf8_unicode_ci,
  `medialist3` text COLLATE utf8_unicode_ci,
  `medialist4` text COLLATE utf8_unicode_ci,
  `medialist5` text COLLATE utf8_unicode_ci,
  `medialist6` text COLLATE utf8_unicode_ci,
  `medialist7` text COLLATE utf8_unicode_ci,
  `medialist8` text COLLATE utf8_unicode_ci,
  `medialist9` text COLLATE utf8_unicode_ci,
  `medialist10` text COLLATE utf8_unicode_ci,
  `link1` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link2` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link3` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link4` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link5` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link6` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link7` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link8` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link9` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link10` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linklist1` text COLLATE utf8_unicode_ci,
  `linklist2` text COLLATE utf8_unicode_ci,
  `linklist3` text COLLATE utf8_unicode_ci,
  `linklist4` text COLLATE utf8_unicode_ci,
  `linklist5` text COLLATE utf8_unicode_ci,
  `linklist6` text COLLATE utf8_unicode_ci,
  `linklist7` text COLLATE utf8_unicode_ci,
  `linklist8` text COLLATE utf8_unicode_ci,
  `linklist9` text COLLATE utf8_unicode_ci,
  `linklist10` text COLLATE utf8_unicode_ci,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `group_template` int NOT NULL,
  `group_closed` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `slice_priority` (`article_id`,`priority`,`module_id`),
  KEY `clang_id` (`clang_id`),
  KEY `article_id` (`article_id`),
  KEY `find_slices` (`clang_id`,`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_clang`;
CREATE TABLE `rex_clang` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `priority` int unsigned NOT NULL,
  `status` tinyint(1) NOT NULL,
  `revision` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `rex_clang` WRITE;
/*!40000 ALTER TABLE `rex_clang` DISABLE KEYS */;
INSERT INTO `rex_clang` VALUES 
  (1,'de','deutsch',1,1,0);
/*!40000 ALTER TABLE `rex_clang` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_config`;
CREATE TABLE `rex_config` (
  `namespace` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`namespace`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  ('core','package-config','{\"backup\":{\"install\":true,\"status\":true},\"be_style\":{\"install\":true,\"status\":true,\"plugins\":{\"customizer\":{\"install\":true,\"status\":true},\"redaxo\":{\"install\":true,\"status\":true}}},\"cronjob\":{\"install\":true,\"status\":true,\"plugins\":{\"article_status\":{\"install\":false,\"status\":false},\"optimize_tables\":{\"install\":false,\"status\":false}}},\"debug\":{\"install\":false,\"status\":false},\"developer\":{\"install\":true,\"status\":true},\"install\":{\"install\":true,\"status\":true},\"markitup\":{\"install\":true,\"status\":true,\"plugins\":{\"documentation\":{\"install\":false,\"status\":false}}},\"media_manager\":{\"install\":true,\"status\":true},\"mediapool\":{\"install\":true,\"status\":true},\"metainfo\":{\"install\":true,\"status\":true},\"phpmailer\":{\"install\":true,\"status\":true},\"project\":{\"install\":true,\"status\":true},\"sprog\":{\"install\":true,\"status\":true},\"structure\":{\"install\":true,\"status\":true,\"plugins\":{\"content\":{\"install\":true,\"status\":true},\"history\":{\"install\":false,\"status\":false},\"version\":{\"install\":false,\"status\":false}}},\"theme\":{\"install\":true,\"status\":true},\"users\":{\"install\":true,\"status\":true},\"ycom\":{\"install\":true,\"status\":true,\"plugins\":{\"auth\":{\"install\":true,\"status\":true},\"docs\":{\"install\":true,\"status\":true},\"group\":{\"install\":true,\"status\":true},\"media_auth\":{\"install\":false,\"status\":false}}},\"yform\":{\"install\":true,\"status\":true,\"plugins\":{\"email\":{\"install\":true,\"status\":true},\"manager\":{\"install\":true,\"status\":true},\"rest\":{\"install\":false,\"status\":false},\"tools\":{\"install\":false,\"status\":false}}},\"yrewrite\":{\"install\":true,\"status\":true}}'),
  ('core','package-order','[\"be_style\",\"be_style\\/customizer\",\"be_style\\/redaxo\",\"users\",\"backup\",\"cronjob\",\"developer\",\"install\",\"markitup\",\"media_manager\",\"mediapool\",\"phpmailer\",\"sprog\",\"structure\",\"metainfo\",\"structure\\/content\",\"theme\",\"yform\",\"yform\\/email\",\"yform\\/manager\",\"yrewrite\",\"ycom\",\"ycom\\/auth\",\"ycom\\/docs\",\"ycom\\/group\",\"project\"]'),
  ('core','utf8mb4','false'),
  ('core','version','\"5.12.0\"'),
  ('developer','actions','true'),
  ('developer','delete','true'),
  ('developer','dir_suffix','true'),
  ('developer','items','{\"templates\":{\"1\":1616250704}}'),
  ('developer','modules','true'),
  ('developer','prefix','true'),
  ('developer','rename','true'),
  ('developer','sync_backend','true'),
  ('developer','sync_frontend','true'),
  ('developer','templates','true'),
  ('developer','umlauts','false'),
  ('developer','yform_email','true'),
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
  ('phpmailer','from','\"\"'),
  ('phpmailer','fromname','\"Mailer\"'),
  ('phpmailer','host','\"localhost\"'),
  ('phpmailer','logging','0'),
  ('phpmailer','mailer','\"smtp\"'),
  ('phpmailer','password','\"\"'),
  ('phpmailer','port','587'),
  ('phpmailer','priority','0'),
  ('phpmailer','security_mode','false'),
  ('phpmailer','smtp_debug','\"0\"'),
  ('phpmailer','smtpauth','true'),
  ('phpmailer','smtpsecure','\"tls\"'),
  ('phpmailer','test_address','\"\"'),
  ('phpmailer','username','\"\"'),
  ('phpmailer','wordwrap','120'),
  ('sprog','chunkSizeArticles','4'),
  ('theme','include_be_files','false'),
  ('theme','synchronize_actions','false'),
  ('theme','synchronize_modules','false'),
  ('theme','synchronize_templates','false'),
  ('theme','synchronize_yformemails','false'),
  ('ycom','auth_cookie_ttl','\"14\"'),
  ('ycom','login_field','\"email\"'),
  ('ycom/auth','auth_rule','\"login_try_5_pause\"'),
  ('yrewrite','unicode_urls','false'),
  ('yrewrite','yrewrite_hide_url_block','false');
/*!40000 ALTER TABLE `rex_config` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_cronjob`;
CREATE TABLE `rex_cronjob` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8_unicode_ci,
  `interval` text COLLATE utf8_unicode_ci NOT NULL,
  `nexttime` datetime DEFAULT NULL,
  `environment` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `execution_moment` tinyint(1) NOT NULL,
  `execution_start` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_markitup_profiles`;
CREATE TABLE `rex_markitup_profiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `urltype` varchar(50) NOT NULL,
  `minheight` smallint unsigned NOT NULL,
  `maxheight` smallint unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `markitup_buttons` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_markitup_profiles` WRITE;
/*!40000 ALTER TABLE `rex_markitup_profiles` DISABLE KEYS */;
INSERT INTO `rex_markitup_profiles` VALUES 
  (1,'textile_full','Textile default configuration','relative',300,800,'textile','bold,code,clips[Snippetname1=Snippettext1|Snippetname2=Snippettext2],deleted,emaillink,externallink,groupheading[1|2|3|4|5|6],grouplink[file|internal|external|mailto],heading1,heading2,heading3,heading4,heading5,heading6,internallink,italic,media,medialink,orderedlist,paragraph,quote,sub,sup,table,underline,unorderedlist'),
  (2,'markdown_full','Markdown default configuration','relative',300,800,'markdown','bold,code,clips[Snippetname1=Snippettext1|Snippetname2=Snippettext2],deleted,emaillink,externallink,groupheading[1|2|3|4|5|6],grouplink[file|internal|external|mailto],heading1,heading2,heading3,heading4,heading5,heading6,internallink,italic,media,medialink,orderedlist,paragraph,quote,sub,sup,table,underline,unorderedlist');
/*!40000 ALTER TABLE `rex_markitup_profiles` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_markitup_snippets`;
CREATE TABLE `rex_markitup_snippets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `lang` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_media`;
CREATE TABLE `rex_media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `attributes` text COLLATE utf8_unicode_ci,
  `filetype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originalname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filesize` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `revision` int unsigned NOT NULL,
  `med_description` text COLLATE utf8_unicode_ci,
  `med_darken` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `med_gallery_legend` text COLLATE utf8_unicode_ci,
  `med_gallery_title` text COLLATE utf8_unicode_ci,
  `med_gallery_text` text COLLATE utf8_unicode_ci,
  `med_gallery_link_text` text COLLATE utf8_unicode_ci,
  `med_gallery_link` text COLLATE utf8_unicode_ci,
  `med_description_en` text COLLATE utf8_unicode_ci,
  `med_title_en` text COLLATE utf8_unicode_ci,
  `med_gallery_title_en` text COLLATE utf8_unicode_ci,
  `med_gallery_text_en` text COLLATE utf8_unicode_ci,
  `med_gallery_link_text_en` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_media_category`;
CREATE TABLE `rex_media_category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int unsigned NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8_unicode_ci,
  `revision` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_media_manager_type`;
CREATE TABLE `rex_media_manager_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` int unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `rex_media_manager_type` WRITE;
/*!40000 ALTER TABLE `rex_media_manager_type` DISABLE KEYS */;
INSERT INTO `rex_media_manager_type` VALUES 
  (1,1,'rex_mediapool_detail','Zur Darstellung von Bildern in der Detailansicht im Medienpool','2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (2,1,'rex_mediapool_maximized','Zur Darstellung von Bildern im Medienpool wenn maximiert','2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (3,1,'rex_mediapool_preview','Zur Darstellung der Vorschaubilder im Medienpool','2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (4,1,'rex_mediabutton_preview','Zur Darstellung der Vorschaubilder in REX_MEDIA_BUTTON[]s','2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (5,1,'rex_medialistbutton_preview','Zur Darstellung der Vorschaubilder in REX_MEDIALIST_BUTTON[]s','2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend');
/*!40000 ALTER TABLE `rex_media_manager_type` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_media_manager_type_effect`;
CREATE TABLE `rex_media_manager_type_effect` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int unsigned NOT NULL,
  `effect` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parameters` text COLLATE utf8_unicode_ci NOT NULL,
  `priority` int unsigned NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `rex_media_manager_type_effect` WRITE;
/*!40000 ALTER TABLE `rex_media_manager_type_effect` DISABLE KEYS */;
INSERT INTO `rex_media_manager_type_effect` VALUES 
  (1,1,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"200\",\"rex_effect_resize_height\":\"200\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (2,2,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"600\",\"rex_effect_resize_height\":\"600\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (3,3,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"80\",\"rex_effect_resize_height\":\"80\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (4,4,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"246\",\"rex_effect_resize_height\":\"246\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend'),
  (5,5,'resize','{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"\",\"rex_effect_crop_height\":\"\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_amount\":\"80\",\"rex_effect_filter_blur_radius\":\"8\",\"rex_effect_filter_blur_threshold\":\"3\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"246\",\"rex_effect_resize_height\":\"246\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"not_enlarge\"},\"rex_effect_workspace\":{\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\"}}',1,'2021-03-20 16:31:44','backend','2021-03-20 16:31:44','backend');
/*!40000 ALTER TABLE `rex_media_manager_type_effect` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_metainfo_field`;
CREATE TABLE `rex_metainfo_field` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `priority` int unsigned NOT NULL,
  `attributes` text COLLATE utf8_unicode_ci NOT NULL,
  `type_id` int unsigned DEFAULT NULL,
  `default` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `validate` text COLLATE utf8_unicode_ci,
  `callback` text COLLATE utf8_unicode_ci,
  `restrictions` text COLLATE utf8_unicode_ci,
  `templates` text COLLATE utf8_unicode_ci,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_metainfo_type`;
CREATE TABLE `rex_metainfo_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dbtype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dblength` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `output` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `input` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8_unicode_ci,
  `revision` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_module_action`;
CREATE TABLE `rex_module_action` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int unsigned NOT NULL,
  `action_id` int unsigned NOT NULL,
  `revision` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_redactor2_profiles`;
CREATE TABLE `rex_redactor2_profiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `urltype` varchar(191) NOT NULL,
  `externalurltarget` text NOT NULL,
  `minheight` int NOT NULL,
  `maxheight` int NOT NULL,
  `characterlimit` int NOT NULL,
  `toolbarfixed` tinyint(1) NOT NULL,
  `shortcuts` tinyint(1) NOT NULL,
  `linkify` tinyint(1) NOT NULL,
  `imagetag` text NOT NULL,
  `redactor_plugins` text NOT NULL,
  `redactor_customplugins` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_redactor2_profiles` WRITE;
/*!40000 ALTER TABLE `rex_redactor2_profiles` DISABLE KEYS */;
INSERT INTO `rex_redactor2_profiles` VALUES 
  (1,'full','Standard Redactor-Konfiguration','relative','',300,800,0,0,0,0,'','alignment,blockquote,bold,cleaner,clips[Snippetname1=Snippettext1|Snippetname2=Snippettext2],deleted,emaillink,externallink,fontcolor[Weiss=#ffffff|Schwarz=#000000],fontfamily[Arial|Times],fontsize[12px|15pt|120%],fullscreen,groupheading[1|2|3|4|5|6],grouplink[email|external|internal|media],grouplist[unorderedlist|orderedlist|indent|outdent],heading1,heading2,heading3,heading4,heading5,heading6,horizontalrule,internallink,italic,media,medialink,orderedlist,paragraph,properties,redo,source,styles[code=Code|kbd=Shortcut|mark=Markiert|samp=Sample|var=Variable],sub,sup,table,textdirection,underline,undo,unorderedlist',''),
  (2,'demo','Redactor-Konfiguration für die Demo','relative','',300,800,0,1,1,0,'','groupheading[1|2|3|4|5|6],alignment,bold,italic,unorderedlist,orderedlist,blockquote,table,grouplink[email|external|internal|media],horizontalrule,cleaner,fullscreen,properties,source','');
/*!40000 ALTER TABLE `rex_redactor2_profiles` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_sprog_wildcard`;
CREATE TABLE `rex_sprog_wildcard` (
  `pid` int unsigned NOT NULL AUTO_INCREMENT,
  `id` int unsigned NOT NULL,
  `clang_id` int unsigned NOT NULL,
  `wildcard` varchar(255) DEFAULT NULL,
  `replace` text,
  `createuser` varchar(255) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  `revision` int unsigned NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_sprog_wildcard` WRITE;
/*!40000 ALTER TABLE `rex_sprog_wildcard` DISABLE KEYS */;
INSERT INTO `rex_sprog_wildcard` VALUES 
  (1,1,1,'more_info','Mehr Informationen','admin','admin','2016-05-30 19:54:56','2016-05-30 19:54:56',0),
  (2,1,2,'more_info','More Information','admin','admin','2016-05-30 19:54:56','2016-05-30 19:58:27',0),
  (3,2,1,'form_firstname','Vorname','admin','admin','2016-05-30 20:03:22','2016-05-30 20:03:22',0),
  (4,2,2,'form_firstname','First name','admin','admin','2016-05-30 20:03:22','2016-05-30 20:36:52',0),
  (5,3,1,'form_error_firstname','Bitte Vornamen angeben','admin','admin','2016-05-30 20:34:44','2016-05-30 20:34:44',0),
  (6,3,2,'form_error_firstname','Please fill in your first name','admin','admin','2016-05-30 20:34:44','2016-05-30 20:47:13',0),
  (7,4,1,'form_lastname','Nachname','admin','admin','2016-05-30 20:35:48','2016-05-30 20:35:48',0),
  (8,4,2,'form_lastname',' Last name','admin','admin','2016-05-30 20:35:48','2016-05-30 20:46:38',0),
  (9,5,1,'form_error_lastname','Bitte Nachnamen angeben','admin','admin','2016-05-30 20:36:01','2016-05-30 20:36:01',0),
  (10,5,2,'form_error_lastname','Please fill in your last name','admin','admin','2016-05-30 20:36:01','2016-05-30 20:47:28',0),
  (11,6,1,'form_message','Nachricht','admin','admin','2016-05-30 20:36:09','2016-05-30 20:36:09',0),
  (12,6,2,'form_message','Message','admin','admin','2016-05-30 20:36:09','2016-05-30 20:46:48',0),
  (13,7,1,'form_error_message','Bitte Nachricht angeben','admin','admin','2016-05-30 20:36:21','2016-05-30 20:36:21',0),
  (14,7,2,'form_error_message','Please fill in your message','admin','admin','2016-05-30 20:36:22','2016-05-30 20:47:45',0),
  (15,8,1,'form_send','Nachricht senden','admin','admin','2016-05-30 20:36:29','2016-05-30 20:49:02',0),
  (16,8,2,'form_send','Send message','admin','admin','2016-05-30 20:36:30','2016-05-30 20:46:26',0),
  (17,9,1,'languages','Sprachen','admin','admin','2016-06-01 23:26:33','2016-06-01 23:26:33',0),
  (18,9,2,'languages','Sprachen','admin','admin','2016-06-01 23:26:33','2016-06-01 23:26:33',0);
/*!40000 ALTER TABLE `rex_sprog_wildcard` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_template`;
CREATE TABLE `rex_template` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` mediumtext COLLATE utf8_unicode_ci,
  `active` tinyint(1) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8_unicode_ci,
  `revision` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `rex_template` WRITE;
/*!40000 ALTER TABLE `rex_template` DISABLE KEYS */;
INSERT INTO `rex_template` VALUES 
  (1,NULL,'Default','REX_ARTICLE[]',1,'2021-03-20 15:31:44','','2021-03-20 15:31:44','','{\"ctype\":[],\"modules\":{\"1\":{\"all\":\"1\"}},\"categories\":{\"all\":\"1\"}}',0);
/*!40000 ALTER TABLE `rex_template` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_user_role`;
CREATE TABLE `rex_user_role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `perms` text COLLATE utf8_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `revision` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
DROP TABLE IF EXISTS `rex_ycom_group`;
CREATE TABLE `rex_ycom_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_ycom_user`;
CREATE TABLE `rex_ycom_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
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
  `login_tries` int DEFAULT NULL,
  `ycom_groups` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yform_email_template`;
CREATE TABLE `rex_yform_email_template` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_from` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_from_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_reply_to` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_reply_to_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yform_field`;
CREATE TABLE `rex_yform_field` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prio` int NOT NULL,
  `type_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `list_hidden` tinyint(1) NOT NULL,
  `search` tinyint(1) NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `not_required` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiple` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `default` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `only_empty` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `table` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashname` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_db` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_label` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `field` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `empty_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `empty_option` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_size` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `types` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fields` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `width` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `show_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `html` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `notice` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `regex` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `pattern` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_date` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `widget` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attributes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `query` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` text COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `choices` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expanded` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `columns` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `googleapikey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `precision` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `scale` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_yform_field` WRITE;
/*!40000 ALTER TABLE `rex_yform_field` DISABLE KEYS */;
INSERT INTO `rex_yform_field` VALUES 
  (1,'rex_ycom_user',1,'value','html','',0,0,'html1','html1','','','','','','','','','','','','','','','','','','','','','','','','','<div class=\"row\"><div class=\"col-md-6\">','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (2,'rex_ycom_user',2,'value','text','',1,1,'login','translate:login','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (3,'rex_ycom_user',3,'validate','empty','',1,0,'login','','','','','','','','translate:ycom_please_enter_login','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (4,'rex_ycom_user',4,'validate','unique','',1,0,'login','','','','','','','','translate:ycom_this_login_exists_already','rex_ycom_user','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (5,'rex_ycom_user',5,'value','text','',0,1,'email','translate:email','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (6,'rex_ycom_user',6,'validate','empty','',1,0,'email','','','','','','','','translate:ycom_please_enter_email','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (7,'rex_ycom_user',7,'validate','email','',1,0,'email','','','','','','','','translate:ycom_please_enter_email','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (8,'rex_ycom_user',8,'validate','unique','',1,0,'email','','','','','','','','translate:ycom_this_email_exists_already','rex_ycom_user','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (9,'rex_ycom_user',9,'value','ycom_auth_password','',1,1,'password','translate:password','','','','','','','translate:ycom_validate_password_policy_rules_error','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','{\"length\":{\"min\":8},\"letter\":{\"min\":1},\"lowercase\":{\"min\":1},\"uppercase\":{\"min\":1}}','','','','','','1','','','','','','','','','','',''),
  (10,'rex_ycom_user',10,'value','text','',0,1,'firstname','translate:firstname','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (11,'rex_ycom_user',11,'value','text','',0,1,'name','translate:name','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (12,'rex_ycom_user',12,'value','html','',0,0,'html2','html2','','','','','','','','','','','','','','','','','','','','','','','','','</div><div class=\"col-md-6\">','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (13,'rex_ycom_user',13,'value','choice','',0,1,'status','translate:status','','','0','-1','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','translate:ycom_account_inactive_termination=-3,translate:ycom_account_inactive_logins=-2,translate:ycom_account_inactive=-1,translate:ycom_account_requested=0,translate:ycom_account_confirm=1,translate:ycom_account_active=2','','','','','','',''),
  (14,'rex_ycom_user',14,'value','generate_key','',1,1,'activation_key','translate:activation_key','','','','','','1','','','','','','','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (15,'rex_ycom_user',15,'value','generate_key','',1,1,'session_key','translate:session_key','','','','','','1','','','','','','','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (16,'rex_ycom_user',16,'value','checkbox','tinyint(1)',1,1,'termsofuse_accepted','translate:termsofuse_accepted','','','','0','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (17,'rex_ycom_user',17,'value','checkbox','tinyint(1)',1,1,'new_password_required','translate:new_password_required','','','','0','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (18,'rex_ycom_user',18,'value','datestamp','',1,1,'last_action_time','translate:last_action_time','','','','','','2','','','','','','','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (19,'rex_ycom_user',19,'value','datestamp','',1,1,'last_login_time','translate:last_login_time','','','','','','2','','','','','','','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (20,'rex_ycom_user',20,'value','datestamp','',1,1,'termination_time','translate:termination_time','','','','','','2','','','','','','','','','','','','','','','','','','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (21,'rex_ycom_user',21,'value','integer','',0,1,'login_tries','translate:login_tries','','','','0','','','','','','','','','','','','','','','','','','','','','','translate:ycom_login_tries_info','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (22,'rex_ycom_user',22,'value','html','',0,0,'html3','html3','','','','','','','','','','','','','','','','','','','','','','','','','</div></div>','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (23,'rex_ycom_user',23,'value','be_manager_relation','',1,1,'ycom_groups','translate:ycom_groups','','','1','','','','','rex_ycom_group','','','','','name','1','','1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (24,'rex_ycom_group',1,'value','text','',0,1,'name','translate:name','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (25,'rex_ycom_group',2,'validate','empty','',1,0,'name','','','','','','','','translate:ycom_group_yform_enter_name','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
/*!40000 ALTER TABLE `rex_yform_field` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_yform_history`;
CREATE TABLE `rex_yform_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataset_id` int NOT NULL,
  `action` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dataset` (`table_name`,`dataset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yform_history_field`;
CREATE TABLE `rex_yform_history_field` (
  `history_id` int NOT NULL,
  `field` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`history_id`,`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yform_table`;
CREATE TABLE `rex_yform_table` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL,
  `table_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `list_amount` int NOT NULL DEFAULT '50',
  `list_sortfield` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'id',
  `list_sortorder` enum('ASC','DESC') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ASC',
  `prio` int NOT NULL,
  `search` tinyint(1) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `export` tinyint(1) NOT NULL,
  `import` tinyint(1) NOT NULL,
  `mass_deletion` tinyint(1) NOT NULL,
  `mass_edit` tinyint(1) NOT NULL,
  `schema_overwrite` tinyint(1) NOT NULL DEFAULT '1',
  `history` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_name` (`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `rex_yform_table` WRITE;
/*!40000 ALTER TABLE `rex_yform_table` DISABLE KEYS */;
INSERT INTO `rex_yform_table` VALUES 
  (1,1,'rex_ycom_user','translate:rex_ycom_user','',100,'login','DESC',1,1,0,1,1,0,0,1,0),
  (2,1,'rex_ycom_group','translate:ycom_group_name','',200,'name','ASC',2,0,0,1,1,0,0,1,0);
/*!40000 ALTER TABLE `rex_yform_table` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_yrewrite_alias`;
CREATE TABLE `rex_yrewrite_alias` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `alias_domain` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain_id` int NOT NULL,
  `clang_start` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yrewrite_domain`;
CREATE TABLE `rex_yrewrite_domain` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mount_id` int NOT NULL,
  `start_id` int NOT NULL,
  `notfound_id` int NOT NULL,
  `clangs` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clang_start` int NOT NULL,
  `clang_start_auto` tinyint(1) NOT NULL,
  `clang_start_hidden` tinyint(1) NOT NULL,
  `robots` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_scheme` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auto_redirect` tinyint(1) NOT NULL,
  `auto_redirect_days` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rex_yrewrite_forward`;
CREATE TABLE `rex_yrewrite_forward` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int NOT NULL,
  `status` int NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `article_id` int NOT NULL,
  `clang` int NOT NULL,
  `extern` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `media` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `movetype` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
SET FOREIGN_KEY_CHECKS = 1;
