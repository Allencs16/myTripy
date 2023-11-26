import 'package:flutter/material.dart';
import 'package:mytripy/components/button/Button.dart';

class MainBottomSheet{
  static void showBottomSheet(BuildContext context, String element, List<Widget> widgets){    
     showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        )
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(element),
                onTap: () {                                    
                  Navigator.pop(context);
                },
              ),
              Column(
                children: widgets
              )
            ],
          ),
        );
      },
    );
  }
}
