import 'package:flutter/material.dart';
import 'package:jothilabproject/domain/product_model.dart';
import 'package:flutter/animation.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({
    super.key,
    required this.index, // Pass index to determine color
    required this.prod,
    required this.callbackAdd,
    this.callbackDelete,
  });

  final int index;
  final Products prod;
  final VoidCallback callbackAdd;
  final VoidCallback? callbackDelete;

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // List of colors for alternating cards
  final List<Color> cardColors = [
    Colors.blue.shade100,
    Colors.lightGreen.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
    Colors.yellow.shade100,
    Colors.red.shade100,
    Colors.cyan.shade100,
    Colors.indigo.shade100,
  ];

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Slide Animation (Left to Right)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Fade-in Animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Start animation when widget is built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Card(
          color: cardColors[widget.index % cardColors.length],
          margin: EdgeInsets.only(top: 15,left: 5,right: 5),
          // Alternate colors
          elevation: 5,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.prod.thumbnail!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.prod.title!,
                        style: const TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.prod.price!.toString(),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            Text(widget.prod.rating!.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.callbackDelete != null) {
                        widget.callbackDelete!();
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.callbackAdd();
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
