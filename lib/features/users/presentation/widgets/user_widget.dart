import 'package:action_item_project/features/users/domain/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserWidget extends StatelessWidget {
  final UserEntity? user;
  final void Function(UserEntity user)? onUserPressed;

  const UserWidget({
    Key ? key,
    this.user,
    this.onUserPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 7, top: 7),
        height: MediaQuery
            .of(context)
            .size
            .width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: user!.picture!.thumbnail,
        imageBuilder: (context, imageProvider) =>
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 3,
                  height: double.maxFinite,
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 3,
                  height: double.maxFinite,
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 3,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: const Icon(Icons.error),
                ),
              ),
            )
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Title
            Text(
              "${user?.name?.title} ${user?.name?.first} ${user?.name?.last}" ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Butler',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.person, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    user?.gender ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Datetime
            Row(
              children: [
                const Icon(CupertinoIcons.globe, size: 16),
                const SizedBox(width: 4),
                Text(
                  user?.location?.country ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _onTap() {
    if (onUserPressed != null) {
      onUserPressed!(user!);
    }
  }
}