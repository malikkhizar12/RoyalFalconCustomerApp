import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../view_model/hourly_card_view_model.dart';

class VehicleCard extends StatelessWidget {
  final VoidCallback onBookNow;

  VehicleCard({required this.onBookNow});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VehicleCardViewModel>(context);

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
          ), // Replace with your car image
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SEDAN',
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
                    'AED ${viewModel.price}',
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
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 0.4.sw,
              child: ElevatedButton(
                onPressed: onBookNow,
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
