import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/geolocation.dart';
import 'package:surf_practice_chat_flutter/ui/theme/theme.dart';

class FieldWithButton extends StatelessWidget {
  const FieldWithButton(
      {Key? key,
      required this.controller,
      this.onIconTap,
      this.hintText,
      this.messageInProgress = false,
      this.icon,
      this.onEditingComplete})
      : super(key: key);
  final TextEditingController controller;
  final VoidCallback? onIconTap;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  final IconData? icon;
  final bool messageInProgress;

  Future<void> onLoadGeo() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    final loc = await Geolocator.getCurrentPosition();
    ChatGeolocationDto(latitude: loc.latitude, longitude: loc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(color: AppColors.msgBackBlue),
            child: IconButton(
                onPressed: () => onLoadGeo(),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(
                  Icons.share_location_outlined,
                  color: AppColors.iconBlue,
                )),
          ),
        ),
        Expanded(
          flex: 7,
          child: TextField(
            onEditingComplete: onEditingComplete,
            controller: controller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                hintText: hintText ?? 'СООБЩЕНИЕ',
                hintStyle: TxtStyle.blender20Blue),
          ),
        ),
        messageInProgress
            ? const CircularProgressIndicator(
                color: AppColors.red,
              )
            : IconButton(
                onPressed: onIconTap,
                icon: Icon(
                  icon,
                  color: AppColors.red,
                ),
              )
      ],
    );
  }
}
