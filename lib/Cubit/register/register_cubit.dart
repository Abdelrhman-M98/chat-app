// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        emit(RegisterFailure(errMessage: 'The password provided is too weak.'));
      } else if (e.code == "email-already-in-use") {
        emit(RegisterFailure(
            errMessage: "The account already exists for that email."));
      }
      if (e.code == 'user-not-found') {
        emit(RegisterFailure(errMessage: "No user found for that email."));
      } else if (e.code == 'wrong-password') {
        RegisterFailure(errMessage: "Wrong password provided for that user.");
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: "Some Thing Went Wrong"));
    }
  }
}
