import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

void main() {
  runApp(
    MaterialApp(
      home: AnimatedRadialChartExample(),
    ),
  );
}

class AnimatedRadialChartExample extends StatefulWidget {
  @override
  _AnimatedRadialChartExampleState createState() =>
      _AnimatedRadialChartExampleState();
}

class _AnimatedRadialChartExampleState
    extends State<AnimatedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = Size(200.0, 200.0);

  double value = 50.0;
  Color labelColor = Colors.blue[200];

  void _increment() {
    setState(() {
      value += 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState.updateData(data);
    });
  }

  void _decrement() {
    setState(() {
      value -= 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState.updateData(data);
    });
  }

  List<CircularStackEntry> _generateChartData(double value) {
    Color dialColor = Colors.blue[200];
    if (value < 0) {
      dialColor = Colors.red[200];
    } else if (value < 50) {
      dialColor = Colors.yellow[200];
    }
    labelColor = dialColor;

    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage',
          )
        ],
        rankKey: 'percentage',
      ),
    ];

    if (value > 100) {
      labelColor = Colors.green[200];

      data.add(CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value - 100,
            Colors.green[200],
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = Theme.of(context)
        .textTheme
        .title
        .merge(new TextStyle(color: labelColor));

    return Scaffold(
      appBar: AppBar(
        title: Text('Percentage Dial'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: _generateChartData(value),
              chartType: CircularChartType.Radial,
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
              holeLabel: Text(
                '$value%',
                style: _labelStyle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: _decrement,
                child: Icon(Icons.remove),
                shape: CircleBorder(),
                color: Colors.red[200],
                textColor: Colors.white,
              ),
              RaisedButton(
                onPressed: _increment,
                child: Icon(Icons.add),
                shape: CircleBorder(),
                color: Colors.blue[200],
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
