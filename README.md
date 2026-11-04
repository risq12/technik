# TECHNIK AI — starter Flutter

Pierwszy szkielet aplikacji Android:
- motyw jasny i ciemny,
- język polski i angielski,
- ekran główny z postępem nauki,
- katalog dziedzin technicznych,
- przykładowe dane lokalne.

## Jak uzyskać APK bez instalowania Flutter SDK na swoim komputerze

Projekt zawiera GitHub Actions, które kompiluje APK na serwerze GitHub.

1. Zaloguj się lub załóż konto na GitHub.
2. Utwórz nowe **publiczne** repozytorium, np. `technik-ai`.
3. Rozpakuj ZIP i wgraj do repozytorium całą zawartość folderu `technik_ai_flutter` (razem z ukrytym folderem `.github`). Możesz użyć opcji **Add file → Upload files**.
4. Zatwierdź zmiany przyciskiem **Commit changes**.
5. Otwórz zakładkę **Actions** w repozytorium. Workflow „Build TECHNIK AI APK” powinien uruchomić się automatycznie. Jeśli nie, wybierz go i kliknij **Run workflow**.
6. Po zakończeniu kompilacji otwórz wykonany przebieg (zielony status), przewiń do **Artifacts** i pobierz `technik-ai-debug-apk`.
7. Rozpakuj pobrane archiwum ZIP — w środku będzie `app-debug.apk`. Prześlij go na telefon i zainstaluj.

Do pobrania APK nie potrzeba Flutter SDK ani Android Studio na komputerze. GitHub może wymagać zalogowania. Nie publikuj w repozytorium żadnych kluczy API ani haseł.

## Lokalna kompilacja (opcjonalnie)

```bash
flutter pub get
flutter run
flutter build apk --debug
```

## Struktura

```text
lib/
  main.dart
  app/
  data/
  models/
  screens/
  widgets/
.github/workflows/android-apk.yml
```

## Ważne

To demonstracyjny punkt startowy UI, a nie gotowy produkt produkcyjny. Dane są przykładowe. Na tym etapie nie ma jeszcze backendu, kont użytkowników, właściwych kursów ani połączenia z AI. APK z GitHub Actions będzie kompilacją debug, przeznaczoną do testów.

Nie umieszczaj kluczy API w aplikacji Android.
