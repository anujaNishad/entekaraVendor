part of 'sign_up_bloc.dart';

class SignUpState {
  bool validate;
  String errorMessage;

  String selected = "Male";
  SignUpState({this.errorMessage = "", this.validate = false});
}

class SignUpInitial extends SignUpState {
  SignUpInitial() : super();
}

class ValidateFormState extends SignUpState {
  ValidateFormState() : super(validate: true);
}

class LoadDropDown extends SignUpState {
  LoadDropDown() : super();
}

class DropDownSuccess extends SignUpState {
  VendorTypeModel? dropDownData;

  DropDownSuccess(this.dropDownData) : super();
}

class Signup1Success extends SignUpState {
  String id;
  Signup1Success(this.id);
}

class Signup1Error extends SignUpState {
  String error;
  Signup1Error(this.error);
}

class AddDataSuccessfulState extends SignUpState {
  AddDataSuccessfulState();
}

class AddDataLoadingState extends SignUpState {
  AddDataLoadingState();
}

class AddDataErrorState extends SignUpState {
  String error;
  AddDataErrorState(this.error);
}
