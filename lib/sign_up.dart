import 'package:firebase_login_app/services/auth_service.dart';
import 'package:firebase_login_app/widgets/custom_text__button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login_app/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email, password;

  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Center(
                  child: Container(
                    child: Image.asset(
                      "lib/images/img-1.png", // Ensure this path is correct
                      height: 200,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
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
                    ),
                  ),
                ),
                SizedBox(height: 25),
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
                SizedBox(height: 10),
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
                SizedBox(height: 25),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          }, buttonText: "Sign In"),
                          CustomTextButton(
                            onPressed: (){SignUp();}, 
                            buttonText: "Next"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  
  }

  Future<void> SignUp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String? result = await AuthService().signUp(email, password);
      if (result == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kayıt başarılı! Giriş yapabilirsiniz.")),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$result")),
        );
        formKey.currentState!.reset();
      }
    }
  }

}
