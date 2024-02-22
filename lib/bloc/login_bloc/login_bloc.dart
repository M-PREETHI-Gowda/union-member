import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/components/config.dart';
import 'package:user_app/dao/login_dao.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late LoginDao loginDao;
  LoginBloc() : super(LoginInitial()) {
    loginDao =LoginDao();
    on<LoginEvents>((event, emit) async{
      await mapLoginWithPhoneNumber(event, emit);
    });
  }

  Future<void> mapLoginWithPhoneNumber(
      LoginEvents event, Emitter<LoginState> emit) async {
    try{
      emit(const LoginLoading());
      var response = await loginDao.login(memberId: event.memberId, password: event.password);
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);


      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        String accessToken = (jsonDecoded["data"]["access_token"])== null ? "" :jsonDecoded["data"]["access_token"];
        Config.accessToken = accessToken;
        emit(LoginSuccess(accessToken: accessToken ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        emit(LoginFailed(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        emit(LoginFailed(message: message));
      }

    }catch(error){



      emit(LoginFailed(message: "Something went wrong"));
    }
  }
}
