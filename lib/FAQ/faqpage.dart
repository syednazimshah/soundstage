import 'package:flutter/material.dart';
import 'package:soundstageweb/Topbar/topbar.dart';
import '../Bottombar/bottombar.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
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

          bottomNavigationBar: bottombar(),

          backgroundColor: Colors.transparent,

          appBar: topbar(context, "faq"),

          body: SingleChildScrollView(
            child: Container(
              // height: constraints.maxHeight,
              // width: constraints.maxWidth,
              padding: EdgeInsets.symmetric(horizontal: 250.0,vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'What is AI voice?',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  //SizedBox(height: 10.0),
                  Text(
                    'AI voice refers to the use of artificial intelligence (AI) technology to synthesize or mimic human speech. AI voice technology is able to generate spoken language that sounds natural and is often indistinguishable from human speech. This technology relies on machine learning algorithms and deep neural networks to analyze and learn from large datasets of human speech. This allows it to generate speech that is not only fluent and natural-sounding but also able to adapt to different accents and speaking styles.',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                  SizedBox(height: 32.0),
                  Divider(
                    height: 50,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 32,),
                  Text(
                    'Why should I use an AI voice generator instead of hiring voice artists?',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'AI voice makers make the process of creating voice overs easier. It gives you complete control over your workflow and enables you to convert your home recordings or scripts directly into voiceovers. AI text to speech saves time and money while maintaining the quality of your voice overs.',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                  SizedBox(height: 32.0),
                  Divider(
                    height: 50,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 32,),
                  Text(
                    'Who can use the application?',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Any layperson who wants to generate sounds for any purpose can use our website. Our target audience includes unrecognized artists who cannot afford to hire separate foley artists, visually impaired/blind people, and it can also be used for educational purposes.',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                  SizedBox(height: 32.0),
                  Divider(
                    height: 50,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 32,),
                  Text(
                    'I have a specific query, how can I reach your team?',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'You can send us an email at support@soundstage.com or reach out to us on our social media handles.',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white),
                  ),

                  // Container(
                  //   width: 250,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(25.0),
                  //     color: Colors.white,
                  //   ),
                  //   child: FlatButton(
                  //     onPressed: () {
                  //
                  //       Navigator.push(
                  //           context,
                  //           PageRouteBuilder(
                  //             pageBuilder: (context, _, __) => SynthesisPage(),
                  //             transitionDuration: Duration(seconds: 0),
                  //           ));
                  //
                  //     },
                  //     child: Text(
                  //       'Get Started!',
                  //       style: TextStyle(
                  //         color: Colors.blue[900],
                  //         fontSize: 20.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
