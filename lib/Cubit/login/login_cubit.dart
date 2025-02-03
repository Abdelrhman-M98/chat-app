// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errMessage: "Login failed. Please try again."));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        emit(LoginFailure(errMessage: 'No user found for that email.'));
      } else if (e.code == "wrong-password") {
        emit(
            LoginFailure(errMessage: "Wrong password provided for that user."));
      } else if (e.code == "too-many-requests") {
        emit(LoginFailure(
            errMessage: "Too many failed attempts. Try again later."));
      } else if (e.code == "network-request-failed") {
        emit(LoginFailure(
            errMessage: "Network error. Please check your connection."));
      } else {
        emit(LoginFailure(errMessage: "Authentication failed: ${e.message}"));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: "Something went wrong: ${e.toString()}"));
    }
  }
}
