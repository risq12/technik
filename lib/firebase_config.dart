/// Uzupełnij wartości z Firebase Console / FlutterFire.
/// Nie wpisuj tutaj hasła Google ani prywatnego klucza serwisowego.
class FirebaseConfig {
  static const apiKey = 'WSTAW_FIREBASE_API_KEY';
  static const appId = 'WSTAW_FIREBASE_APP_ID';
  static const messagingSenderId = 'WSTAW_SENDER_ID';
  static const projectId = 'WSTAW_PROJECT_ID';
  static const webClientId = 'WSTAW_WEB_CLIENT_ID.apps.googleusercontent.com';

  static bool get isConfigured =>
      !apiKey.startsWith('WSTAW_') &&
      !appId.startsWith('WSTAW_') &&
      !messagingSenderId.startsWith('WSTAW_') &&
      !projectId.startsWith('WSTAW_') &&
      !webClientId.startsWith('WSTAW_');
}
