import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const ImageContainer({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: child,
        ),
      ),
    );
  }
}
