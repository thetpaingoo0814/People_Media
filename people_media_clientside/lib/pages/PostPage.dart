import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:people_media/models/Comment.dart';
import 'package:people_media/providers/CommentProvider.dart';
import 'package:people_media/providers/PostProvider.dart';
import 'package:people_media/providers/UserProvider.dart';
import 'package:people_media/utils/Kop.dart';
import 'package:people_media/utils/Routes.dart';
import 'package:people_media/utils/Vary.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../utils/DTime.dart';

class PostPage extends StatefulWidget {
  final String id;
  const PostPage({super.key, required this.id});

  @override
  State<PostPage> createState() => _PostPageState(id: id);
}

class _PostPageState extends State<PostPage> {
  String id;
  _PostPageState({required this.id});
  List<String> images = [
    "assets/images/Flutter-Static.png",
    "assets/images/Java-Static.png",
    "assets/images/Node-Static.png",
    "assets/images/PHP-Static.png",
    "assets/images/Python-Static.png",
  ];
  bool isFile = false;
  late File file;
  bool isShowComment = false;
  final TextEditingController _commentController = TextEditingController();

  final String para0 =
      """မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။ မြန်မာနိုင်ငံ စတင်တည်ထောင်စဉ်ကာလ အနော်ရထာမင်း၏ လက်ထက်တွင် သက္ကတဘာသာစာဖြင့် ရေးသောအုတ်ခွက်စာများ။""";
  final String para1 =
      """မြန်မာစာစတင်ဖြစ်ပေါ်လာခြင်းသည် မြန်မာသည် ပျူနှင့်မွန်စာရေးနည်းကို စံတင်ပြီး (၁၂)ရာစုတွင် မြန်မာဘာသာ ပေါ်ထွန်းလာခဲ့ခြင်းဖြစ်သည်။ မြန်မာနိုင်ငံ စတင်တည်ထောင်စဉ်ကာလ အနော်ရထာမင်း၏ လက်ထက်တွင် သက္ကတဘာသာစာဖြင့် ရေးသောအုတ်ခွက်စာများ၊ ပါဠိစာများဖြင့်ရေးသော အုတ်ခွက်စာများကို အထောက်အထားပြုကာ မြန်မာ့တို့သည် မူလက ပါဠိနှင့် သက္ကတဘာသာတို့ကို ရင်းနှီးခဲ့ကြောင်း သိရသည်။ သက္ကတဘာသာသည် မဟာယာန ဗုဒ္ဓဘာသာနှင့် ဆက်နွယ်ပြီး ပါဠိဘာသာသည် ထေရဝါဒဗုဒ္ဓဘာသာနှင့် နှီးနွယ်ကြောင်းသိရသည်။""";
  final String para2 =
      """မြန်မာတို့သည် တိုင်းခြားဘာသာဖြစ်သော ပါဠိစာကိုဗုဒ္ဓဘာသာစာပေအဖြစ် လက်ခံလာချိန်တွင် မြန်မာတိုင်းရင်းသားများ၏ စာပေဖြစ်သော ပျူစာ၊ မွန်စာတို့သည် ရှင်သန်နှင့် နေပြီးဖြစ်ကြောင်း သိရသည်။ မြန်မာစာပေါ်ပေါက်လာသော အခါတွင် မြန်မာတို့သည် မြန်မာစာနှင့်အတူ တိုင်းရင်း ပျူ၊ မွန်စာပေတို့ကိုလည်း ဆက်လက်ပြုစုလာခဲ့ကြပြီး ခရစ်နှစ်(၁၁၁၃)ခုနှစ် တွင် ရာဇကုမာရ်မင်းသား ရေးထိုးသော မြစေတီ ကျောက်စာတွင် ပျူ၊ မွန်၊ မြန်မာဘာသာ တို့ကို ပါဠိစာပေနှင့် အတူ ယှဉ်တွဲ တွေ့ရှိရသည်။ ပါဠိစာပေမှ မြန်မာစာပေသို့ အပြန်အလှန် ဘာသာပြန် အရေးအသားနှင့် ပါဠိဘာသာပြန်ရေးသည့် အရေးအသားများ ထွန်းကားလာခဲ့ပြီး (၁၁)ရာစု အနော်ရထာမင်း လက်ထက်တွင် ထေရဝါဒဗုဒ္ဓသာသနာနှင့် အတူ ပိဋိကတ်စာပေများ ပုဂံသို့ရောက်ရှိလာပြီးနောက်တွင် (၁၁) ရာစု နှောင်းပိုင်းတွင် မြန်မာစာ စတင် ပေါ်ပေါက် ထွန်းကားခဲ့ကြောင်း သမိုင်းအထောက်အထားများက ပြဆိုထားသည်။""";
  final String para3 =
      """မြန်မာစာ ပေါ်ပေါက်လာပုံကို ပုဂံခေတ် ကျန်စစ်သားမင်း နတ်ရွာစံပြီး ခရစ်နှစ် (၁၁၁၃) ခန့်တွင် ရေးထိုးသော ရာဇကုမာရ်ကျောက်စာသည် သက္ကရာဇ် အခိုင်အမာ ပါသော အစောဆုံး မြန်မာစာ ဖြစ်ကြောင်းသိရသည်။ မြန်မာစာစတင် ဖော်ပြရာတွင် ဗုဒ္ဓစာပေများကို ကျောက်စာ၊ မှင်စာများဖြင့် ဇာတ်နိပါတ်၊ ပန်းချီ၊ ပန်းပု များနှင့် အတူ မှင်ဖြင့် ဖော်ပြကြပြီး ကျောက်စာများ ၊ မှင်စာများ စတင် ပေါ်ပေါက်လာခဲ့ရကြောင်း သိရသည်။ နောက်ပိုင်းတွင် ဗုဒ္ဓစာပေ အကြောင်းအရာများကို စကားပြေဖြင့်လည်းကောင်း ကဗျာများဖြင့်လည်းကောင်း ဖွဲ့နွဲလာကြပြီး ဗုဒ္ဓစာပေကို အခြေခံကာ မြန်မာစာပေ အရေးအဖွဲ့ အမျိုးမျိုး ပေါ်ထွန်းလာရကြောင်းသိရသည်။ ပါဠိ၊ ပျူ၊ မွန်၊ မြန်မာ ဟူသော ဘာသာစကားတို့မှ စကားလုံးများကို မွေးစား သုံးနှုန်းခြင်း၊ ဘာသာပြန်သုံးနှုန်းခြင်းတို့ဖြင့် မြန်မာစကား နှင့် စာပေ ဖွံ့ဖြိုးကြွယ်ဝ လာခဲ့ သည်ဟု ဆိုကြသည်။ ပင်းယခေတ် (၁၃၀၉ ခုနှစ် ခန့် မှ ၁၃၆၀) နှင့် အင်းဝခေတ် (၁၃၆၄ မှ ၁၄၈၆) တစ်လျောက်လုံးတွင် မြန်မာတို့သည် ဗုဒ္ဓစာပေအမွေအနှစ်များကို ပါဠိဘာသာမှ တစ်ဆင့် ဘာသာပြန်ပြုစုလာခဲ့ကြပြီး မြန်မာစာပေအနေနှင့် အရေးအသား အသုံးအနှုန်းများ ခိုင်မြဲစွာ အမြစ်တွယ် ထွန်းကားနေပြီ ဖြစ်သည်။""";
  final String titleString =
      "သတင်းခေါင်းစဥ်သည် ဤနေရာတွင် ဖြစ်ပေါ်မည်ဖြစ်၍ သတင်းဖတ်သူများ အနေနှင့် ခေါင်းစဥ်ကို";
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false).getById(id);
      Provider.of<CommentProvider>(context, listen: false).getComments(id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vider = Provider.of<PostProvider>(context);
    var cVider = Provider.of<CommentProvider>(context);
    return Scaffold(
      body:
          vider.isLoading
              ? SizedBox()
              : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    // toolbarHeight: 0,
                    pinned: false,
                    floating: false,
                    expandedHeight: 200,
                    flexibleSpace: Image.network(
                      vider.post.images[0],
                      fit: BoxFit.contain,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  bool success =
                                      await Provider.of<CommentProvider>(
                                        context,
                                        listen: false,
                                      ).addPostLike(id);
                                  if (success) {
                                    await Provider.of<CommentProvider>(
                                      context,
                                      listen: false,
                                    ).getComments(id);
                                    await Provider.of<PostProvider>(
                                      context,
                                      listen: false,
                                    ).getById(id);
                                    Kpo.successToast(
                                      context,
                                      "Like လုပ်တာအောင်တယ်",
                                    );
                                  } else {
                                    Kpo.errorToast(
                                      context,
                                      "Like လုပ်တာ မအောင်ဘူး",
                                    );
                                  }
                                },
                                child: Icon(
                                  Icons.heart_broken,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                              Text(
                                "${cVider.comments.length} Comments",
                                style: GoogleFonts.patuaOne(fontSize: 12.0),
                              ),
                              Text(
                                "${vider.post.likes} likes",
                                style: GoogleFonts.patuaOne(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DTime.getDifferent(vider.post.created),
                                style: GoogleFonts.patuaOne(
                                  fontSize: 12.0,
                                  color: const Color.fromARGB(255, 39, 39, 39),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                height: 20,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Switch(
                                    value: isShowComment,
                                    onChanged: (v) {
                                      setState(() {
                                        isShowComment = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                vider.post.author,
                                style: GoogleFonts.patuaOne(
                                  fontSize: 12.0,
                                  color: const Color.fromARGB(255, 39, 39, 39),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  isShowComment
                      ? SliverToBoxAdapter(child: SizedBox())
                      : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SelectableText.rich(
                                    style: GoogleFonts.padauk(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextSpan(text: vider.post.title),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  isShowComment
                      ? SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 330,
                              child: ListView.builder(
                                itemCount: cVider.comments.length,
                                itemBuilder:
                                    (context, index) =>
                                        _makeComment(cVider.comments[index]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final image = await picker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (image == null) {
                                        return;
                                      } else {
                                        file = File(image.path);
                                        isFile = true;
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(Icons.upload),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _commentController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (isFile) {
                                        var request = http.MultipartRequest(
                                          'POST',
                                          Uri.parse("$API_URL/cmmt"),
                                        );
                                        request.fields["postId"] =
                                            vider.post.id;
                                        request.fields["content"] =
                                            _commentController.text;
                                        request.files.add(
                                          await http.MultipartFile.fromPath(
                                            'file',
                                            file.path,
                                          ),
                                        );
                                        request.headers['authorization'] =
                                            'bearer ${Provider.of<Userprovider>(context, listen: false).token}';
                                        var response = await request.send();
                                        var responsed = await http
                                            .Response.fromStream(response);
                                        final responseData = json.decode(
                                          responsed.body,
                                        );
                                        Vary.msg = responseData;
                                        Kpo.successToast(
                                          context,
                                          "Comment တင်တာအောင်မြင်ပါတယ်၊",
                                        );
                                      } else {
                                        bool success =
                                            await Provider.of<CommentProvider>(
                                              context,
                                              listen: false,
                                            ).addComment(
                                              vider.post.id,
                                              _commentController.text,
                                            );
                                        if (success) {
                                          await Provider.of<CommentProvider>(
                                            context,
                                            listen: false,
                                          ).getComments(vider.post.id);
                                          Kpo.successToast(
                                            context,
                                            "Comment တင်တာ အောင်မြင်ပါတယ်၊",
                                          );
                                        } else {
                                          Kpo.errorToast(
                                            context,
                                            "Comment တင်တာမအောင်ဘူး",
                                          );
                                        }
                                      }
                                    },
                                    child: Icon(Icons.send),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  _makeRichText(vider.post.content),
                                  // SizedBox(height: 20),
                                  // _makeRichText(para2),
                                  // SizedBox(height: 20),
                                  // _makeRichText(para3),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
    );
  }

  _makeRichText(String text) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12.0),
        children: [
          WidgetSpan(child: SizedBox(width: 30.0)),
          TextSpan(text: text),
        ],
      ),
    );
  }

  _makeComment(Comment comment) {
    return comment.image == ""
        ? _makeNoImageComment(comment)
        : Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(height: 50, child: Image.network(comment.image)),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(comment.content),
                      ),
                      // _makeRichText(para0),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DTime.getDifferent(comment.created)),
                          Text(comment.user),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }

  _makeNoImageComment(Comment comment) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft, child: Text(comment.content)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DTime.getDifferent(comment.created)),
                Text(comment.user),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
