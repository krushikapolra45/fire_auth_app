import 'package:fire_auth_app/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
        appBar: AppBar(
          title: const Text(
            "sign up screen",
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.all(screenWidth / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0.8,
                          color: Color(0x8EB3B3B3),
                        ),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,
                      hintText: " Name ",
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
                        borderSide: const BorderSide(
                          width: 0.8,
                          color: Color(0x8EB3B3B3),
                        ),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,

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
                        borderSide: const BorderSide(
                          width: 0.8,
                          color: Color(0x8EB3B3B3),
                        ),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,
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
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFF00AB6C),
                      ),
                      fixedSize: MaterialStatePropertyAll(
                        Size(screenWidth / 0.1, screenHeight / 16),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        signupCall();
                        //   debugPrint("is valid");
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const LoginView(),
                        //     ),
                        //   );
                        // } else {
                        //   debugPrint("is not valid");
                      }
                    },
                    child: const Text(
                      textAlign: TextAlign.center,
                      ("signup"),
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signupCall() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then(
            (value) => (value) {
              userData = value.user;
              userData!.emailVerified;
              debugPrint(value.user.toString());
              setState(() {});
            },
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.------------------------------------------------------------------->>>');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.------------------------------------------------------------------->>>');
      }
    } catch (e) {
      debugPrint("$e ------------------------------------------------------------------->>>");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
