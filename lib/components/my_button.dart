import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onTap;

  const AnimatedButton({Key? key, required this.onTap}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  late double _scale;

  @override
  void initState() {
    super.initState();
    _scale = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _animateButton();
        widget.onTap();
      },
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Color(0xFF891905),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()..scale(_scale),
            child: Text(
              "Masuk",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _animateButton() {
    setState(() {
      _scale = 0.95;
    });

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }
}
