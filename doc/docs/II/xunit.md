
# Zusammenfassung: xUnit im .NET Framework / .NET

## Allgemeines

**xUnit.net** ist ein weit verbreitetes **Unit-Test-Framework für .NET**.
Es wird aktiv weiterentwickelt und gilt als moderner Nachfolger von NUnit und MSTest in vielen Projekten.

xUnit unterstützt:

* .NET Framework
* .NET (Core / 5 / 6 / 7 / 8+)

Es wird besonders häufig in Kombination mit `dotnet test` und CI-Pipelines eingesetzt.

---

## Projektanlage

Ein xUnit-Testprojekt kann mit der .NET-CLI erstellt werden:

```bash
dotnet new xunit --output AverageCalculator.Tests
```

Typischerweise wird das Testprojekt als **separates Projekt** angelegt und referenziert die zu testende Klassenbibliothek:

```bash
cd AverageCalculator.Tests
dotnet add reference ../AverageCalculator/AverageCalculator.csproj
```

---

## Grundprinzip

Ein **Unit-Test** überprüft eine kleine, in sich abgeschlossene Funktionalität (z. B. eine Methode).

Ein Test besteht typischerweise aus drei Phasen (**AAA-Pattern**):

1. **Arrange** – Vorbereitung der Testdaten
2. **Act** – Ausführen der zu testenden Methode
3. **Assert** – Überprüfen des Ergebnisses

---

## Testklassen und Attribute

### `[Fact]`

* Kennzeichnet einen **einzelnen, parameterlosen Test**
* Wird verwendet, wenn keine Testdaten übergeben werden

```csharp
[Fact]
public void Count_ReturnsZero_WhenNoElementsAdded()
{
    var calculator = new AverageCalculator();

    int result = calculator.count();

    Assert.Equal(0, result);
}
```

---

### `[Theory]` und `[InlineData]`

* Ermöglicht **datengetriebene Tests**
* Ein Test wird mit mehreren Eingabewerten ausgeführt

```csharp
[Theory]
[InlineData(new double[] { 2, 4 }, 3)]
[InlineData(new double[] { 1, 1, 1 }, 1)]
public void GetAverage_ReturnsCorrectValue(double[] values, double expected)
{
    var calculator = new AverageCalculator();
    calculator.add(values);

    double result = calculator.getAverage();

    Assert.Equal(expected, result);
}
```

---

## Wichtige Assert-Methoden

xUnit stellt die Klasse `Assert` zur Verfügung.

Häufig verwendete Methoden:

| Methode                          | Bedeutung                  |
| -------------------------------- | -------------------------- |
| `Assert.Equal(expected, actual)` | Vergleich von Werten       |
| `Assert.NotEqual(a, b)`          | Ungleichheit               |
| `Assert.True(condition)`         | Bedingung muss wahr sein   |
| `Assert.False(condition)`        | Bedingung muss falsch sein |
| `Assert.NotNull(object)`         | Objekt ist nicht `null`    |
| `Assert.Empty(collection)`       | Sammlung ist leer          |
| `Assert.Throws<T>(...)`          | Erwartete Exception        |

Beispiel für Exception-Tests:

```csharp
Assert.Throws<InvalidOperationException>(() => calculator.getAverage());
```

---

## Test-Lebenszyklus

### Konstruktor statt `[SetUp]`

xUnit verwendet **keine** `[SetUp]`- oder `[TearDown]`-Attribute.

* Der **Konstruktor der Testklasse** wird **vor jedem Test** ausgeführt
* Optional kann `IDisposable` für Aufräumarbeiten verwendet werden

```csharp
public class AverageCalculatorTests : IDisposable
{
    private AverageCalculator calculator;

    public AverageCalculatorTests()
    {
        calculator = new AverageCalculator();
    }
    
    [Fact]
    public void Test() {
        Assert.NotNull(calculator);
    }

    public void Dispose()
    {
        // Cleanup (falls notwendig)
    }
}
```

---

## Testisolation

* Jede Testmethode wird **in einer neuen Instanz** der Testklasse ausgeführt
* Tests beeinflussen sich nicht gegenseitig
* Gemeinsamer Zustand sollte vermieden werden

---

## Benennungskonventionen

Bewährt haben sich sprechende Testnamen nach dem Muster:

```
MethodName_ExpectedBehavior_WhenCondition
```

Beispiel:

```csharp
GetAverage_ReturnsZero_WhenNoElementsExist
Add_IncreasesCount_WhenSingleValueIsAdded
```

---

## Vorteile von xUnit

* Klare, moderne API
* Gute Integration in `dotnet test`
* Unterstützung für datengetriebene Tests
* Sehr gute CI/CD-Tauglichkeit
* Keine unnötigen Attribute oder Boilerplate

---

## Typische Einsatzszenarien im Unterricht

* Testen von Klassenbibliotheken
* Verifikation mathematischer Funktionen
* Einführung in Test-Driven Development (TDD)
* Vergleich zu klassischen „Main-Methoden-Tests“

---

## Kurzvergleich zu anderen Frameworks

| Framework | Besonderheit                           |
| --------- | -------------------------------------- |
| xUnit     | Modern, minimalistisch                 |
| NUnit     | Ähnlich, mehr Attribute                |
| MSTest    | Microsoft-Standard, stärker integriert |


