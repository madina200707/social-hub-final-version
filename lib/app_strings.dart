class AppStrings {
  static String get(String key, String lang) {
    final data = {
      'en': {
        'profile': 'Profile',
        'user': 'User',
        'toggleTheme': 'Toggle Theme',
        'logout': 'Logout',
        'language': 'Language',
        'feed': 'Feed',
        'create': 'Create',
        'explore': 'Explore',
      },
      'ru': {
        'profile': 'Профиль',
        'user': 'Пользователь',
        'toggleTheme': 'Сменить тему',
        'logout': 'Выйти',
        'language': 'Язык',
        'feed': 'Лента',
        'create': 'Создать',
        'explore': 'Обзор',
      },
      'kk': {
        'profile': 'Профиль',
        'user': 'Қолданушы',
        'toggleTheme': 'Тақырыпты ауыстыру',
        'logout': 'Шығу',
        'language': 'Тіл',
        'feed': 'Лента',
        'create': 'Жасау',
        'explore': 'Шолу',
      },
    };

    return data[lang]?[key] ?? data['en']![key] ?? key;
  }
}