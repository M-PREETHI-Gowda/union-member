part of 'sing_up_bloc.dart';

@immutable
abstract class SingUpEvent extends Equatable{
  const SingUpEvent();

  @override
  List<Object> get props => [];
}

class SingUpEvents extends SingUpEvent{
  String salutiation;
  String firstName;
  String lastName;
  String mobile;
  String email;
  String password;
  String confirmPassword;
  String? profilePic;

  SingUpEvents({
    required this.salutiation,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.profilePic});

  @override
  List<Object> get props => [salutiation,firstName,lastName,mobile,email,password,confirmPassword,profilePic!];
}

class UploadImageEvent extends SingUpEvent{
  final File imagePath;
  VoidCallback onSuccess;
  VoidCallback onError;

  UploadImageEvent({required this.imagePath,required this.onSuccess,required this.onError});

  @override
  List<Object> get props => [imagePath,onSuccess,onError];
}