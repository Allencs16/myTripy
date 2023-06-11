import 'package:flutter/material.dart';

class InputText extends StatefulWidget{
  TextEditingController controller;
  String title;
  String label;
  bool isPassword;

  InputText({Key? key, required this.controller, required this.title, required this.label, required this.isPassword}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StateInputText();
  }

}

class _StateInputText extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.label,
        hintText: widget.title,
        focusColor: Theme.of(context).primaryColor,
      ),
      obscureText: widget.isPassword,
    );
  }
}