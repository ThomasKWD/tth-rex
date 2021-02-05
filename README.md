# Technischer Thesaurus Holzbau (TTH)

Ein Projekt, initiiert von [Timm Miersch](mailto:timm.miersch@googlemail.com).

Dies ist eine [MySQL](https://de.wikipedia.org/wiki/MySQL)-Umsetzung der ursprünglichen MS-Access-Datenbank. Sie ist eingebettet in eine [Redaxo](https://www.redaxo.org)-Installation mit YForm. Sie erlaubt eine flexible Online-Bearbeitung der Daten. Außerdem ist eine benutzerfreundliche Abfrage und Präsentation von Daten der DB ohne Login möglich.

Das vorliegende System ist als Entwurf einer unabhängigen, redaktionellen Datenbank zu verstehen.

Ziel ist später die Anbindung an offizielle Museumsdatenbanken und -Standards. Eventuell sollen die Daten in das Format eines [MediaWiki](https://mediawiki.org) konvertiert werden.

## Installation

Das Repository stellt das Basis-Verzeichnis einer lauffähigen [Redaxo 5.10.x](https://redaxo.org/download/core/) Installation dar (Apache, MySQL, PHP entsprechend Erfordernissen von Redaxo benötigt).

Das Redaxo benötigt für dieses Projekt folgende Addons: developer, markitup, phpmailer, theme, YForm

Du solltest erst Redaxo und alle benötigten Addons installieren und dann den Inhalt des Downloads (https://github.com/ThomasKWD/tth-rex/archive/master.zip) oder "Clone" hinein kopieren. 

### Ungelöste Installations-Probleme

Wenn das Projekt in einem auf [friendsofredaxo/demo:base]" basierenden Docker-Container-System läuft, ist nicht klar was mit den Datei-Rechten der von Git ausgecheckten Projektdaten geschieht. Die Installation läuft. der Redaxo-Container kann aber nicht ohne Probleme ins Image zurück gespeichert werden.

Es sollte das "volume" getrennt gesichert werden, dann keine Rechte-Probleme(?).

Für das Zusammenspiel Docker-Git-Repo sollte das Projekt ausschließlich innerhalb des theme bearbeitet werden. Dazu muss phpunit innerhalb des theme Addon laufen. Der Einfachheit halber könnte man das Root des Projektes weiterhin dem Root der Redaxo-Installation gleichsetzen. 

## Tabellenstruktur

Die meisten Feldnamen wurden geändert, um die Bezeichnungen zu vereinfachen und sie mehr den Konventionen anzupassen (falls später fremde Leute die DB Konvertieren/reparieren müssen). 

! Welche Konventionen von Museumsdatenbanken sollten beachtet werden??

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

Die meisten Beziehungen *innerhalb* `tth_begriffe` (Wortliste) sind 1-to-Many-Beziehungen (1:n) oder Many-to-Many-Beziehungen (n:m) mit `tth_begriffe` selbst.

Für die in der folgenden Tabelle Felder gilt:

* Das urspüngliche Feld der accdb wird erhalten aber nicht mehr verändert. 
* Für n:m-Beziehungen wurde eine separate Beziehungstabelle angelegt.
* mit im [template](./theme/private/redaxo/templates/Basis%20[2]/2.Basis.template.php) implementiertem Werkzeug können die Daten wiederholt aus dem ursprünglichen Feld in die Beziehungstabelle geschrieben werden.

|Feld|Typ der Beziehung|Beziehungstabelle|
|---|---|---|
|grobgliederung|n:m|`tth_begriff_grobgliederung`|
|benutze|1:n||
|oberbegriff|n:m|`tth_begriff_oberbegriffe`|
|unterbegriff|n:m|`tth_begriff_unterbegriffe`|
|verwandte_begriffe|n:m|`tth_begriff_verwandte`|
|aequivalent|n:m|`tth_begriff_aequivalente`|

Die usrprüngliche Beziehung "Benutzt für" wird nicht verwendet. Sie wird aus den durch "Benutze" definierten Beziehungen berechnet.

Die externen Beziehungen in `tth_begriffe` haben teilweise auch zusätzliche Beziehungstabellen erhalten falls erforderlich (n:m).

|Feld|Tabelle|Typ der Beziehung|Beziehungstabelle|
|---|---|---|---|
|autor_id| `tth_autoren`| 1:n ||
|quellen_idlist| `tth_quellen`| n:m |`tth_begriff_quellen`|
|begriffsstatus_id| `tth_begriffsstati`| 1:n ||
|sprache_id| `tth_sprachen`| 1:n ||
|sprachstil_id| `tth_sprachstile`| 1:n ||
|region_id| `tth_regionen`| 1:n ||

### Medien

Hier wird eine vereinfachte Sonderform gewählt: Kommagetrennte Liste von Dateinamen. Nachteil: bei Löschen von Bildern Verwaltung kompliziert (aber nur wenn *nicht* Redaxo/YForm - oder ein vergleichbares CMS - die Bildverwaltung kontrolliert).

### YForm 

### Werkzeuge

Konvertieren einzelne n:m-Tabelle
~~Konvertieren aller n:m-Tabellen~~

### Abfragen (Views)

* Alle Begriffe alphabetisch mit Link (mache bis 4 Spalten)
* Ein Begriff alle Infos (IDs der Beziehungen müssen als Namen aufgelöst werden)
* Ein Begriff alle Infos *mi Links*
* Alle Begriffe für Kriterium aus anderer Tabelle z.B. alle eines Autors
* Alle Begriffe für Beziehung, z.B. alle für eine Begriff, der eine bestimmte Grobgliederung ist

### Kontrollansichten

~~Inhalte aller n:m-Tabellen (Ansicht der Haupt-Tabellen gibt es ja im Backend)~~
braucht man eigentlich nicht, ist ja nur für Admins und die können in phpMyAdmin schauen oder die Tabellen in YForm auf sichtbar stellen.

## Wiki-Anbindung