import 'package:cryptotracker/Models/cryptocurrency.dart';
import 'package:cryptotracker/Provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/details_page.dart';

class CryptoListTile extends StatefulWidget {

  final CryptoCurrency currentCrypto;

  const CryptoListTile({super.key,required this.currentCrypto});

  @override
  State<CryptoListTile> createState() => _CryptoListTileState();
}

class _CryptoListTileState extends State<CryptoListTile> {

  @override
  Widget build(BuildContext context) {

    MarketProvider marketProvider= Provider.of<MarketProvider>(context,listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailsPage(id: widget.currentCrypto.id!),
          ),
        );
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(widget.currentCrypto.image!),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Flexible(
            child:Text(
              "${widget.currentCrypto.name!}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          (widget.currentCrypto.isFavourite==false) ? GestureDetector(
            onTap: () {
              marketProvider.addFavorites(widget.currentCrypto);
            },
            child: const Icon(
              CupertinoIcons.heart,
              size: 20,
            ),
          ) : GestureDetector(
            onTap: () {
              marketProvider.removeFavorites(widget.currentCrypto);
            },
            child: const Icon(
              CupertinoIcons.heart_fill,
              size: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
      subtitle: Text(widget.currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ " + widget.currentCrypto.currentPrice!.toStringAsFixed(4),
            style: const TextStyle(
              color: Color(0xff0395eb),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          //   taking builder because we want to show price change in different color in green and red
          Builder(
            builder: (context) {
              double priceChange = widget.currentCrypto.priceChange24H!;
              double priceChangePercentage =
              widget.currentCrypto.priceChangePercentage24H!;

              if (priceChange < 0) {
                return Text(
                  "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                );
              } else {
                return Text(
                  "+" +
                      "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
