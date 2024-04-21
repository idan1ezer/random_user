import 'package:flutter/material.dart';

import '../../features/users/domain/entities/user.dart';
import '../../features/users/presentation/pages/user_detailed/user_detailed_screen.dart';
import '../../features/users/presentation/pages/user_detailed/user_detailed_screen_arguments.dart';
import '../../features/users/presentation/pages/users_list/users_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const UserScreen());

      case '/UserDetailed':
        final args = settings.arguments as UserDetailedScreenArguments;
        return _materialRoute(UserDetailedScreen(user: args.user, users: args.users,));

      default:
        return _materialRoute(const UserScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}