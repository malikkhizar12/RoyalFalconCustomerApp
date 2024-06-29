import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool mandatory;
  final bool readOnly;
  final bool isVisible; // New property to control visibility
  final TextEditingController? controller; // Controller for text input
  final VoidCallback? onTap;

  const FormTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.mandatory = false,
    this.readOnly = false,
    this.isVisible = true, // Default to true for backward compatibility
    this.controller, // Accepts a TextEditingController
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      // Return an empty SizedBox if the field is not visible
      return SizedBox.shrink();
    }

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
              style:  TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            if (mandatory)
              Text(
                ' *',
                style: TextStyle(
                  color: Color(0xFFFFBC07),
                  fontSize: 16.sp,
                ),
              ),
          ],
        ),
         SizedBox(height: 8.h),
        SizedBox(
          height: 60.h,
          child: TextField(

            controller: controller, // Bind the controller to the TextField
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
        ),
      ],
    );
  }
}
