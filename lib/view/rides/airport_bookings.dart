import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/rides/ride_card_abudhabi.dart';
import 'package:royal_falcon/view/rides/ride_card_dubai.dart';
import '../../utils/colors.dart';
import '../widgets/appbarcustom.dart';
import 'location_buttons.dart';
import 'rides_booking_form.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';

class AirportBookings extends StatefulWidget {
  @override
  _AirportBookingsState createState() => _AirportBookingsState();
}

class _AirportBookingsState extends State<AirportBookings> {
  String selectedLocation = 'Dubai';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleViewModel>(context, listen: false).fetchVehicleCategories(context);
    });
  }

  void navigateToBookingForm(BuildContext context, String price, String id) {
    double parsedPrice = double.parse(price); // Extract numeric value
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RidesBookingForm(price: parsedPrice, isFromAirportBooking: true, id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 16),
          const AppbarCustom(title: 'Choose your ride'),
          const SizedBox(height: 16),
          FractionallySizedBox(
            widthFactor: 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: LocationButton(
                    text: 'Dubai',
                    isSelected: selectedLocation == 'Dubai',
                    onTap: () {
                      setState(() {
                        selectedLocation = 'Dubai';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LocationButton(
                    text: 'Abu Dhabi',
                    isSelected: selectedLocation == 'Abu Dhabi',
                    onTap: () {
                      setState(() {
                        selectedLocation = 'Abu Dhabi';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<VehicleViewModel>(
              builder: (context, vehicleViewModel, child) {
                if (vehicleViewModel.loading) {
                  return Center(child: CircularProgressIndicator());
                }

                List<dynamic> selectedRidesList = selectedLocation == 'Dubai'
                    ? vehicleViewModel.dubaiVehicles
                    : vehicleViewModel.abuDhabiVehicles;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: selectedRidesList.length,
                  itemBuilder: (context, index) {
                    final package = selectedRidesList[index];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 400 + (index * 250)),
                      curve: Curves.decelerate,
                      transform: Matrix4.translationValues(
                        vehicleViewModel.loading ? 400 : 0,
                        0,
                        0,
                      ),
                      child: selectedLocation == 'Dubai'
                          ? RideCardDubai(
                        package: package,
                        onTap: () => navigateToBookingForm(context, package['minimumAmount'].toString(), package['_id']),
                      )
                          : RideCardAbudhabi(
                        package: package,
                        onTap: () => navigateToBookingForm(context, package['minimumAmount'].toString(), package['_id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
