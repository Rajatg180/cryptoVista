import 'dart:async';
import 'package:cryptotracker/Models/local_storage.dart';
import 'package:flutter/material.dart';
import '../Models/api.dart';
import '../Models/cryptocurrency.dart';

class MarketProvider with ChangeNotifier{

    MarketProvider(){
        // when we create the instance of MarketProvider it will fetch the data
        fetchData();
    }

    bool isLoading = true ;

    List<CryptoCurrency> markets=[];

    Future<void> fetchData()async{

        List<dynamic> _markets = await API.getMarkets();
        // List<dynamic> _markets = await API.fetchNewsData();

        List<String> favorites=await LocalStorage.fetchFavorites();

        List<CryptoCurrency> temp=[];

        for(var market in _markets){
            CryptoCurrency newCrypto = CryptoCurrency.fromJson(market);

            if(favorites.contains(newCrypto.id!)){
                newCrypto.isFavourite = true;
            }
            temp.add(newCrypto);
        }

        markets=temp;
        isLoading=false;
        notifyListeners();

    //     calling fetchData() after every 3 second to load the updated data
    //     Timer(const Duration(seconds: 3), () {
    //       fetchData();
    //     });

    }

    // for detail page getting the crypto details for single id
    CryptoCurrency fetchCryptoById(String id) {
        // return the match id
        CryptoCurrency crypto = markets.where((element)=>element.id==id).toList()[0];

        return crypto;
    }

    void addFavorites(CryptoCurrency crypto) async{
        int indexOfCrypto = markets.indexOf(crypto);
        markets[indexOfCrypto].isFavourite=true;
        await LocalStorage.addFavorite(crypto.id!);
        notifyListeners();
    }

    void removeFavorites(CryptoCurrency crypto)async{
        int indexOfCrypto = markets.indexOf(crypto);
        markets[indexOfCrypto].isFavourite=false;
        await LocalStorage.removeFavorite(crypto.id!);
        notifyListeners();
    }


}