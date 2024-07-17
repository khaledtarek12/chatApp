part of 'select_image_cubit.dart';

@immutable
sealed class SelectImageState {}

final class SelectImageInitialState extends SelectImageState {}
final class SelectImageUploadSucsess extends SelectImageState {}
final class SelectImageUploadFailure extends SelectImageState {
  SelectImageUploadFailure({required this.errMessage});
  final String errMessage;
}
