import 'package:flutter/material.dart';

class SquareButton extends StatefulWidget {
  String title;
  IconData icon;

  SquareButton({required this.title, required this.icon});

  @override
  State<StatefulWidget> createState() {
    return _SquareButtonState();
  }
}

class _SquareButtonState extends State<SquareButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _isTapped = !_isTapped;
          });
        },
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
