// This code is create by M23W7502_ThetPaingOo
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:people_media/models/Cat.dart';
import 'package:people_media/providers/CatProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:provider/provider.dart';

import '../../utils/Routes.dart';
import '../../utils/Vary.dart';

class CatEdit extends StatefulWidget {
  final Cat cat;
  const CatEdit({super.key, required this.cat});

  @override
  State<CatEdit> createState() => _CatEditState(cat: cat);
}

class _CatEditState extends State<CatEdit> {
  Cat cat;
  _CatEditState({required this.cat});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  late File file;
  bool isFile = false;

  @override
  void initState() {
    _nameController.text = cat.name;
    _descController.text = cat.desc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add New Category")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 50, height: 50, child: Image.network(cat.image)),
              SizedBox(height: 20),
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
                  ? SizedBox(width: 100, child: Image.file(file))
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (!isFile) {
                        bool success = await Provider.of<CatProvider>(
                          context,
                          listen: false,
                        ).update(
                          cat.id,
                          _nameController.text,
                          _descController.text,
                        );
                        if (success) {
                          Kpo.successToast(
                            context,
                            "Catogory Edit တာ အောင်မြင်တယ်",
                          );
                          Navigator.pop(context);
                        } else {
                          Kpo.errorToast(
                            context,
                            "Category Edit တာ ပြဿနာရှိတယ်၊",
                          );
                        }
                      } else {
                        var request = http.MultipartRequest(
                          "PATCH",
                          Uri.parse("$CAT_URL/${cat.id}"),
                        );
                        request.fields["name"] = _nameController.text;
                        request.fields["desc"] = _descController.text;
                        request.files.add(
                          await http.MultipartFile.fromPath("file", file.path),
                        );
                        request.headers["authorization"] =
                            "bearer ${Vary.token}";
                        var response = await request.send();
                        var responsed = await http.Response.fromStream(
                          response,
                        );
                        final result = json.decode(responsed.body);
                        bool con = result["con"] as bool;
                        if (con) {
                          await Provider.of<CatProvider>(
                            context,
                            listen: false,
                          ).getAll();
                          Kpo.successToast(
                            context,
                            "Catogory Edit တာ အောင်မြင်တယ်",
                          );
                          Navigator.pop(context);
                        } else {
                          Kpo.errorToast(
                            context,
                            "Category Eidt တာ ပြဿနာရှိတယ်၊",
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
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
