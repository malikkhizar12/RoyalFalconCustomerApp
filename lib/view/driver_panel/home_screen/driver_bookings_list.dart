import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/driver_bookings_view_model.dart';
import '../../widgets/custom_end_drawer.dart';
import '../driver_widgets/bookings_list.dart';
import '../driver_widgets/day_time_selector.dart';
import '../driver_widgets/driver_appbar.dart';

class DriverBookingPage extends StatelessWidget {
  final String driverId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DriverBookingPage({required this.driverId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DriverBookingViewModel(driverId),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomEndDrawer(),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              AppBarCustom(title: 'Your Bookings', scaffoldKey: _scaffoldKey),
              DayTimeSelector(),
              Expanded(
                child: Consumer<DriverBookingViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.driverBookings == null) {
                      return Center(child: CircularProgressIndicator());
                    } else if (viewModel.driverBookings!.isEmpty) {
                      return Center(child: Text('No bookings found'));
                    } else {
                      return BookingsList(bookings: viewModel.driverBookings!);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
