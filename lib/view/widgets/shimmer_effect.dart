import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FullScreenShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFF333639),
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 20.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
          );
        }),
      ),
    );
  }
}
