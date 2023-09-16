import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sign_up_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  User? userData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    return Padding(
      padding: devicePadding,
      child: Scaffold(
        body: Column(
          children: [
            const Text(
              "login screen",
              style: TextStyle(fontSize: 30, color: Color(0xFF388E3D)),
            ),
            Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.all(screenWidth / 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
                          return "Enter email id ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                        ),
                        // contentPadding: const EdgeInsets.all(00),
                        isDense: true,
                        labelText: "email",
                        hintText: "Enter email ",
                        contentPadding: const EdgeInsets.all(12),
                        hintStyle: const TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: screenHeight / 40,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (!RegExp(r"^[a-zA-Z0-9]{6}$").hasMatch(value!)) {
                          return "Enter Passcode";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                        ),
                        // contentPadding: const EdgeInsets.all(00),
                        isDense: true,
                        labelText: "passcode",
                        hintText: "Enter passcode ",
                        contentPadding: const EdgeInsets.all(12),
                        hintStyle: const TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: screenHeight / 40),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(Color(0xFF388E3D)),
                        fixedSize: MaterialStatePropertyAll(
                          Size(screenWidth / 0.1, screenHeight / 16),
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      onPressed: () {
                        loginCall();
                        if (formkey.currentState!.validate()) {
                          debugPrint("is valid");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const HomeView(),
                          //   ),
                          // );
                        } else {
                          debugPrint("is not valid");
                        }
                      },
                      child: const Text(
                        textAlign: TextAlign.center,
                        ("login"),
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpView(),
                            ),
                          );
                        },
                        child: const Text("account")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginCall() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then(
            (value) => (value) {
              debugPrint(value.user.toString());
              setState(() {});
            },
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.------------------------------------------------------------------->>>');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.------------------------------------------------------------------->>>');
      }
    } catch (e) {
      debugPrint("$e ------------------------------------------------------------------->>>");
    }
  }
}
