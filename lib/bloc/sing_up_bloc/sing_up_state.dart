part of 'sing_up_bloc.dart';

@immutable
abstract class SingUpState extends Equatable{
  const SingUpState();

  @override
  List<Object> get props => [];
}

class SingUpInitial extends SingUpState {}

class SingUpLoading extends SingUpState {
  const SingUpLoading();
  @override
  List<Object> get props => [];
}

class SingUpFailed extends SingUpState{
  String message;

  SingUpFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class SingUpSuccess extends SingUpState{
  String  salutation;
  String firstName;
  String lastName;
  String membershipId;

  SingUpSuccess({required this.salutation,required this.firstName,required this.lastName,required this.membershipId});

  @override
  List<Object> get props => [salutation,firstName,lastName,membershipId];
}

class UploadImageSuccess extends SingUpState {
  String filePath;
  UploadImageSuccess({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

class UploadImageFailed extends SingUpState {

  const UploadImageFailed();

  @override
  List<Object> get props => [];
}