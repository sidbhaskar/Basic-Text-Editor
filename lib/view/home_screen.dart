import 'package:flutter/material.dart';
import 'package:text_editor_2/widgets/customtext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  bool hasBorder = false;
  Offset offset = Offset.zero;
  String editableText = 'New Text';
  Color editableColor = Colors.black;
  double fontSize = 20;

  List<Color> colorOptions = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To Canvas'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.blue.shade100,
              ),
              Positioned(
                left: hasBorder ? offset.dx : offset.dx,
                top: hasBorder ? offset.dy : offset.dy,
                child: Container(
                  decoration: BoxDecoration(
                    border: hasBorder ? Border.all() : null,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        hasBorder = !hasBorder;
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        if (hasBorder) {
                          offset = Offset(
                            offset.dx + details.delta.dx,
                            offset.dy + details.delta.dy,
                          );
                        }
                      });
                    },
                    child: MyText(
                      editColor: editableColor,
                      editSize: fontSize,
                      editText: editableText,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Visibility(
            visible: hasBorder,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Change Properties : '),
            ),
          ),
          Visibility(
            visible: hasBorder,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(hintText: 'Edit text'),
                      onChanged: (value) {
                        setState(() {
                          editableText = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Color: '),
                      DropdownButton<Color>(
                        value: editableColor,
                        onChanged: (Color? newValue) {
                          setState(() {
                            editableColor = newValue!;
                          });
                        },
                        items: colorOptions
                            .map<DropdownMenuItem<Color>>((Color value) {
                          return DropdownMenuItem<Color>(
                            value: value,
                            child: Container(
                              width: 50,
                              height: 20,
                              color: value,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Font : '),
                      SizedBox(
                        width: 200,
                        child: Slider(
                          value: fontSize,
                          min: 10,
                          max: 80,
                          divisions: 50,
                          label: fontSize.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              fontSize = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
