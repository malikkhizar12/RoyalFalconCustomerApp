// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_booking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverBookingDataAdapter extends TypeAdapter<DriverBookingData> {
  @override
  final int typeId = 7;

  @override
  DriverBookingData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DriverBookingData(
      message: fields[0] as String?,
      driverBookings: (fields[1] as List?)?.cast<MyDriverBooking>(),
      pagination: fields[2] as Pagination?,
    );
  }

  @override
  void write(BinaryWriter writer, DriverBookingData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.driverBookings)
      ..writeByte(2)
      ..write(obj.pagination);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverBookingDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MyDriverBookingAdapter extends TypeAdapter<MyDriverBooking> {
  @override
  final int typeId = 8;

  @override
  MyDriverBooking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyDriverBooking(
      id: fields[0] as String?,
      bookingSource: fields[1] as String?,
      addedBy: fields[2] as String?,
      userId: fields[3] as String?,
      guests: (fields[4] as List?)?.cast<DriverGuest>(),
      status: fields[5] as String?,
      createdAt: fields[6] as String?,
      updatedAt: fields[7] as String?,
      driverId: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyDriverBooking obj) {
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
      ..write(obj.driverId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyDriverBookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DriverGuestAdapter extends TypeAdapter<DriverGuest> {
  @override
  final int typeId = 9;

  @override
  DriverGuest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DriverGuest(
      from: fields[0] as Location?,
      to: fields[1] as Location?,
      bookingType: fields[2] as String?,
      name: fields[3] as String?,
      contactNumber: fields[4] as String?,
      email: fields[5] as String?,
      pickUpDateTime: fields[6] as String?,
      fromLocationName: fields[7] as String?,
      toLocationName: fields[8] as String?,
      noOfpeople: fields[9] as int?,
      noOfBaggage: fields[10] as int?,
      bookingAmount: fields[11] as int?,
      specialRequest: fields[12] as String?,
      vehicleCategoryId: fields[13] as String?,
      amountStatus: fields[14] as String?,
      id: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DriverGuest obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.noOfpeople)
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
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverGuestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 10;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      type: fields[0] as String?,
      coordinates: (fields[1] as List?)?.cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
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
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaginationAdapter extends TypeAdapter<Pagination> {
  @override
  final int typeId = 11;

  @override
  Pagination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pagination(
      totalRecords: fields[0] as int?,
      currentPage: fields[1] as int?,
      totalPages: fields[2] as int?,
      limit: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Pagination obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalRecords)
      ..writeByte(1)
      ..write(obj.currentPage)
      ..writeByte(2)
      ..write(obj.totalPages)
      ..writeByte(3)
      ..write(obj.limit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
