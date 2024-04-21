import 'package:action_item_project/features/users/domain/entities/user.dart';
import 'package:action_item_project/features/users/presentation/bloc/user/remote/remote_user_bloc.dart';
import 'package:action_item_project/features/users/presentation/bloc/user/remote/remote_user_event.dart';
import 'package:action_item_project/features/users/presentation/pages/user_detailed/user_detailed_screen_arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../bloc/user/remote/remote_user_state.dart';
import '../../widgets/user_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super (key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserEntity> users = [];
  List<String> countries = [];
  List<String> names = [];
  bool isFiltered = false;


  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteUserBloc>(
      create: (context) => sl(),
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text(
        'Users',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => setState(() {
          }),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(CupertinoIcons.refresh, color: Colors.red),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteUserBloc, RemoteUserState> (
      builder: (_,state) {
        if (state is RemoteUserLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteUserException) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteUserDone) {
          countries = [];
          names = [];
          users = state.users!;
          for (UserEntity user in users) {
            String country = user.location!.country;
            String name = user.name!.first;
            if (!countries.contains(country)) {
              countries.add(country);
            }
            if (!names.contains(name)) {
              names.add(name);
            }
          }

          return Column(
            children: [
              isFiltered ?
                  Builder(
                    builder: (context) {
                      return ElevatedButton(onPressed: () => _removeFilter(context), child: const Text("Remove Filter"));
                    }
                  ) :

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFilterByCountrySelector(),
                  _buildFilterByNameSelector(),
                ],
              ),
              Expanded(
              child: ListView.builder(
                itemBuilder: (context,index){
                  return UserWidget(
                    user: state.users![index] ,
                    onUserPressed: (user) => _onUserPressed(context,user),
                  );
                },
                itemCount: state.users!.length,
              ),
            ),]
          );
        }
        if (state is RemoteUserFilterCountryDone) {

          if (state.users!.isEmpty) {
            return const Text("There is no one from that country");
          }
          else {
            return Column(
              children: [
                isFiltered ?
                Builder(
                  builder: (context) {
                    return ElevatedButton(onPressed: () => _removeFilter(context), child: const Text("Remove Filter"));
                  }
                ) :

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFilterByCountrySelector(),
                    _buildFilterByNameSelector(),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context,index){
                      return UserWidget(
                        user: state.users![index] ,
                        onUserPressed: (user) => _onUserPressed(context,user),
                      );
                    },
                    itemCount: state.users!.length,
                  ),
                ),
              ],
            );
          }
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(CupertinoIcons.cloud_download, color: Colors.greenAccent),
      ),
    );
  }

  void _removeFilter(BuildContext context) {
    BlocProvider.of<RemoteUserBloc>(context).add(UserFilterChanged(null, null, users));
    setState(() {
      isFiltered = false;
    });
  }

  Widget _buildFilterByCountrySelector() {
    return Builder(
      builder: (context) =>
          Center(
            child: DropdownButton<String>(
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              hint: Text("Filter by country"),
              onChanged: (String? country) async {
                if (country != null) {
                  BlocProvider.of<RemoteUserBloc>(context).add(UserFilterChanged(country, null, users));
                  setState(() {
                    isFiltered = true;
                  });
                }
              },
              items: countries
                  .map<DropdownMenuItem<String>>(
                    (e) =>
                    DropdownMenuItem<String>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(e)
                        ],
                      ),
                    ),
              )
                  .toList(),
            ),
          ),
    );
  }

  Widget _buildFilterByNameSelector() {
    return Builder(
      builder: (context) =>
          Center(
            child: DropdownButton<String>(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              hint: Text("Filter by name"),
              onChanged: (String? name) async {
                if (name != null) {
                  BlocProvider.of<RemoteUserBloc>(context).add(UserFilterChanged(null, name, users));
                  setState(() {
                    isFiltered = true;
                  });
                }
              },
              items: names
                  .map<DropdownMenuItem<String>>(
                    (e) =>
                    DropdownMenuItem<String>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(e)
                        ],
                      ),
                    ),
              )
                  .toList(),
            ),
          ),
    );
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<RemoteUserBloc>(context).add(const GetUsers());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Getting Users...'),
      ),
    );
  }

  void _onUserPressed(BuildContext context, UserEntity user) {
    Navigator.pushNamed(context, '/UserDetailed', arguments: UserDetailedScreenArguments(user, users));
  }
}