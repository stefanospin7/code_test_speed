import 'dart:ui' as ui;
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Benchmark App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        // Adjust other theme properties as needed
      ),
      home: const MyHomePage(title: 'Flutter Benchmark'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime _startTime;
  late String _benchmarkResult = "";

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    // Perform heavy graphic operations or any other operations here
    _generateImages(2500000).then((result) {
      setState(() {
        _benchmarkResult = result;
      });
    });
  }

Future<String> _generateImages(int n) async {
  final int width = 1000;
  final int height = 1000;

  for (int i = 0; i < n; i++) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromPoints(Offset(0.0, 0.0), Offset(width.toDouble(), height.toDouble())));

    // Draw more complex shapes
    final Paint paint = Paint();
    canvas.drawCircle(Offset(width / 2, height / 2), 400, paint);
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(width.toDouble(), height.toDouble())
        ..lineTo(width.toDouble(), 0)
        ..close(),
      paint,
    );

    // Draw multiple layers
    final Paint gradientPaint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        const Offset(1000, 1000),
        [Colors.red, Colors.green],
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), gradientPaint);

    // Apply filter effects
    final ImageFilter filter = ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10);
    canvas.saveLayer(Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), Paint());
    canvas.drawCircle(Offset(width / 2, height / 2), 300, paint..maskFilter = MaskFilter.blur(BlurStyle.normal, 10));
    canvas.restore();

  }
  return 'Image generation completed $n times';
}



  @override
  Widget build(BuildContext context) {
    DateTime endTime = DateTime.now();
    Duration elapsedTime = endTime.difference(_startTime);
    String loadingTime = 'View loaded in ${elapsedTime.inMilliseconds} milliseconds.';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Benchmark Result:'),
            Text(
              _benchmarkResult,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              loadingTime,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
