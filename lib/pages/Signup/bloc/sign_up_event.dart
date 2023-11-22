part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class ValidteFormEvent extends SignUpEvent {
  const ValidteFormEvent();
}

class FetchTypeEvent extends SignUpEvent {
  final String currentValue;
  final String type;

  const FetchTypeEvent(this.currentValue, this.type);
}

class SignUp1Event extends SignUpEvent {
  final File? cropped;
  final int userId;
  final String vendorName;
  final String ownerName;
  final int vendorId;
  final int contact;
  final String address;
  final String gstNumber;
  final int pincode;
  final String state;
  final String district;
  final String locality;
  final double lattitude;
  final double longitude;
  final String registerDate;
  final File? image;

  const SignUp1Event(
      this.cropped,
      this.userId,
      this.vendorName,
      this.ownerName,
      this.vendorId,
      this.contact,
      this.address,
      this.gstNumber,
      this.pincode,
      this.state,
      this.district,
      this.locality,
      this.lattitude,
      this.longitude,
      this.registerDate,
      this.image);
}

class SignUp2Event extends SignUpEvent {
  final int userId;
  final String vendorName;
  final String ownerName;
  final int vendorId;
  final int contact;
  final String address;
  final String gstNumber;
  final int pincode;
  final String state;
  final String district;
  final String locality;
  final double lattitude;
  final double longitude;
  final String registerDate;

  const SignUp2Event(
    this.userId,
    this.vendorName,
    this.ownerName,
    this.vendorId,
    this.contact,
    this.address,
    this.gstNumber,
    this.pincode,
    this.state,
    this.district,
    this.locality,
    this.lattitude,
    this.longitude,
    this.registerDate,
  );
}
