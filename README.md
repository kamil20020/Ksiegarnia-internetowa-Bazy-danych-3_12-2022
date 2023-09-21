# Księgarnia internetowa (12.2022)
Aplikacja została zrealizowana w ramach zajęć projektowych z Internetowych baz danych na Politechnice Wrocławskiej. Szacujemy, że aplikację udało się zrealizować w około 90%.

## Cel projektu
Celem projektu były projekt, implementacja oraz wdrożenie księgarni internetowej dla wymyślonej firmy "Bookshop". Firma ta znajduje się na terenie Wrocławia oraz zajmuje się stacjonarną sprzedażą książek. Głównym powodem stworzenia systemu było usprawnienie pracy firmy oraz zapewnienie wygodnej i szybkiej obsługi klienta.

## Plan projektu:
* Analiza SWOT,
* Wymagania funkcjonalne i niefunkcjonalne,
* Dobór narzędzi,
* Diagramy UML,
* Diagramy ERD,
* Prototypy interfejsu użytkownika.
### Implementacja:
* Baza danych,
* Aplikacja serwerowa,
* Aplikacja kliencka.
### Testowanie:
* Testy integracyjne backendu,
* Testy jednostkowe,
* Testy manualne interfejsu użytkownika,
* Testy automatyczne interfejsu użytkownika (zabrakło czasu).
### Na koniec:
* Wdrożenie całego systemu,
* Sporządzenie dokumentacji.
 
## Role użytkowników:
* Użytkownik - rola przypisywana każdemu użytkownikowi w systemie,
* Niezalogowany użytkownik,
* Zalogowany użytkownik,
* Klient - użytkownik zalogowany na koncie klienta,
* Pracownik - użytkownik zalogowany na koncie pracownika.

<p align="center">
    <img src="img/aktorzy.png">
</p>

## Wymagania funkcjonalne:
* Użytkownik:
    * Przeglądanie listy dostępnych książek,
    * Wyświetlenie detali danej ksiązki.
* Niezalogowany użytkownik:
    * Założenie konta klienta (zabrakło czasu na podpięcie OAuth 2.0),
    * Zalogowanie się.
* Zalogowany użytkownik:
    * Wylogowanie się.
* Klient:
    * Modyfikacja danych osobowych,
    * Koszyk,
    * Złożenie zamówienia,
    * Sprawdzenie statusu własnego zamówienia,
    * Wycofanie wsłasnego zamówienia niebędącego jeszcze w trakcie realizacji.
* Pracownik:
    * Przeglądanie listy wszystkich książek,
    * Zarządzanie książkami (zabrakło czasu),
    * Dodanie / wycofanie książki z oferty (zabrakło czasu),
    * Przeglądanie listy zamówień,
    * Zmiana statusu zamówienia (Utworzone, Realizacja, Wycofane, Odebrane).

### Diagram przypadków użycia dla niezalogowanego oraz zalogowanego użytkownika:
<p align="center">
    <img src="img/przypadki-uzycia-niezalogowany-zalogowany.png">
</p>

### Diagram przypadków użycia dla klienta:
<p align="center">
    <img src="img/przypadki-uzycia-klient.png">
</p>

### Diagram przypadków użycia dla pracownika:
<p align="center">
    <img src="img/przypadki-uzycia-pracownik.png">
</p>

## Architektura systemu
<p align="center">
    <img src="img/architektura.png">
</p>

Serewr aplikacji 1 odpowiada przede wszystkim za funkcje, z których mogą skorzystać klienci oraz pracownicy.
Serewr aplikacji 2 odpowiada za funkcje, z których mogą skorzystać wszyscy użytkownicy.

## Diagram ERD
<p align="center">
    <img src="img/erd.png">
</p>

