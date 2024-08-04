import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../view_model/bus_booking_view_model.dart';
import '../../../view_model/hourly_card_view_model.dart';

class VehicleCardBus extends StatelessWidget {
  final Function(int) onBookNow;
  final bool showButton;

  VehicleCardBus({required this.onBookNow, this.showButton = true, required int price});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BusCardViewModel>(context);

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
              'assets/images/white_bus.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ), // Replace with your car image
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'King Long Bus',
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
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.white),
                        onPressed: viewModel.decrementHours,
                      ),
                      Text(
                        '${viewModel.hours} Hour',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Color(0xFFFFBC07)),
                        onPressed: viewModel.incrementHours,
                      ),
                    ],
                  ),
                  Text(
                    'AED ${viewModel.price}',  // Use the dynamic price
                    style: TextStyle(
                      color: Color(0xFFFFBC07),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    'Max ${viewModel.maxHours} Hours',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
          if (showButton) // Conditionally show the button
            SizedBox(height: 20),
          if (showButton)
            Center(
              child: SizedBox(
                width: 0.4.sw,
                child: ElevatedButton(
                  onPressed: () {
                    onBookNow(viewModel.price); // Pass the dynamic price
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFBC07), // Background color
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
