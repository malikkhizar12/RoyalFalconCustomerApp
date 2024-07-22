import 'package:hive/hive.dart';

part 'driver_booking_model.g.dart';

@HiveType(typeId: 7)
class DriverBookingData {
  @HiveField(0)
  String? message;
  @HiveField(1)
  List<MyDriverBooking>? driverBookings;
  @HiveField(2)
  Pagination? pagination;

  DriverBookingData({this.message, this.driverBookings, this.pagination});

  factory DriverBookingData.fromJson(Map<String, dynamic> json) {
    return DriverBookingData(
      message: json['message'],
      driverBookings: (json['bookings'] as List?)?.map((item) {
        print("Parsing booking: $item"); // Debug statement
        return MyDriverBooking.fromJson(item);
      }).toList(),
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }
}

@HiveType(typeId: 8)
class MyDriverBooking {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? bookingSource;
  @HiveField(2)
  String? addedBy;
  @HiveField(3)
  String? userId;
  @HiveField(4)
  List<DriverGuest>? guests;
  @HiveField(5)
  String? status;
  @HiveField(6)
  String? createdAt;
  @HiveField(7)
  String? updatedAt;
  @HiveField(8)
  String? driverId;

  MyDriverBooking({
    this.id,
    this.bookingSource,
    this.addedBy,
    this.userId,
    this.guests,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.driverId,
  });

  factory MyDriverBooking.fromJson(Map<String, dynamic> json) {
    return MyDriverBooking(
      id: json['_id'],
      bookingSource: json['bookingSource'],
      addedBy: json['addedBy'],
      userId: json['userId'],
      guests: (json['guests'] as List?)?.map((item) {
        print("Parsing guest: $item"); // Debug statement
        return DriverGuest.fromJson(item);
      }).toList(),
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      driverId: json['driverId'],
    );
  }
}

@HiveType(typeId: 9)
class DriverGuest {
  @HiveField(0)
  Location? from;
  @HiveField(1)
  Location? to;
  @HiveField(2)
  String? bookingType;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? contactNumber;
  @HiveField(5)
  String? email;
  @HiveField(6)
  String? pickUpDateTime;
  @HiveField(7)
  String? fromLocationName;
  @HiveField(8)
  String? toLocationName;
  @HiveField(9)
  int? noOfpeople; // Changed to match JSON key
  @HiveField(10)
  int? noOfBaggage;
  @HiveField(11)
  int? bookingAmount;
  @HiveField(12)
  String? specialRequest;
  @HiveField(13)
  String? vehicleCategoryId;
  @HiveField(14)
  String? amountStatus;
  @HiveField(15)
  String? id;

  DriverGuest({
    this.from,
    this.to,
    this.bookingType,
    this.name,
    this.contactNumber,
    this.email,
    this.pickUpDateTime,
    this.fromLocationName,
    this.toLocationName,
    this.noOfpeople, // Changed to match JSON key
    this.noOfBaggage,
    this.bookingAmount,
    this.specialRequest,
    this.vehicleCategoryId,
    this.amountStatus,
    this.id,
  });

  factory DriverGuest.fromJson(Map<String, dynamic> json) {
    return DriverGuest(
      from: json['from'] != null ? Location.fromJson(json['from']) : null,
      to: json['to'] != null ? Location.fromJson(json['to']) : null,
      bookingType: json['bookingType'],
      name: json['name'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      pickUpDateTime: json['pickUpDateTime'],
      fromLocationName: json['fromLocationName'],
      toLocationName: json['toLocationName'],
      noOfpeople: json['noOfpeople'], // Changed to match JSON key
      noOfBaggage: json['noOfBaggage'],
      bookingAmount: json['bookingAmount'],
      specialRequest: json['specialRequest'],
      vehicleCategoryId: json['vehicleCategoryId'],
      amountStatus: json['amountStatus'],
      id: json['_id'],
    );
  }
}

@HiveType(typeId: 10)
class Location {
  @HiveField(0)
  String? type;
  @HiveField(1)
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: (json['coordinates'] as List<dynamic>).map((e) => e as double).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

@HiveType(typeId: 11)
class Pagination {
  @HiveField(0)
  int? totalRecords;
  @HiveField(1)
  int? currentPage;
  @HiveField(2)
  int? totalPages;
  @HiveField(3)
  int? limit;

  Pagination({this.totalRecords, this.currentPage, this.totalPages, this.limit});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalRecords: json['totalRecords'],
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      limit: json['limit'],
    );
  }
}
