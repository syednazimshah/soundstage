import 'package:flutter/material.dart';
import '../About/aboutpage.dart';
import '../FAQ/faqpage.dart';
import '../Landing/landing.dart';
import '../Login/LoginPage.dart';
import 'package:go_router/go_router.dart';
import 'package:soundstageweb/Login/AuthManager.dart';

topbar(BuildContext context, pagetype){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Image.asset(
      "assets/logo.png",
      fit: BoxFit.contain,
    ),
    leadingWidth: 150,
    toolbarHeight: 100,
    actions: [
      Container(
        height: 100,
        width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            if(pagetype!="landing")
              TextButton(
              child: Text(
                "Home",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                context.go('/');
                // Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       pageBuilder: (context, _, __) => LandingPage(),
                //       transitionDuration: Duration(seconds: 0),
                //     ));
              },
            ),



            if(pagetype!="about")
              TextButton(
              child: Text(
                "About",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                context.go('/about');
                // Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       pageBuilder: (context, _, __) => AboutPage(),
                //       transitionDuration: Duration(seconds: 0),
                //     ));
              },
            ),



            if(pagetype!="faq")TextButton(
              child: Text(
                "FAQ's",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                context.go('/faqs');
                // Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       pageBuilder: (context, _, __) => FAQPage(),
                //       transitionDuration: Duration(seconds: 0),
                //     ));
              },
            ),
              if(!isLoggedIn && pagetype!="landing")
              TextButton(
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                  context.go('/login');

              },
            ),
            if(isLoggedIn && pagetype!="landing")
            TextButton(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    logout();
                    context.go('/');
                  },
                ),

          ],
        ),
      ),
    ],
  );
}