import 'package:flutter/material.dart';

class AnimatedSquare extends StatefulWidget {
  final int speed;

  const AnimatedSquare({
    super.key,
    required this.speed,
  });

  @override
  State<AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<AnimatedSquare>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<Alignment> _animation;
  late Tween<Alignment> _tween;

  Duration get _duration =>
      Duration(milliseconds: (4000 / widget.speed).round());

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    )..repeat(reverse: true);

    _animation = (_tween =
            Tween(end: Alignment.centerLeft, begin: Alignment.centerRight))
        .animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant AnimatedSquare oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.speed != widget.speed) {
      if (_animationController.status == AnimationStatus.reverse) {
        _tween = Tween(end: _tween.begin, begin: _tween.end);
        setState(() {
          _animation = _tween.animate(_animationController);
        });

        _animationController.value = 1 - _animationController.value;
      }

      _animationController.repeat(
        period: _duration,
        reverse: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) => Align(
        alignment: _animation.value,
        child: child,
      ),
      animation: _animation,
      child: Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
    );
  }
}
