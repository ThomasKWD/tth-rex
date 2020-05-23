# Technischer Thesaurus Holzbau (TTH)

Ein Projekt, initiiert von [Timm Miersch](mailto:timm.miersch@googlemail.com).

Dies ist eine [MySQL](https://de.wikipedia.org/wiki/MySQL)-Umsetzung der ursprünglichen MS-Access-Datenbank. Sie ist eingebettet in eine [Redaxo](https://www.redaxo.org)-Installation mit YForm. Sie erlaubt eine einfache und flexible Online-Bearbeitung der Daten.

Das vorliegende System ist als Entwurf einer unabhängigen, redaktionellen Datenbank zu verstehen.

Ziel ist später die Anbindung an offizielle Museumsdatenbanken und -Standards.

## Installation

Root des Repo ist Root einer lauffähigen [Redaxo 5.10.x](https://redaxo.org/download/core/) Installation (Apache, MySQL, PHP entsprechend Erfordernissen von Redaxo benötigt).

Das Redaxo benötigt für dieses Projekt folgende Addons: developer, markitup, phpmailer, theme, YForm

Du solltest erst Redaxo und alle benötigten Addons installieren und dann den Inhalt des [Downloads](https://github.com/ThomasKWD/tth-rex/archive/master.zip) oder "Clone" hinein kopieren. 

## Tabellenstruktur

Die meisten Feldnamen wurden geändert, um die Bezeichnungen zu vereinfachen und sie mehr den Konventionen anzupassen (falls später fremde Leute die DB Konvertieren/reparieren müssen). 

! Welche Konventionen von Museumsdatenbanken sollten beachtet werden??

Irgendwie möchte ich die Bezeichnungen noch einmal ändern... Gefällt mir noch nicht

Tabelle Wortliste : begriffe

|accdb | mysql|
|------|-------|
|ID_Wortlise | id|
|Begriff | begriff|
|BegriffDefinition | definition|
|BegriffGrobgliederung | grobgliederung|
|ND_Text Quelle | autor_id|
|QuelleSeite | quelle_seite|
|ND_Beleg Quellen | quellen_idlist|
|BegriffsCode | code|
|ND_BegriffsStatus | begriffsstatus_id|
|ScopeNotes | notes|
|Bild | bild|
|BeziehungenBenutze | benutze|
|BeziehungenBenutztFür | benutzt_fuer|
|BeziehungOberbegriff | oberbegriff|
|BeziehungenUnterbegriff | unterbegriff|
|BeziehungenVerwanteBegriffe | verwandte_begriffe ||
|BeziehungenAquivalent | aequivalent|
|InhaltlicheDatierung | inhaltliche_datierung|
|HistorischeHintergrund | historischer_hintergrund|
|ND_Sprache | sprache_id|
|ND_Region | region_id|
|ND_SprachStil | sprachstil_id|
|EigenschaftKategorie | kategorie|
|Veröffentlichen? | veröffentlichen|
|noch Bearbeiten | bearbeiten|

### Beziehungen (Nodes)

Die meisten Beziehungen *innerhalb* `tth_begriffe` (Wortliste) 1-to-Many-Beziehungen (1:n) oder Many-to-Many-Beziehungen (n:m) mit `tth_begriffe` selbst.

Für die in der Tabelle folgenden Felder gilt:

* das urspüngliche Feld der accdb wird erhalten aber nicht mehr verändert. 
* für n:m-Beziehungen ist eine separate Beziehungstabelle ist erfordrlich.
* mit im [template](./theme/private/redaxo/templates/Basis%20[2]/2.Basis.template.php) implementiertem Werkzeug können die Daten wiederholt aus dem ursprünglichen Feld in die Beziehungstabelle geschrieben werden.

|Feld|Typ der Beziehung|Beziehungstabelle|
|---|---|---|
|grobgliederung|n:m|`tth_begriff_grobgliederung`|
|benutze|1:n||
|benutzt_fuer|n:m|`tth_begriff_benutzt_fuer`|
|oberbegriff|n:m|`tth_begriff_oberbegriffe`|
|unterbegriff|n:m|`tth_begriff_unterbegriffe`|
|verwandte_begriffe|n:m|`tth_begriff_verwandte`|
|aequivalent|n:m|`tth_begriff_aequivalente`|

Davon ausgenommen sind die externen Beziehungen in `tth_begriffe`.
Diese haben teilweise auch zusätzliche Beziehungstabellen (n:m,1:n)

|Feld|Tabelle|Typ der Beziehung|Beziehungstabelle|
|---|---|---|---|
|autor_id| `tth_autoren`| 1:n ||
|quellen_idlist| `tth_quellen`| n:m |`tth_begriff_quellen`|
|begriffsstatus_id| `tth_begriffsstati`| 1:n ||

### Medien

Hier wird eine vereinfachte Sonderform gewählt: Kommagetrennte Liste von Dateinamen. Nachteil: bei Löschen von Bildern Verwaltung kompliziert wenn nicht Redaxo/YForm genutzt werden kann.

Aufgaben: MEDIA_WIDGET für Editieren!

### YForm 

### Werkzeuge

Konvertieren einzelne n:m-Tabelle
Konvertieren aller n:m-Tabellen

## Daten lesen

### Ideen für Abfragen

* Alle Begriffe alphabetisch mit Link (mache bis 4 Spalten)
* Ein Begriff alle Infos (IDs der Beziehungen müssen als Namen aufgelöst werden)
* Ein Begriff alle Infos *mi Links*
* Alle Begriffe für Kriterium aus anderer Tabelle z.B. alle eines Autors
* Alle Begriffe für Beziehung, z.B. alle für eine Begriff, der eine bestimmte Grobgliederung ist

### Kontrollansichten

~~Inhalte aller n:m-Tabellen (Ansicht der Haupt-Tabellen gibt es ja im Backend)~~
braucht man eigentlich nicht, ist ja nur für Admins und die können in phpMyAdmin schauen oder die Tabellen in YForm auf sichtbar stellen.

