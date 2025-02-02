// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously, avoid_print, unused_local_variable, must_be_immutable

import 'package:chat_app/Cubit/register/register_cubit.dart';
import 'package:chat_app/Screens/chat_page.dart';
import 'package:chat_app/Widget/custom_btn.dart';
import 'package:chat_app/Widget/custom_text_form_field.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  static String id = "RegisterPage";
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChatPage.id);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scholar Chat",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          "SignUp",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      onChange: (data) {
                        email = data;
                      },
                      hintText: "Email",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      onChange: (data) {
                        password = data;
                      },
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomBtn(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .registerUser(email: email!, password: password!);
                        }
                      },
                      btnText: "Register",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account..",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            " Login",
                            style: TextStyle(
                              color: Color(0xffc7ede6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 3,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
