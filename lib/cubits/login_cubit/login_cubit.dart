import 'package:khaled/helper/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'login_state.dart';

// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  CacheData cacheData = CacheData();

  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      var auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      cacheData.setEmail(email: email);
      // cacheData.setPassword(password: password);
      emit(LoginSucsessState(email: email));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailureState(errMessage: 'User not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailureState(errMessage: 'Wrong password'));
      }
    } catch (ex) {
      emit(LoginFailureState(errMessage: 'something went wrong'));
    }
  }
}
