import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/themes.dart';
import '../Models/cryptocurrency.dart';
import '../Provider/market_provider.dart';
import '../Provider/theme_provider.dart';
import 'Graph.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoCurrency currentCrypto =
                  marketProvider.fetchCryptoById(widget.id);
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    Text(
                      currentCrypto.name!,
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        child: Image.network(
                          currentCrypto.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      currentCrypto.symbol!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "INR ${currentCrypto.currentPrice!.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 20, 99, 163),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Builder(
                      builder: (context) {
                        double priceChange = currentCrypto.priceChange24H!;
                        double priceChangePercentage = currentCrypto.priceChangePercentage24H!;
                        if (priceChange < 0) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${priceChangePercentage.toStringAsFixed(2)}%",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                                const Icon(
                                  Icons.arrow_downward_rounded,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                Text(
                                  "INR ${priceChange.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "+${priceChangePercentage.toStringAsFixed(2)}%",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 18),
                                ),
                                const Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                Text(
                                  "INR ${priceChange.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 18),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration:
                              (themeProvider.themeMode == ThemeMode.light)
                                  ? BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius:
                                              15, // changes position of shadow
                                        ),
                                      ],
                                    )
                                  : const BoxDecoration(),
                          margin: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height - 450,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                    left: 10,
                                    right: 10,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    "Fundamental Analysis",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                showAnalysis(
                                    "HIGH", currentCrypto.high24H.toString()),
                                showAnalysis(
                                    "LOW", currentCrypto.low24H.toString()),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width - 80,
                                  height: 1,
                                  color: darkTheme.scaffoldBackgroundColor,
                                ),
                                showAnalysis("Market Cap Rank",
                                    currentCrypto.marketCapRank.toString()),
                                showAnalysis("Market Cap",
                                    currentCrypto.marketCap.toString()),
                                showAnalysis("Circulating Supply",
                                    currentCrypto.circulatingSupply.toString()),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GraphView(id: currentCrypto.id!),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.indigoAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: const  Text(
                                      "View Graph",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget showAnalysis(String analysisName, String analysisValue) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            analysisName,
            style: const TextStyle(fontSize: 15),
          ),
          Text("INR $analysisValue"),
        ],
      ),
    );
  }
}

// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// import '../Models/GraphPoint.dart';
// import '../Models/cryptocurrency.dart';
// import '../Provider/graph_provider.dart';
// import '../Provider/market_provider.dart';
//
// class DetailsPage extends StatefulWidget {
//   final String id;
//
//   const DetailsPage({Key? key, required this.id}) : super(key: key);
//
//   @override
//   _DetailsPageState createState() => _DetailsPageState();
// }
//
// class _DetailsPageState extends State<DetailsPage> {
//   Widget titleAndDetail(
//       String title, String detail, CrossAxisAlignment crossAxisAlignment) {
//     return Column(
//       crossAxisAlignment: crossAxisAlignment,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//         ),
//         Text(
//           detail,
//           style: TextStyle(fontSize: 17),
//         ),
//       ],
//     );
//   }
//
//   late GraphProvider graphProvider;
//
//   int days = 1;
//   List<bool> isSelected = [true, false, false, false];
//
//   void toggleDate(int index) async {
//     log("Loading....");
//
//     for (int i = 0; i < isSelected.length; i++) {
//       if (i == index) {
//         isSelected[i] = true;
//         log(isSelected.toString());
//       } else {
//         isSelected[i] = false;
//         log(isSelected.toString());
//       }
//     }
//
//     switch (index) {
//       case 0:
//         days = 1;
//         break;
//       case 1:
//         days = 7;
//         break;
//       case 2:
//         days = 28;
//         break;
//       case 3:
//         days = 90;
//         break;
//       default:
//         break;
//     }
//
//     await graphProvider.initializeGraph(widget.id, days);
//
//     setState(() {});
//
//     log("Graph Loaded!");
//   }
//
//   void initializeInitialGraph() async {
//     log("Loading Graph...");
//
//     await graphProvider.initializeGraph(widget.id, days);
//     setState(() {});
//
//     log("Graph Loaded!");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     graphProvider = Provider.of<GraphProvider>(context, listen: false);
//     initializeInitialGraph();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//
//         appBar: AppBar(
//
//         ),
//         body: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(
//               left: 20,
//               right: 20,
//             ),
//             child: ListView(
//
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: ToggleButtons(
//                     borderRadius: BorderRadius.circular(10),
//                     onPressed: (index) {
//                       toggleDate(index);
//                     },
//                     children: [
//                       Text("1D"),
//                       Text("7D"),
//                       Text("28D"),
//                       Text("90D"),
//                     ],
//                     isSelected: isSelected,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 300,
//                   child: SfCartesianChart(
//                     primaryXAxis: DateTimeAxis(),
//                     series: <AreaSeries>[
//                       AreaSeries<GraphPoint, dynamic>(
//                           color: Color(0xff1ab7c3).withOpacity(0.5),
//                           borderColor: Color(0xff1ab7c3),
//                           borderWidth: 2,
//                           dataSource: graphProvider.graphPoints,
//                           xValueMapper: (GraphPoint graphPoint, index) =>
//                           graphPoint.date,
//                           yValueMapper: (GraphPoint graphpoint, index) =>
//                           graphpoint.price),
//                     ],
//                   ),
//                 ),
//                 Consumer<MarketProvider>(
//                   builder: (context, marketProvider, child) {
//                     CryptoCurrency currentCrypto =
//                     marketProvider.fetchCryptoById(widget.id);
//
//                     return ListView(
//
//
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       children: [
//                         ListTile(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//                           contentPadding: EdgeInsets.all(10),
//                           tileColor: Color.fromARGB(19, 92, 92, 92),
//
//
//                           leading: (
//                               ClipOval(
//                                 child: Image.network(currentCrypto.image!),
//
//
//                               )
//                           ),
//                           title: Text(
//                             currentCrypto.name! +
//                                 " (${currentCrypto.symbol!.toUpperCase()})",
//                             style: TextStyle(
//                               fontSize: 30,
//                             ),
//                           ),
//                           subtitle: Text(
//                             "₹ " +
//                                 currentCrypto.currentPrice!.toStringAsFixed(4),
//                             style: TextStyle(
//                                 color: Color(0xff0395eb),
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Column(
//
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Price Change (24h)",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20 ,),
//                             ),
//                             Builder(
//                               builder: (context) {
//                                 double priceChange =
//                                 currentCrypto.priceChange24H!;
//                                 double priceChangePercentage =
//                                 currentCrypto.priceChangePercentage24H!;
//
//                                 if (priceChange < 0) {
//                                   // negative
//                                   return Text(
//                                     "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
//                                     style: TextStyle(
//                                         color: Colors.red, fontSize: 23),
//                                   );
//                                 } else {
//                                   // positive
//                                   return Text(
//                                     "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
//                                     style: TextStyle(
//                                         color: Colors.green, fontSize: 23),
//                                   );
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             titleAndDetail(
//                                 "Market Cap",
//                                 "₹ " +
//                                     currentCrypto.marketCap!.toStringAsFixed(4),
//                                 CrossAxisAlignment.start),
//                             titleAndDetail(
//                                 "Market Cap Rank",
//                                 "#" + currentCrypto.marketCapRank.toString(),
//                                 CrossAxisAlignment.end),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             titleAndDetail(
//                                 "Low 24h",
//                                 "₹ " + currentCrypto.low24H!.toStringAsFixed(4),
//                                 CrossAxisAlignment.start),
//                             titleAndDetail(
//                                 "High 24h",
//                                 "₹ " + currentCrypto.high24H!.toStringAsFixed(4),
//                                 CrossAxisAlignment.end),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             titleAndDetail(
//                                 "Circulating Supply",
//                                 currentCrypto.circulatingSupply!
//                                     .toInt()
//                                     .toString(),
//                                 CrossAxisAlignment.start),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             titleAndDetail(
//                                 "All Time Low",
//                                 currentCrypto.atl!.toStringAsFixed(4),
//                                 CrossAxisAlignment.start),
//                             titleAndDetail(
//                                 "All Time High",
//                                 currentCrypto.ath!.toStringAsFixed(4),
//                                 CrossAxisAlignment.start),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
