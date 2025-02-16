import 'package:clean_app/features/users/domain/usecases/get_users.dart';
import 'package:clean_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_app/features/users/presentation/bloc/users_event.dart';
import 'package:clean_app/features/users/presentation/pages/users_page.dart';
import 'package:clean_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_app/injection_container.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<UserBloc>()..add(FetchUsers()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: UsersPage(),
      ),
    );
  }
}
