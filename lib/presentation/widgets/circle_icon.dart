import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final String description;
  final double width;
  final double height;
  final Color? color;
  final Color colorDescription;

  const CircleIcon({
    Key? key,
    required this.icon,
    required this.description,
    this.width = 50,
    this.height = 50,
    this.color,
    this.colorDescription = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Colors.blue,
            borderRadius: BorderRadius.circular(width / 2),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: width * 0.5,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          description,
          style: TextStyle(
            color: colorDescription,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
