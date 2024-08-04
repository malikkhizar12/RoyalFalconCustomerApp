import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import 'package:royal_falcon/model/driver_model.dart';
import 'package:royal_falcon/model/user_model.dart';
import '../../../../utils/colors.dart';

class DriverProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Consumer<UserViewModel>(
          builder: (context, userViewModel, child) {
            return FutureBuilder<Driver?>(
              future: userViewModel.getDriverDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No driver details found'));
                } else {
                  Driver driver = snapshot.data!;
                  return FutureBuilder<UserModel?>(
                    future: userViewModel.getUser(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (userSnapshot.hasError) {
                        return Center(child: Text('Error: ${userSnapshot.error}'));
                      } else if (!userSnapshot.hasData || userSnapshot.data == null) {
                        return Center(child: Text('No user details found'));
                      } else {
                        UserModel user = userSnapshot.data!;
                        String? name = driver.name ?? user.user?.name;
                        String? email = driver.email ?? user.user?.email;
                        return ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            _buildProfileHeader(name, email, driver.profileImage),
                            SizedBox(height: 20.0.h),
                            _buildBookingStatsSection(),
                            SizedBox(height: 20.0.h),
                            _buildImageGrid(context, driver),
                          ],
                        );
                      }
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(String? name, String? email, String? profileImage) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF35383B),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: profileImage != null && profileImage.isNotEmpty
                ?  CachedNetworkImageProvider(profileImage)
                : null,
            child: profileImage == null || profileImage.isEmpty
                ? Icon(Icons.person, size: 50.0, color: Colors.white)
                : null,
          ),
          SizedBox(height: 16.h),
          Text(
            name ?? 'N/A',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            email ?? 'N/A',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
  Widget _buildBookingStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildBookingStat('Total Bookings', '132'),
        _buildBookingStat('Completed', '120'),
        _buildBookingStat('Pending', '12'),
      ],
    );
  }

  Widget _buildBookingStat(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildImageGrid(BuildContext context, Driver driver) {
    List<Map<String, String?>> images = [
      {'Transa Card Picture': driver.transaCardPicture},
      {'Emirates ID Front': driver.emiratesIdFront},
      {'Emirates ID Back': driver.emiratesIdBack},
      {'Driving License Pic': driver.drivingLicensePic},
      {'Passport Pic': driver.passportPic},
    ];

    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: images
          .map((image) => _buildImageNameCard(
        context,
        image.keys.first,
        image.values.first,
      ))
          .toList(),
    );
  }

  Widget _buildImageNameCard(BuildContext context, String title, String? imageUrl) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Column(
              children: [
                Expanded(
                  child: PhotoView(
                    imageProvider: CachedNetworkImageProvider(imageUrl ?? 'https://via.placeholder.com/150'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Container(
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [Colors.white12, Color(0xFFFFBC07)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }}
