import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:people_media/models/Post.dart';
import 'package:people_media/providers/PostProvider.dart';
import 'package:people_media/utils/DTime.dart';
import 'package:provider/provider.dart';
import '../providers/CatProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  List<String> images = [
    "assets/images/hello.jpg",
    "assets/images/car1.jpg",
    "assets/images/fashion.jpg",
    "assets/images/technology1.png",
    "assets/images/phone.png",
  ];

  String sampleText =
      """ဆွတ်လဲ့ဆိုရောင် ပန်းလက်ဆောင်ဟု ခွေးဟောင်ခေါ်မှတ် ကောကနတ်လျှင် ထပ်ထပ်ဖပ်ဖပ် သူ့ပွင့်ချက်ဖြင့် ပျက်ဝပ်ညောင်းငြိမ် ပန်းကောင်းဖိတ်လဲ """;

  @override
  void initState() {
    _tabController = TabController(
      length: Provider.of<CatProvider>(context, listen: false).cats.length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
        Provider.of<PostProvider>(context, listen: false).changeCat(
          Provider.of<CatProvider>(
            context,
            listen: false,
          ).cats[currentIndex].id,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pVider = Provider.of<PostProvider>(context);
    return Scaffold(
      body: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axisDirection == AxisDirection.down &&
              scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
            Provider.of<PostProvider>(context, listen: false).setIndex();
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 230,
              title: TabBar(
                isScrollable: true,
                controller: _tabController,
                dividerColor: Colors.transparent,
                tabs: List.generate(
                  Provider.of<CatProvider>(context).cats.length,
                  (index) {
                    return Tab(
                      text: Provider.of<CatProvider>(context).cats[index].name,
                    );
                  },
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(160),
                child: CarouselSlider(
                  items:
                      images.map((img) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(img),
                              ),
                            );
                          },
                        );
                      }).toList(),
                  options: CarouselOptions(
                    height: 160,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          Provider.of<CatProvider>(
                            context,
                          ).cats[currentIndex].name,
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: pVider.posts.length,
                (BuildContext context, index) =>
                    _makeNewsList(pVider.posts[index]),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("People Media"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Account Setting"),
              onTap: () {
                context.push("/setting");
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Categories"),
              onTap: () {
                context.push("/catpage");
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Tags"),
              onTap: () {
                context.push("/tagpage");
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Posts"),
              onTap: () {
                context.push("/postgen");
              },
            ),
          ],
        ),
      ),
    );
  }

  _makeNewsList(Post post) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.push("/post", extra: post.id);
            },
            child: SizedBox(
              width: 100,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(post.images[0]),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    post.content.length > 60
                        ? post.content.substring(0, 60)
                        : post.content,
                    style: GoogleFonts.padauk(fontSize: 12.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DTime.getDifferent(post.created),
                        style: GoogleFonts.alegreya(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        post.author,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 12.0,
                          color: const Color.fromARGB(255, 41, 40, 40),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
