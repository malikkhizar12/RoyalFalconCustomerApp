import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              SizedBox(height: 36.0),

              // First rectangle
              Container(
                width: double.infinity,
                height: 100.0,
                color: Colors.grey[300],
              ),
              SizedBox(height: 16.0),
              // Smaller rectangles
              Container(
                width: double.infinity,
                height: 200.0,
                color: Colors.grey[300],
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                height: 50.0,
                color: Colors.grey[300],
              ),
              SizedBox(height: 16.0),
              // Second rectangle
              Container(
                width: double.infinity,
                height: 200.0,
                color: Colors.grey[300],
              ),
              SizedBox(height: 16.0),
              // Smaller rectangle at the bottom
              Container(
                width: double.infinity,
                height: 100.0,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),

    );
  }
}