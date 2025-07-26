// This code is create by M23W7502_ThetPaingOo
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:people_media/providers/UserProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:people_media/utils/Routes.dart';
import 'package:people_media/utils/Vary.dart';
import 'package:provider/provider.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    var pVider = Provider.of<Userprovider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Account")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(pVider.user.profile),
              ),
              TextButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image == null) return;
                  final imagePath = File(image.path);

                  var request = http.MultipartRequest(
                    'POST',
                    Uri.parse("$USER_URL/changeProfile"),
                  );
                  request.files.add(
                    await http.MultipartFile.fromPath("file", imagePath.path),
                  );
                  request.headers["authorization"] = "Bearer ${Vary.token}";
                  var response = await request.send();
                  var responsed = await http.Response.fromStream(response);
                  var responseData = json.decode(responsed.body);
                  print(responseData);
                  Kpo.successToast(context, "Image Uploaded");
                },
                child: Text("Upload New Image"),
              ),
              SizedBox(height: 30),
              Text(pVider.user.name),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => pVider.nameChange(value),
                      decoration: InputDecoration(
                        labelText: "Name Change",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      bool isSuccess =
                          await Provider.of<Userprovider>(
                            context,
                            listen: false,
                          ).editName();
                      if (isSuccess) {
                        Kpo.successToast(context, "Name successfully changed!");
                      } else {
                        Kpo.errorToast(context, "Name change fail!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                    ),
                    child: Text("Change"),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => pVider.passwordChange(value),
                      decoration: InputDecoration(
                        labelText: "Password Change",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      bool isSuccess =
                          await Provider.of<Userprovider>(
                            context,
                            listen: false,
                          ).editPassword();
                      if (isSuccess) {
                        Kpo.successToast(
                          context,
                          "Password successfully changed!",
                        );
                        // exit(0);
                      } else {
                        Kpo.errorToast(context, "Password change fail!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                    ),
                    child: Text("Change"),
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
