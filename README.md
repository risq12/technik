# TECHNIK AI 0.4.0

Rozbudowana wersja edukacyjnej aplikacji Flutter – około 550 lekcji i tematów w ścieżkach nauki. Projekt nadal używa dotychczasowego układu nawigacji i stylu Material 3, ale ma znacznie większy zakres nauki oraz nowe narzędzia praktyczne.

## Zawartość kursów

- Mechanika: 105 lekcji – jednostki i pomiary, statyka, kinematyka, energia, materiały, wały i łożyska, silniki 2T/4T, układy pomocnicze i diagnostyka.
- Elektronika: 123 lekcje – podstawy, prawa obwodów, elementy bierne, diody, tranzystory, pomiary, zasilanie, schematy, fale, anteny i systemy alarmowe.
- Elektromechanika: 103 lekcje – elektromagnetyzm, silniki DC/AC/BLDC, generatory, układy pojazdu, przekaźniki, czujniki, falowniki i diagnostyka.
- CAD: 130 tematów dla Tinkercad, Fusion 360, Onshape, Inventor, AutoCAD i FreeCAD. Kursy CAD są domyślnie ukryte; włącz je w Profil i ustawienia → Kursy programów CAD.
- Automatyka, programowanie, Arduino i energetyka: dodatkowe ścieżki praktyczne.

Lekcje zawierają wyjaśnienia, analogie, procedury krok po kroku, przykłady, zadania i quizy. Rozbudowane tematy mają dodatkowe zadania. Wzory posiadają opisy symboli i jednostek. Schematy poglądowe są rysowane wektorowo w aplikacji.

## Nowe funkcje

- Pracownia elektroniczna 2D: symulacja obwodu LED, prądu, mocy rezystora, przerwy i odwrotnej polaryzacji.
- Trenażer czytania schematów.
- Kalkulator częstotliwości, długości fali, dipola półfalowego i anteny ćwierćfalowej oraz tabela pasm VLF–EHF.
- Symulator logiczny systemu alarmowego: kontaktron, PIR, sabotaż i uzbrojenie.
- Symulator przekładni oraz wcześniejszy model tranzystora WE.
- Wybór kursów CAD w ustawieniach – wybrane kursy pojawiają się na ekranie Nauka.
- Elektromechanika wymaga ukończenia mechaniki i elektroniki. Tryb administratora omija blokady.
- Kod `skladak` w Profil i ustawienia → Kod dostępu uruchamia lokalny panel testera.
- Panel testera może odblokować ścieżki, oznaczyć wszystkie lekcje jako ukończone i zapisać wszystkie pakiety offline.
- Ulepszono quizy: odpowiedzi są merytoryczne i zależą od działu, a nie powtarzają jednego zestawu losowych opcji.
- Workflow GitHub Actions korzysta z nowszych wersji checkout i upload-artifact.

## Ważne ograniczenia

- Kod `skladak` jest celowo prostym kodem testowym zaszytym w aplikacji. Nie jest bezpiecznym uwierzytelnianiem administratora – każdy, kto zna kod lub przeanalizuje APK, może go użyć. W publicznej aplikacji panel administracyjny należy przenieść na backend z prawdziwą autoryzacją.
- Rysunki w lekcjach są schematami poglądowymi tworzonymi w aplikacji, nie zdjęciami rzeczywistych urządzeń.
- Pracownia elektroniczna jest edukacyjnym symulatorem uproszczonego obwodu LED, a nie pełnym symulatorem SPICE typu Falstad. Nie modeluje wszystkich charakterystyk półprzewodników ani pasożytniczych parametrów.
- Pakiety offline zapisują treść lekcji w pamięci lokalnej, ale cała baza jest obecnie dołączona do aplikacji. Prawdziwe pobieranie treści z serwera wymaga hostingu/API lub Firebase Storage.
- Przypomnienia zapisują preferencję, ale powiadomienia systemowe nie są jeszcze podłączone.
- Logowanie Google wymaga uzupełnienia `lib/firebase_config.dart` danymi własnego projektu Firebase oraz konfiguracji SHA-1/SHA-256.
- Postępy są lokalne i nie synchronizują się jeszcze między urządzeniami.
- Treści o instalacjach, alarmach, maszynach i antenach są edukacyjne. Prace przy sieci 230 V, urządzeniach dużej mocy i instalacjach zabezpieczeń wymagają odpowiednich kwalifikacji, dokumentacji i zgodności z lokalnymi przepisami radiowymi oraz budowlanymi.

## Budowanie APK bez Fluttera na komputerze użytkownika

Po wypchnięciu zmian do gałęzi `main` GitHub Actions sam instaluje Flutter SDK na runnerze i buduje APK. Nie trzeba instalować Fluttera lokalnie.

1. `git add .`
2. `git commit -m "TECHNIK AI 0.4.0"
3. `git push origin main`
4. Otwórz kartę Actions i pobierz artefakt `technik-ai-debug-apk` z udanego uruchomienia.

## Logowanie Google

Ekran logowania Firebase/Google wymaga własnej konfiguracji. Utwórz projekt w Firebase Console, dodaj aplikację Android, włącz Google w Authentication, dodaj odciski SHA-1/SHA-256 i wstaw konfigurację do `lib/firebase_config.dart`. Nie wpisuj hasła Google do kodu aplikacji i nie commituj prywatnych kluczy serwisowych.
