import 'package:easy_join/service/auth_service.dart';
import 'package:easy_join/utils/customColors.dart';
import 'package:easy_join/widgets/custom_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late String email, password;
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: const EdgeInsets.only(top:50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Easy Join App",style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ubuntu",
                              ),),
                              Image.asset("images/resim2.png"),
                              Text("Merhaba",style: TextStyle(
                                fontFamily: "ubuntu",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Tekrar'dan hoşgeldin dostum.",style: TextStyle(
                                fontFamily: "ubuntu",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),),
                            ],
                          ),
                        ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 30,right: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      emailTextField(),
                      SizedBox(height: 10,),
                      passwordTextField(),
                    ],
                  ),
                ),

              ),
              SizedBox(height: 25,),
              Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        loginPageButton(),
                        SizedBox(height: 5,),
                        GestureDetector(
                          onTap: (){},
                          child: Text("Şifrenizi mi unuttunuz?",style: TextStyle(
                            color: Color(0xfff393a58),
                            fontSize: 14,
                            fontFamily: "ubuntu",
                          ),),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hesabınız yok mu?",style: TextStyle(
                          color:  Color(0xfff393a58),
                          fontFamily: "ubuntu"
                        ),),
                        CustomTextButton(onPressed: () => Navigator.pushNamed(context, "/signUp"),
                        buttonText: "Kayıt Ol", textColor: CustomColors.textButtonColor),
                      ],
                    ),
                    CustomTextButton(onPressed: () async{
                      final result = await authService.signInAnonymous();
                      if(result !=null){
                        Navigator.pushReplacementNamed(context, "/homePage");
                      }else{
                        print("hata ile karşılaşır");
                      }

                    }, buttonText: "Misafir Girişi", textColor: CustomColors.textButtonColor)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Center loginPageButton() {
    return Center(
      child: ElevatedButton(
        onPressed: signIn,
        child: Text(
          "Giriş Yap",
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
  InputDecoration customInputDecoration(String hintext) {
    return InputDecoration(
      hintText: hintext,
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
      try {
        final userResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userResult.user != null) {
          Navigator.pushNamed(context, "/homePage");
        } else {
          print("Kullanıcı bilgileri alınamadı.");
        }
      } catch (e) {
        print("Giriş hatası: ${e.toString()}");
      }
    } else {
      print("Form doğrulaması başarısız.");
    }
  }

}
