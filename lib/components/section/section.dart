import 'package:flutter/material.dart';

class Section extends StatefulWidget{
  String title;
  Widget item;

  Section({required this.title, required this.item});

  @override
  State<StatefulWidget> createState() {
    return _SectionState();
  }

}

class _SectionState extends State<Section>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 236, 236),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  child: widget.item
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}