
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
  @HiveField(8)
  final Driver? driver; // New field

  Bookings({
    required this.id,
    required this.bookingSource,
    required this.addedBy,
    required this.userId,
    required this.guests,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.driver, // New field
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
      driver: json['driverId'] != null ? Driver.fromJson(json['driverId']) : null, // Handle null case
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
      'driverId': driver?.toJson(), // New field
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

@HiveType(typeId: 4)
class Driver extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
  final String role;
  @HiveField(5)
  final DriverDetails driverDetails;

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.driverDetails,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      driverDetails: DriverDetails.fromJson(json['driverDetails'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'driverDetails': driverDetails.toJson(),
    };
  }
}

@HiveType(typeId: 5)
class DriverDetails extends HiveObject {
  @HiveField(0)
  final String licenseNumber;
  @HiveField(1)
  final DateTime licenseExpiryDate;
  @HiveField(2)
  final String passportNumber;
  @HiveField(3)
  final String transaCardPicture;
  @HiveField(4)
  final String emiratesIdFront;
  @HiveField(5)
  final String emiratesIdBack;
  @HiveField(6)
  final String drivingLicensePic;
  @HiveField(7)
  final String passportPic;
  @HiveField(8)
  final Vehicle attachVehicle;

  DriverDetails({
    required this.licenseNumber,
    required this.licenseExpiryDate,
    required this.passportNumber,
    required this.transaCardPicture,
    required this.emiratesIdFront,
    required this.emiratesIdBack,
    required this.drivingLicensePic,
    required this.passportPic,
    required this.attachVehicle,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) {
    return DriverDetails(
      licenseNumber: json['licenseNumber'] ?? '',
      licenseExpiryDate: DateTime.parse(json['licenseExpiryDate'] ?? DateTime.now().toIso8601String()),
      passportNumber: json['passportNumber'] ?? '',
      transaCardPicture: json['transaCardPicture'] ?? '',
      emiratesIdFront: json['emiratesIdFront'] ?? '',
      emiratesIdBack: json['emiratesIdBack'] ?? '',
      drivingLicensePic: json['drivingLicensePic'] ?? '',
      passportPic: json['passportPic'] ?? '',
      attachVehicle: Vehicle.fromJson(json['attachVehicle'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'licenseNumber': licenseNumber,
      'licenseExpiryDate': licenseExpiryDate.toIso8601String(),
      'passportNumber': passportNumber,
      'transaCardPicture': transaCardPicture,
      'emiratesIdFront': emiratesIdFront,
      'emiratesIdBack': emiratesIdBack,
      'drivingLicensePic': drivingLicensePic,
      'passportPic': passportPic,
      'attachVehicle': attachVehicle.toJson(),
    };
  }
}

@HiveType(typeId: 6)
class Vehicle extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final VehicleCategory vehicleCategory;
  @HiveField(2)
  final String plateNo;
  @HiveField(3)
  final String chasisNo;
  @HiveField(4)
  final DateTime regStartDate;
  @HiveField(5)
  final DateTime regEndDate;
  @HiveField(6)
  final String insuranceCompany;
  @HiveField(7)
  final String color;
  @HiveField(8)
  final List<String> registryImages;
  @HiveField(9)
  final List<String> vehicleImages;
  @HiveField(10)
  final String driver;

  Vehicle({
    required this.id,
    required this.vehicleCategory,
    required this.plateNo,
    required this.chasisNo,
    required this.regStartDate,
    required this.regEndDate,
    required this.insuranceCompany,
    required this.color,
    required this.registryImages,
    required this.vehicleImages,
    required this.driver,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'] ?? '',
      vehicleCategory: VehicleCategory.fromJson(json['vehicleCategory'] ?? {}),
      plateNo: json['plateNo'] ?? '',
      chasisNo: json['chasisNo'] ?? '',
      regStartDate: DateTime.parse(json['regStartDate'] ?? DateTime.now().toIso8601String()),
      regEndDate: DateTime.parse(json['regEndDate'] ?? DateTime.now().toIso8601String()),
      insuranceCompany: json['insuranceCompany'] ?? '',
      color: json['color'] ?? '',
      registryImages: json['registryImages'] != null ? List<String>.from(json['registryImages']) : [],
      vehicleImages: json['vehicleImages'] != null ? List<String>.from(json['vehicleImages']) : [],
      driver: json['driver'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'vehicleCategory': vehicleCategory.toJson(),
      'plateNo': plateNo,
      'chasisNo': chasisNo,
      'regStartDate': regStartDate.toIso8601String(),
      'regEndDate': regEndDate.toIso8601String(),
      'insuranceCompany': insuranceCompany,
      'color': color,
      'registryImages': registryImages,
      'vehicleImages': vehicleImages,
      'driver': driver,
    };
  }
}
