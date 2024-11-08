// import 'dart:ffi';

import 'package:cryptotracker/Widgets/listtile.ddart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/cryptocurrency.dart';
import '../Provider/market_provider.dart';
import 'details_page.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              // onRefresh: () async {
              //   await marketProvider.fetchData();
              // },
              // to avoid the limit of api i have stop refresh 
              onRefresh: ()async{

              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  // get the current index crypto
                  CryptoCurrency currentCrypto = marketProvider.markets[index];
                  return CryptoListTile(currentCrypto: currentCrypto);
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
