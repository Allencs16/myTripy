import 'package:flutter/material.dart';

class Welcome extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('lib/assets/landscape.png'),
            fit: BoxFit.cover,
            alignment: Alignment(-1, 1)
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 42, 0, 8),
                child: Text(
                  'Unforgotten \nExperiences',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    fontSize: 40
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(42, 8, 42, 8),
                child: Text(
                  'Share your best trips around the world \nwith friends and plan the next one',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 580, 0, 16),
                child: SizedBox(
                  width: 380,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    },
                    child: const Text('Continue'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor
                    ),
                  ),
                ),
              )
            ],
          )
        )
      ),
    );
  }
}