import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:people_media/models/Cat.dart';
import 'package:people_media/pages/LoginPage.dart';
import 'package:people_media/pages/PostGen.dart';
import 'package:people_media/pages/SettingPage.dart';
import 'package:people_media/pages/TagPage.dart';
import 'package:people_media/providers/CatProvider.dart';
import 'package:people_media/providers/CommentProvider.dart';
import 'package:people_media/providers/PostProvider.dart';
import 'package:people_media/providers/TagProvider.dart';
import 'package:people_media/providers/ThemeProvider.dart';
import 'package:people_media/providers/UserProvider.dart';
import 'package:people_media/providers/UtilProvider.dart';
import 'package:people_media/supages/cats/CatAdd.dart';
import 'package:people_media/supages/cats/CatEdit.dart';
import 'package:people_media/supages/tags/TagEdit.dart';
import 'package:provider/provider.dart';
import 'models/Tag.dart';
import 'pages/CatPage.dart';
import 'pages/EditAccount.dart';
import 'pages/HomePage.dart';
import 'pages/PostPage.dart';
import 'supages/tags/TagAdd.dart';

void main() {
  //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Utilprovider()),
        ChangeNotifierProvider(create: (context) => Userprovider()),
        ChangeNotifierProvider(create: (context) => CatProvider()),
        ChangeNotifierProvider(create: (context) => TagProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: "/", builder: (context, state) => LoginPage()),
        GoRoute(path: "/login", builder: (context, state) => LoginPage()),
        GoRoute(path: "/home", builder: (context, state) => HomePage()),
        GoRoute(
          path: "/post",
          builder: (context, state) {
            final String postId = GoRouterState.of(context).extra! as String;
            return PostPage(id: postId);
          },
        ),
        GoRoute(path: "/setting", builder: (context, state) => SettingPage()),
        GoRoute(path: "/catpage", builder: (context, state) => CatPage()),
        GoRoute(path: "/catadd", builder: (context, state) => CatAdd()),
        GoRoute(
          path: "/catedit",
          builder: (context, state) {
            final Cat cat = GoRouterState.of(context).extra! as Cat;
            return CatEdit(cat: cat);
          },
        ),
        GoRoute(path: "/tagpage", builder: (context, state) => TagPage()),
        GoRoute(path: "/tagadd", builder: (context, state) => TagAdd()),
        GoRoute(
          path: "/tagedit",
          builder: (context, state) {
            final Tag tag = GoRouterState.of(context).extra! as Tag;
            return TagEdit(tag: tag);
          },
        ),
        GoRoute(path: "/postgen", builder: (context, state) => PostGen()),
        GoRoute(
          path: "/editaccount",
          builder: (context, state) => EditAccount(),
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeMode,
    );
  }
}

/*
  BLOC - Riverpod
  Clean Architecture
  BLOC - Provider
*/
