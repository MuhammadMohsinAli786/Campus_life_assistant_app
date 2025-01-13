import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/loginProvider.dart';
import '../utils/methods.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  late List datas;
  bool error = false;
  bool loading = false;
  List months = [];

  // Load data asynchronously
  Future<void> loadData() async {
    try {
      final res = await context.read<LoginProvider>().getdatewiseattendance();
      datas = res;
      getMonthsArray(res);
      setState(() {
        error = false;
        loading = false;
      });
    } catch (err) {
      setState(() {
        error = true;
        loading = false;
      });
    }
  }

  // Extract months from data
  void getMonthsArray(List data) {
    months.clear(); // Reset months list
    for (var entry in data) {
      String date = entry['date'];
      date = date.split(' ')[1]; // Extract the month from the date
      if (!months.contains(date)) {
        months.add(date);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Hero(
        tag: 'graph',
        child: Scaffold(
          appBar: AppBar(title: const Text('Analysis by Graph')),
          body: const Center(
            child: SpinKitCircle(
              color: Colors.blue,
              size: 50,
            ),
          ),
        ),
      );
    }

    return Hero(
      tag: 'graph',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ThemeData.dark().primaryColor,
          appBar: AppBar(
            title: const Text('Analysis by Graph'),
          ),
          body: error
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                      const Text('Some Error Occurred'),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            loading = true;
                            error = false;
                          });
                          loadData();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 100),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        color: Color(0xff232d37),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 18.0,
                          left: 12.0,
                          top: 24,
                          bottom: 12,
                        ),
                        child: LineChart(mainData()),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // Define the main chart data
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      // titlesData: FlTitlesData(
      //   show: true,
      //   bottomTitles: SideTitles(
      //     showTitles: true,
      //     reservedSize: 22,
      //     textStyle: const TextStyle(
      //       color: Color(0xff68737d),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 16,
      //     ),
      //     getTitles: (value) => months[value.toInt()],
      //     margin: 8,
      //   ),
      //   leftTitles: SideTitles(
      //     showTitles: true,
      //     textStyle: const TextStyle(
      //       color: Color(0xff67727d),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //     getTitles: (value) {
      //       int rem = value.toInt() % 25;
      //       return rem == 0 ? value.toString() : '';
      //     },
      //     reservedSize: 28,
      //     margin: 12,
      //   ),
      // ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: (months.length - 1).toDouble(),
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            datas.length,
            (int index) => FlSpot(
              map(
                inputlo: 0,
                inputhi: datas.length.toDouble(),
                outputlo: 0,
                outputhi: months.length.toDouble() - 1,
                val: index.toDouble(),
              ),
              datas[index]['percentage'],
            ),
          ),
          isCurved: true,
          color: Colors.black,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, color: Colors.amber),
        ),
      ],
    );
  }
}
