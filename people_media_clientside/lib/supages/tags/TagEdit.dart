import 'package:flutter/material.dart';
import 'package:people_media/models/Tag.dart';
import 'package:people_media/providers/TagProvider.dart';
import 'package:provider/provider.dart';

import '../../utils/Kop.dart';

class TagEdit extends StatefulWidget {
  final Tag tag;
  const TagEdit({super.key, required this.tag});

  @override
  State<TagEdit> createState() => _TagEditState(tag: tag);
}

class _TagEditState extends State<TagEdit> {
  Tag tag;
  _TagEditState({required this.tag});
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = tag.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Edit Tag")),
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
                    ).update(tag.id, _nameController.text);
                    if (success) {
                      await Provider.of<TagProvider>(
                        context,
                        listen: false,
                      ).getAll();
                      Kpo.successToast(context, "Tag Edit လုပ်တာ အောင်မြင်တယ်");
                      Navigator.pop(context);
                    } else {
                      Kpo.errorToast(context, "Tag Edit လုပ်တာ ပြဿနာရှိတယ်၊");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text("Update", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
