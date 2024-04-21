import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../bloc/user/remote/remote_user_bloc.dart';
import '../bloc/user/remote/remote_user_event.dart';

class UserDetailedWidget extends StatefulWidget {
  final UserEntity? user;
  final List<UserEntity>? users;

  const UserDetailedWidget({
    Key ? key,
    this.user,
    this.users,
  }) : super(key: key);

  @override
  State<UserDetailedWidget> createState() => _UserDetailedWidgetState();
}

class _UserDetailedWidgetState extends State<UserDetailedWidget> {
  final _nameController = TextEditingController();
  String oldName = "";

  @override
  void initState() {
    super.initState();
    // Set initial name in text-field
    oldName = "${widget.user!.name!.title} ${widget.user!.name!.first} ${widget.user!.name!.last}";
    _nameController.text = "${widget.user!.name!.title} ${widget.user!.name!.first} ${widget.user!.name!.last}";
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          _buildImage(context),
      _buildUserDetails(),
          Builder(
              builder: (context) {
                return ElevatedButton(onPressed: () => _saveUserName(context), child: const Text("Save user name"));
              }
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: widget.user!.picture!.large,
        imageBuilder: (context, imageProvider) =>
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: const CupertinoActivityIndicator(),
                ),
              ),
            ),
        errorWidget: (context, url, error) =>
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: const Icon(Icons.error),
                ),
              ),
            )
    );
  }

  Widget _buildUserDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 50, bottom: 8, right: 8, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4,),
            _buildGender(),
            const SizedBox(height: 4,),
            _buildChangeableName(),
            const SizedBox(height: 4,),
            _buildAgeDetails(),
            const SizedBox(height: 4,),
            // Text(
            //   "${user?.location?.street?.name} ${user?.location?.street?.number}, ${user?.location?.city}, ${user?.location?.state}",
            //   style: const TextStyle(
            //     fontSize: 14,
            //   ),
            // ),
            _buildAddressDetails(),
            const SizedBox(height: 4,),
            _buildContactDetails(),
            const SizedBox(height: 4,),
          ],
        ),
      ),
    );
  }

  Widget _buildGender() {
    return Row(
      children: [
        const Icon(CupertinoIcons.person, size: 22),
        const SizedBox(width: 10),
        Text(
          widget.user?.gender ?? '',
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildChangeableName() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: 'Name'),
    );
    return const Text(
      "Need to create changeable name",
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget _buildAgeDetails() {
    return Row(
      children: [
        const Icon(Icons.cake_outlined, size: 22),
        const SizedBox(width: 10),
        Text(
          "${widget.user?.dob?.age}, ${widget.user?.dob?.date.substring(0, 4)}",
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          children: [
            Icon(Icons.home_outlined, size: 22),
            SizedBox(width: 10),
            Text(
              "Address:",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(width: 30,),
        Column(
          children: [
            Text(
              "${widget.user?.location?.street?.name} ${widget.user?.location?.street?.number}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              "${widget.user?.location?.city}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              "${widget.user?.location?.state}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),

          ],
        )
      ],
    );
  }

  Widget _buildContactDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          children: [
            Icon(Icons.contact_emergency_outlined, size: 22),
            SizedBox(width: 10),
            Text(
              "Contact:",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(width: 30,),
        Column(
          children: [
            Text(
              "${widget.user?.email}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              "${widget.user?.cell}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }


  void _saveUserName(BuildContext context) {
    BlocProvider.of<RemoteUserBloc>(context).add(UserNameUpdated(_nameController.text, oldName, widget.users ?? []));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Saving user\'s name...'),
      ),
    );
  }
}
