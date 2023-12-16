import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExplicitAnimation(),
    );
  }
}

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _tweenAnimation;
  late Animation<double> _customAnimation;

  @override
  void initState() {
    super.initState();

    // Tween Animation
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _tweenAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Custom Animation
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _customAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Untuk melihat hasil animasi, jalankan _controller.forward();
    // _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 2),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Container(
                    color: Colors.blue,
                    height: 100,
                    width: 100,
                    child: const Center(
                      child: Text(
                        'Tween Animation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _customAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _customAnimation.value,
                  child: Container(
                    color: Colors.green,
                    height: 100,
                    width: 100,
                    child: const Center(
                      child: Text(
                        'Custom Animation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
