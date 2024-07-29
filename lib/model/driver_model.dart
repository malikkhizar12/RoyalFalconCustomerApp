class Driver {
  String? profileImage;
  String? name;
  String? email;
  String? licenseNumber;
  String? licenseExpiryDate;
  String? passportNumber;
  String? transaCardPicture;
  String? emiratesIdFront;
  String? emiratesIdBack;
  String? drivingLicensePic;
  String? passportPic;
  String? attachVehicle;

  Driver({
    this.profileImage,
    this.name,
    this.email,
    this.licenseNumber,
    this.licenseExpiryDate,
    this.passportNumber,
    this.transaCardPicture,
    this.emiratesIdFront,
    this.emiratesIdBack,
    this.drivingLicensePic,
    this.passportPic,
    this.attachVehicle,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      profileImage: json['profileImage'],
      name: json['name'],
      email: json['email'],
      licenseNumber: json['licenseNumber'],
      licenseExpiryDate: json['licenseExpiryDate'],
      passportNumber: json['passportNumber'],
      transaCardPicture: json['transaCardPicture'],
      emiratesIdFront: json['emiratesIdFront'],
      emiratesIdBack: json['emiratesIdBack'],
      drivingLicensePic: json['drivingLicensePic'],
      passportPic: json['passportPic'],
      attachVehicle: json['attachVehicle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profileImage': profileImage,
      'name': name,
      'email': email,
      'licenseNumber': licenseNumber,
      'licenseExpiryDate': licenseExpiryDate,
      'passportNumber': passportNumber,
      'transaCardPicture': transaCardPicture,
      'emiratesIdFront': emiratesIdFront,
      'emiratesIdBack': emiratesIdBack,
      'drivingLicensePic': drivingLicensePic,
      'passportPic': passportPic,
      'attachVehicle': attachVehicle,
    };
  }
}
