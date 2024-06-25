import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FullScreenShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFF333639)!,
      direction: ShimmerDirection.ltr,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
