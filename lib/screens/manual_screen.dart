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
  const DropdownFieldWidget({
    Key? key,
    required this.title,
    required this.listItem,
  }) : super(key: key);

  @override
  State<DropdownFieldWidget> createState() => _DropdownFieldWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownFieldWidgetState extends State<DropdownFieldWidget> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    dropdownValue = widget.listItem[0];
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
            });
          },
          items: widget.listItem.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
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
        "   Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
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
      ),
      DropdownFieldWidget(
        title: 'How many members are there in you environmet?',
        listItem: [
          '01',
          '03',
          '04',
          '05',
          '06',
          '07',
          '08',
          '09',
          'Other',
        ],
      ),
      Column(
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
      )
    ];

    return Column(
      children: [
        Flexible(
          child: PageView.builder(
            controller: _controller,
            itemCount: _sample.length,
            itemBuilder: (BuildContext ctx, int index) {
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
                  _controller.nextPage(duration: _duration, curve: _curve);
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
