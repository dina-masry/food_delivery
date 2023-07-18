import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon ;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  const AppIcon({Key? key,
    required this.icon,
    required this.backgroundColor,
    this.size=40,
    this.iconSize=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size/2),
      ),
      child:  Icon(icon,size: iconSize,color: Colors.black,),
    );
  }
}
