import 'dart:async';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:green_phl/provider/data.dart';
import 'package:green_phl/widget/background.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  var isShowDialog = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dataProvider = Provider.of<Data>(context);
    dataProvider.getLiveData();

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (dataProvider.isNotSafe && !isShowDialog) {
        isShowDialog = true;
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: SizedBox(
                width: double.infinity,
                child: Text(
                  "Warning!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CO2 indicator is now OVERLOADED!',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Please UPDATE number of people',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _textEditingController,
                      validator: (value) {
                        return value!.isNotEmpty
                            ? null
                            : "Please UPDATE the number of people present in your env";
                      },
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: "Member number"),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(dataProvider.memberNum.toString());
                    // isShowDialog = false;
                    // dataProvider.changeState();
                    isShowDialog = true;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  child: const Text(
                    "No",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(_textEditingController.text.isEmpty
                        ? dataProvider.memberNum.toString()
                        : _textEditingController.text.toString());
                    isShowDialog = false;
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        ).then((value) => dataProvider.changePeopleNum(value));
      }
    });
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        fit: StackFit.loose,
        children: [
          const Background(),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            width: size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                GreetingBar(),
                SizedBox(
                  height: 40,
                ),
                SizedBox(height: 260, width: 260, child: MainCircle()),
                SizedBox(
                  height: 60,
                ),
                InformationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainCircle extends StatelessWidget {
  const MainCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<Data>(context);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            child: const CircularSpin(),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(150)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 248,
                alignment: Alignment.center,
                width: 248,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(500),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 0),
                      blurRadius: 5,
                    ),
                  ],
                  border: Border.all(style: BorderStyle.solid),
                  // color: Colors.lightGreenAccent,
                  color: dataProvider.isNotSafe
                      ? Colors.red[400]
                      : Colors.lightGreenAccent,
                ),
                child: Text(
                  dataProvider.isNotSafe ? 'WARNING!' : "SAFE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: dataProvider.isNotSafe ? Colors.white : Colors.cyan,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularSpin extends StatelessWidget {
  const CircularSpin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 260,
      curve: Curves.linear,
      lineWidth: 7,
      percent: 1,
      linearGradient: LinearGradient(colors: [
        Colors.red[400]!,
        Colors.orange[400]!,
        Colors.yellow[400]!,
        Colors.lightGreenAccent,
      ]),
    );
  }
}

class InformationWidget extends StatefulWidget {
  const InformationWidget({Key? key}) : super(key: key);

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  var _isInit = true;
  var _isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //load init
      Provider.of<Data>(context, listen: false).getLiveData().then(
            (_) => {
              setState(() {
                _isLoading = false;
              })
            },
          );

      //create a periodTimer
      Timer.periodic(const Duration(seconds: 10), (timer) {
        setState(
          () {
            _isLoading = true;
            Provider.of<Data>(context, listen: false).getLiveData().then(
                  (value) => {
                    setState(() {
                      _isLoading = false;
                    })
                  },
                );
          },
        );
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<Data>(context);
    Size size = MediaQuery.of(context).size;
    // dataProvider.getLiveData();
    return Container(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 40,
            bottom: 40,
            child: Container(
              height: 120,
              width: 300,
              color: Colors.white.withOpacity(0.4),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: SizedBox(
                  width: size.width * 0.435,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cur CO2:",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Avg CO2:",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Over CO2:",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _isLoading
                                ? 'Loading...'
                                : '${dataProvider.curCO2.toStringAsFixed(2)} ppm',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            '${dataProvider.memberNum <= 10 ? "302.00" : "645.00"} ppm',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            //TODO change
                            '${dataProvider.memberNum <= 10 ? "702.00" : "1045.00"} ppm',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Update people number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightGreenAccent,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _textEditingController,
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "Please UPDATE the number of people present in your env";
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: "Member number"),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx)
                                .pop(dataProvider.memberNum.toString());
                            // isShowDialog = false;
                            // dataProvider.changeState();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[400]),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(
                                _textEditingController.text.isEmpty
                                    ? dataProvider.memberNum.toString()
                                    : _textEditingController.text.toString());
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.cyan)),
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).then((value) => dataProvider.changePeopleNum(value));
              },
              child: PeopleCircle(),
            ),
            top: 20,
            bottom: 20,
            right: 40,
          ),
        ],
      ),
    );
  }
}

class PeopleCircle extends StatelessWidget {
  const PeopleCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<Data>(context);
    return Container(
      height: 160,
      alignment: Alignment.center,
      width: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyan[100]!,
            Colors.purple[100]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(500),
        ),
        color: Colors.lightGreenAccent,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${dataProvider.memberNum}",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.blue,
            ),
          ),
          Text(
            'People',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          )
        ],
      ),
    );
  }
}

class GreetingBar extends StatelessWidget {
  const GreetingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Container(
        height: 110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          //TODO: Use more custom gradient
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.cyan.withOpacity(0.3),
              Colors.white,
            ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        width: double.infinity,
        child: const ListTile(
          title: Text("Welcome back"),
          subtitle: Text(
            "Coby Lee",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          //TODO: add elevation
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.png"),
            radius: 30,
          ),
        ),
      ),
    );
  }
}