## Technologie:
### Klient:
* Biblioteka do tworzenia UI - React (JavaScript),
* Statyczne typowanie - TypeScript,
* Biblioteka komponentów - MUI,
* Globalny stan aplikacji - Redux,
* IDE - Visual Studio Code.
### Serwer 1:
* Główny język - Java,
* Framework - Spring / Spring Boot (Java),
* Uwierzytelnianie - OAuth 2.0 (zabrakłko czasu),
* Środowisko - Itellij.
### Serwer 2:
* Główny język - Python,
* Framework - Django,
* Środowisko - PyCharm.
### Testowanie:
* Testy integracyjne oraz jednostkowe - JUnit, REST-assured,
* Testy automatyczne interfejsu użytkownika - Selenium (zabrakło czasu),
* Manualne testowanie wysyłania zapytań do serwerów - Postman.
### Wdrożenie:
* Chmura - Azure,
* Serwer webowy - Nginx,
* Docker.
### Pozostałe:
* Uwierzytelnianie - OAuth 2.0 (zabrakło czasu - jest uwierzytelnianie w pamięci a nie w bazie danych),
* Komunikacja między klientem a serwerami 1 oraz 2 - REST,
* Sporządzenie diagramów UML oraz ERD - Visual Paradigm,
* Projekt interfejsu użytkownika - Figma,
* Dokumentacja - Microsoft Word.

## Specyfikacja API:
### Backend 1:
<p align="center">
    <img src="img/api-backend-1.png">
</p>

### Backend 2:
* GET /books/all - pobranie danych wszystkich książek oraz kategorii książek
dostępnych w sklepie,
* GET /book/{bookId} - wyszukanie książki po id,
* GET /books/find/ - wyszukiwanie dostępnych książek według ustalonych
kryteriów (poprzez query params).

## Zrzuty ekranu:

Rejestracja:
<p align="center">
    <img src="img/screeny/rejestracja.png">
</p>

Dla najwazniejszych pól wejściowych przeprowadzana jest walidacja np. dla rejestracji:
<p align="center">
    <img src="img/screeny/rejestracja-walidacja.png">
</p>

Logowanie:
<p align="center">
    <img src="img/screeny/logowanie.png">
</p>

Lista dostępnych książek:
<p align="center">
    <img src="img/screeny/lista.png">
</p>

Lista dostępnych książek z wypełnionymi kryteriami i filtrami:
<p align="center">
    <img src="img/screeny/kryteria.png">
</p>

Szczegółowe informacje o książce:
<p align="center">
    <img src="img/screeny/detale.png">
</p>

Wszystkie informacje o książce:
<p align="center">
    <img src="img/screeny/wszystkie-detale.png">
</p>

Zaimplementowano system powiadomień o sukcesie albo wystąpieniu błędu np. przy dodaniu produktu do koszyka:
<p align="center">
    <img src="img/screeny/dodanie-koszyk.png">
</p>

Koszyk widziany przez niezalogowanego użytkownika:
<p align="center">
    <img src="img/screeny/niezalogowany-koszyk.png">
</p>

Koszyk widziany przez zalogowanego użytkownika:
<p align="center">
    <img src="img/screeny/zalogowany-koszyk.png">
</p>

Jest brak możliwości złożenia zamówienia w przypadku brakujących produktów:
<p align="center">
    <img src="img/screeny/koszyk-walidacja.png">
</p>

Składanie zamówienia:
<p align="center">
    <img src="img/screeny/skladanie-zamowienia.png">
</p>

Użytkownik może użyć danych podanych podczas rejestracji albo podać nowe.

Lista własnych zamówień:
<p align="center">
    <img src="img/screeny/moje-zamowienia.png">
</p>

Wyświetlenie wszystkich produktów z zamówienia:
<p align="center">
    <img src="img/screeny/produkty-z-zamowienia.png">
</p>

Wyświetlenie danych odbiorcy przypisanego do zamówienia:
<p align="center">
    <img src="img/screeny/dane-odbiorcy.png">
</p>

Wyszukiwarka zamówień:
<p align="center">
    <img src="img/screeny/wyszukiwanie-zamowien.png">
</p>

Wyszukiwarka zamówień z wypełnionymi kryteriami i filtrami:
<p align="center">
    <img src="img/screeny/wyszukiwanie-zamowien-wypelnione.png">
</p>

Zarządzanie zamówieniem:
<p align="center">
    <img src="img/screeny/zarzadzanie-zamowieniem.png">
</p>
