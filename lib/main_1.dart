import 'package:flutter/material.dart';
import 'package:kama_test_task/spawn_square_object.dart';
import 'package:kama_test_task/square_controller.dart';
import 'package:kama_test_task/widgets/animated_square.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<SpawnResult>(
        future: spawnSpeedListener(),
        builder: (BuildContext context, AsyncSnapshot<SpawnResult> snapshot) {
          final data = snapshot.data;
          if (data != null) {
            return MyHomePage(
              spawnResult: data,
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final SpawnResult spawnResult;

  const MyHomePage({
    super.key,
    required this.spawnResult,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final SquareController squareController;

  @override
  void initState() {
    super.initState();

    squareController = SquareController(
      (speed) {
        widget.spawnResult.sendPort.send(speed);
      },
    )..init();
  }

  @override
  void dispose() {
    super.dispose();
    squareController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: widget.spawnResult.stream,
        initialData: 1,
        builder: (context, snapshot) => AnimatedSquare(
          speed: snapshot.requireData,
        ),
      ),
    );
  }
}
