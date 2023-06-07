import 'package:flutter/material.dart';

class MainBottomSheet{
  static void showBottomSheet(BuildContext context, dynamic element){
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
              // Add your content for the bottom sheet here
              ListTile(
                title: Text(element.startDate.toString()),
                onTap: () {
                  // Handle the tap on option 1
                  // For example, you can close the bottom sheet
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
