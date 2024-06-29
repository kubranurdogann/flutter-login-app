import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/home_page.dart';
import 'package:firebase_login_app/services/auth_service.dart';
import 'package:firebase_login_app/sign_up.dart';
import 'package:firebase_login_app/widgets/custom_text__button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;

  final formKey = GlobalKey<FormState>();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox25(),
                Center(
                  child: Container(
                      child: Image.asset(
                    "lib/images/img-1.png",
                    height: 200,
                  )),
                ),
                SizedBox25(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Sign In",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.blue.withOpacity(0.8),
                            offset: Offset(2, 2),
                            blurRadius: 3,
                          ),
                        ],
                      )),
                ),
                SizedBox25(),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen e-posta adresinizi giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: "What's your email?",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 8.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox10(),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen şifre giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: "What's your password?",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 8.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox25(),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          onPressed: () {
                            signIn();
                          },
                          buttonText: "Next",
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child:Column(
                    children: [
                      CustomTextButton(onPressed: (){}, buttonText: "Şifremi unuttum!"),
                      SizedBox10(),
                      CustomTextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()),
                              );
                            },
                            buttonText: "Sign Up"),
                      SizedBox10(),
                      CustomTextButton(
                        onPressed: () async {
                        final result = await AuthService().signInAnonymous;
                        if(result != "null"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(kullanici:"Misafir"),));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Hata ile karılaşıldı!")),
                        );
                        }
                        },
                        buttonText: "Misafir Girişi"),
                    ],
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }


  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String? result = await AuthService().signIn(email, password);
      if (result == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Giriş başarılı!")),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(kullanici: email),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$result")),
        );
        formKey.currentState!.reset();
      }
    }
  }
}

SizedBox25() {
  return SizedBox(height: 25);
}

SizedBox10() {
  return SizedBox(height: 10);
}
