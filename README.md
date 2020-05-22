# Technischer Thesaurus Holzbau (TTH)

Ein Projekt, initiiert von [Timm Miersch](mailto:timm.miersch@googlemail.com).

Dies ist eine MySQL-Umsetzung der ursprünglichen MS-Access-Datenbank. Sie ist eingebettet in eine [Redaxo](https://www.redaxo.org)-Installation mit YForm. Sie erlaubt eine einfache und flexible Online-Bearbeitung der Daten.

Das vorliegende ist als Entwurf einer unabhängigen, redaktionellen Datenbank zu verstehen.

Ziel ist später die Anbindung an offizielle Museumsdatenbanken und -Standards.

## Installation

## Tabellenstruktur

Die meisten Feldnamen wurden geändert, um die Bezeichnungen zu vereinfachen und sie mehr den Konventionen anzupassen (falls später fremde Leute die DB Konvertieren/reparieren müssen). 

! Welche Konventionen von Museumsdatenbanken sollten beachtet werden??

Irgendwie möchte ich die Bezeichnungen noch einmal ändern... Gefällt mir noch nicht

Tabelle Wortliste : begriffe

```
accdb : mysql
-------------
ID_Wortlise : id
Begriff : begriff
BegriffDefinition : definition
BegriffGrobgliederung : grobgliederung
ND_Text Quelle : autor_id
QuelleSeite : quelle_seite
ND_Beleg Quellen : quellen_idlist
BegriffsCode : code
ND_BegriffsStatus : begriffsstatus_id
ScopeNotes : notes
Bild : bild_id
BeziehungenBenutze : benutze
BeziehungenBenutztFür : benutzt_fuer
BeziehungOberbegriff : oberbegriff
BeziehungenUnterbegriff : unterbegriff
BeziehungenVerwanteBegriffe : verwandte_begriffe :
BeziehungenAquivalent : aequivalent
InhaltlicheDatierung : inhaltliche_datierung
HistorischeHintergrund : historischer_hintergrund
ND_Sprache : sprache_id
ND_Region : region_id
ND_SprachStil : sprachstil_id
EigenschaftKategorie : kategorie
Veröffentlichen? : veröffentlichen
noch Bearbeiten : bearbeiten
```

### YForm 

* der "Name" ist genau umgekehrt das Feld in DB und "Bezeichnung" wird im Tabellen-manager von YForm angezeigt.