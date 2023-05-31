import 'package:flutter/material.dart';

class RoundedAlertBox extends StatelessWidget {
  final Widget icon;
  final String message;
  final onPressed;

  RoundedAlertBox({required this.icon, required this.message, required this.onPressed()});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      //backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('OK',),
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                elevation: MaterialStateProperty.all(0),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

/*class ForgottenPasswordAlertBox extends StatelessWidget {
  //final Widget icon;
  TextEditingController email = TextEditingController();
  final onPressed;

  ForgottenPasswordAlertBox({required this.onPressed()});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.security_rounded,color: Colors.blue,size: 100,),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.withOpacity(0.25),
              ),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.email_rounded),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('OK',),
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                elevation: MaterialStateProperty.all(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/