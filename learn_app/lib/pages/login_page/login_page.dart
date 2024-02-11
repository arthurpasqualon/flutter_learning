import 'package:flutter/material.dart';
import 'package:learn_app/pages/main_page/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  bool isObscureText = true;

  void onPressLogin() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email cannot be empty"),
          backgroundColor: Colors.red,
        ),
      );
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password cannot be empty"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MainPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      const Expanded(
                        flex: 2,
                        child: Image(
                          height: 125,
                          image: AssetImage("lib/images/logo.png"),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Join the Avengers",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: "Enter your email address",
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    child: TextField(
                      obscureText: isObscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Enter your email password",
                          hintStyle:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                            child: Icon(
                              isObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: onPressLogin,
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text("Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )),
                  Expanded(child: Container()),
                  Container(
                    height: 30,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    child: const Text("Forgot Password?"),
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {},
                        child: const Text("Signup",
                            style: TextStyle(fontSize: 16))),
                  ),
                  const SizedBox(
                    height: 24,
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
