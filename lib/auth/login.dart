import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:baitap_2_3_4/auth/regiter.dart';

import '../screen/home_page.dart';
import '../servites/auth_servites.dart';
import '../widget/text_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  AuthServices _auth = AuthServices();

  void _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
    EasyLoading.show(status: 'loading...');
    User? user = await _auth.signIn(email, password);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      EasyLoading.showError("Email Hoặc password không đúng");
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Form(
      key: _formkey,
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đăng Nhập",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextInput(
                controller: _emailController,
                labelText: 'Email',
                hintText: "Nhập email",
                prefixIcon: Icon(Icons.email),
                textInputType: TextInputType.text,
                isShowpassword: false,
                // other parameters...
              ),
              SizedBox(
                height: 20,
              ),
              TextInput(
                controller: _passwordController,
                labelText: 'Password',
                hintText: "Nhập password",
                prefixIcon: Icon(Icons.password),
                textInputType: TextInputType.text,
                isShowpassword: true,
                // other parameters...
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: null, child: Text("Quên mật khẩu?"))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: _signIn,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Đăng Nhập",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản?",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Regiter())),
                      child: Text(
                        "Đăng Ký",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ))
                ],
              )
            ],
          )),
    )));
  }
}
