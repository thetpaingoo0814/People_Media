// This code is create by M23W7502_ThetPaingOo
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:people_media/providers/CatProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:provider/provider.dart';

import '../../utils/Routes.dart';
import '../../utils/Vary.dart';

class CatAdd extends StatefulWidget {
  const CatAdd({super.key});

  @override
  State<CatAdd> createState() => _CatAddState();
}

class _CatAddState extends State<CatAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  late File file;
  bool isFile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add New Category")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descController,
              onChanged: (value) {},
              minLines: 5,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Desc",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image == null) {
                  return;
                } else {
                  isFile = true;
                  file = File(image.path);
                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Text(
                "Upload Image",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
            isFile ? SizedBox(width: 100, child: Image.file(file)) : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var request = http.MultipartRequest(
                      "POST",
                      Uri.parse(CAT_URL),
                    );
                    request.fields["name"] = _nameController.text;
                    request.fields["desc"] = _descController.text;
                    request.files.add(
                      await http.MultipartFile.fromPath("file", file.path),
                    );
                    request.headers["authorization"] = "bearer ${Vary.token}";
                    var response = await request.send();
                    var responsed = await http.Response.fromStream(response);
                    final result = json.decode(responsed.body);
                    bool con = result["con"] as bool;
                    if (con) {
                      await Provider.of<CatProvider>(
                        context,
                        listen: false,
                      ).getAll();
                      Kpo.successToast(context, "Catogory ထည့်တာ အောင်မြင်တယ်");
                      Navigator.pop(context);
                    } else {
                      Kpo.errorToast(context, "Category ဖန်တီးတာ ပြဿနာရှိတယ်၊");
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
    );
  }
}
