import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FieldNumber extends StatefulWidget {
  const FieldNumber({Key? key}) : super(key: key);

  @override
  State<FieldNumber> createState() => _FieldNumberState();
}

class _FieldNumberState extends State<FieldNumber> {
  int _integerValue = 0;
  int _decimalValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
              width: 230,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberPicker(
                      value: _integerValue,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                            ),
                            top: BorderSide(
                              color: Colors.white,
                            ),
                            left: BorderSide(
                              color: Colors.white,
                            ),
                          )),
                      textStyle: TextStyle(fontSize: 25, color: Colors.black),
                      selectedTextStyle:
                          TextStyle(color: Colors.white, fontSize: 40),
                      minValue: 0,
                      maxValue: 999,
                      onChanged: (newValue) {
                        setState(() {
                          _integerValue = newValue;
                        });
                      },
                    ),
                    //SizedBox(width: 10),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                          ),
                          top: BorderSide(
                            color: Colors.white,
                          ),
                        )),
                        child: Text('.',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white))),

                    NumberPicker(
                      value: _decimalValue,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                            ),
                            top: BorderSide(
                              color: Colors.white,
                            ),
                            right: BorderSide(
                              color: Colors.white,
                            ),
                          )),
                      textStyle: TextStyle(fontSize: 25, color: Colors.black),
                      selectedTextStyle:
                          TextStyle(color: Colors.white, fontSize: 40),
                      minValue: 0,
                      maxValue: 99,
                      onChanged: (newValue) {
                        setState(() {
                          _decimalValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
              )),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      color: Colors.purple,
                    ),
                    width: 130.0,
                    child: SizedBox(
                        child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("age");
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      textColor: Colors.white,
                    )),
                  ),
                ),
              ),
              const SizedBox(
                width: 62,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 100.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    color: Colors.purple,
                  ),
                  width: 130.0,
                  child: SizedBox(
                      child: MaterialButton(
                    onPressed: () {
                      double finalValue = _integerValue + (_decimalValue / 100);
                      print('Final Value: $finalValue');
                      Navigator.of(context).pushNamed("height");
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    textColor: Colors.white,
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
