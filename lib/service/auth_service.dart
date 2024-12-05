import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  final firebaseAuth = FirebaseAuth.instance;

  Future signInAnonymous() async {
    try{
      final result = await firebaseAuth.signInAnonymously();
      print(result.user!.uid);
      return result.user;
    }catch (e){
      print("Anon error $e");
      return null;
    }
  }
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Kullanıcı oluşturma hatası: $e");
      return null;
    }
  }
}