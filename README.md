# Documentor

## Auteurs

- NAGY Sallah Hassad, Master 1 GL
- RANANTENAINA Stephan, Master 1 GL

Projet réalisé dans le cadre du cours de Génie Logiciel (Master 1), avec le Pr Stéphane Ducasse.

Outil qui produit un rapport Microdown sur une classe Pharo (via `MicMicrodownTextualBuilder`).

## Chargement

```smalltalk
Metacello new
	baseline: 'Documentor';
	repository: 'github://NAGYs77/Documentor/src';
	load.
```

## Utilisation

```smalltalk
(Documentor on: OrderedCollection) report.
```

Le rapport contient : nom, heritage, champs, package, premier paragraphe du commentaire, hierarchie, methodes et leur premier commentaire, metriques (profondeur, champs, methodes, appels a super, methodes longues) et mini linter (methodes sans variable d'instance, sans self ni variable d'instance, complexite cyclomatique).

## Architecture

- `Documentor` : construit le rapport avec le builder Microdown
- `DocumentorMetrics` : calcule les metriques
- `DocumentorLinter` et `DocumentorMethodVisitor` : analyse de l'AST avec un visiteur

## Tests

Lancer les tests du package `Documentor-Tests` avec le Test Runner.

## Compatibilité

Testé avec Pharo 13 (21 tests verts).
