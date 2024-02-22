import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_app/components/config.dart';
import 'package:user_app/dao/profile_dao.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late ProfileDao profileDao;
  ProfileBloc() : super(ProfileInitial()) {
    profileDao = ProfileDao();
    on<FetchProfileEvent>((event, emit) async{
      await mapFetchProfileEvent(event, emit);
    });
  }

  Future<void> mapFetchProfileEvent(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    try{
      emit(const ProfileLoading());

      var response = await profileDao.fetchProfile();

      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        String firstName = jsonDecoded["data"]["first_name"];
        String lastName = jsonDecoded["data"]["last_name"];
        String profileImage = jsonDecoded["data"]["profile_pic"] ?? "";

        Config.firstName = firstName;
        Config.lastName = lastName;
        Config.profilePic = profileImage;

        emit(FetchProfileSuccess(firstName: firstName,lastName: lastName));
      } else{
        String message = jsonDecoded["message"];
        emit(FetchProfileFailed(message: message));
      }

    }catch(error){
      emit(FetchProfileFailed(message: "Something Went wrong"));
    }
  }

}
