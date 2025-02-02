// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:chat_app/Cubit/login/login_cubit.dart';
import 'package:chat_app/Screens/chat_page.dart';
import 'package:chat_app/Screens/register_page.dart';
import 'package:chat_app/Widget/custom_btn.dart';
import 'package:chat_app/Widget/custom_text_form_field.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static String id = "LoginPage";

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email, password;

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        }

        if (state is LoginSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChatPage.id);
        }
        if (state is LoginFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.center,
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
                        "Login",
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
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .loginUser(email: email!, password: password!);
                      }
                    },
                    child: CustomBtn(
                      btnText: "LOGIN",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have an account!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          " Register",
                          style: TextStyle(
                            color: Color(0xffc7ede6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
