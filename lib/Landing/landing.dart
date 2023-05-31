import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soundstageweb/Synthesis/synthesispage.dart';
import 'package:soundstageweb/Topbar/topbar.dart';
import '../Bottombar/bottombar.dart';
import 'package:soundstageweb/Login/AuthManager.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpg"), fit: BoxFit.cover)),
        child: Scaffold(

          bottomNavigationBar:bottombar(),

          backgroundColor: Colors.transparent,

          appBar: topbar(context, "landing"),

          body: SingleChildScrollView(
            child: Container(
              // height: constraints.maxHeight,
              // width: constraints.maxWidth,
              padding: EdgeInsets.all(100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'AI VOICES',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  //SizedBox(height: 10.0),
                  Text(
                    'STUNNING REALISM,',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  //SizedBox(height: 10.0),
                  Text(
                    'CAPTIVATING EMOTION',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Generate compelling, lifelike performances\nwith fully expressive AI-generated voices\nand sound effects which make the story a\nfulfilling experience.',
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                  SizedBox(height: 50.0),

                  Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if(isLoggedIn)
                          context.go('/synthesis');

                        else
                          context.go('/login');

                      },
                      child: Text(
                        'Get Started!',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),

                    ],
                  )
                ,
              ),
            ),
          ),

      );
    });
  }
}
