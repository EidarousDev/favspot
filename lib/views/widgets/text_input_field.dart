import 'package:flutter/material.dart';

import '../../core/config/app_colors.dart';
import '../../core/config/text_styles.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String value) onTextChanged;
  final bool multiLine;
  const TextInputField(
      {Key? key,
      required this.label,
      required this.hint,
      required this.onTextChanged,
      this.multiLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            label,
            style: TextStyles.label,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            maxLines: multiLine ? 3 : 1,
            onChanged: (val) {
              onTextChanged(val);
            },
            decoration: InputDecoration(
              fillColor: AppColors.secondaryColor,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                borderSide: BorderSide(color: Colors.grey.shade50),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                borderSide: BorderSide(color: Colors.grey.shade50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                borderSide: BorderSide(color: Colors.grey.shade50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
