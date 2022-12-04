import 'dart:isolate';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:kama_test_task/square_object.dart';

Future<SpawnResult> spawnSpeedListener() async {
  final p = ReceivePort();
  await Isolate.spawn(
    (SendPort p) async {
      final commandPort = ReceivePort();
      p.send(commandPort.sendPort);

      final SquareObject squareObject = SquareObject(initialSpeed: 1);

      squareObject.speed.addListener(() {
        p.send(squareObject.speed.value);
      });

      await for (final message in commandPort) {
        if (message is int) {
          squareObject.updateSpeed(message);
        }
      }

      Isolate.exit();
    },
    p.sendPort,
  );

  final events = StreamQueue<Object?>(p);

  SendPort sendPort = await events.next as SendPort;

  return SpawnResult(
    sendPort: sendPort,
    stream: events.rest.map((event) => event as int),
  );
}

@immutable
class SpawnResult {
  final SendPort sendPort;
  final Stream<int> stream;

  const SpawnResult({
    required this.sendPort,
    required this.stream,
  });
}
