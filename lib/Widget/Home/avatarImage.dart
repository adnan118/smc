import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smc/Core/Constant/color.dart';

class AvatarImag extends StatelessWidget {
  final Color color;
  final String img;
  final double radius;
  final int numCircle;

  AvatarImag(
      {Key? key,
      required this.color,
      required this.img,
      required this.radius,
      required this.numCircle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: const Duration(seconds: 5),
      glowColor: color,
      glowShape: BoxShape.circle,
      glowRadiusFactor: 0.2,
      curve: Curves.easeInCirc,
      glowCount: numCircle,
      child: Material(
        elevation: 5.0,
        shape: CircleBorder(),
        color: Colors.transparent,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,

          backgroundImage: CachedNetworkImageProvider(img),


          //NetworkImage(img),
          //NetworkImage("${LinksApp.linkImagProfile}/$img"),
          radius: radius,
        ),
      ),
    );
  }
}
