// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_bookings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingsAdapter extends TypeAdapter<Bookings> {
  @override
  final int typeId = 0;

  @override
  Bookings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookings(
      id: fields[0] as String,
      bookingSource: fields[1] as String,
      addedBy: fields[2] as String,
      userId: fields[3] as String,
      guests: (fields[4] as List).cast<Guest>(),
      status: fields[5] as String,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,

      driver: fields[8] as Driver?,

    );
  }

  @override
  void write(BinaryWriter writer, Bookings obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bookingSource)
      ..writeByte(2)
      ..write(obj.addedBy)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.guests)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.driver);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GuestAdapter extends TypeAdapter<Guest> {
  @override
  final int typeId = 1;

  @override
  Guest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Guest(
      from: fields[0] as Coordinates,
      to: fields[1] as Coordinates,
      bookingType: fields[2] as String,
      name: fields[3] as String,
      contactNumber: fields[4] as String,
      email: fields[5] as String,
      pickUpDateTime: fields[6] as DateTime,
      fromLocationName: fields[7] as String,
      toLocationName: fields[8] as String,
      noOfPeople: fields[9] as int,
      noOfBaggage: fields[10] as int,
      bookingAmount: fields[11] as double,
      specialRequest: fields[12] as String,
      vehicleCategoryId: fields[13] as VehicleCategory?,
      amountStatus: fields[14] as String,
      id: fields[15] as String,
      flightNo: fields[16] as String?,
      flightTiming: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Guest obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.to)
      ..writeByte(2)
      ..write(obj.bookingType)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.contactNumber)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.pickUpDateTime)
      ..writeByte(7)
      ..write(obj.fromLocationName)
      ..writeByte(8)
      ..write(obj.toLocationName)
      ..writeByte(9)
      ..write(obj.noOfPeople)
      ..writeByte(10)
      ..write(obj.noOfBaggage)
      ..writeByte(11)
      ..write(obj.bookingAmount)
      ..writeByte(12)
      ..write(obj.specialRequest)
      ..writeByte(13)
      ..write(obj.vehicleCategoryId)
      ..writeByte(14)
      ..write(obj.amountStatus)
      ..writeByte(15)
      ..write(obj.id)
      ..writeByte(16)
      ..write(obj.flightNo)
      ..writeByte(17)
      ..write(obj.flightTiming);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordinatesAdapter extends TypeAdapter<Coordinates> {
  @override
  final int typeId = 2;

  @override
  Coordinates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coordinates(
      type: fields[0] as String,
      coordinates: (fields[1] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, Coordinates obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VehicleCategoryAdapter extends TypeAdapter<VehicleCategory> {
  @override
  final int typeId = 3;

  @override
  VehicleCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleCategory(
      id: fields[0] as String,
      name: fields[1] as String,
      noOfVehicle: fields[2] as int,
      noOfPeople: fields[3] as int,
      noOfBaggage: fields[4] as int,
      minimumAmount: fields[5] as double,
      categoryVehicleImage: fields[6] as String,
      city: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleCategory obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.noOfVehicle)
      ..writeByte(3)
      ..write(obj.noOfPeople)
      ..writeByte(4)
      ..write(obj.noOfBaggage)
      ..writeByte(5)
      ..write(obj.minimumAmount)
      ..writeByte(6)
      ..write(obj.categoryVehicleImage)
      ..writeByte(7)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DriverAdapter extends TypeAdapter<Driver> {
  @override
  final int typeId = 4;

  @override
  Driver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Driver(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      phoneNumber: fields[3] as String,
      role: fields[4] as String,
      driverDetails: fields[5] as DriverDetails,
    );
  }

  @override
  void write(BinaryWriter writer, Driver obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.driverDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DriverDetailsAdapter extends TypeAdapter<DriverDetails> {
  @override
  final int typeId = 5;

  @override
  DriverDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DriverDetails(
      licenseNumber: fields[0] as String,
      licenseExpiryDate: fields[1] as DateTime,
      passportNumber: fields[2] as String,
      transaCardPicture: fields[3] as String,
      emiratesIdFront: fields[4] as String,
      emiratesIdBack: fields[5] as String,
      drivingLicensePic: fields[6] as String,
      passportPic: fields[7] as String,
      attachVehicle: fields[8] as Vehicle,
    );
  }

  @override
  void write(BinaryWriter writer, DriverDetails obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.licenseNumber)
      ..writeByte(1)
      ..write(obj.licenseExpiryDate)
      ..writeByte(2)
      ..write(obj.passportNumber)
      ..writeByte(3)
      ..write(obj.transaCardPicture)
      ..writeByte(4)
      ..write(obj.emiratesIdFront)
      ..writeByte(5)
      ..write(obj.emiratesIdBack)
      ..writeByte(6)
      ..write(obj.drivingLicensePic)
      ..writeByte(7)
      ..write(obj.passportPic)
      ..writeByte(8)
      ..write(obj.attachVehicle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VehicleAdapter extends TypeAdapter<Vehicle> {
  @override
  final int typeId = 6;

  @override
  Vehicle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle(
      id: fields[0] as String,
      vehicleCategory: fields[1] as VehicleCategory,
      plateNo: fields[2] as String,
      chasisNo: fields[3] as String,
      regStartDate: fields[4] as DateTime,
      regEndDate: fields[5] as DateTime,
      insuranceCompany: fields[6] as String,
      color: fields[7] as String,
      registryImages: (fields[8] as List).cast<String>(),
      vehicleImages: (fields[9] as List).cast<String>(),
      driver: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehicleCategory)
      ..writeByte(2)
      ..write(obj.plateNo)
      ..writeByte(3)
      ..write(obj.chasisNo)
      ..writeByte(4)
      ..write(obj.regStartDate)
      ..writeByte(5)
      ..write(obj.regEndDate)
      ..writeByte(6)
      ..write(obj.insuranceCompany)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.registryImages)
      ..writeByte(9)
      ..write(obj.vehicleImages)
      ..writeByte(10)
      ..write(obj.driver);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
