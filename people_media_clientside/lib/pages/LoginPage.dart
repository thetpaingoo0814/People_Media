import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:go_router/go_router.dart';
import 'package:people_media/pages/RegisterPage.dart';
import 'package:people_media/providers/CatProvider.dart';
import 'package:people_media/providers/UserProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:provider/provider.dart';

import '../providers/PostProvider.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  bool isHidden = true;
  final gradientColors = [
    Color(0xff8f00ff), // violet
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    var pVider = Provider.of<Userprovider>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientAnimationText(
                text: Text(
                  'User Login',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 35),
                ),
                colors: gradientColors,
                duration: Duration(seconds: 5),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => pVider.nameChange(value),
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.green, width: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => pVider.passwordChange(value),
                obscureText: pVider.isHidePass,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () => pVider.toggleShow(),
                    child: Icon(
                      pVider.isHidePass
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.green, width: 10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forget your password?",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
              pVider.isLoading
                  ? Kpo.showLoadingIndicator()
                  : ElevatedButton(
                    onPressed: () async {
                      bool isSuccess = await pVider.login();
                      if (isSuccess) {
                        await Provider.of<PostProvider>(
                          context,
                          listen: false,
                        ).getAll();
                        await Provider.of<CatProvider>(
                          context,
                          listen: false,
                        ).getAll();
                        context.pushReplacement("/home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(pVider.error),
                            backgroundColor: Colors.pinkAccent,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    child: Text(
                      "Login",
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      Text(
                        " Sign up",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
