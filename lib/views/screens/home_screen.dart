import 'package:flutter/material.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsController newsController = NewsController();
  TextEditingController newController = TextEditingController();

  Future<void> launchLinks(String link,
      {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link), mode: launchMode);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newController.text = prefs.getString('news') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "News",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TextField(
                onSubmitted: (value) {
                  setState(() {});
                },
                controller: newController,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        )),
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: newsController.getInformation(newController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    // ignore: avoid_print
                    print(snapshot.error);
                    return const Center(child: Text("Ma'lumot mavjud emas"));
                  }
                  if (snapshot.data == null) {
                    // ignore: avoid_print
                    print("aa");
                    return const Center(child: Text("Ma'lumot mavjud emas"));
                  }
                  final List<News> news = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () async {
                            await launchLinks(news[index].url);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      news[index].urlToImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    news[index].title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Author: ${news[index].author}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                          "Published At: ${news[index].publishedAt.toString().split(' ')[0]}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 20),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// TextField(
//               decoration: InputDecoration(
//                   labelText: "Search",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25))),
//             ),