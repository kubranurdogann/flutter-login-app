import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String kullanici;

  const HomePage({super.key, required this.kullanici});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(kullanici)), // '$kullanici' içindeki kullanici değişkeni olmadan 
    );
  }
}
