import 'package:action_item_project/features/users/presentation/widgets/user_detailed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/user/remote/remote_user_bloc.dart';

class UserDetailedScreen extends StatelessWidget {
  final UserEntity? user;
  final List<UserEntity>? users;

  const UserDetailedScreen({super.key, this.user, this.users});

  @override
  Widget build(BuildContext context) {
   return BlocProvider<RemoteUserBloc>(
       create: (context) => sl(),
     child: Scaffold(
       // resizeToAvoidBottomInset : false,
          appBar: _buildAppbar(context),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: UserDetailedWidget(user: user,users: users,)
              ),
            ),
          ),
          // body: UserDetailedWidget(user: user,),
     ),
   );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.chevron_left, color: Colors.black),
        ),
      ),
    );
  }


  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}