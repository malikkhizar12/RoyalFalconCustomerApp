import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/vehicle_card_hourly.dart';
import '../../../view_model/hourly_card_view_model.dart';

class ConfirmBookingFullDayBottomSheet {
  final List<Map<String, dynamic>> vehicles;

  ConfirmBookingFullDayBottomSheet({required this.vehicles});

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Make the background transparent
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8, // Set the initial size to 80% of the screen height
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add the line at the top
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: vehicles.map((vehicle) {
                            return ChangeNotifierProvider(
                              create: (_) => VehicleCardViewModel(initialPrice: vehicle['price'], defaultHours: 10,bookingType: BookingType.fullDay),
                              child: Consumer<VehicleCardViewModel>(
                                builder: (context, viewModel, child) {
                                  return Column(
                                    children: [
                                      VehicleCard(
                                        showPriceButton: false,
                                        selectedHours: viewModel.hours,
                                        isFullDay: true,
                                        onBookNow: (price) {},
                                        price: viewModel.price,
                                        vehicleName: vehicle['name'], // Use the dynamic price
                                      ),
                                      SizedBox(height: 10), // Add spacing between vehicle cards
                                    ],
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
