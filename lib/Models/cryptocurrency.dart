class CryptoCurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  int? marketCap;
  int? marketCapRank;
  double? totalVolume;
  double? high24H;
  double? low24H;
  double? priceChange24H;
  double? priceChangePercentage24H;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool isFavourite = false;
  String? volume;

  CryptoCurrency({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.totalVolume,
    this.high24H,
    this.low24H,
    this.priceChange24H,
    this.priceChangePercentage24H,
    this.circulatingSupply,
    this.ath,
    this.atl
  });

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        currentPrice: double.parse(json["current_price"].toString()),
        marketCap: json["market_cap"],
        marketCapRank: json["market_cap_rank"],
        high24H: double.parse(json["high_24h"].toString()),
        low24H: double.parse(json["low_24h"].toString()),
        priceChange24H: double.parse(json["price_change_24h"].toString()),
        priceChangePercentage24H:
        double.parse(json["price_change_percentage_24h"].toString()),
        circulatingSupply: double.parse(json["circulating_supply"].toString()),
        ath: double.parse(json["ath"].toString()),
        atl: double.parse(json["atl"].toString()));
  }

//   toJson() when we need to save data to firebase

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> _data = <String, dynamic>{};
//   _data["id"] = id;
//   _data["symbol"] = symbol;
//   _data["name"] = name;
//   _data["image"] = image;
//   _data["current_price"] = currentPrice;
//   _data["market_cap"] = marketCap;
//   _data["market_cap_rank"] = marketCapRank;
//   _data["fully_diluted_valuation"] = fullyDilutedValuation;
//   _data["total_volume"] = totalVolume;
//   _data["high_24h"] = high24H;
//   _data["low_24h"] = low24H;
//   _data["price_change_24h"] = priceChange24H;
//   _data["price_change_percentage_24h"] = priceChangePercentage24H;
//   _data["market_cap_change_24h"] = marketCapChange24H;
//   _data["market_cap_change_percentage_24h"] = marketCapChangePercentage24H;
//   _data["circulating_supply"] = circulatingSupply;
//   _data["total_supply"] = totalSupply;
//   _data["max_supply"] = maxSupply;
//   _data["ath"] = ath;
//   _data["ath_change_percentage"] = athChangePercentage;
//   _data["ath_date"] = athDate;
//   _data["atl"] = atl;
//   _data["atl_change_percentage"] = atlChangePercentage;
//   _data["atl_date"] = atlDate;
//   _data["roi"] = roi;
//   _data["last_updated"] = lastUpdated;
//   return _data;
// }


}