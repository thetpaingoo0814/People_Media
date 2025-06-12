import 'package:flutter/material.dart';
import 'package:people_media/providers/TagProvider.dart';
import 'package:provider/provider.dart';

import '../../utils/Kop.dart';

class TagAdd extends StatefulWidget {
  const TagAdd({super.key});

  @override
  State<TagAdd> createState() => _TagAddState();
}

class _TagAddState extends State<TagAdd> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add New Tag")),
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
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool success = await Provider.of<TagProvider>(
                      context,
                      listen: false,
                    ).addTag(_nameController.text);
                    if (success) {
                      await Provider.of<TagProvider>(
                        context,
                        listen: false,
                      ).getAll();
                      Kpo.successToast(context, "Tag ထည့်တာ အောင်မြင်တယ်");
                      Navigator.pop(context);
                    } else {
                      Kpo.errorToast(context, "Tag ဖန်တီးတာ ပြဿနာရှိတယ်၊");
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
