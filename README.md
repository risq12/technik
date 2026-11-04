# TECHNIK AI 0.2.0

Testowa rozbudowana wersja aplikacji Flutter.

## Co zawiera
- 14 ścieżek nauki, w tym osobne kursy CAD: Tinkercad, Fusion 360, Onshape, Inventor, AutoCAD i FreeCAD.
- Lekcje z teorią prostym językiem, analogią, opisem działania, wzorami, przykładem, zadaniem i quizem.
- Mechanika: podstawy, przełożenia, moment, moc i diagnostyka usterek odblokowywana po podstawach.
- Elektronika: prąd, napięcie, rezystancja, obwody, LED, multimetr, tranzystory i bezpieczeństwo.
- Elektromechanika i Arduino zablokowane do czasu ukończenia podstaw elektroniki.
- Automatyka, programowanie, Arduino i energetyka.
- Symulator obwodu LED oraz symulator przekładni.
- XP, poziomy, postępy i lokalny zapis ukończonych lekcji.
- Ciemny motyw i przełącznik języka interfejsu (część etykiet jest jeszcze po polsku).

## Budowanie APK
Workflow GitHub Actions buduje testowy APK po pushu do `main`.
Artefakt: `technik-ai-debug-apk`.

## Logowanie Google – wymagane kroki konfiguracyjne
Ekran logowania Google i obsługa Firebase Auth są już w kodzie. Żeby logowanie faktycznie działało, trzeba podpiąć własny projekt Firebase – dane OAuth są unikalne dla aplikacji i nie mogę ich wymyślić.

1. Otwórz https://console.firebase.google.com/ i utwórz projekt.
2. Dodaj aplikację Android. Identyfikator pakietu po `flutter create` to domyślnie `com.example.technik_ai` (sprawdź `applicationId` w `android/app/build.gradle` lub `android/app/build.gradle.kts`).
3. W Firebase Authentication → Sign-in method włącz dostawcę Google.
4. W ustawieniach aplikacji Android dodaj SHA-1 i SHA-256 klucza debug. W katalogu `android` można je wyświetlić poleceniem `./gradlew signingReport` (Windows: `gradlew.bat signingReport`).
5. W Firebase Project settings → Your apps / OAuth pobierz Web client ID (typ klienta Web application).
6. Otwórz `lib/firebase_config.dart` i wstaw `apiKey`, `appId`, `messagingSenderId`, `projectId` oraz `webClientId` z własnego projektu Firebase.
7. Zapisz zmiany i ponownie zbuduj APK przez GitHub Actions.

W kodzie użyte jest oficjalne okno logowania Google i Firebase Authentication. Nie wpisuj hasła Google w aplikacji. Nie commituj prywatnych kluczy serwisowych ani haseł. Wartości Firebase aplikacji mobilnej i OAuth Client ID nie są hasłami, ale nie publikuj dodatkowych sekretów serwerowych.

## Ważne ograniczenia
- Symulacje są edukacyjnymi prototypami, a nie symulatorami fizycznymi klasy inżynierskiej.
- Postępy zapisują się lokalnie na urządzeniu; nie synchronizują się między urządzeniami.
- Quizy mają proste sprawdzanie jednej odpowiedzi. Egzaminy końcowe, AI tutor i pełne animacje są kolejnymi etapami.
- Materiały wymagają dalszej weryfikacji i rozbudowy przed publikacją.
