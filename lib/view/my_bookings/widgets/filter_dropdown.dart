import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDropdown extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String?> onChanged;

  const FilterDropdown({
    Key? key,
    required this.selectedFilter,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 60.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: Color(0xFFFFBC07),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedFilter,
          onChanged: onChanged,
          dropdownColor: Color(0xFFFFBC07),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          items: [
            DropdownMenuItem<String>(
              value: 'All',
              child: Text(
                'All',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Payment Pending',
              child: Text(
                'Payment Pending',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Pending',
              child: Text(
                'Pending',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Assigned',
              child: Text(
                'Assigned',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Completed',
              child: Text(
                'Completed',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Rejected',
              child: Text(
                'Rejected',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
