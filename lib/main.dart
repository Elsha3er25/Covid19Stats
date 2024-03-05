import 'package:covid19stats/selectCountry.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'dart:math';

// The main function is the entry point of the application.
void main() => runApp(MyApp());

// The MyApp class is the main application widget.
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // The build method returns the widget tree for the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application title and theme settings.
      debugShowCheckedModeBanner: false,
      title: 'Covid19 Stats',
      theme: ThemeData(primarySwatch: Colors.red),
      // Home page set to MyHomePage.
      home: MyHomePage(),
    );
  }
}

// MyHomePage is the main screen of the application.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // The build method returns the widget tree for the home page.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// _MyHomePageState is the state class for MyHomePage.
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // Declare variables and objects for the state.
  final GlobalKey _refreshIndicatorKey = GlobalKey();
  var countryData = {
    "Global": [0, 0, 0, 0, 0, 0, 0, 0.0, true]
  };
  var chartsData = {};
  String country = "Global";

  int springAnimationDuration = 750;
  AnimationController _controller;
  List<Color> gradientColorsTotal = [
    Colors.grey[600],
    Colors.grey[800],
  ];
  List<Color> gradientColorsRecovered = [
    Colors.lightGreen,
    Colors.green[800],
  ];
  List<Color> gradientColorsDeaths = [
    Colors.orange[800],
    Colors.red,
  ];

  // Initialize the state.
  @override
  initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    chartsData["Global"] = [
      [
        ["0", "1"],
        [0, 1],
        gradientColorsTotal
      ],
      [
        ["0", "1"],
        [0, 1],
        gradientColorsRecovered
      ],
      [
        ["0", "1"],
        [0, 1],
        gradientColorsDeaths
      ],
      false,
      false,
      false
    ];

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (_refreshIndicatorKey.currentState as dynamic)?.show();
    });
  }

  // Helper functions for parsing and processing data.
  List parseRow(List<String> row, bool hasInnerTag, String link) {
    int offset = hasInnerTag ? 0 : -2;
    return [
      parseInteger(row[5 + offset]),
      parseInteger(row[7 + offset]),
      parseInteger(row[9 + offset]),
      parseInteger(row[11 + offset]),
      parseInteger(row[13 + offset]),
      parseInteger(row[15 + offset]),
      parseInteger(row[17 + offset]),
      parseDouble(row[19 + offset]),
      link
    ];
  }

  int parseInteger(String s) {
    try {
      return int.parse(s.split("<")[0].replaceAll(",", "").replaceAll("+", ""));
    } catch (e) {
      return 0;
    }
  }

  double parseDouble(String s) {
    try {
      return double.parse(s.split("<")[0].replaceAll(",", "").replaceAll("+", ""));
    } catch (e) {
      return 0;
    }
  }

  String getInnerString(String source, String a, String b) {
    return source.split(a)[1].split(b)[0];
  }

  String normalizeName(String n) {
    return n.replaceAll("&ccedil;", "ç").replaceAll("&eacute;", "é");
  }

  // Function to refresh data by making HTTP requests.
  Future<void> refreshData() async {
    String localCountry = country.toString();
    var url = 'https://www.worldometers.info/coronavirus/';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var row = response.body.split("<tr class=\"total_row\">")[1].split("</tr>")[0].split(">");

      countryData["Global"] = parseRow(row, true, "");

      var tbody = getInnerString(response.body, "<tbody>", "</tbody>");
      var rows = tbody.split("<tr style=\"\">");
      rows.skip(1).forEach((rawRow) {
        row = rawRow.split(">");
        bool hasInnerTag = rawRow.contains("</a>") || rawRow.contains("</span>");
        countryData[normalizeName(row[hasInnerTag ? 2 : 1].split("<")[0])] =
            parseRow(row, hasInnerTag, rawRow.contains("</a>") ? getInnerString(rawRow, "href=\"", "\"") : null);
      });

      setState(() {

