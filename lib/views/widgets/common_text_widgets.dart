import 'package:flutter/material.dart';

import '../../core/config/text_styles.dart';

class Label extends StatelessWidget {
  final String text;
  const Label({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.label,
    );
  }
}
