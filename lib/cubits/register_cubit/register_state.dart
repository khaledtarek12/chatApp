part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}
final class RegisterLoadingState extends RegisterState {}
final class RegisterSuccsessState extends RegisterState {}
final class RegisterNotSamePasswordState extends RegisterState {}
final class RegisterFailureState extends RegisterState {
  RegisterFailureState({required this.errMessage});
  final String errMessage;
}
