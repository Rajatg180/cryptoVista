import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Models/GraphPoint.dart';
import '../Models/cryptocurrency.dart';
import '../Provider/graph_provider.dart';
import '../Provider/market_provider.dart';

class GraphView extends StatefulWidget {
  final String id;
  const GraphView({super.key, required this.id});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  late GraphProvider graphProvider;
  bool isLoading = true;

  int days = 1;
  List<bool> isSelected = [true, false, false, false];

  void toggleDate(int index) async {
    setState(() {
      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
        if (buttonIndex == index) {
          isSelected[buttonIndex] = true;
        } else {
          isSelected[buttonIndex] = false;
        }
      }
      isLoading = true;
    });

    switch (index) {
      case 0:
        days = 1;
        break;
      case 1:
        days = 7;
        break;
      case 2:
        days = 28;
        break;
      case 3:
        days = 90;
        break;
      default:
        break;
    }

    await graphProvider.initializeGraph(widget.id, days);

    setState(() {
      isLoading = false;
    });
    
  }

  void initializeInitialGraph() async {
    await graphProvider.initializeGraph(widget.id, days);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    graphProvider = Provider.of<GraphProvider>(context, listen: false);
    initializeInitialGraph();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(
              children: [
                Consumer<MarketProvider>(
                  builder: (context, marketProvider, child) {
                    CryptoCurrency currentCrypto = marketProvider.fetchCryptoById(widget.id);
                    return Column(
                      children: [
                        Text(
                          currentCrypto.name!,
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 20),
                        Text(
                          currentCrypto.symbol!.toUpperCase(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (index) {
                      toggleDate(index);
                    },
                    isSelected: isSelected,
                    fillColor: Colors.blue, // Add this line
                    selectedColor: Colors.white, // And this line
                    children: const [
                      Text("1D"),
                      Text("7D"),
                      Text("28D"),
                      Text("90D"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(),
                          series: <AreaSeries>[
                            AreaSeries<GraphPoint, dynamic>(
                                color: Color(0xff1ab7c3).withOpacity(0.5),
                                borderColor: Color(0xff1ab7c3),
                                borderWidth: 2,
                                dataSource: graphProvider.graphPoints,
                                xValueMapper: (GraphPoint graphPoint, index) =>
                                    graphPoint.date,
                                yValueMapper: (GraphPoint graphpoint, index) =>
                                    graphpoint.price),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
