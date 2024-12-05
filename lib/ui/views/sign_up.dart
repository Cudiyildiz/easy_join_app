import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late String email, password;
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true, // Boyutlanmayı kapatıyoruz
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Klavye dışına tıklayınca kapatma
        child: Center(
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * .50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/resim1.png"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Easy Join App",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ubuntu",
                              ),
                            ),
                            Image.asset("images/resim2.png"),
                            Text(
                              "Merhaba",
                              style: TextStyle(
                                fontFamily: "ubuntu",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Hoşgeldiniz.",
                              style: TextStyle(
                                fontFamily: "ubuntu",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Column(
                    children: [
                      emailTextField(),
                      SizedBox(height: 25),
                      passwordTextField(),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Center(
                  child: Column(
                    children: [
                      signUpButton(),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hesabınız var mı? ",
                            style: TextStyle(
                              color: Color(0xfff393a58),
                              fontFamily: "ubuntu",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/loginPage");
                            },
                            child: Text(
                              "Giriş yap",
                              style: TextStyle(
                                fontFamily: "ubuntu",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xfff393a58),
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
        ),
      ),
    );
  }
  Center signUpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: signIn,
        child: Text(
          "Kayıt Ol",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "ubuntu",
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xfff393a58),
          shadowColor: Colors.grey,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),
        ),
      ),
    );
  }
  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksiksiz doldur";
        }
        return null;
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      decoration: customInputDecoration("Şifre"),
    );
  }
  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksiksiz doldur";
        }
        return null;
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: customInputDecoration("Email"),
    );
  }
  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black54, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black54, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color(0xfffed42ab), width: 2),
      ),
    );
  }
  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try{
        var userResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
            "Hesabınız oluşturuldu,giriş sayfasına yönlendiriliyorsunuz"),
        ));
        Navigator.pushNamed(context, "/loginPage");
      }
      catch (e){
        print(e.toString());
      }
    }
  }

}
