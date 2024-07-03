import 'package:hive/hive.dart';

part 'my_bookings_model.g.dart';

@HiveType(typeId: 0)
class Bookings extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String bookingSource;
  @HiveField(2)
  final String addedBy;
  @HiveField(3)
  final String userId;
  @HiveField(4)
  final List<Guest> guests;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final DateTime createdAt;
  @HiveField(7)
  final DateTime updatedAt;

  Bookings({
    required this.id,
    required this.bookingSource,
    required this.addedBy,
    required this.userId,
    required this.guests,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) {
    return Bookings(
      id: json['_id'] ?? '',
      bookingSource: json['bookingSource'] ?? '',
      addedBy: json['addedBy'] ?? '',
      userId: json['userId'] ?? '',
      guests: (json['guests'] as List).map((i) => Guest.fromJson(i)).toList(),
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'bookingSource': bookingSource,
      'addedBy': addedBy,
      'userId': userId,
      'guests': guests.map((guest) => guest.toJson()).toList(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

@HiveType(typeId: 1)
class Guest extends HiveObject {
  @HiveField(0)
  final Coordinates from;
  @HiveField(1)
  final Coordinates to;
  @HiveField(2)
  final String bookingType;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String contactNumber;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final DateTime pickUpDateTime;
  @HiveField(7)
  final String fromLocationName;
  @HiveField(8)
  final String toLocationName;
  @HiveField(9)
  final int noOfPeople;
  @HiveField(10)
  final int noOfBaggage;
  @HiveField(11)
  final double bookingAmount;
  @HiveField(12)
  final String specialRequest;
  @HiveField(13)
  final VehicleCategory? vehicleCategoryId;
  @HiveField(14)
  final String amountStatus;
  @HiveField(15)
  final String id;
  @HiveField(16)
  final String? flightNo; // New field
  @HiveField(17)
  final String? flightTiming; // New field

  Guest({
    required this.from,
    required this.to,
    required this.bookingType,
    required this.name,
    required this.contactNumber,
    required this.email,
    required this.pickUpDateTime,
    required this.fromLocationName,
    required this.toLocationName,
    required this.noOfPeople,
    required this.noOfBaggage,
    required this.bookingAmount,
    required this.specialRequest,
    required this.vehicleCategoryId,
    required this.amountStatus,
    required this.id,
    this.flightNo, // New field
    this.flightTiming, // New field
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      from: Coordinates.fromJson(json['from'] ?? {}),
      to: Coordinates.fromJson(json['to'] ?? {}),
      bookingType: json['bookingType'] ?? '',
      name: json['name'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      email: json['email'] ?? '',
      pickUpDateTime: DateTime.parse(json['pickUpDateTime'] ?? DateTime.now().toIso8601String()),
      fromLocationName: json['fromLocationName'] ?? '',
      toLocationName: json['toLocationName'] ?? '',
      noOfPeople: json['noOfpeople'] ?? 0,
      noOfBaggage: json['noOfBaggage'] ?? 0,
      bookingAmount: (json['bookingAmount'] ?? 0).toDouble(),
      specialRequest: json['specialRequest'] ?? '',
      vehicleCategoryId: json['vehicleCategoryId'] != null ? VehicleCategory.fromJson(json['vehicleCategoryId']) : null,
      amountStatus: json['amountStatus'] ?? '',
      id: json['_id'] ?? '',
      flightNo: json['flightNo'], // New field
      flightTiming: json['flightTiming'], // New field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from.toJson(),
      'to': to.toJson(),
      'bookingType': bookingType,
      'name': name,
      'contactNumber': contactNumber,
      'email': email,
      'pickUpDateTime': pickUpDateTime.toIso8601String(),
      'fromLocationName': fromLocationName,
      'toLocationName': toLocationName,
      'noOfPeople': noOfPeople,
      'noOfBaggage': noOfBaggage,
      'bookingAmount': bookingAmount,
      'specialRequest': specialRequest,
      'vehicleCategoryId': vehicleCategoryId?.toJson(),
      'amountStatus': amountStatus,
      '_id': id,
      'flightNo': flightNo, // New field
      'flightTiming': flightTiming, // New field
    };
  }
}


@HiveType(typeId: 2)
class Coordinates extends HiveObject {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final List<double> coordinates;

  Coordinates({required this.type, required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'] ?? '',
      coordinates: json['coordinates'] != null ? List<double>.from(json['coordinates']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

@HiveType(typeId: 3)
class VehicleCategory extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int noOfVehicle;
  @HiveField(3)
  final int noOfPeople;
  @HiveField(4)
  final int noOfBaggage;
  @HiveField(5)
  final double minimumAmount;
  @HiveField(6)
  final String categoryVehicleImage;
  @HiveField(7)
  final String city;

  VehicleCategory({
    required this.id,
    required this.name,
    required this.noOfVehicle,
    required this.noOfPeople,
    required this.noOfBaggage,
    required this.minimumAmount,
    required this.categoryVehicleImage,
    required this.city,
  });

  factory VehicleCategory.fromJson(Map<String, dynamic> json) {
    return VehicleCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      noOfVehicle: json['noOfVehicle'] ?? 0,
      noOfPeople: json['noOfPeople'] ?? 0,
      noOfBaggage: json['noOfBaggage'] ?? 0,
      minimumAmount: (json['minimumAmount'] ?? 0).toDouble(),
      categoryVehicleImage: json['categoryVehicleImage'] ?? '',
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'noOfVehicle': noOfVehicle,
      'noOfPeople': noOfPeople,
      'noOfBaggage': noOfBaggage,
      'minimumAmount': minimumAmount,
      'categoryVehicleImage': categoryVehicleImage,
      'city': city,
    };
  }
}
