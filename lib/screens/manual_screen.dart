import 'package:flutter/material.dart';
import 'package:green_phl/provider/data.dart';
import 'package:provider/provider.dart';
import 'package:green_phl/screens/main_screen.dart';
import 'package:green_phl/widget/screen_layout.dart';
import 'package:green_phl/widget/title_with_pic.dart';

class ManualScreen extends StatelessWidget {
  static const routeName = '/get-started';
  const ManualScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        },
        child: ScreenLayout(
          isHavingNavBar: false,
          bottomFieldRatio: 0.7,
          titleChild: const TitleWithPic(
            title: "Getting Started",
          ),
          contentChild: SizedBox(
            width: size.width,
            height: size.height,
            child: WalkthroughWidget(),
          ),
        ),
      ),
    );
  }
}

class DropdownFieldWidget extends StatefulWidget {
  final title;
  final List<String> listItem;
  final initVal;
  final Function callback;
  const DropdownFieldWidget({
    Key? key,
    required this.title,
    required this.listItem,
    required this.initVal,
    required this.callback,
  }) : super(key: key);

  @override
  State<DropdownFieldWidget> createState() => _DropdownFieldWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownFieldWidgetState extends State<DropdownFieldWidget> {
  String dropdownValue = '';

  @override
  void initState() {
    // TODO: implement initState
    dropdownValue = widget.initVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 20,
        ),
        DropdownButton<String>(
          alignment: Alignment.bottomCenter,
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          iconSize: 24,
          elevation: 16,
          style: Theme.of(context).textTheme.bodyText2,
          underline: Container(
            height: 2,
            color: Colors.purpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              widget.callback(newValue);
            });
          },
          items: widget.listItem.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ManualText extends StatelessWidget {
  const ManualText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Text(
        "The PHLAPP application is an electronic device-based application developed by the GREENPHL team that helps inform users about air quality, especially CO2 from the GREENPHL device placed in their enclosed space.\n\nIn addition to measuring the usual CO2 concentration, the device can assess whether the amount of CO2 is appropriate for the number of people in the room, there is a risk of COVID spread. From there, make recommendations to users on ventilation measures and adjust the appropriate number of people.\n\nThe PHLAPP application helps users collect information, adjust the air as well as the number of people in their enclosed space, limiting the possibility of COVID-19 infection.The application is applied in Vietnam.",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class WalkthroughWidget extends StatefulWidget {
  const WalkthroughWidget({Key? key}) : super(key: key);

  @override
  _WalkthroughWidgetState createState() => _WalkthroughWidgetState();
}

class _WalkthroughWidgetState extends State<WalkthroughWidget> {
  final _controller = PageController();
  final _duration = const Duration(microseconds: 300);
  final _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);
    final List _sample = [
      ManualText(),
      DropdownFieldWidget(
        title: 'Where does the device is placed now?',
        listItem: data.envTypes,
        initVal: data.envTypes[0],
        callback: data.changeEnvType,
      ),
      DropdownFieldWidget(
        title: 'How many members are there in you environment?',
        listItem: [
          '01',
          '03',
          '04',
          '05',
          '06',
          '07',
          '08',
          '09',
          '10',
          'Other',
        ],
        initVal: '01',
        callback: data.changePeopleNum,
      ),
      /* Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Select the devices you are using",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text("Air Conditioner"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text("Heater"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text("Humidifier"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text("Air Purifier"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text("Kitchen deodorizer"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text("Oven mitts"),
                  ],
                ),
              ],
            ),
          )
        ],
      ) */
    ];

    var currentIndex = 0;

    return Column(
      children: [
        Flexible(
          child: PageView.builder(
            controller: _controller,
            itemCount: _sample.length,
            itemBuilder: (BuildContext ctx, int index) {
              currentIndex = index;
              return _sample[index];
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  _controller.previousPage(duration: _duration, curve: _curve);
                },
                child: Text(
                  'Prev',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (currentIndex == _sample.length - 1) {
                    Navigator.of(context)
                        .pushReplacementNamed(MainScreen.routeName);
                  } else {
                    _controller.nextPage(duration: _duration, curve: _curve);
                  }
                },
                child: Text(
                  'Next',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
