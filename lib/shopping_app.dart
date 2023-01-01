import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchase_app/utils/const.dart';
import 'package:purchase_app/utils/model.dart';
import 'package:purchase_app/utils/product_dialog.dart';

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  List<Item> itemList = [];
  String itemcount = '0';
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();

  void showSnack(String title) {
    final snackbar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
      ),
    ));
    scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  // save new item
  void saveNewItem() {
    setState(() {
      var _item = Item(
        itemName: itemNameController.text,
        itemPrice: itemPriceController.text,
      );
      itemList.add(_item);
      Navigator.of(context).pop();
    });
    itemNameController.clear();
    itemPriceController.clear();
  }

  // create item
  void createNewItem() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          itemName: itemNameController,
          itemPrice: itemPriceController,
          onSave: () {
            if (itemNameController.text.isEmpty ||
                itemPriceController.text.isEmpty) {
              HapticFeedback.vibrate();
              showSnack("Please fill all out the fields");
            } else {
              saveNewItem();
            }
          },
          onCancel: () {
            itemNameController.clear();
            itemPriceController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Items",
          style: shopStyle(20, Colors.black45, FontWeight.w500),
        ),
        actions: [Text(itemcount)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
