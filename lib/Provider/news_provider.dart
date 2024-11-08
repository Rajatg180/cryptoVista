import 'package:cryptotracker/Models/api.dart';
import 'package:cryptotracker/Models/news.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier{

  NewsProvider(){

    fetchData();

  }

  bool isLoading = true ;

  List<News> news=[];

  Future<void> fetchData()async{

    List<dynamic> _news = await API.fetchNewsData();

    List<News> temp=[];

    for(var news in _news){

      News newNews = News.fromJson(news);

      temp.add(newNews);
      
    }

    news=temp;

    isLoading=false;

    notifyListeners();

  }

}