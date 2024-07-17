part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginSucsessState extends LoginState {
  LoginSucsessState({required this.email});
  final String email;
}

final class LoginLoadingState extends LoginState {}

final class LoginFailureState extends LoginState {
  LoginFailureState({required this.errMessage});
  final String errMessage;
}
