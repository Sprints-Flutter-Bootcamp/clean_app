# Clean App Task
This is a simple app build to practice the **Clean Architecture** principles

We used the same API we used before in the [**empm project task**][empm_repo_link] for fetching user data into a list view builder
It implements a **User List** feature with **Bloc for state management** and **Dio for API calls**.


## Clean Architecture Implementation

This project follows the **three-layered Clean Architecture**:

 **Clean Architecture** principles separate concerns into different layers, ensuring scalability, testability, and maintainability. 

### 1️⃣ Data Layer
- **Responsible for data retrieval**
- Implements `UserRemoteDataSource` using **Dio** for API requests.
- Converts **JSON responses into UserModel**.
- Implements `UserRepositoryImpl` which interacts with `UserRemoteDataSource`.

### 2️⃣ Domain Layer
- **Business logic layer** (independent of data sources & UI).
- Defines:
  - `User` **entity** (Core business object).
  - `UserRepository` **abstract class** (contract).
  - `GetUsers` **use case** (fetches users from the repository).

### 3️⃣ Presentation Layer
- **Handles UI & state management**.
- Uses **Flutter Bloc** to manage user state.
- `UsersBloc` listens to `FetchUsers` events and loads users.

<br>

---
---
---

## 🔗 Dependency Injection

We use **GetIt** for dependency injection. The `injection_container.dart` file registers:
- `Dio` instance
- `UserRemoteDataSourceImpl`
- `UserRepositoryImpl`
- `GetUsers` use case
- `UsersBloc`

like below...

```dart
sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(dio: sl()));
```
<br>

---
---
---

## State Management (BLoC)
The UsersBloc listens for the FetchUsers event, fetches data using the GetUsers use case, and emits either:

UsersLoaded (on success)
UsersError (on failure)
Example:

```dart
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;

  UsersBloc({required this.getUsers}) : super(UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoading());
    final result = await getUsers(NoParams());
    result.fold(
      (failure) => emit(UsersError()),
      (users) => emit(UsersLoaded(users: users)),
    );
  }
}

```

<br>

---
---
---

## 🎨 UI Implementation
A basic UI displays fetched users:

UsersPage triggers FetchUsers event.
BlocBuilder listens to UsersBloc and updates UI.
Displays users in a ListView.
Example:

``` dart
BlocBuilder<UsersBloc, UsersState>(
  builder: (context, state) {
    if (state is UsersLoading) {
      return CircularProgressIndicator();
    } else if (state is UsersLoaded) {
      return ListView.builder(
        itemCount: state.users.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(state.users[index].name));
        },
      );
    }
    return Text("Failed to load users");
  },
);

```
<br>

---
---
---

## 🛠 Tech Stack
- Flutter
- Flutter Bloc
- Dio (API requests)
- GetIt (Dependency Injection)
- Equatable (Value comparison)

<br>

---
---
---

### I have used the package `very_good_cli` to easily create a structured flutter project with ease

*I have kept some of the readme generated below*


---
---
---
## Getting Started with very_good_cli

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Clean App works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:clean_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

[empm_repo_link]: https://github.com/Sprints-Flutter-Bootcamp/Users-Info


[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
