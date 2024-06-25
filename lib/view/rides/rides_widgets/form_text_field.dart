import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool mandatory;
  final bool readOnly;
  final VoidCallback? onTap;

  const FormTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.mandatory = false,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTextField(context, label, hint);
  }

  Widget buildTextField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            if (mandatory)
              Text(
                ' *',
                style: TextStyle(
                  color: Color(0xFFFFBC07),
                  fontSize: 16,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFBC07)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
