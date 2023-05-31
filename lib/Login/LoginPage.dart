import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soundstageweb/Bottombar/bottombar.dart';
import 'package:soundstageweb/Synthesis/synthesispage.dart';
import 'package:soundstageweb/Topbar/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundstageweb/Misc/Alertbox.dart';
import 'AuthManager.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin=true;
  bool loading=false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String> registerUser(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to the home page on successful registration:
      return 'Successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Handle weak password error:
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        // Handle email already in use error:
        return 'The account already exists for that email.';
      } else {
        // Handle other errors:
        return e.toString();
      }
    } catch (e) {
      // Handle other errors:
      return e.toString();
    }
  }


  Future<String> loginUser(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found error:
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        // Handle incorrect password error:
        return 'Wrong password provided for that user.';
      } else {
        // Handle other errors:
        return e.toString();
      }
    } catch (e) {
      // Handle other errors:
      return e.toString();
    }
  }

  Future<String> resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Show a success message to the user:
      return 'Successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found error:
        return 'No user found for that email.';
      } else {
        // Handle other errors:
        return e.toString();
      }
    } catch (e) {
      // Handle other errors:
      return e.toString();
    }
  }



ForgottenPasswordAlertBox(){

  TextEditingController email = TextEditingController();
  return  Dialog(

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 0.0,
    //backgroundColor: Colors.blueGrey,
    child: Container(
      //color: Colors.blueGrey,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.security_rounded,color: Colors.blue,size: 100,),
          SizedBox(height: 20),
          Text("Enter email to reset your password",style: TextStyle(fontSize: 20,color: Colors.white),),
          SizedBox(height: 20,),
          Container(
            width: 400,
            //height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.25),
            ),
            child: TextField(
              controller: email,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Enter Email',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.email_rounded),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {

              if(email.text!=''){
                String output= await resetPassword(context, email.text);
                if(output=='Successful'){
                  Navigator.of(context).pop();
                  showDialog(context: context, builder: (BuildContext context){
                    return RoundedAlertBox(
                      icon: Icon(Icons.check_circle_outline_rounded,size: 100,color: Colors.green,),
                      message: 'Email sent. Please Check',
                      onPressed: () {
                        Navigator.of(context).pop();
                        //  context.go('/synthesis');
                      },
                    );
                  });
                }
                else {
                  Navigator.of(context).pop();
                  showDialog(context: context, builder: (BuildContext context){
                    return RoundedAlertBox(
                      icon: Icon(Icons.warning_amber_rounded,size: 100,color: Colors.red,),
                      message: output,
                      onPressed: () {
                        Navigator.of(context).pop();
                        //context.go('/synthesis');
                      },
                    );
                  });
                }
              }
              else{

                showDialog(context: context, builder: (BuildContext context){
                  return RoundedAlertBox(
                    icon: Icon(Icons.warning_amber_rounded,size: 100,color: Colors.red,),
                    message: "Email cannot be empty",
                    onPressed: () {
                      Navigator.of(context).pop();
                      //context.go('/synthesis');
                    },
                  );
                });
              }
            },
            child: Text('Send Email',),
            style: ButtonStyle(
              backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
              elevation: MaterialStateProperty.all(0),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    ),
  );
}












  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/background.jpg"),fit: BoxFit.cover)
            ),
          child: Scaffold(

            appBar: topbar(context, "login"),

            backgroundColor: Colors.transparent,

            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 500,
                  width: 500,
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        isLogin?'Login':'Register',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        isLogin?'Enter your email and password to log in.':'Enter your email and password to Register.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      if(!isLogin) Column(
                        children: [
                          SizedBox(height: 20.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.withOpacity(0.25),
                            ),
                            child: TextField(
                              controller: confirmpassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15.0),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue,
                        ),
                        child: loading?Center(child: CircularProgressIndicator()):TextButton(
                          onPressed: () async {
                            setState(()=>loading=!loading);

                            if(email.text==""||password.text==""){
                              showDialog(context: context, builder: (BuildContext context){
                                return RoundedAlertBox(
                                  icon: Icon(Icons.warning_amber_rounded,size: 100,color: Colors.red,),
                                  message: "Email and Password cannot be empty",
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    //context.go('/synthesis');
                                  },
                                );
                              });
                            }
                            else{


                              if(isLogin){
                                String output= await loginUser(context, email.text, password.text);
                                if(output=='Successful'){
                                  showDialog(context: context, builder: (BuildContext context){
                                    return RoundedAlertBox(
                                      icon: Icon(Icons.check_circle_outline_rounded,size: 100,color: Colors.green,),
                                      message: 'Login Successful',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        login(email.text);
                                        context.go('/synthesis');
                                      },
                                    );
                                  });
                                }
                                else {
                                  showDialog(context: context, builder: (BuildContext context){
                                    return RoundedAlertBox(
                                      icon: Icon(Icons.warning_amber_rounded,size: 100,color: Colors.red,),
                                      message: output,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        //context.go('/synthesis');
                                      },
                                    );
                                  });
                                }
                              }
                              else if (!isLogin){
                                if (password.text==confirmpassword.text){
                                  String output= await registerUser(context, email.text, password.text);
                                  if(output=='Successful'){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return RoundedAlertBox(
                                        icon: Icon(Icons.check_circle_outline_rounded,size: 100,color: Colors.green,),
                                        message: 'Registeration Successful',
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          login(email.text);

                                          context.go('/synthesis');
                                        },
                                      );
                                    });
                                  }
                                  else {
                                    showDialog(context: context, builder: (BuildContext context){
                                      return RoundedAlertBox(
                                        icon: Icon(Icons.warning_amber_rounded,size: 100,color: Colors.red,),
                                        message: output,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          //context.go('/synthesis');
                                        },
                                      );
                                    });
                                  }
                                }
                                else{
                                  showDialog(context: context, builder: (BuildContext context){
                                    return RoundedAlertBox(
                                      icon: Icon(Icons.warning_amber_rounded,size: 100,color: Colors.red,),
                                      message: "Passwords do not match",
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        //context.go('/synthesis');
                                      },
                                    );
                                  });
                                }

                              }
                            }
                            setState(()=>loading=!loading);
                          },
                          child: Text(
                            isLogin?'Login':'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: (){
                                setState((){
                                  isLogin=!isLogin;
                                });
                              },
                              child: Text(isLogin?"New here? Register here":"Coming back? Login here")
                          ),
                          if(isLogin) TextButton(
                              onPressed: (){
                                showDialog(context: context, builder: (BuildContext builder){
                                  return ForgottenPasswordAlertBox();
                                });
                              },
                              child: Text("Forgotten Password?")
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar:bottombar(),
          ),
        );
      }
    );
  }
}
