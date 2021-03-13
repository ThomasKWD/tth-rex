# Thesaurus Traditioneller Holzbau (TTH)

Ein Projekt, initiiert von [Timm Miersch](mailto:timm.miersch@googlemail.com).

Demo: https://www.thesaurus-traditioneller-holzbau.net/

Dies ist eine [MySQL](https://de.wikipedia.org/wiki/MySQL)-Umsetzung der ursprünglichen Datenbank (MS Access), eingebettet in eine [Redaxo](https://www.redaxo.org)-Installation mit YForm.

Sie erlaubt eine flexible Online-Bearbeitung der Daten. Außerdem ist eine benutzerfreundliche Abfrage und Präsentation von Daten der DB ohne Login möglich.

Das vorliegende System ist der Entwurf einer unabhängigen, redaktionellen Datenbank welche später eine Anbindung an die wissenschaftliche Datenbasis ("xtree.digicult.de") erhalten soll.



## Tabellenstruktur

Die meisten Feldnamen wurden geändert, um die Bezeichnungen zu vereinfachen und sie mehr den Konventionen anzupassen. 

* [ ] Welche Konventionen von Museumsdatenbanken sollten beachtet werden??

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

## Implementation

`README.md` Texte in Unterordnern, die nur die Implementation betreffen, sind in Englisch.

### Datenbank

Die aktuelle lokale Test-Datenbank ist unter ... gespeichert.

Die aktuelle Datenbank, die zur öffentlichen Anzeige geeignet ist, ist unter ... archiviert. Diese sollte stets importiert werden, wenn das Projekt auf einer neuen Umgebung aufgesetzt wird.


## Installation

Das Repository stellt das Basis-Verzeichnis einer lauffähigen [Redaxo 5.10.x](https://redaxo.org/download/core/) Installation dar (Apache, MySQL, PHP entsprechend Erfordernissen von Redaxo benötigt).

Das Redaxo benötigt für dieses Projekt folgende Addons: developer, markitup, phpmailer, theme, YForm, YCom, xoutputfilter (optional).

Es sollte zuerst Redaxo und alle benötigten Addons installiert werden und dann der Inhalt des Downloads (https://github.com/ThomasKWD/tth-rex/archive/master.zip) hinein kopiert werden.

Eine Anpassung verschiedener Einstellungen ist erforderlich. Es werden Administrator-Kenntnisse von Redaxo vorausgesetzt.