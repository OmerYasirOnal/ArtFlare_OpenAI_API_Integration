import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeOutAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeOutAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 1.0, end: 0.5),
              duration: const Duration(milliseconds: 100))
          .thenTween('y', Tween(begin: 0.6, end: -100.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
          offset: Offset(0, value.get("y")),
          child: child,
        ),
      ),
    );
  }
}
