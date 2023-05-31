import 'package:flutter/material.dart';
import 'package:soundstageweb/Topbar/topbar.dart';
import '../Bottombar/bottombar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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

          appBar: topbar(context, "about"),

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
                      'About Us',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'SoundStage',
                    style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                  Text(
                    'Generate compelling, lifelike performances with fully expressive AI-generated voices and sound effects which make the story a fulfilling experience',
                    style: TextStyle(
                        fontSize: 50.0,
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
                    'What we do?',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  //SizedBox(height: 10.0),
                  Text(
                    'For years, to make good voiceovers, you would have to spend hundreds, if not thousands of dollars recruiting voice artists, renting recording studios to record the script, buying expensive recording equipment, and hiring or outsourcing an audio editor to mix the audio and produce a high-quality voiceover. It is also worth noting the number of hours devoted to this entire process. There is still the possibility, even after all this, that the output audio file may still not be of the desired quality after all this. What if there was an alternative to creating studio-quality voiceovers, and that too from the comfort of your own homes? What if there was an alternative to generating unusual sounds to upskill the sixth sense of visually impaired? Introducing Soundstage, which eliminates the entire process of manually generating voiceovers and allows you to quickly produce human-like voiceovers without the need for specialized hardware or professional. Moreover, to assist the visually impaired and help them to be trained better with different types of sounds which they usually don’t hear in their surroundings.The realistic online voice generator tool uses advanced AI algorithms and machine learning to convert text into natural-sounding speech in a matter of minutes. it functions as a voice maker, allowing you to create lifelike synthetic voices that mimic the tonalities and prosodies of human speech and sound. Soundstage’s AI voices, unlike other computer-generated voices, are not monotonous and robotic. The Soundstage’s voices, on the other hand, are extremely realistic and flawless.',
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
                    'Why choose us?',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Soundstage stands out from other text to speech tools because, as an online voice generator, it allows you to create high-quality outputs quickly. Soundstage allows anyone, from enterprises to small and medium businesses to individual context creators, to create realistic-sounding voice overs in a variety of ages. It’s simple interface, sleek design, and high-end features make it a must-have tool for anyone looking to create great voiceovers in a matter of minutes. are you looking for a high-quality, low-cost solution for creating voiceover narrations? Soundstage natural-sounding text-to-speech is the solution.',
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
                    'Features',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    '\n     1. Speech Styles: Use expressive emotional speaking styles to make the voices sound more natural and engaging.\n     2. Multi-Voice Feature: Create conversation like voiceovers by using different voices for sentences in the same audio file.\n     3. Voice-Inflections: Fine-tune Rate, Pitch, Emphasis and Pauses to create a more suitable voice tone.\n     4. Preview Mode: Listen and preview a single paragraph or full text before converting it to speech.',
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
                    'Services',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Soundstage offers the following services all in one packet which distinguishes it from its competitors:\n\n     1. Voice Synthesis\n     2. Foley (Environmental Sounds)\n     3. Emotional Expression\n     4. Natural Text Input',
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
