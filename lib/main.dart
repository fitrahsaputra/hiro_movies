import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies/core.dart';

Future main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'lib/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: myProviders,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          // appBarTheme: const AppBarTheme(elevation: 8),
        ),
        initialRoute: '/',
        routes: myRoutes,
      ),
    );
  }
}
