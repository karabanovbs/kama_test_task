import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kama_test_task/fire_scene.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                OpenScreenButton(),
                OpacityButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  text: '3',
                  onTap: () {},
                ),
                const ExitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AppButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        clipBehavior: Clip.antiAlias,
        color: Colors.cyan,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: '4',
      onTap: () {
        showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Do you wanna exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('NO'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ).then(
            (value) => value != null && value ? SystemNavigator.pop() : null);
      },
    );
  }
}

var opacity = 1.0;

class OpacityButton extends StatelessWidget {
  const OpacityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (
        BuildContext context,
        void Function(void Function()) setState,
      ) {
        return AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(seconds: 1),
          child: AppButton(
            text: '2',
            onTap: () {
              setState(
                () {
                  opacity = max(0.1, opacity - 0.1);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class OpenScreenButton extends StatelessWidget {
  const OpenScreenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: '1',
      onTap: () {
        showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Do you wanna navigate?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Move'),
              ),
            ],
          ),
        ).then(
          (value) => value != null && value
              ? Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FireScene(),
                  ),
                )
              : null,
        );
      },
    );
  }
}
