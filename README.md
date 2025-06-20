BankApp Mobile (Flutter MVP)

MVP aplikacji zbudowane we Flutterze.  
Obsługuje logowanie BasicAuth, rejestrację, dashboard, eksport PDF i lokalną bazę danych.  
Stylizacja w Material 3 na podstawie szablonu z Figma.


Funkcjonalności

Rejestracja użytkownika
Logowanie (BasicAuth)
Dashboard z danymi z API
Tryb demo bez rejestracji
Eksport danych do PDF
Czyszczenie lokalnej bazy (Drift)
Obsługa motywu jasny / ciemny / systemowy (Material 3)
Testy jednostkowe + widgetowe



Struktura projektu


lib/
├── main.dart
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── dashboard_screen.dart
│   └── settings_screen.dart
├── services/
│   ├── auth_service.dart
│   ├── api_service.dart
│   └── pdf_exporter.dart
├── data/
│   └── app_database.dart
├── widgets/
│   └── settings_icon_button.dart
└── theme/
└── app_theme.dart

test/
├── auth_service_test.dart
├── pdf_export_test.dart
└── settings_screen_test.dart



Jak uruchomić

bash
flutter pub get
flutter run




Jak testować

```bash
flutter test




Zależności

- `http`
- `shared_preferences`
- `pdf`
- `path_provider`
- `drift`
- `sqlite3_flutter_libs`
- `mockito`
- `flutter_test`
- `http/testing`


Autor

Projekt stworzony przez [Marcin Gantkowski](https://github.com/mart-gant).  
Licencja: MIT
