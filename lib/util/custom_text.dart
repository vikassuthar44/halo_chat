import 'package:flutter/material.dart';

Text TitleText(String title, BuildContext context) {
  return Text(
    title,
    style: Theme.of(context).textTheme.displayMedium,
  );
}