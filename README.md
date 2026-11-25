# Novasys School Frontend

A neutral, clickable Flutter UI prototype for the Parent experience on Android
and iOS. Driver screens are not implemented yet.

## Demo flow

Splash -> Welcome -> Sign up or Log in -> Verify -> Home.
The bottom menu opens Home, Trips, Notifications, and More. More includes
**End demo session**, which clears local state and returns to Welcome.

Use made-up details (for example parent@example.test), any password of at least
six characters, and the displayed verification code **123456**. Sign up also
requires a name and matching confirmation. No real account is created, password
authenticated, or email sent. Resend only shows a demo message. Password inputs
are cleared on submission and are not stored by the demo controller.

State lives in memory and resets when the app restarts. Routes are intentionally
unguarded for UI development; this is not a production authentication system.
Trip, map, and notification panels are explicitly labeled placeholders. No
backend, GPS, payments, or real transport data is connected.

## Organization

- lib/main.dart: application entry point.
- lib/app/: MaterialApp.router, route constants/configuration, bottom-menu shell.
- lib/core/: shared widgets and reserved constants, theme, and utility folders.
- lib/features/auth/: splash, welcome, forms, verification, and a local demo
  controller. Views own text fields; the controller owns demo session state.
- lib/features/parent/views/: Home, Trips, and Notifications wireframes.
- lib/features/more/views/: prototype information and ending the demo session.
- Each feature retains controllers/, models/, repositories/, views/, and widgets/
  directories. Add models and repositories only when needed; no dummy data
  access layer is included. Git does not preserve empty directories.

## Run and verify

Created with Flutter 3.47.7 and Dart 3.13.5.

```sh
flutter pub get
flutter run
dart format lib test
flutter analyze
flutter test
```

Use an Android device or emulator. iOS builds require macOS with Xcode.
Widget tests cover sign-up validation, incorrect/correct verification, login,
bottom tabs, session reset, missing verification state, and a small viewport
with a keyboard inset.

Dependencies remain Flutter, go_router, cupertino_icons, flutter_test, and
flutter_lints. No additional packages or custom assets are required.
