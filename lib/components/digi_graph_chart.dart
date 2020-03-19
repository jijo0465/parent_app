import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// class Chart extends StatelessWidget {
//   //const ({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child : SfCartesianChart(
//             primaryXAxis: CategoryAxis(),
//             // Chart title
//             title: ChartTitle(text: 'Half yearly sales analysis'),
//             // Enable legend
//             legend: Legend(isVisible: true),
//             // Enable tooltip
//             tooltipBehavior: TooltipBehavior(enable: true),
//             series: <ChartSeries<SalesData, String>>[
//               LineSeries<SalesData, String>(
//                   dataSource: <SalesData>[
//                     SalesData('Jan', 35),
//                     SalesData('Feb', 28),
//                     SalesData('Mar', 34),
//                     SalesData('Apr', 32),
//                     SalesData('May', 40)
//                   ],
//                   xValueMapper: (SalesData sales, _) => sales.year,
//                   yValueMapper: (SalesData sales, _) => sales.sales,
//                   // Enable data label
//                   dataLabelSettings: DataLabelSettings(isVisible: true)
//               )
//             ]
//         ),
//     );
//   }
// }

// class SalesData {
//   SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
//
class Charts extends StatelessWidget{
  final int index;
  Charts({Key key, this.index}) : super(key: key);
  List<charts.Series<MarksAnalysis, String>> seriesList;
  _createSampleData() {
    var data = [[
      new MarksAnalysis(1, 65,'Mid-\nTerm'),
      new MarksAnalysis(2, 80,'Half\nYearly'),
      new MarksAnalysis(3, 75,'Mid\nterm II'),
      new MarksAnalysis(4, 70,'Quarterly'),
      new MarksAnalysis(5, 88,'Model'),
      new MarksAnalysis(6, 85, 'Final')],
      [new MarksAnalysis(1, 80,'Mid\nTerm'),
      new MarksAnalysis(2, 86,'Half\nYearly'),
      new MarksAnalysis(3, 70,'Mid\nterm II'),
      new MarksAnalysis(4, 75,'Quarterly'),
      new MarksAnalysis(5, 80,'Model'),
      new MarksAnalysis(6, 78,'Final')],
      [new MarksAnalysis(1, 90,'Mid\nTerm'),
      new MarksAnalysis(2, 80,'Half\nYearly'),
      new MarksAnalysis(3, 65,'Mid\nterm II'),
      new MarksAnalysis(4, 80,'Quarterly'),
      new MarksAnalysis(5, 85,'Model'),
      new MarksAnalysis(6, 96,'Final')],
      [new MarksAnalysis(1, 70,'Mid\nTerm'),
      new MarksAnalysis(2, 80,'Half\nYearly'),
      new MarksAnalysis(3, 94,'Mid\nterm II'),
      new MarksAnalysis(4, 78,'Quarterly'),
      new MarksAnalysis(5, 88,'Model'),
      new MarksAnalysis(6, 75,'Final')],
      [new MarksAnalysis(1, 85,'Mid\nTerm'),
      new MarksAnalysis(2, 45,'Half\nYearly'),
      new MarksAnalysis(3, 75,'Mid\nterm II'),
      new MarksAnalysis(4, 60,'Quarterly'),
      new MarksAnalysis(5, 80,'Model'),
      new MarksAnalysis(6, 70,'Final')],
      [new MarksAnalysis(1, 70,'Mid\nTerm'),
      new MarksAnalysis(2, 73,'Half\nYearly'),
      new MarksAnalysis(3, 75,'Mid\nterm II'),
      new MarksAnalysis(4, 75,'Quarterly'),
      new MarksAnalysis(5, 80,'Model'),
      new MarksAnalysis(6, 78,'Final')],
      [new MarksAnalysis(1, 85,'Mid\nTerm'),
      new MarksAnalysis(2, 80,'Half\nYearly'),
      new MarksAnalysis(3, 60,'Mid\nterm II'),
      new MarksAnalysis(4, 85,'Quarterly'),
      new MarksAnalysis(5, 90,'Model'),
      new MarksAnalysis(6, 88,'Final')]
    ];
    seriesList.add(charts.Series<MarksAnalysis, String>(
      id: 'Marks %',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (MarksAnalysis totalPercent, _) => totalPercent.name,
      measureFn: (MarksAnalysis totalPercent, _) => totalPercent.totalPercent,
      data: data.elementAt(index),
    ));
  }

  @override
  Widget build(BuildContext context) {
    seriesList = List<charts.Series<MarksAnalysis, String>>();
    _createSampleData();
    // TODO: implement build
    return Container(
        child: charts.BarChart(
      seriesList,
      //layoutConfig: ,
      animate: true,
      animationDuration: Duration(milliseconds: 400),
    ));
  }
}

/// Sample ordinal data type.
class MarksAnalysis {
  final int exam;
  final int totalPercent;
  final String name; 
  MarksAnalysis(this.exam, this.totalPercent, this.name);
}
