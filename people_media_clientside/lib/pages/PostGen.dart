// This code is create by M23W7502_ThetPaingOo
import 'package:flutter/material.dart';
import 'package:people_media/models/Post.dart';
import 'package:people_media/providers/PostProvider.dart';
import 'package:people_media/supages/posts/PostAdd.dart';
import 'package:people_media/supages/posts/PostEdit.dart';
import 'package:provider/provider.dart';

import '../utils/Kop.dart';

class PostGen extends StatelessWidget {
  const PostGen({super.key});

  @override
  Widget build(BuildContext context) {
    var pVider = Provider.of<PostProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Post Gen Starting!");
      pVider.invoke();
    });
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Posts")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostAdd()),
                      );
                    },
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    _makeHeaderText("စဥ်"),
                    _makeHeaderText("နာမည်"),
                    _makeHeaderText("Action"),
                  ],
                ),
              ],
            ),
            Table(
              border: TableBorder.all(),
              children: List.generate(pVider.posts.length, (index) {
                Post post = pVider.posts[index];
                return TableRow(
                  children: [
                    _makeDataText("${index + 1}"),
                    _makeDataText(post.title),
                    _makeActionIcon(context, pVider, post),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  _makeHeaderText(text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  _makeDataText(text) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(child: Text(text)),
      ),
    );
  }

  _makeActionIcon(BuildContext context, PostProvider pVider, Post post) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostEdit(post: post)),
              );
            },
            child: Icon(Icons.edit, color: Colors.greenAccent),
          ),
          GestureDetector(
            onTap: () async {
              bool success = await pVider.delete(post.id);
              if (success) {
                Kpo.successToast(context, "Post Deleted");
              } else {
                Kpo.errorToast(context, "Post Delete Fail!");
              }
            },
            child: Icon(Icons.delete, color: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }
}
