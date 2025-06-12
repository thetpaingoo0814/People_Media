import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Comments")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
                CommentTile(
                  name: "Zatoitchi",
                  time: "4:30 PM",
                  comment:
                      "မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။",
                  avatar: "assets/images/logo.png",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write a comment",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      // fillColor: Colors.grey
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send, color: Colors.deepOrangeAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final String name;
  final String time;
  final String comment;
  final String avatar;

  const CommentTile({
    super.key,
    required this.name,
    required this.time,
    required this.comment,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundImage: AssetImage(avatar), radius: 30),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Thu Khant Aung",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text("4:50 PM"),
                    ],
                  ),
                  SizedBox(height: 5),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                      text: comment,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Reply",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
