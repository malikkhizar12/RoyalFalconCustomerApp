import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/driver_bookings_view_model.dart';
import 'time_button.dart';
import 'day_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DayTimeSelector extends StatefulWidget {
  @override
  _DayTimeSelectorState createState() => _DayTimeSelectorState();
}

class _DayTimeSelectorState extends State<DayTimeSelector> {
  List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  int selectedDayIndex = (DateTime.now().weekday - 1) % 7;
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 23, minute: 59);
  DateTime selectedDate = DateTime.now();
  bool filtersApplied = false;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFFBC07),
              onPrimary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
        filtersApplied = true;
        _notifyFilterChange();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFFBC07),
              onPrimary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedDayIndex = picked.weekday - 1;
        filtersApplied = true;
        _notifyFilterChange();
      });
    }
  }

  void _notifyFilterChange() {
    final startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startTime.hour,
      startTime.minute,
    );
    final endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endTime.hour,
      endTime.minute,
    );
    print('Filtering by date and time from $startDateTime to $endDateTime'); // Debug statement
    Provider.of<DriverBookingViewModel>(context, listen: false)
        .filterBookingsByDateTime(startDateTime, endDateTime, selectedDate != DateTime.now());
  }

  void _clearFilter() {
    setState(() {
      selectedDate = DateTime.now();
      selectedDayIndex = (DateTime.now().weekday - 1) % 7;
      startTime = TimeOfDay(hour: 0, minute: 0);
      endTime = TimeOfDay(hour: 23, minute: 59);
      filtersApplied = false;
    });
    Provider.of<DriverBookingViewModel>(context, listen: false).clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Day and Time',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              if (filtersApplied)
                GestureDetector(
                  onTap: _clearFilter,
                  child: Text(
                    'Clear Filter',
                    style: TextStyle(
                      color: Color(0xFFFFBC07),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDayIndex = index;
                    selectedDate = DateTime.now().add(Duration(days: (index - selectedDate.weekday + 1) % 7));
                  });
                },
                child: DayButton(
                  day: days[index],
                  isSelected: selectedDayIndex == index,
                ),
              );
            }),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _selectTime(context, true),
                child: TimeButton(
                  time: startTime.format(context),
                  isSelected: true,
                ),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Text(
                    DateFormat.yMd().format(selectedDate),
                    style: TextStyle(color: Color(0xFFFFBC07), fontSize: 16.sp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectTime(context, false),
                child: TimeButton(
                  time: endTime.format(context),
                  isSelected: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
