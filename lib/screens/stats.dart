// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
//
import 'dart:math';

import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FancyLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  FancyLineChart(this.seriesList, {this.animate});

  /// Creates a [FancyLineChart] with sample data and no transition.
  factory FancyLineChart.withSampleData() {
    return new FancyLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory FancyLineChart.withRandomData() {
    return new FancyLineChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        displayName: "SALES",
        overlaySeries: true,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 100,

      borderOnForeground: true,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "SALES",
                //style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          LimitedBox(
              maxHeight: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: charts.LineChart(
                  seriesList,
                  animate: animate,
                ),
              )),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChart.withSampleData() {
    return new DonutAutoLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory DonutAutoLabelChart.withRandomData() {
    return new DonutAutoLabelChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, int>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 300,
      child: new charts.PieChart(seriesList,
          animate: animate,

          // Configure the width of the pie slices to 60px. The remaining space in
          // the chart will be left as a hole in the center.
          //
          // [ArcLabelDecorator] will automatically position the label inside the
          // arc if the label will fit. If the label will not fit, it will draw
          // outside of the arc with a leader line. Labels can always display
          // inside or outside using [LabelPosition].
          //
          // Text style for inside / outside can be controlled independently by
          // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
          //
          // Example configuring different styles for inside/outside:
          //       new charts.ArcLabelDecorator(
          //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
          //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 60,
              arcRendererDecorators: [new charts.ArcLabelDecorator()])),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

class LandscapeView extends StatefulWidget {
  final Widget child;

  const LandscapeView({Key key, this.child}) : super(key: key);

  @override
  _LandscapeViewState createState() => _LandscapeViewState();
}

class _LandscapeViewState extends State<LandscapeView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: widget.child,
    );
  }

  @override
  void dispose() {

    

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }
}

/// Create one series with sample hard coded data.
List<Series<LinearSales, int>> createSampleData() {
  final data = [
    new LinearSales(0, 5),
    new LinearSales(1, 25),
    new LinearSales(2, 100),
    new LinearSales(3, 75),
  ];

  return [
    new Series<LinearSales, int>(
      id: 'Sales',
      colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: data,
    )
  ];
}
