import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:people_media/models/Cat.dart';
import 'package:people_media/providers/CatProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:provider/provider.dart';

class CatPage extends StatelessWidget {
  const CatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var pVider = Provider.of<CatProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pVider.invoke();
    });

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Categories")),
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
                        context.push('/catadd');
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
                children: List.generate(pVider.cats.length, (index) {
                  Cat cat = pVider.cats[index];
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

  _makeActionIcon(BuildContext context, CatProvider pVider, Cat cat) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.push("/catedit", extra: cat);
            },
            child: Icon(Icons.edit, color: Colors.greenAccent),
          ),
          GestureDetector(
            onTap: () async {
              bool success = await pVider.delete(cat.id);
              if (success) {
                Kpo.successToast(context, "Category Deleted");
              } else {
                Kpo.errorToast(context, "Category Delete Fail!");
              }
            },
            child: Icon(Icons.delete, color: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }
}
