import 'package:flutter/material.dart';
import 'package:to_bee/views/home.dart';
import 'package:to_bee/views/sign_up.dart';
import 'package:to_bee/views/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    final String email = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackbar("All fields are required.");
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
          (Route<dynamic> route) => false,
        );
      } else {
        showSnackbar("Authentication failed. Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showSnackbar("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showSnackbar("The email address is not valid.");
      } else {
        showSnackbar("Error: ${e.message}");
      }
    } catch (e) {
      showSnackbar("Unexpected error: $e");
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFC397),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Welcome()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                SizedBox(width: 15),
                Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              height: 568,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xffFAFAFA),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 390,
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffE0E0E0), width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            hintText: "  username",
                            hintStyle: TextStyle(color: Color(0xff939393)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        width: 390,
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffE0E0E0), width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            hintText: "  password",
                            hintStyle: TextStyle(color: Color(0xff939393)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 295,
                      height: 57,
                      child: MaterialButton(
                        color: const Color(0xffFE6C00),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(width: 2, color: Color(0xffFE6C00)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signIn();
                          } else {
                            showSnackbar("Please fill in all fields correctly.");
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
