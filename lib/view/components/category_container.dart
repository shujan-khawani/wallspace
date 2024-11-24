import 'package:flutter/material.dart';
import 'package:wallspace/view/components/text.dart';

class CategoryContainer extends StatelessWidget {
  final String title;
  final String asset;
  const CategoryContainer(
      {super.key, required this.title, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(asset),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: CustomText(
            text: title,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
