import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_app/dao/sing_up_dao.dart';

part 'sing_up_event.dart';
part 'sing_up_state.dart';

class SingUpBloc extends Bloc<SingUpEvent, SingUpState> {
  late SingUpDao singUpDao;
  SingUpBloc() : super(SingUpInitial()) {
    singUpDao =SingUpDao();
    on<SingUpEvents>((event, emit) async {
      await mapLoginWithPhoneNumber(event, emit);
    });
    on<UploadImageEvent>((event, emit) async{
      await mapUploadImageEvent(event, emit);
    });
  }
  Future<void> mapLoginWithPhoneNumber(
      SingUpEvents event, Emitter<SingUpState> emit) async {
    try{
      emit(const SingUpLoading());
      var response = await singUpDao.singUp(
          salutiation: event.salutiation,
          firstName: event.firstName,
          lastName: event.lastName,
          mobile: event.mobile,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
          profilePic: event.profilePic
      );
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);


      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        String salutation = jsonDecoded["data"]["salutiation"];
        String firstName = jsonDecoded["data"]["first_name"];
        String lastName = jsonDecoded["data"]["last_name"];
        String membershipId = jsonDecoded["data"]["member_id"];
        emit(SingUpSuccess(salutation: salutation,firstName: firstName,lastName: lastName,membershipId: membershipId ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        emit(SingUpFailed(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        emit(SingUpFailed(message: message));
      }

    }catch(error){
      emit(SingUpFailed(message: "Something went wrong"));
    }
  }

  Future<void> mapUploadImageEvent(
      UploadImageEvent event, Emitter<SingUpState> emit) async {
    try{
      emit(const SingUpLoading());
      var response = await singUpDao.uploadImage(imagePath: event.imagePath);
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        String filePath = jsonDecoded["data"];

        emit(UploadImageSuccess(filePath: filePath));
        event.onSuccess();

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        log(message);
        emit(const UploadImageFailed());
        event.onError();
      }
      else{
        emit(const UploadImageFailed());
        event.onError();
      }
    }catch(error){
      emit(const UploadImageFailed());
      event.onError();
    }
  }
}
