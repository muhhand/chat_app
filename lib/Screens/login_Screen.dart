import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/chat_Page.dart';
import 'package:scholar_chat/Screens/register_Screen.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Spacer(flex: 1,),
                Image.asset('assets/images/scholar.png'),
                Text("Scholar Chat" , style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: 'pacifico'
                ),
                ),
                Spacer(flex: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("LOGIN" , style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                    ),),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  onChanged: (data){email = data;},
                  hintText: "Email",
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  obsecureText: true,
                  onChanged: (data){password = data;},
                  hintText: "Password",
                ),
                SizedBox(height: 10,),
                CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState((){});
                      try{
                        var auth = FirebaseAuth.instance;
                        UserCredential user = await auth.signInWithEmailAndPassword(email: email!, password: password!);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Loging in successfully")));
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      }on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user-not-found")));
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password provided for that user.")));
                        }
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
                      }
                      isLoading = false;
                      setState((){});
                    }
                  },
                  text: "LOGIN",),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don't have an account ?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: Text("  Register",
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    )

                  ],
                ),
                Spacer(flex: 3,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
