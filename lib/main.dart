import 'package:flutter/material.dart';

import 'config/routes/app_routes.dart';
import 'config/theme/app_themes.dart';
import 'features/users/presentation/pages/users_list/users_screen.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Action Item Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const UserScreen(),
    );
  }
}
