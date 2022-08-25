import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/chat_Page.dart';
import 'package:scholar_chat/Screens/login_Screen.dart';
import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';



class RegisterScreen extends StatefulWidget {


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    Text("REGISTER" , style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  onChanged: (data){
                    email = data;
                  },
                  hintText: "Email",
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  onChanged: (data){
                    password = data;
                  },
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
                        UserCredential user = await auth.createUserWithEmailAndPassword(email: email!, password: password!);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email created successfully")));
                        Navigator.pushNamed(context, ChatPage.id);
                      }on FirebaseAuthException catch(e){
                        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Weak Password")));
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email Already In Use")));
                        }
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
                      }
                      isLoading = false;
                      setState((){});

                    }
                  },
                  text: "REGISTER",),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text("  Login",
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
