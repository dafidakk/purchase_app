import 'package:flutter/material.dart';
import 'my_button.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class DialogBox extends StatefulWidget {
  TextEditingController itemName = TextEditingController();
  TextEditingController itemPrice = TextEditingController();
  VoidCallback onSave;
  VoidCallback onCancel;

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  DialogBox(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.onCancel,
      required this.onSave});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Center(
            child: Text('New Item'),
          ),
          // ignore: sized_box_for_whitespace
          content: Container(
            height: 175,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //get user input
                TextFormField(
                  controller: widget.itemName,
                  decoration: const InputDecoration(hintText: "Item Name"),
                ),
                TextFormField(
                  controller: widget.itemPrice,
                  decoration: const InputDecoration(hintText: "Item Price"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),

                //buttons -> Save + Cancel
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //cancel button
                    MyElevatedButton(
                      text: "Cancel",
                      onPressed: widget.onCancel,
                    ),

                    const SizedBox(
                      width: 25,
                    ),
                    //save button
                    MyElevatedButton(
                      text: "Add",
                      onPressed: widget.onSave,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
