## XML-Dokumentationskommentare in C#

### **1. Zweck**

XML-Kommentare in C# dienen dazu, Klassen, Methoden, Eigenschaften usw. so zu dokumentieren, dass daraus später automatisch **API-Dokumentation** (z. B. mit *DocFX*, *Sandcastle*, *Visual Studio IntelliSense*) generiert werden kann.

---

## **2. Syntax**

Dokumentationskommentare beginnen mit **`///`** direkt vor einem Member.

```csharp
/// <summary>
/// Berechnet die Summe zweier Zahlen.
/// </summary>
/// <param name="a">Erste Zahl.</param>
/// <param name="b">Zweite Zahl.</param>
/// <returns>Die Summe von a und b.</returns>
public int Add(int a, int b)
{
    return a + b;
}
```

---

## **3. Wichtige XML-Tags**

### **Basis-Tags**

| Tag           | Bedeutung                                 |
| ------------- | ----------------------------------------- |
| `<summary>`   | Kurze Beschreibung der Funktion/Klasse.   |
| `<remarks>`   | Längere erklärende Hinweise.              |
| `<param>`     | Beschreibung eines Methodenparameters.    |
| `<returns>`   | Beschreibung des Rückgabewerts.           |
| `<value>`     | Beschreibung einer Eigenschaft.           |
| `<example>`   | Codebeispiele.                            |
| `<exception>` | Welche Exceptions geworfen werden können. |

---

### **Verweis-Tags**

| Tag         | Bedeutung                              |
| ----------- | -------------------------------------- |
| `<see>`     | Verweis auf eine andere Klasse/Member. |
| `<seealso>` | „Siehe auch“-Verweise.                 |

Beispiel:

```csharp
/// <see cref="Math.Pow(double, double)"/>
```

---

### **Codeformatierung**

```csharp
/// <code>
/// var x = Add(1, 2);
/// </code>
```

---

## **4. Aktivieren der XML-Dateiausgabe**

In `.csproj`:

```xml
<PropertyGroup>
  <DocumentationFile>bin\Debug\net8.0\MyLib.xml</DocumentationFile>
</PropertyGroup>
```

Damit erzeugt der Compiler automatisch eine `.xml`-Dokumentationsdatei.

---

## **5. Vorteile**

* IntelliSense zeigt automatisch die Dokumentation an.
* Einheitliche, standardisierte Dokumentation.
* Generierbare HTML/PDF/API-Dokumentation.
* Guter Standard für Bibliotheken und große Projekte.

