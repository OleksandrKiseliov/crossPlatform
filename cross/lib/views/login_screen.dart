import 'package:flutter/material.dart';
import 'package:to_bee/views/home.dart';
import 'package:to_bee/views/sign_up.dart';
import 'package:to_bee/views/welcome.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 10, left: 10),
                          hintText: "  password",
                          hintStyle: TextStyle(color: Color(0xff939393)),
                        ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 390,
                        height: 50,
                        child: MaterialButton(
                          color: const Color(0xffFFFFFF),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            side: BorderSide(width: 2, color: Colors.transparent),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  "lib/assets/images/google-logo.jpg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Continue with Google",
                                style: TextStyle(fontSize: 15, color: Colors.black),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_outlined),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 390,
                        height: 50,
                        child: MaterialButton(
                          color: const Color(0xffFFFFFF),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            side: BorderSide(width: 2, color: Colors.transparent),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  "lib/assets/images/facebook-logo.jpg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Continue with Facebook",
                                style: TextStyle(fontSize: 15, color: Colors.black),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_outlined),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
