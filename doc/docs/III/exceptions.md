### Überblick über Exception Handling in C\#

Exception Handling in C# dient dazu, Fehler in Programmen zu behandeln, die außerhalb der normalen Programmausführung auftreten können (z. B. 
Datei nicht gefunden, Null-Referenzzugriff, usw.). Die Hauptmechanismen sind:

1. **`try`-Block**: Markiert Code, der potenziell Ausnahmen wirft.
2. **`catch`-Block**: Fängt spezifische Ausnahmen ab.
3. **`finally`-Block**: Wird immer ausgeführt (unabhängig vom Fehler), z. B. für Ressourcenfreigabe.
4. **`throw`**: Wird verwendet, um eine Ausnahme explizit zu werfen.
5. **Benutzerdefinierte Ausnahmen**: Erstellen eigene Exception-Klassen (z. B. `class CustomException : Exception`).

#### Beispiel für eine benutzerdefinierte Ausnahme:
```csharp
public class CustomException : Exception
{
    public CustomException(string message) : base(message) { }
}
```

---

### Übung 1: Grundlegendes Exception Handling

**Aufgabe**:  
Erstelle eine Methode, die eine Division durch Null durchführt. Fange die `DivideByZeroException` ab und informiere den Benutzer.

**Lösung**:
```csharp
using System;

class Program
{
    static void Main()
    {
        try
        {
            Console.WriteLine("Zahl 1 eingeben:");
            double a = double.Parse(Console.ReadLine());
            Console.WriteLine("Zahl 2 eingeben:");
            double b = double.Parse(Console.ReadLine());

            double result = Divide(a, b);
            Console.WriteLine($"Ergebnis: {result}");
        }
        catch (DivideByZeroException ex)
        {
            Console.WriteLine($"Fehler: {ex.Message}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Unerwarteter Fehler: {ex.Message}");
        }
    }

    static double Divide(double a, double b)
    {
        if (b == 0)
            throw new DivideByZeroException("Division durch Null nicht erlaubt!");
        return a / b;
    }
}

// Benutzerdefinierte Ausnahme
[System.Serializable]
public class DivideByZeroException : Exception
{
    public DivideByZeroException() { }
    public DivideByZeroException(string message) : base(message) { }
}
```

---

### Übung 2: Dateioperationen mit Exception Handling

**Aufgabe**:  
Schreibe eine Methode, die eine Datei liest. Behandle folgende Ausnahmen:
- `FileNotFoundException`: Datei existiert nicht.
- `UnauthorizedAccessException`: Keine Leseberechtigung.

**Lösung**:
```csharp
using System;
using System.IO;

class Program
{
    static void Main()
    {
        string filePath = @"C:\beispieldatei.txt";

        try
        {
            string content = File.ReadAllText(filePath);
            Console.WriteLine("Datei-Inhalt:");
            Console.WriteLine(content);
        }
        catch (FileNotFoundException ex)
        {
            Console.WriteLine($"Datei nicht gefunden: {ex.Message}");
        }
        catch (UnauthorizedAccessException ex)
        {
            Console.WriteLine($"Zugriff verweigert: {ex.Message}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Allgemeiner Fehler: {ex.Message}");
        }
    }
}
```

---

### Tipps zum Umgang mit Exceptions:
- **Spezifische Ausnahmen fangen**: Vermeide allgemeine `catch (Exception)`, es sei denn, du kannst den Fehler handeln.
- **Ressourcenbereinigung**: Nutze `finally` oder `using` für Stream-Objekte.
- **Benutzerdefinierte Ausnahmen**: Klasse bei komplexen Fehlerlogik.


