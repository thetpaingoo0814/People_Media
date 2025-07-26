// This code is create by M23W7502_ThetPaingOo
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:people_media/models/Tag.dart';
import 'package:people_media/providers/TagProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:provider/provider.dart';

class TagPage extends StatelessWidget {
  const TagPage({super.key});

  @override
  Widget build(BuildContext context) {
    var pVider = Provider.of<TagProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pVider.invoke();
    });

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Tags")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
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
                        context.push('/tagadd');
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
                children: List.generate(pVider.tags.length, (index) {
                  Tag cat = pVider.tags[index];
                  return TableRow(
                    children: [
                      _makeDataText("${index + 1}"),
                      _makeDataText(cat.name),
                      _makeActionIcon(context, pVider, cat),
                    ],
                  );
                }),
              ),
            ],
          ),
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

  _makeActionIcon(BuildContext context, TagProvider pVider, Tag tag) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.push('/tagedit', extra: tag);
            },
            child: Icon(Icons.edit, color: Colors.greenAccent),
          ),
          GestureDetector(
            onTap: () async {
              bool success = await pVider.delete(tag.id);
              if (success) {
                Kpo.successToast(context, "Tag Deleted");
              } else {
                Kpo.errorToast(context, "Tag Delete Fail!");
              }
            },
            child: Icon(Icons.delete, color: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }
}
