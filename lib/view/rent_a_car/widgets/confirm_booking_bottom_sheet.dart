import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/vehicle_card_without_button.dart';
import '../../../utils/colors.dart';
import '../../../view_model/hourly_card_view_model.dart';

class ConfirmBookingBottomSheet {
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (_) => VehicleCardViewModel(),
          child: Consumer<VehicleCardViewModel>(
            builder: (context, viewModel, child) {
              return Container(
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VehicleCardWithoutButton(),
                      Divider(color: Colors.grey),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Date',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: viewModel.selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                viewModel.setDate(pickedDate);
                              }
                            },
                            child: Icon(Icons.calendar_today, color: Color(0xFFFFBC07)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${viewModel.selectedDate.toLocal()}'.split(' ')[0],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Time',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: viewModel.selectedTime,
                              );
                              if (pickedTime != null) {
                                viewModel.setTime(pickedTime);
                              }
                            },
                            child: Icon(Icons.watch_later, color: Color(0xFFFFBC07)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTimeChip(context, '01:00 AM', viewModel, TimeOfDay(hour: 1, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '03:00 AM', viewModel, TimeOfDay(hour: 3, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '05:00 AM', viewModel, TimeOfDay(hour: 5, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '07:00 AM', viewModel, TimeOfDay(hour: 7, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '09:00 AM', viewModel, TimeOfDay(hour: 9, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '11:00 AM', viewModel, TimeOfDay(hour: 11, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '01:00 PM', viewModel, TimeOfDay(hour: 13, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '03:00 PM', viewModel, TimeOfDay(hour: 15, minute: 0)),
                            SizedBox(width: 4.w),
                            _buildTimeChip(context, '05:00 PM', viewModel, TimeOfDay(hour: 17, minute: 0)),
                            // Add more time chips if needed
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Selected Time: ${viewModel.selectedTime.format(context)}',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFBC07),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Your confirmation action here
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white, fontSize: 18.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTimeChip(BuildContext context, String label, VehicleCardViewModel viewModel, TimeOfDay time) {
    return GestureDetector(
      onTap: () {
        viewModel.setTime(time);
      },
      child: Chip(
        label: Text(label, style: TextStyle(color: Colors.black)),
        backgroundColor: viewModel.selectedTime == time ? Color(0xFFFFBC07) : Colors.grey[700],
      ),
    );
  }
}
