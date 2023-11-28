import 'package:flutter/material.dart';

class SquareButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  SquareButton({required this.title, required this.icon, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return _SquareButtonState();
  }
}

class _SquareButtonState extends State<SquareButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: isPressed ? Theme.of(context).primaryColor.withAlpha(80) : Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            setState(() {
              isPressed = !isPressed;
            });
            widget.onPressed();
          },
          splashColor: Theme.of(context).primaryColor.withAlpha(30),
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Icon(widget.icon, color: Colors.white),
                    ),
                    SizedBox(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
