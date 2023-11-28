import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/components/bottomSheet/bottom_sheet.dart';
import 'package:mytripy/components/button/Button.dart';
import 'package:mytripy/components/inputText/inputText.dart';
import 'package:mytripy/components/section/section.dart';
import 'package:mytripy/components/snackbar/Main_snackBar.dart';
import 'package:mytripy/components/squareButton/square_button.dart';
import 'package:mytripy/models/expense/expenseModel.dart';
import 'package:mytripy/models/trips/trip.dart';

class Trip extends StatefulWidget{
  TripModel trip;

  Trip({required this.trip});

  @override
  State<StatefulWidget> createState() {
    return _TripState();
  }
}

class _TripState extends State<Trip>{
  late int typeExpense;
  TextEditingController expenseBottomSheet = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip.name.toString()),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Section(
                          title: 'Distancia:', 
                          item: Text(
                            '${widget.trip.distanceFromSource.toString()} Km',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Data Início:', 
                          item: Text(
                            DateFormat.yMMMMd('pt-BR').format(DateTime.parse(widget.trip.startDay.toString())),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Data Fim:', 
                          item: Text(
                            DateFormat.yMMMMd('pt-BR').format(DateTime.parse(widget.trip.endDay.toString())),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Descrição:', 
                          item: Text(
                            widget.trip.description.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Budget Disponível:', 
                          item: Text(
                            '${widget.trip.weekModel!.totalBudget.toString()} Reais',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Button(
                          onPressed: () {
                            MainBottomSheet.showBottomSheet(context, 'Salvar novo gasto', [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: const Text('Selecione o tipo do Gasto'),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                                    child: Row(
                                      children: [
                                        SquareButton(icon: Icons.food_bank, title: 'Comida', onPressed: () {
                                          setState(() {
                                            typeExpense = 1;
                                          });
                                        },),
                                        SquareButton(icon: Icons.gas_meter, title: 'Gasolina', onPressed: () {
                                          typeExpense = 2;
                                        },),
                                        SquareButton(icon: Icons.home, title: 'Hospedagem', onPressed: () {
                                          typeExpense = 0;
                                        },),
                                        SquareButton(icon: Icons.menu, title: 'Outros', onPressed: () {
                                          typeExpense = 3;
                                        },),
                                      ],
                                    ),
                                  ),
                                )
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: InputText(
                                  controller: expenseBottomSheet, 
                                  title: 'Valor do Gasto', 
                                  label: 'Valor do Gasto', 
                                  isPassword: false,
                                  textInputType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Button(
                                    onPressed: () {
                                      createExpense();
                                    }, 
                                    title: 'Salvar gasto'
                                  ),
                                ),
                              )
                            ]);
                          }, 
                          title: 'Criar Gasto'
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  createExpense() async{
    ExpenseModel expense = ExpenseModel(expenseDate: DateTime.now().toString(), type: typeExpense.toString(), value: int.parse(expenseBottomSheet.text), weekId: widget.trip.id);
    createAndSaveExpense(expense);
    MainSnackBar.showSnackBar(context, "Despesa Criada com Sucesso.");
    Navigator.pop(context);
  }
}