# TECHNIK AI 0.3.0

Rozbudowana wersja edukacyjnej aplikacji Flutter.

## Co zawiera
- 14 ścieżek nauki, w tym osobne kursy CAD: Tinkercad, Fusion 360, Onshape, Inventor, AutoCAD i FreeCAD.
- 100 nowych lekcji z mechaniki, 100 z elektroniki i 100 z elektromechaniki (łącznie z wcześniejszymi lekcjami: odpowiednio 105, 106 i 103).
- Podział rozbudowanych kursów na 10 kategorii po 10 tematów.
- Lekcje z teorią, analogią, sposobem analizy, zadaniem, ćwiczeniem warsztatowym i quizem.
- Wzory z opisem symboli oraz jednostek przy każdym wzorze.
- Mechanika: pomiary, statyka, kinematyka, energia, materiały, napędy, silniki spalinowe, układy silnika i diagnostyka.
- Elektronika: podstawy elektryczności, prawo Ohma, elementy bierne, diody, tranzystory, logika, pomiary, zasilacze, montaż i diagnostyka.
- Elektromechanika: elektromagnetyzm, silniki DC/AC, silniki specjalne, alternatory, przekaźniki, czujniki, falowniki i diagnostyka napędów.
- Elektromechanika odblokowuje się po ukończeniu mechaniki i elektroniki.
- Symulator obwodu LED, symulator przekładni oraz uproszczony symulator tranzystora NPN w układzie wspólnego emitera (WE).
- XP, poziomy, postępy i lokalny zapis ukończonych lekcji.
- Ustawienia motywu, języka, podpowiedzi, preferencji przypomnień, zarządzanie pakietami offline i reset postępów.
- Zapisywanie wybranych kategorii lub całych kursów w lokalnej pamięci offline.

## Ważne ograniczenia tej wersji
- Treści kursów są obecnie dołączone do aplikacji. Funkcja „Zapisz offline” zapisuje wybrane pakiety lokalnie, ale nie pobiera jeszcze treści z serwera. Prawdziwe pobieranie na żądanie bez dołączania całej bazy do APK wymaga skonfigurowania hostingu/API lub Firebase Storage.
- Ustawienie przypomnień zapisuje preferencję, ale powiadomienia systemowe nie są jeszcze podłączone.
- Multimedia (obrazy i filmy) wymagają przygotowania i podpięcia konkretnych materiałów.
- Treści i symulatory mają charakter edukacyjny. Nie zastępują dokumentacji producenta, kwalifikacji ani nadzoru przy pracy z maszynami i instalacjami.
- Postępy są lokalne i nie synchronizują się jeszcze między urządzeniami.

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

W kodzie użyte jest oficjalne okno logowania Google i Firebase Authentication. Nie wpisuj hasła Google w aplikacji. Nie commituj prywatnych kluczy serwisowych ani haseł.
