import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:people_media/providers/ThemeProvider.dart';
import 'package:people_media/providers/UserProvider.dart';
import 'package:people_media/providers/theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    isDark = Provider.of<ThemeProvider>(context).themeMode == darkMode;
    var pVider = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Setting",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(pVider.user.profile),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pVider.user.displayName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        pVider.user.phone,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          exit(0);
                        },
                        child: Text(
                          "Sign out ${pVider.user.name}",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Colors.pinkAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      "Dark Mode",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: isDark,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).toggleTheme();
                    },
                  ),
                  Divider(),
                  SwitchListTile(
                    title: Text(
                      "Notification",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Edit Account"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.push("/editaccount");
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Change Password"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Language"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text("Private Account"),
                    value: false,
                    onChanged: (v) {},
                  ),
                  ListTile(
                    title: Text("Privacy & Setting Help"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
