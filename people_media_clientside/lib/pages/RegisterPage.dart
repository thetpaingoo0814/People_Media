import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:people_media/pages/LoginPage.dart';
import 'package:people_media/providers/UserProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:provider/provider.dart';
// A123456

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

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
    Userprovider pVider = Provider.of<Userprovider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                GradientAnimationText(
                  text: Text(
                    'Register',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 35),
                  ),
                  colors: gradientColors,
                  duration: Duration(seconds: 5),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged:
                      (value) => Provider.of<Userprovider>(
                        context,
                        listen: false,
                      ).nameChange(value),
                  decoration: InputDecoration(
                    labelText: "name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.green, width: 10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged:
                      (value) => Provider.of<Userprovider>(
                        context,
                        listen: false,
                      ).displayNameChange(value),
                  decoration: InputDecoration(
                    labelText: "Display Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.green, width: 10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged:
                      (value) => Provider.of<Userprovider>(
                        context,
                        listen: false,
                      ).phoneChange(value),
                  decoration: InputDecoration(
                    labelText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.green, width: 10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged:
                      (value) => Provider.of<Userprovider>(
                        context,
                        listen: false,
                      ).passwordChange(value),
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
                        bool isSuccess =
                            await Provider.of<Userprovider>(
                              context,
                              listen: false,
                            ).register();
                        if (isSuccess) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Register Success!"),
                                content: Text(
                                  "Registration Success, login now",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    },
                                    child: Text("Got To Login"),
                                  ),
                                ],
                              );
                            },
                          );
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
                        backgroundColor: Colors.pinkAccent,
                      ),
                      child: Text(
                        "Register",
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          " Sign in",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
