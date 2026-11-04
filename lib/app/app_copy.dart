enum AppLanguage { polish, english }

class AppCopy {
  static const Map<AppLanguage, Map<String, String>> _values = {
    AppLanguage.polish: {
      'hello': 'Cześć! Czego dziś chcesz się nauczyć?',
      'subtitle': 'Rozwijaj umiejętności techniczne krok po kroku.',
      'yourProgress': 'TWÓJ POSTĘP',
      'level': 'Poziom',
      'experience': 'Punkty XP',
      'streak': 'Seria nauki',
      'days': 'dni',
      'categories': 'Dziedziny techniczne',
      'seeAll': 'Zobacz wszystkie',
      'continueLearning': 'Kontynuuj naukę',
      'continueSubtitle': 'Wróć do ostatnio otwartej lekcji',
      'start': 'Otwórz',
      'courses': 'kursów',
      'lessons': 'lekcji',
      'comingSoon': 'Ten moduł dodamy w kolejnej wersji.',
      'home': 'Start',
      'learn': 'Nauka',
      'profile': 'Profil',
      'theme': 'Zmień motyw',
      'language': 'Zmień język',
    },
    AppLanguage.english: {
      'hello': 'Hi! What would you like to learn today?',
      'subtitle': 'Build technical skills step by step.',
      'yourProgress': 'YOUR PROGRESS',
      'level': 'Level',
      'experience': 'XP points',
      'streak': 'Learning streak',
      'days': 'days',
      'categories': 'Technical fields',
      'seeAll': 'See all',
      'continueLearning': 'Continue learning',
      'continueSubtitle': 'Return to your last opened lesson',
      'start': 'Open',
      'courses': 'courses',
      'lessons': 'lessons',
      'comingSoon': 'This module will be added in a future version.',
      'home': 'Home',
      'learn': 'Learn',
      'profile': 'Profile',
      'theme': 'Change theme',
      'language': 'Change language',
    },
  };

  static String get(AppLanguage language, String key) {
    return _values[language]?[key] ?? key;
  }
}
