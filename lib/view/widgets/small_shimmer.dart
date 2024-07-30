import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SmallShimmerLoading extends StatelessWidget {
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

              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 100.0,
                color: Colors.grey[300],
              ),
              SizedBox(height: 16.0),
              // Smaller rectangles


            ],
          ),
        ),
      ),

    );
  }
}