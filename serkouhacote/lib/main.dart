import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:serkouhacote/core/navigation/GoRoute.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_users.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_bloc.dart';
import 'package:serkouhacote/features/users/presentation/bloc/userevent.dart';

import 'package:serkouhacote/features/users/injection/injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init(); // Initialize dependencies

  runApp(
    MultiProvider(
      providers: [
        Provider<GetUsers>(create: (_) => di.sl<GetUsers>()),
        BlocProvider<UserBloc>(
          create: (context) => di.sl<UserBloc>()..add(LoadUsers()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(useMaterial3: false),
    );
  }
}
