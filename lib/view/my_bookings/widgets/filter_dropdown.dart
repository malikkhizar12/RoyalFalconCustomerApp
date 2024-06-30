// filter_dropdown.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDropdown extends StatefulWidget {
  final String selectedFilter;
  final ValueChanged<String?> onChanged;

  const FilterDropdown({
    Key? key,
    required this.selectedFilter,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FilterDropdownState createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 60.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: Color(0xFFFFBC07),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedFilter,
          onChanged: widget.onChanged,
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
              value: 'Approved',
              child: Text(
                'Approved',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem<String>(
              value: 'Disapproved',
              child: Text(
                'Disapproved',
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
          ],
        ),
      ),
    );
  }
}
