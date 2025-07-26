// This code is create by M23W7502_ThetPaingOo
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:people_media/providers/UtilProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FlashPage extends StatelessWidget {
  FlashPage({super.key});

  final gradientColors = [
    Color(0xff8f00ff), // violet
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
  ];

  final colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = GoogleFonts.padauk(fontSize: 30);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Utilprovider pVider = Provider.of<Utilprovider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(height: 20),
              !pVider.showTitle
                  ? AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'စစ်မှန်မူ',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        'တည်ကြည်မူ',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        'ဓမ္မဓိဠာန် ကျမူ',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                    onFinished: () async {
                      bool bol = await pVider.checkAppVersion();
                      if (bol) {
                        await Future.delayed(Duration(seconds: 5));
                        context.go("/login");
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("App Version Outdated!"),
                              content: Column(
                                children: [
                                  Text("Your app version is outdated!"),
                                  Text("Please download new version!"),
                                  Text(pVider.error),
                                ],
                              ),
                              actions: [
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        exit(0);
                                      },
                                      child: Text("Exist"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _launchUrl(pVider.error);
                                      },
                                      child: Text("Download"),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  )
                  : GradientAnimationText(
                    text: Text(
                      'People Media',
                      style: GoogleFonts.aBeeZee(fontSize: 30),
                    ),
                    colors: gradientColors,
                    duration: Duration(seconds: 5),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
