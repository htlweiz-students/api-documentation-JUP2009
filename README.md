[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/QIbzCkVP)
# APIs und Dokumentation erstellen

## Aufgabenstellung

Es ist eine kleine .NET-Klassenbibliothek zu entwickeln, die zur Berechnung von Durchschnittswerten dient.

Die Bibliothek wird mithilfe der `dotnet`-Kommandozeilenanwendung erstellt.
Eine Übersicht aller verfügbaren Projektvorlagen kann mit folgendem Befehl angezeigt werden:

```bash
dotnet new list
```

Anschließend ist eine **Class Library** mit dem Namen **AverageCalculator** zu erstellen.

> **Wichtig:**
> Das Projekt muss mit der Kommandozeilenoption
> `--output <Projektverzeichnis>/`
> in einem **Unterverzeichnis** erzeugt werden.

---

## Klassen und Funktionalität

Die Bibliothek enthält eine Klasse `AverageCalculator`.

### Konstruktor

Die Klasse stellt einen **Default-Konstruktor** bereit, der eine sinnvolle Initialisierung des internen Zustands sicherstellt (z. B. Vorbereitung einer internen Datenstruktur zur Speicherung der Werte).

---

### Methoden

#### `add`

Die Klasse stellt zwei überladene Methoden mit dem Namen `add` bereit:

1. `add(double value)`
   Fügt einen einzelnen `double`-Wert zur internen Sammlung hinzu.

2. `add(double[] values)`
   Fügt mehrere `double`-Werte aus einem Array hinzu.
   Leere Arrays dürfen dabei keinen Fehler verursachen.

---

#### `getAverage`

```csharp
double getAverage()
```

Gibt das **arithmetische Mittel** aller bisher hinzugefügten Werte zurück.

* Falls noch keine Werte hinzugefügt wurden, ist ein sinnvolles Verhalten zu definieren
  (z. B. Rückgabewert `0`, `NaN` oder eine [Exception](../../../III/exceptions.md) – Entscheidung ist zu begründen).

---

#### `getElements`

```csharp
double[] getElements()
```

Gibt alle bisher gespeicherten Werte zurück.

* Die interne Datenstruktur darf dabei **nicht veränderbar nach außen gegeben** werden, um Manipulationen zu verhindern.

---

#### `count`

```csharp
int count()
```

Gibt die Anzahl der bisher hinzugefügten Werte zurück.

---

## Qualität und Tests

Für jede Funktionalität ist eine **ausgiebige Testabdeckung** zu erstellen.

* Mindestens **drei Unit-Tests pro Methode**
* Positiv- und Grenzfälle sind zu berücksichtigen
  (z. B. keine Werte, ein Wert, mehrere Werte, Array-Übergaben)

Ein gängiges .NET-Testframework (z. B. [xUnit](../../xunit.md), NUnit oder MSTest) ist zu verwenden.

---

## Dokumentation

Die gesamte öffentliche API ist mit **XML-Inline-Dokumentation** zu versehen.

* Klassen
* Konstruktor
* Alle öffentlichen Methoden

Die Dokumentation orientiert sich an der entsprechenden Theorieeinheit:
[XML-Dokumentation](../../xml_documentation.md)

