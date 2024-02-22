part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable{
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
  @override
  List<Object> get props => [];
}

class FetchProfileFailed extends ProfileState {
  String message;

  FetchProfileFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class FetchProfileSuccess extends ProfileState {
  String firstName;
  String lastName;

  FetchProfileSuccess({required this.firstName,required this.lastName});
  @override
  List<Object> get props => [firstName,lastName];
}
