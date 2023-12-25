import 'package:cryptotracker/Provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/theme_provider.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsPageState();
}

class _NewsPageState extends State<News> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Consumer<NewsProvider>(
      builder: (context, newProvider, child) {
        if (newProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (newProvider.news.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await newProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: newProvider.news.length,
                itemBuilder: (context, index) {
                  var currentNews = newProvider.news[index];
                  return Container(
                    decoration: (themeProvider.themeMode == ThemeMode.light)
                        ? BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 8, // changes position of shadow
                              ),
                            ],
                          )
                        : const BoxDecoration(),
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        width: double.infinity,
                        // margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.all(12.0),
                        height: MediaQuery.of(context).size.height*0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Hero(
                                tag: currentNews.publishedAt.toString(),
                                child: Container(
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: (currentNews.urlToImage == null)
                                          ? const NetworkImage(
                                              'https://picsum.photos/250?image=9')
                                          : NetworkImage(currentNews.urlToImage
                                              .toString()),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentNews.title.toString() ?? "No Title",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    currentNews.description.toString() ??
                                        "No Description",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    currentNews.publishedAt.toString() ??
                                        "No Date Published",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text("Data not found!"),
            );
          }
        }
      },
    );
  }
}
