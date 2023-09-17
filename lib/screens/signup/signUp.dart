import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp>{
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  bool _passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/77.jpg'),
            fit: BoxFit.cover
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Olá, Crie sua conta para continuar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: GlassContainer(
                      width: MediaQuery.of(context).size.width * 0.9,
                      blur: 4,
                      color: Colors.white.withOpacity(1),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                  hintText: 'Nome:',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                  hintText: 'Email:',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: TextFormField(
                                controller: _senha,
                                decoration: InputDecoration(
                                  hintText: 'Senha:',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor
                                    )
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(() => _passwordVisibility = !_passwordVisibility),
                                    child: Icon(
                                      _passwordVisibility
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                obscureText: _passwordVisibility ? false : true,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  
                                }, 
                                child: const Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}