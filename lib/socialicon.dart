import 'package:flutter/material.dart';


class Socialicon extends StatefulWidget {
  final IconData icon;
  final Color color;
  const Socialicon({super.key, required this.icon, required this.color});

  @override
  State<Socialicon> createState() => _SocialiconState();
}

class _SocialiconState extends State<Socialicon> {
  bool ishoverd = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          ishoverd = true;
        });
      },
      onExit: (event) {
        setState(() {
          ishoverd = false;
        });
      },
      child: AnimatedContainer(
        height: 40,
        width: 40,
        duration: Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: ishoverd
              ? widget.color
              : Colors.white24, // Change background color
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          // Ensures the child is aligned at the center
          child: FittedBox(
            fit: BoxFit
                .contain, // Scales the icon proportionally to fit the container
            child: Icon(
              widget.icon,
              size: 30, // Size matching the container
              color: Colors.white, // Icon color
            ),
          ),
        ),
      ),
    );
  }
}
