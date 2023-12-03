import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:entekaravendor/model/document_type.dart';
import 'package:entekaravendor/model/signup_model.dart';
import 'package:entekaravendor/model/vendorType_model.dart';
import 'package:entekaravendor/pages/Signup/data/sign_up_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository _signUpRepository = SignUpRepository();
  final storage = GetStorage();
  SignUpBloc() : super(SignUpInitial()) {
    on<ValidteFormEvent>((event, emit) => emit(ValidateFormState()));

    on<FetchTypeEvent>((event, emit) async {
      try {
        emit(LoadDropDown());
        VendorTypeModel dropDownData =
            await _signUpRepository.getType(event.currentValue, event.type);

        emit(DropDownSuccess(dropDownData));
      } catch (e) {
        rethrow;
      }
    });

    on<SignUp1Event>((event, emit) async {
      try {
        SignupModel? signupModel = await _signUpRepository.vendorSignUp(
            event.cropped!,
            event.userId,
            event.vendorName,
            event.ownerName,
            event.vendorId,
            event.contact,
            event.address,
            event.gstNumber,
            event.pincode,
            event.state,
            event.district,
            event.locality,
            event.lattitude,
            event.longitude,
            event.registerDate,
            event.image!,
            event.email,
            event.documentType);
        emit(Signup1Success(signupModel));
      } catch (e) {
        emit(Signup1Error(e.toString()));
      }
    });
    on<SignUp2Event>((event, emit) async {
      try {
        SignupModel? signupModel = await _signUpRepository.signUp1(
            event.userId,
            event.vendorName,
            event.ownerName,
            event.vendorId,
            event.contact,
            event.address,
            event.gstNumber,
            event.pincode,
            event.state,
            event.district,
            event.locality,
            event.lattitude,
            event.longitude,
            event.registerDate,
            event.email,
            event.documentType);
        emit(Signup1Success(signupModel!));
      } catch (e) {
        emit(Signup1Error(e.toString()));
      }
    });

    on<FetchDocumentTypeEvent>((event, emit) async {
      try {
        emit(LoadDropDown());
        DocumentTypeModel documentTypeModel =
            await _signUpRepository.getDocumentType();

        emit(DocumentTypeSuccess(documentTypeModel));
      } catch (e) {
        rethrow;
      }
    });
  }
}
