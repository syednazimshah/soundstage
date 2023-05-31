import 'package:flutter/material.dart';
import 'package:soundstageweb/About/aboutpage.dart';
import 'package:soundstageweb/FAQ/faqpage.dart';
import 'package:soundstageweb/Login/LoginPage.dart';
import 'package:soundstageweb/Synthesis/synthesispage.dart';
import 'Landing/landing.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soundstageweb/History/History.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'about',
          builder: (context,state) {
            return const AboutPage();
          },
        ),
        GoRoute(
          path: 'faqs',
          builder: (context, state) {
            return const FAQPage();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'synthesis',
          builder: (context, state) {
            return const SynthesisPage();
          },
        ),
        GoRoute(
          path: 'history',
          builder: (context, state) {
            return const HistoryPage();
          },
        ),
      ],
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyA_Kw71PqSnFOVRx0yAHS7z3ukz8D3cN24",
      appId: "1:996476601036:web:765296c2c89f3d3f237869",
      messagingSenderId: "996476601036",
      projectId: "soundstagefyp",
      storageBucket: "soundstagefyp.appspot.com",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      title: 'SoundStage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
        ),
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,

      //home: LandingPage(),
    );
  }
}


