import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:people_media/models/Cat.dart';
import 'package:people_media/models/Tag.dart';
import 'package:people_media/providers/CatProvider.dart';
import 'package:people_media/providers/PostProvider.dart';
import 'package:people_media/providers/TagProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:people_media/utils/Routes.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../utils/Vary.dart';

class PostAdd extends StatefulWidget {
  const PostAdd({super.key});

  @override
  State<PostAdd> createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String catHint = "Choose Category";
  String tagHit = "Choose Tag";
  String selectedCatId = "Choose Category";
  String selectedTagId = "Choose Tag";

  List<File> files = [];
  bool isFile = false;

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CatProvider>(context);
    var tagProvider = Provider.of<TagProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      catProvider.invoke();
      tagProvider.invoke();
    });

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add New Post")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            children: [
              DropdownButton<Cat>(
                hint: Text(catHint),
                items:
                    catProvider.cats.map((Cat cat) {
                      return DropdownMenuItem<Cat>(
                        value: cat,
                        child: Text(cat.name),
                      );
                    }).toList(),
                onChanged: (cat) {
                  selectedCatId = cat!.id;
                  setState(() {
                    catHint = cat.name;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButton<Tag>(
                hint: Text(tagHit),
                items:
                    tagProvider.tags.map((Tag tag) {
                      return DropdownMenuItem<Tag>(
                        value: tag,
                        child: Text(tag.name),
                      );
                    }).toList(),
                onChanged: (tag) {
                  selectedTagId = tag!.id;
                  tagHit = tag.name;
                  setState(() {});
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _titleController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _contentController,
                minLines: 5,
                maxLines: 5,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final pickFiles = await picker.pickMultiImage();
                  if (pickFiles.isNotEmpty) {
                    files = pickFiles.map((pFile) => File(pFile.path)).toList();
                    isFile = true;
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  "Upload Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
              isFile
                  ? Row(
                    children: List.generate(files.length, (index) {
                      return SizedBox(
                        width: 100,
                        child: Image.file(files[index]),
                      );
                    }),
                  )
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var request = http.MultipartRequest(
                        "POST",
                        Uri.parse(POST_URL),
                      );
                      request.fields["title"] = _titleController.text;
                      request.fields["content"] = _contentController.text;
                      request.fields["category"] = selectedCatId;
                      request.fields["tag"] = selectedTagId;
                      for (var file in files) {
                        request.files.add(
                          await http.MultipartFile.fromPath("files", file.path),
                        );
                      }
                      request.headers["authorization"] = "bearer ${Vary.token}";
                      var response = await request.send();
                      var responsed = await http.Response.fromStream(response);
                      final result = json.decode(responsed.body);
                      bool con = result["con"] as bool;
                      if (con) {
                        await Provider.of<PostProvider>(
                          context,
                          listen: false,
                        ).getAll();
                        Kpo.successToast(context, "Post ထည့်တာ အောင်မြင်တယ်");
                        Navigator.pop(context);
                      } else {
                        Kpo.errorToast(context, "Post ဖန်တီးတာ ပြဿနာရှိတယ်၊");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text("Add", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
