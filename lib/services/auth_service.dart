import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  Future signInAnonymous() async{
    try{
      final result = await firebaseAuth.signInAnonymously();
      return(result.user!.uid);

    }catch(e){
      return(null);
    }
  }

/*   Future forgotPassword(String email) async {
    try{
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
      print("mail kutusunu kontrol edin!");
    }catch(e){}
  }*/
 

  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } catch (e){
        res = "Kullanici email veya şifre hatali. Lütfen tekrar deneyin!";
    }
    return res;
  }

  Future<String> signUp(String email, String password) async {
    String? res;
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } catch (e) {
        res = "Kayıt başarısız";
      }
      return res;
  }
}

