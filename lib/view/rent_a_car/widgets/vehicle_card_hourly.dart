import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../view_model/hourly_card_view_model.dart';

class VehicleCard extends StatelessWidget {
  final String vehicleName;
  final int price;
  final int maxHours;
  final int? selectedHours;
  final bool isFullDay;
  final bool isHalfDay;
  final Function(int) onBookNow;
  final bool showButton;
  final bool showPriceButton;

  VehicleCard({
    required this.vehicleName,
    required this.price,
    this.maxHours = 10,
    this.isFullDay = false,
    this.isHalfDay = false,
    required this.onBookNow,
    this.showButton = true,
    this.selectedHours, required this.showPriceButton,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VehicleCardViewModel>(context);

    // Use selectedHours if provided, otherwise fallback to viewModel.hours
    final hours = selectedHours ?? viewModel.hours;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/hourly_booking_car.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.white, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'With Driver',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isFullDay && !isHalfDay && showPriceButton)
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.white),
                          onPressed: viewModel.hours > 0 ? viewModel.decrementHours : null,
                        ),
                        Text(
                          '${hours} Hour${hours > 1 ? 's' : ''}',
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Color(0xFFFFBC07)),
                          onPressed: viewModel.hours < maxHours ? viewModel.incrementHours : null,
                        ),
                      ],
                    ),
                  if (isFullDay)
                    Text(
                      '10 Hours',
                      style: TextStyle(color: Colors.white),
                    ),
                  if (isHalfDay)
                    Text(
                      '5 Hours',
                      style: TextStyle(color: Colors.white),
                    ),
                  Text(
                    'AED $price',
                    style: TextStyle(
                      color: Color(0xFFFFBC07),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  if (!isFullDay && !isHalfDay && showPriceButton)
                    Text(
                      'Max ${viewModel.maxHours} Hours',
                      style: TextStyle(color: Colors.white),
                    ),
                ],
              ),
            ],
          ),
          if (showButton)
            SizedBox(height: 20),
          if (showButton)
            Center(
              child: SizedBox(
                width: 0.4.sw,
                child: ElevatedButton(
                  onPressed: () {
                    onBookNow(price);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFBC07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
