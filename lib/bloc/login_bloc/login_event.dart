part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEvents extends LoginEvent{
  String memberId;
  String password;

  LoginEvents({required this.memberId,required this.password});

  @override
  List<Object> get props => [memberId,password];
}
