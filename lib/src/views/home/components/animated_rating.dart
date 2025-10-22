import 'package:flutter/material.dart';

class ProductRating extends StatefulWidget {
  const ProductRating({super.key, required this.rating, required this.colors});

  final double? rating;
  final List<Color> colors;

  @override
  State<ProductRating> createState() => _ProductRatingState();
}

class _ProductRatingState extends State<ProductRating>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star_border_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ),
          ClipRect(
            child: AnimatedBuilder(
              animation: _gradientAnimation,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.centerLeft,

                  widthFactor:
                      _gradientAnimation.value * ((widget.rating ?? 0) / 5),

                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: widget.colors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color:
                              Colors.white, // Any color, overridden by shader
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
